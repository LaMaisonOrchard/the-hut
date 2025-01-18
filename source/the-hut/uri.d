import std.stdio;
import core.atomic;

public
{
	struct Uri
	{
		this(string name)
		{
		}
		
		this (const(Uri) other)
		{
		}
		
		string Service() const
		{
			return "file";
		}
		
		string Path() const
		{
			return "dub.json";
		}
	}
	
	struct UriNode
	{
		private this(BaseUriNode node)
		{
			if (node is null)
			{
				throw new UriNullException("UriNode");
			}
			
			this.node = node;
			this.node.Inc();
		}
		
		this(ref return scope UriNode rhs)
		{
			rhs.node.Inc();
			this.node = rhs.node;
		}
		
		~this()
		{
			this.node.Dec();
		}
		
		ref UriNode opAssign(ref UriNode rhs) return
		{
			rhs.node.Inc();
			this.node.Dec();
			this.node = rhs.node;
			
			return this;
		}
		
		void   Close()            {this.node.Close();}
		void[] Read (void[] data) {return this.node.Read(data);}
		void[] Write(void[] data) {return this.node.Write(data);}
		bool   Eof()              {return this.node.Eof();}
		bool   IsOpen()           {return this.node.IsOpen();}
		
		private BaseUriNode node;
	}
	
	UriNode Open(string name)
	{
		return Open(Uri(name));
	}
	
	UriNode Open(const(Uri) uri)
	{	
		shared IService* service;
		synchronized {
			service = uri.Service() in serviceList;
		}
		
		if (service is null)
		{
			throw new UriNoServiceException(uri.Service());
		}
		else
		{
			return UriNode(service.Open(uri));
		}
	}
}

unittest
{
	Uri uri = "source/test.d";
	assert(uri.Service() == "file");
}

unittest
{
	Uri uri = "file:source/test.d";
	assert(uri.Service() == "file");
}

unittest
{
	Uri uri = "File:source/test.d";
	assert(uri.Service() == "file");
}

unittest
{
	auto fp = Open("source/test.d");
	assert(fp.IsOpen());
	assert(!fp.Eof());
	
	byte[10] data;
	void[] rtn = fp.Read(data);
	assert(rtn.length == 10);
	writeln(cast(char[])rtn);
}

public
{
	class UriException : Exception
	{
		this(string msg)
		{
			super(msg);
		}
	}
	
	class UriNullException : UriException
	{
		this(string msg)
		{
			super("null pointer : " ~ msg);
		}
	}
	
	class UriOpException : UriException
	{
		this(string msg)
		{
			super("operation failed : " ~ msg);
		}
	}
	
	class UriNoServiceException : UriException
	{
		this(string msg)
		{
			super("missing service : " ~ msg);
		}
	}
	
	class UriNotFoundException : UriException
	{
		this(string msg)
		{
			super("URI not found : " ~ msg);
		}
	}
	
	interface IUriNode
	{
		void   Close();
		void[] Read (void[] data);
		void[] Write(void[] data);
		bool   Eof();
		bool   IsOpen();
	}
	
	shared class BaseUriNode : IUriNode
	{
		abstract void   Close();
		abstract void[] Read (void[]);
		abstract void[] Write(void[]);
		abstract bool   Eof();
		abstract bool   IsOpen();
	
		final void Inc()
		{
			atomicOp!("+=", int, int)(this.count, 1);
		}
		
		final void Dec()
		{
			if (atomicOp!("+=", int, int)(this.count, 1) <= 0)
			{
				Close();
			}
		}
		
		private int  count  = 0;
	}
}

private
{
	shared IService[string] serviceList;
		
	static this()
	{
		serviceList["file"] = new FileService();
		serviceList["dev"]  = new DevService();
	}
	
	interface IService
	{
		shared BaseUriNode Open(const(Uri) uri);
	}
	
	final class DevService : IService
	{
		final override shared BaseUriNode Open(const(Uri) uri)
		{
			switch(uri.Path())
			{
				case "/stdin":  return new shared PosixUriNode(0);
				case "/stdout": return new shared PosixUriNode(1);
				case "/stderr": return new shared PosixUriNode(2);
				default: throw new UriNotFoundException(uri.Path());
			}
		}
	}
}


private
{
	// unistd.h
	extern (C) int  creat(const(char) *, ulong);
	extern (C) int  fcntl(int, int);
	extern (C) int  open(const(char) *, ulong);
	extern (C) int  close(int fd);
	extern (C) int  read(int, void *, ulong);
	extern (C) int  write(int, const(void) *, ulong);
	extern (C) int  eof(int);
	
	enum ulong O_RDWR = 0;
	
	final class FileService : IService
	{
		final override shared BaseUriNode Open(const(Uri) uri)
		{
			auto path = uri.Path() ~ '\0';
			int fd = open(path.ptr, O_RDWR);
			
			if (fd < 0)
			{
				throw new UriNotFoundException(uri.Path());
			}
			
			return new shared PosixUriNode(fd);
		}
	}
	
	final shared class PosixUriNode : BaseUriNode
	{
		this(int fd)
		{
			this.fd = fd;
		}
		
		final override void Close()
		{
			if (fd > 2)
			{
				close(this.fd);
			}
			this.fd = -1;
		}
		
		final override bool Eof()
		{
			if (this.fd >= 0)
			{
				return (eof(this.fd) != 0);
			}
			else
			{
				return true;
			}
		}
		
		final override bool IsOpen()
		{
			return (this.fd >= 0);
		}
		
		final override void[] Read (void[] data)
		{
			if (data is null)
			{
				throw new UriNullException("BaseUriNode.Read(void[] data)");
			}
			
			if (this.fd >= 0)
			{
				int len = read(this.fd, data.ptr, data.length);
				
				if (len < 0)
				{
					throw new UriOpException("BaseUriNode.Read(void[] data)");
				}
				
				return data[0..len];
			}
				
			return data[0..0];
		}
		
		final override void[] Write(void[] data)
		{
			if (data is null)
			{
				throw new UriNullException("BaseUriNode.Write(void[] data)");
			}
			
			if (this.fd >= 0)
			{
				int len = write(this.fd, &data, data.length);
				
				if (len < 0)
				{
					throw new UriOpException("BaseUriNode.Write(void[] data)");
				}
				
				return data[len..$];
			}
				
			return data[0..0];
		}
		
		int fd;
	}
		
}

