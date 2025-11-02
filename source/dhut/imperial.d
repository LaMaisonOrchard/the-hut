import std.stdio;
import std.format;
import std.string;
public import baseUnits;
public import baseUnits : abs, opEquals;
import si;

public   // Rankine
{
    struct Rankine
    {
        this(const(Rankine) other)
        {
            this.value = other.value;
        }
        
        this(const(Temperature) other)
        {
            this.value = (other/Temperature.unity)*9.0/5.0;
        }
        
        Temperature opCast(T)()
            if (is(T == Temperature))
        {
            return Temperature.unity*(value*5.0/9.0);
        }
        
        string toString() const
        {
            return format!("%G'R")(this.value);
        }
        
        private this(const(double) value)
        {
            this.value = value;
        }

        auto opBinary(string op : "*")(const(double) rhs) const
        {
            return Rankine(this.value * rhs);
        }

        const(double) opBinary(string op : "/")(const(Rankine) rhs) const
        {
            return (this.value * rhs.value);
        }
        
        auto opBinaryRight(string op : "*")(const(double) lhs) const
        {
            return Rankine(this.value * lhs);
        }

        auto opBinary(string op : "/")(const(double) rhs) const
        {
            return Rankine(this.value / rhs);
        }

        auto opBinary(string op : "+")(const(Rankine) rhs) const
        {
            return Rankine(this.value + rhs.value);
        }
        
        auto opBinary(string op : "-")(const(Rankine) rhs) const
        {
            return Rankine(this.value - rhs.value);
        }

        auto opOpAssign(string op : "*")(const(double) rhs)
        {
            return Rankine(this.value *= rhs);
        }

        auto opOpAssign(string op : "/")(const(double) rhs)
        {
            return Rankine(this.value /= rhs);
        }

        auto opOpAssign(string op : "+")(const(Rankine) rhs)
        {
            return Rankine(this.value += rhs.value);
        }
        
        auto opOpAssign(string op : "-")(const(Rankine) rhs)
        {
            return Rankine(this.value -= rhs.value);
        }
        
        int opCmp(const(Rankine) rhs) const
        {
            if (this.value == rhs.value)
            {
                return 0;
            }
            else if (this.value < rhs.value)
            {
                return -1;
            }
            else
            {
                return 1;
            }
        }
        
        private double value;
    }  
    
    bool opEquals(string type)(const(Rankine) a, const(Rankine) b)
    {
        return a.value == b.value;
    }
    
        
    auto abs(string type)(const(Rankine) rhs)
    {
        if (rhs.value < 0.0)
        {
            return BaseUnits!type(-rhs.value);
        }
        else
        {
            return rhs;
        }
    } 
    
    enum Rankine R = Rankine(1.0);
}

public   //Fahrenheit
{
    struct Fahrenheit
    {
        this(const(Fahrenheit) other)
        {
            this.value = other.value;
        }
        
        this(const(Temperature) other)
        {
            this.value = (((other/Temperature.unity) - 273.15)*9.0/5.0)+32.0;
        }
        
        Temperature opCast(T)()
            if (is(T == Temperature))
        {
            return Temperature.unity*(((value - 32.0)*5.0/9.0) +273.15);
        }
        
        string toString() const
        {
            return format!("%G'F")(this.value);
        }
        
        private this(const(double) value)
        {
            this.value = value;
        }

        auto opBinary(string op : "*")(const(double) rhs) const
        {
            return Fahrenheit(this.value * rhs);
        }

        const(double) opBinary(string op : "/")(const(Fahrenheit) rhs) const
        {
            return (this.value * rhs.value);
        }
        
        auto opBinaryRight(string op : "*")(const(double) lhs) const
        {
            return Fahrenheit(this.value * lhs);
        }

        auto opBinary(string op : "/")(const(double) rhs) const
        {
            return Fahrenheit(this.value / rhs);
        }

        auto opBinary(string op : "+")(const(Fahrenheit) rhs) const
        {
            return Fahrenheit(this.value + rhs.value);
        }
        
        auto opBinary(string op : "-")(const(Fahrenheit) rhs) const
        {
            return Fahrenheit(this.value - rhs.value);
        }

        auto opOpAssign(string op : "*")(const(double) rhs)
        {
            return Fahrenheit(this.value *= rhs);
        }

        auto opOpAssign(string op : "/")(const(double) rhs)
        {
            return Fahrenheit(this.value /= rhs);
        }

        auto opOpAssign(string op : "+")(const(Fahrenheit) rhs)
        {
            return Fahrenheit(this.value += rhs.value);
        }
        
        auto opOpAssign(string op : "-")(const(Fahrenheit) rhs)
        {
            return Fahrenheit(this.value -= rhs.value);
        }
        
        int opCmp(const(Fahrenheit) rhs) const
        {
            if (this.value == rhs.value)
            {
                return 0;
            }
            else if (this.value < rhs.value)
            {
                return -1;
            }
            else
            {
                return 1;
            }
        }
        
        private double value;
    }  
    
    bool opEquals(string type)(const(Fahrenheit) a, const(Fahrenheit) b)
    {
        return a.value == b.value;
    }
    
        
    auto abs(string type)(const(Fahrenheit) rhs)
    {
        if (rhs.value < 0.0)
        {
            return BaseUnits!type(-rhs.value);
        }
        else
        {
            return rhs;
        }
    } 
    
    enum Fahrenheit F = Fahrenheit(1.0);
}

private
{
    unittest
    {
        writeln("Imperial Units Test 1");
        
        Temperature a = 2*K;
        Rankine     c = 4*R;
        Fahrenheit  d = 5*F;
        
        assert(a.toString() == "2'K");
        assert(c.toString() == "4'R");
        assert(d.toString() == "5'F");
        
        a = cast(Temperature)c;
        assert(a.toString() == "2.22222'K");
        c = cast(Rankine)a;
        assert(c.toString() == "4'R");
        
        a = cast(Temperature)d;
        assert(a.toString() == "258.15'K");
        d = cast(Fahrenheit)a;
        assert(d.toString() == "5'F");
    }
}