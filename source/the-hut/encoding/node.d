//////////////////////////////////////////////////////////////////
//
//  Copyright 2025 david@the-hut.net
//  All rights reserved
//
@safe:

import std.stdio;
import std.array;
import std.traits;
import std.exception;

//// Exceptions //////////////////////////
public
{
    class NodeException : Exception
    {
        this(string msg)
        {
            super(msg);
        }
    }

    class UnsupportedType : NodeException
    {
        this()
        {
            super("Unsupported Type");
        }
    }

    class TypeCast : NodeException
    {
        this()
        {
            super("Can't case the node to the given type");
        }
    }

    class IllegalIndexType : NodeException
    {
        this()
        {
            super("Illegal type for an associative array");
        }
    }

    class IllegalIndex : NodeException
    {
        this()
        {
            super("Unable to index the type or index out of range");
        }
    }
}

public
{
	struct Node
	{
		this(const(bool) v)
		{
			set(v);
		}
		
		this(const(ubyte) v)
		{
			set(v);
		}
		
		this(const(byte) v)
		{
			set(v);
		}
		
		this(const(ushort) v)
		{
			set(v);
		}
		
		this(const(short) v)
		{
			set(v);
		}
		
		this(const(uint) v)
		{
			set(v);
		}
		
		this(const(int) v)
		{
			set(v);
		}
		
		this(const(ulong) v)
		{
			set(v);
		}
		
		this(const(long) v)
		{
			set(v);
		}
		
		this(const(float) v)
		{
			set(v);
		}
		
		this(const(double) v)
		{
			set(v);
		}
		
		this (const(char)[] v)
		{
			set(v);
		}
		
		this(T)(const(T)[] v)
        if (!isSomeChar!T)
		{
			set!T(v);
		}
		
		this(T1,T2)(const(T1)[T2] v)
		{
			set!(T1,T2)(v);
		}
        
        //// opAssign //////////////////////////////////////////
       
		Node opAssign(const(bool) v)
		{
			set(v);
            return this;
		}
       
		Node opAssign(const(ubyte) v)
		{
			set(v);
            return this;
		}
		
		Node opAssign(const(byte) v)
		{
			set(v);
            return this;
		}
		
		Node opAssign(const(ushort) v)
		{
			set(v);
            return this;
		}
		
		Node opAssign(const(short) v)
		{
			set(v);
            return this;
		}
		
		Node opAssign(const(uint) v)
		{
			set(v);
            return this;
		}
		
		Node opAssign(const(int) v)
		{
			set(v);
            return this;
		}
		
		Node opAssign(const(ulong) v)
		{
			set(v);
            return this;
		}
		
		Node opAssign(const(long) v)
		{
			set(v);
            return this;
		}
		
		Node opAssign(const(float) v)
		{
			set(v);
            return this;
		}
		
		Node opAssign(const(double) v)
		{
			set(v);
            return this;
		}
		
		Node opAssign(const(char)[] v)
		{
			set(v);
            return this;
		}
		
		Node opAssign(T)(const(T)[] v)
        if (!isSomeChar!T)
		{
			set!T(v);
            return this;
		}
		
		Node opAssign(T1,T2)(const(T1)[T2] v)
		{
			set!(T1,T2)(v);
            return this;
		}
        
        @trusted static Node array()
        {
            Node a;
            Node[] list;
            a._type = NodeType.array_;
            a._array = list;
            return a;
        }
        
        @trusted static Node associativeArray()
        {
            Node a;
            Node[Node] list;
            a._type = NodeType.associativeArray_;
            a._associativeArray = list;
            return a;
        }
		
        void tag(uint tag)
        {
            _tagged = true;
            _tag = tag;
        }
        
        uint tag()
        {
            return _tag;
        }
        
        bool isTagged()
        {
            return _tagged;
        }
        
        void clearTag()
        {
            _tagged = false;
        }
            
		bool isSimple()
		{
			return ((_type != NodeType.null_) &&
			        (_type != NodeType.array_) &&
			        (_type != NodeType.associativeArray_));
		}
        
        bool isNull()
        {
            return (_type == NodeType.null_);
        }
        
        bool isArray()
        {
            return (_type == NodeType.array_);
        }
        
        bool isAssociativeArray()
        {
            return (_type == NodeType.associativeArray_);
        }
        
        @trusted ulong length()
        {
            if (_type == NodeType.string_)
            {
                return text.length;
            }
            else if (_type == NodeType.array_)
            {
                return _array.length;
            }
            else if (_type == NodeType.associativeArray_)
            {
                return _associativeArray.length;
            }
            else
            {
                throw new UnsupportedType;
            }
        }
        
        @trusted ulong length(ulong v)
        {
            if (_type == NodeType.array_)
            {
                return _array.length = v;
            }
            else
            {
                throw new UnsupportedType;
            }
        }
		
        //// set /////////////////////////////////////////////////////
		@trusted Node set(const(bool) v)
		{
            _type = NodeType.boolean_;
            boolean = v;
            return this;
        }
        
		Node set(const(float) v)
        {
            _type = NodeType.float_;
            float64 = v;
            return this;
        }
        
		Node set(const(double) v)
        {
            _type = NodeType.double_;
            float64 = v;
            return this;
        }
        
		Node set(const(ubyte) v)
        {
            return set2(v);
        }
        
		Node set(const(byte) v)
        {
            return set2(v);
        }
        
		Node set(const(ushort) v)
        {
            return set2(v);
        }
        
		Node set(const(short) v)
        {
            return set2(v);
        }
        
		Node set(const(uint) v)
        {
            return set2(v);
        }
        
		Node set(const(int) v)
        {
            return set2(v);
        }
        
		Node set(const(ulong) v)
        {
            return set2(v);
        }
        
		Node set(const(long) v)
        {
            return set2(v);
        }
        
		@trusted Node set(const(char)[] v)
        {
            _type = NodeType.string_;
            text = v.idup;
            return this;
        }
        
		Node set2(T)(const(T) v)
            if(isIntegral!T)
        {
            if (v < 0)
            {
                _type = NodeType.signedInt_;
                integer = cast(ulong)(-cast(long)(v));
            }
            else
            {
                _type = NodeType.unsignedInt_;
                integer = v;
            }
            return this;
        }
        
		@trusted Node set(T)(const(T)[] v)
        if (!isSomeChar!T)
        {
            Node[] list;
            list.length = v.length;
            foreach(i, e ; v)
            {
                list[i] = set(e);
            }
            _type = NodeType.array_;
            _array = list;
            return this;
        }
        
		@trusted Node set(T1, T2)(const(T1)[T2] v)
        {
            Node[Node] list;
            foreach(i, e ; v)
            {
                Node idx = i;
                if (!idx.isSimple)
                {
                    throw new IllegalIndexType;
                }
                list[idx] = set(e);
            }
            _type = NodeType.associativeArray_;
            _associativeArray = list;
            return this;
        }
		
		@trusted T as(T)()
		{
			static if (is(T == bool))
			{
                if (_type == NodeType.boolean_)
                {
                    return boolean;
                }
                else
                {
                    throw new TypeCast;
                }
			}
			else static if (is(T == ulong))
			{
                if (_type == NodeType.unsignedInt_)
                {
                    return integer;
                }
                else
                {
                    throw new TypeCast;
                }
			}
			else static if (is(T == uint))
			{
                if ((_type == NodeType.unsignedInt_) && (integer <= 0x0FFFFFFFFU))
                {
                    return cast(uint)(integer);
                }
                else
                {
                    throw new TypeCast;
                }
			}
			else static if (is(T == ushort))
			{
                if ((_type == NodeType.unsignedInt_) && (integer <= 0x0FFFFU))
                {
                    return cast(ushort)(integer);;
                }
                else
                {
                    throw new TypeCast;
                }
			}
			else static if (is(T == ubyte))
			{
                if ((_type == NodeType.unsignedInt_) && (integer <= 0x0FFU))
                {
                    return cast(ubyte)(integer);;
                }
                else
                {
                    throw new TypeCast;
                }
			}
            
			else static if (is(T == long))
			{
                if ((_type == NodeType.unsignedInt_) && (integer <= 0x07FFFFFFFFFFFFFFFU))
                {
                    return cast(long)(integer);
                }
                else if ((_type == NodeType.signedInt_) && (integer <= 0x08000000000000000U))
                {
                    return -cast(long)(integer);
                }
                else
                {
                    throw new TypeCast;
                }
			}
			else static if (is(T == int))
			{
                if ((_type == NodeType.unsignedInt_) && (integer <= 0x07FFFFFFFU))
                {
                    return cast(int)(integer);
                }
                else if ((_type == NodeType.signedInt_) && (integer <= 0x080000000U))
                {
                    return cast(int)(-cast(long)(integer));
                }
                else
                {
                    throw new TypeCast;
                }
			}
			else static if (is(T == short))
			{
                if ((_type == NodeType.unsignedInt_) && (integer <= 0x07FFFU))
                {
                    return cast(short)(integer);
                }
                else if ((_type == NodeType.signedInt_) && (integer <= 0x08000U))
                {
                    return cast(short)(-cast(long)(integer));
                }
                else
                {
                    throw new TypeCast;
                }
			}
			else static if (is(T == byte))
			{
                if ((_type == NodeType.unsignedInt_) && (integer <= 0x07FU))
                {
                    return cast(byte)(integer);
                }
                else if ((_type == NodeType.signedInt_) && (integer <= 0x080U))
                {
                    return cast(byte)(-cast(long)(integer));
                }
                else
                {
                    throw new TypeCast;
                }
			}
            
			else static if (is(T == float))
			{
                if (_type == NodeType.float_)
                {
                    return cast(float)(float64);
                }
                else
                {
                    throw new TypeCast;
                }
			}
			else static if (is(T == double))
			{
                if (_type == NodeType.float_)
                {
                    return cast(float)(float64);
                }
                else if (_type == NodeType.double_)
                {
                    return float64;
                }
                else
                {
                    throw new TypeCast;
                }
			}
            
			else static if (is(T == string))
			{
                if (_type == NodeType.string_)
                {
                    return text;
                }
                else
                {
                    throw new TypeCast;
                }
			}
			else static if (is(T == immutable(ubyte)[]))
			{
                if (_type == NodeType.byteArray_)
                {
                    return data;
                }
                else
                {
                    throw new TypeCast;
                }
			}
            
			else
			{
				throw new UnsupportedType;
			}
		}
		
		@trusted T[] as(T1:T[], T)()
        if (!isSomeChar!T)
		{
            if (_type != NodeType.array_)
            {
				throw new TypeCast;
            }
            
            T[] list;
            list.length = _array.length;
            foreach(i, t ; _array)
            {
                list[i] = _array[i].as!T;
            }
            
            return list;
        }
        
		@trusted T[O] as(T1:T[O], T, O)()
        if (!isSomeChar!T)
		{
            if (_type != NodeType.associativeArray_)
            {
				throw new TypeCast;
            }
            
            T[O] list;
            foreach(i, t ; _array)
            {
                list[i] = _array[i].as!T;
            }
            
            return list;
        }
		
		bool isA(T)()
		{
			static if (is(T == bool))
			{
                if (_type == NodeType.boolean_)
                {
                    return true;
                }
                else
                {
                    return false;
                }
			}
			else static if (is(T == ulong))
			{
                if (_type == NodeType.unsignedInt_)
                {
                    return true;
                }
                else
                {
                    return false;
                }
			}
			else static if (is(T == uint))
			{
                if ((_type == NodeType.unsignedInt_) && (integer <= 0x0FFFFFFFFU))
                {
                    return true;
                }
                else
                {
                    return false;
                }
			}
			else static if (is(T == ushort))
			{
                if ((_type == NodeType.unsignedInt_) && (integer <= 0x0FFFFU))
                {
                    return true;
                }
                else
                {
                    return false;
                }
			}
			else static if (is(T == ubyte))
			{
                if ((_type == NodeType.unsignedInt_) && (integer <= 0x0FFU))
                {
                    return true;
                }
                else
                {
                    return false;
                }
			}
            
			else static if (is(T == long))
			{
                if ((_type == NodeType.unsignedInt_) && (integer <= 0x07FFFFFFFFFFFFFFFU))
                {
                    return true;
                }
                else if ((_type == NodeType.signedInt_) && (integer <= 0x08000000000000000U))
                {
                    return true;
                }
                else
                {
                    return false;
                }
			}
			else static if (is(T == int))
			{
                if ((_type == NodeType.unsignedInt_) && (integer <= 0x07FFFFFFFU))
                {
                    return true;
                }
                else if ((_type == NodeType.signedInt_) && (integer <= 0x080000000U))
                {
                    return true;
                }
                else
                {
                    return false;
                }
			}
			else static if (is(T == short))
			{
                if ((_type == NodeType.unsignedInt_) && (integer <= 0x07FFFU))
                {
                    return true;
                }
                else if ((_type == NodeType.signedInt_) && (integer <= 0x08000U))
                {
                    return true;
                }
                else
                {
                    return false;
                }
			}
			else static if (is(T == byte))
			{
                if ((_type == NodeType.unsignedInt_) && (integer <= 0x07FU))
                {
                    return true;
                }
                else if ((_type == NodeType.signedInt_) && (integer <= 0x080U))
                {
                    return true;
                }
                else
                {
                    return false;
                }
			}
            
			else static if (is(T == float))
			{
                if (_type == NodeType.float_)
                {
                    return true;
                }
                else
                {
                    return false;
                }
			}
			else static if (is(T == double))
			{
                if (_type == NodeType.float_)
                {
                    return true;
                }
                else if (_type == NodeType.double_)
                {
                    return true;
                }
                else
                {
                    return false;
                }
			}
            
			else static if (is(T == string))
			{
                if (_type == NodeType.string_)
                {
                    return true;
                }
                else
                {
                    return false;
                }
			}
			else static if (is(T == immutable(ubyte)[]))
			{
                if (_type == NodeType.byteArray_)
                {
                    return true;
                }
                else
                {
                    return false;
                }
			}
            
			else
			{
                    return false;
			}
		}
		
        @trusted Node opIndex(size_t idx)
        {
            if (_type != NodeType.array_)
            {
				throw new IllegalIndex;
            }
            
            if (idx >= _array.length)
            {
				throw new IllegalIndex;
            }
            
            return _array[idx];
        }
        
        bool opEquals(ref const Node s) const
        {
            return this.toHash == s.toHash;
        }
        
        size_t toHash() const @trusted nothrow
        {
            switch(_type)
            {
                case NodeType.null_: return 0;
                case NodeType.signedInt_  : return  typeid(integer).getHash(&integer);
                case NodeType.unsignedInt_: return ~typeid(integer).getHash(&integer);
                case NodeType.boolean_    : return  typeid(boolean).getHash(&boolean);
                case NodeType.float_      : return  typeid(float64).getHash(&float64);
                case NodeType.double_     : return ~typeid(float64).getHash(&float64);
                case NodeType.string_     : return  typeid(text).getHash(&text);
                case NodeType.byteArray_  : return  typeid(byteArray).getHash(&byteArray);
                case NodeType.array_      : return  typeid(_array).getHash(&_array);
                case NodeType.associativeArray_: return typeid(_associativeArray).getHash(&_associativeArray);
                default : return -1;
            }
        }
        
		package NodeType type()
		{
			return _type;
		}
		
        
        
		private
		{
			NodeType _type = NodeType.null_;
            bool     _tagged = false;
            uint     _tag   = 0;
			union
			{
				ulong   integer;
				bool    boolean;
				double  float64;
                string  text;
                ubyte[] byteArray;
				Node[]     _array;
				Node[Node] _associativeArray;
			}
		}
	}
	
	unittest
	{
		Node a;
		assert(!a.isSimple);
		assert(a.isNull);
		assert(!a.isArray);
		assert(!a.isAssociativeArray);
        
		assert(!a.isA!ubyte);
		assert(!a.isA!byte);
		assert(!a.isA!ushort);
		assert(!a.isA!short);
		assert(!a.isA!uint);
		assert(!a.isA!int);
		assert(!a.isA!ulong);
		assert(!a.isA!long);
		assert(!a.isA!float);
		assert(!a.isA!double);
		assert(!a.isA!string);
		assert(a.type == NodeType.null_);
        
        assertThrown!TypeCast(a.as!(string[]));
	}
	
	unittest
	{
		Node a = Node.array();
		assert(!a.isNull);
		assert(a.isArray);
		assert(!a.isAssociativeArray);
		assert(!a.isSimple);
		assert(!a.isA!ubyte);
		assert(!a.isA!byte);
		assert(!a.isA!ushort);
		assert(!a.isA!short);
		assert(!a.isA!uint);
		assert(!a.isA!int);
		assert(!a.isA!ulong);
		assert(!a.isA!long);
		assert(!a.isA!float);
		assert(!a.isA!double);
		assert(!a.isA!string);
		assert(a.type == NodeType.array_);
        
        assertThrown!TypeCast(a.as!(string[double]));
        
        int[] y = [1,2,3,4];
        Node b = y;
        assert(b.length == 4);
        assert(b[1].as!int == 2);
        
        Node c = [[1,2],[3,4]];
        assert(c.length == 2);
        
        auto d = b.as!(int[]);
	}
	
	unittest
	{
		Node a = Node.associativeArray();
		assert(!a.isNull);
		assert(!a.isArray);
		assert(a.isAssociativeArray);
		assert(!a.isSimple);
		assert(!a.isA!ubyte);
		assert(!a.isA!byte);
		assert(!a.isA!ushort);
		assert(!a.isA!short);
		assert(!a.isA!uint);
		assert(!a.isA!int);
		assert(!a.isA!ulong);
		assert(!a.isA!long);
		assert(!a.isA!float);
		assert(!a.isA!double);
		assert(!a.isA!string);
		assert(a.type == NodeType.associativeArray_);
        
        assertThrown!TypeCast(a.as!bool);
        
        string[double] b;
        b[2.3] = "2.3";
        Node c = b;
        assert(c.length == 1);
        //assert(c[2.3].as!string == "2.3");  -- TODO
        
        auto d = a.as!(string[double]);
	}
	
	unittest
	{
		Node a = true;
		assert(a.isSimple);
		assert(!a.isNull);
		assert(!a.isArray);
		assert(!a.isAssociativeArray);
		assert(!a.isA!ubyte);
		assert(!a.isA!byte);
		assert(!a.isA!ushort);
		assert(!a.isA!short);
		assert(!a.isA!uint);
		assert(!a.isA!int);
		assert(!a.isA!ulong);
		assert(!a.isA!long);
		assert(!a.isA!float);
		assert(!a.isA!double);
		assert(a.isA!bool);
		assert(!a.isA!string);
		assert(a.type == NodeType.boolean_);
		assert(a.as!bool == true);
        
        assertThrown!TypeCast(a.as!uint);
	}
	
	unittest
	{
		Node a = 7U;
		assert(a.isSimple);
		assert(!a.isNull);
		assert(!a.isArray);
		assert(!a.isAssociativeArray);
		assert(a.isA!ubyte);
		assert(a.isA!byte);
		assert(a.isA!ushort);
		assert(a.isA!short);
		assert(a.isA!uint);
		assert(a.isA!int);
		assert(a.isA!ulong);
		assert(a.isA!long);
		assert(!a.isA!float);
		assert(!a.isA!double);
		assert(!a.isA!string);
		assert(a.type == NodeType.unsignedInt_);
		assert(a.as!uint == 7U);
        
        a.as!int;
	}
	
	unittest
	{
		Node a = 7;
		assert(a.isSimple);
		assert(!a.isNull);
		assert(!a.isArray);
		assert(!a.isAssociativeArray);
		assert(a.isA!ubyte);
		assert(a.isA!byte);
		assert(a.isA!ushort);
		assert(a.isA!short);
		assert(a.isA!uint);
		assert(a.isA!int);
		assert(a.isA!ulong);
		assert(a.isA!long);
		assert(!a.isA!float);
		assert(!a.isA!double);
		assert(!a.isA!string);
		assert(a.type == NodeType.unsignedInt_);
		assert(a.as!int == 7);
	}
	
	unittest
	{
		Node a = -7;
		assert(a.isSimple);
		assert(!a.isNull);
		assert(!a.isArray);
		assert(!a.isAssociativeArray);
		assert(!a.isA!ubyte);
		assert(a.isA!byte);
		assert(!a.isA!ushort);
		assert(a.isA!short);
		assert(!a.isA!uint);
		assert(a.isA!int);
		assert(!a.isA!ulong);
		assert(a.isA!long);
		assert(!a.isA!float);
		assert(!a.isA!double);
		assert(!a.isA!string);
		assert(a.type == NodeType.signedInt_);
		assert(a.as!int == -7);
        
        assertThrown!TypeCast(a.as!uint);
        assertThrown!TypeCast(a.as!float);
	}
	
	unittest
	{
		Node a = 0.5F;
		assert(a.isSimple);
		assert(!a.isNull);
		assert(!a.isArray);
		assert(!a.isAssociativeArray);
		assert(!a.isA!ubyte);
		assert(!a.isA!byte);
		assert(!a.isA!ushort);
		assert(!a.isA!short);
		assert(!a.isA!uint);
		assert(!a.isA!int);
		assert(!a.isA!ulong);
		assert(!a.isA!long);
		assert(a.isA!float);
		assert(a.isA!double);
		assert(!a.isA!string);
		assert(a.type == NodeType.float_);
		assert(a.as!float == 0.5F);
	}
	
	unittest
	{
		Node a = 0.500000001;
		assert(a.isSimple);
		assert(!a.isNull);
		assert(!a.isArray);
		assert(!a.isAssociativeArray);
		assert(!a.isA!ubyte);
		assert(!a.isA!byte);
		assert(!a.isA!ushort);
		assert(!a.isA!short);
		assert(!a.isA!uint);
		assert(!a.isA!int);
		assert(!a.isA!ulong);
		assert(!a.isA!long);
		assert(!a.isA!float);
		assert(a.isA!double);
		assert(!a.isA!string);
		assert(a.type == NodeType.double_);
		assert(a.as!double == 0.500000001);
        
        assertThrown!TypeCast(a.as!float);
	}
	
	unittest
	{
		Node a1;
		Node a2 = 1;
		Node a3 = -1;
		Node a4 = 2.3F;
		Node a5 = 7.8;
		Node a6 = "fred";
		Node a7 = [cast(int)(1),2,3,4,5];
		Node a8 = ["fred": 78, "harry" : 98];
        
		a1 = 1;
        assert(a1.as!uint == 1);
		a2 = -1;
		a3 = 2.3F;
		a4 = 7.8;
		a5 = "fred";
		a6 = [cast(int)(1),2,3,4,5];
		a7 = ["fred": 78, "harry" : 98];
	}
}

package
{
	enum NodeType
	{
		null_,
		signedInt_,
		unsignedInt_,
		boolean_,
		float_,
		double_,
		string_,
		byteArray_,
		array_,
		associativeArray_
	}
}