import std.stdio;
import std.format;
import std.string;

public
{
    struct BaseUnits(string type)
    {
        this(const(BaseUnits!type) other)
        {
            this.value = other.value;
            writeln(this.value);
        }
        
        string toString() const
        {
            return format!("%G%s")(this.value, standard(type));
        }
        
        private this(const(double) value)
        {
            this.value = value;
        }

        const(BaseUnits!type) opBinary(string op : "*")(const(double) rhs) const
        {
            return BaseUnits!type(this.value * rhs);
        }

        auto opBinary(string op : "*", string type2)(const(BaseUnits!type2) rhs) const
        {
            return BaseUnits!(combine(type, type2))(this.value * rhs.value);
        }

        const(double) opBinary(string op : "/")(const(BaseUnits!type) rhs) const
        {
            return (this.value * rhs.value);
        }

        auto opBinary(string op : "/", string type2)(const(BaseUnits!type2) rhs) const
        if (type != type2)
        {
            return BaseUnits!(combineDiv(type, type2))(this.value * rhs.value);
        }
        
        const(BaseUnits!type) opBinaryRight(string op : "*")(const(double) lhs) const
        {
            return BaseUnits!type(this.value * lhs);
        }
        
        const(InvBaseUnits!type) opBinaryRight(string op : "/")(const(double) lhs) const
        {
            return InvBaseUnits!type(lhs/this.value);
        }

        const(BaseUnits!type) opBinary(string op : "/")(const(double) rhs) const
        {
            return BaseUnits!type(this.value / rhs);
        }

        const(BaseUnits!type) opBinary(string op : "+")(const(BaseUnits!type) rhs) const
        {
            return BaseUnits!type(this.value + rhs.value);
        }
        
        const(BaseUnits!type) opBinary(string op : "-")(const(BaseUnits!type) rhs) const
        {
            return BaseUnits!type(this.value - rhs.value);
        }

        const(BaseUnits!type) opOpAssign(string op : "*")(const(double) rhs)
        {
            return BaseUnits!type(this.value *= rhs);
        }

        const(BaseUnits!type) opOpAssign(string op : "/")(const(double) rhs)
        {
            return BaseUnits!type(this.value /= rhs);
        }

        const(BaseUnits!type) opOpAssign(string op : "+")(const(BaseUnits!type) rhs)
        {
            return BaseUnits!type(this.value += rhs.value);
        }
        
        const(BaseUnits!type) opOpAssign(string op : "-")(const(BaseUnits!type) rhs)
        {
            return BaseUnits!type(this.value -= rhs.value);
        }
        
        int opCmp(const(BaseUnits!type) rhs) const
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
        
    bool opEquals(string type)(const(BaseUnits!type) a, const(BaseUnits!type) b)
    {
        return a.value == b.value;
    }
        
    const(double) abs(const(double) rhs)
    {
        if (rhs < 0.0)
        {
            return -rhs;
        }
        else
        {
            return rhs;
        }
    }
        
    const(BaseUnits!type) abs(string type)(const(BaseUnits!type) rhs)
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
    
    struct InvBaseUnits(string type)
    {
        this(const(InvBaseUnits!type) other)
        {
            this.value = other.value;
            writeln(this.value);
        }
        
        string toString() const
        {
            return format!("%G%s")(this.value, standard(InverseUnits(type)));
        }
        
        private this(const(double) value)
        {
            this.value = value;
        }

        const(InvBaseUnits!type) opBinary(string op : "*")(const(double) rhs) const
        {
            return InvBaseUnits!type(this.value * rhs);
        }
        
        const(InvBaseUnits!type) opBinaryRight(string op : "*")(const(double) lhs) const
        {
            return InvBaseUnits!type(this.value * lhs);
        }

        auto opBinary(string op : "*", string type2)(const(BaseUnits!type2) rhs) const
        {
            return BaseUnits!(combine(type, type2))(this.value * rhs.value);
        }

        const(double) opBinary(string op : "/")(const(BaseUnits!type) rhs) const
        {
            return (this.value * rhs.value);
        }

        auto opBinary(string op : "/", string type2)(const(BaseUnits!type2) rhs) const
        if (type != type2)
        {
            return BaseUnits!(combineDiv(type, type2))(this.value * rhs.value);
        }

        const(InvBaseUnits!type) opBinary(string op : "/")(const(double) rhs) const
        {
            return InvBaseUnits!type(this.value / rhs);
        }
        
        const(BaseUnits!type) opBinaryRight(string op : "/")(const(double) lhs) const
        {
            return BaseUnits!type(lhs/this.value);
        }

        const(InvBaseUnits!type) opBinary(string op : "+")(const(InvBaseUnits!type) rhs) const
        {
            return InvBaseUnits!type(this.value + rhs.value);
        }
        
        const(InvBaseUnits!type) opBinary(string op : "-")(const(InvBaseUnits!type) rhs) const
        {
            return InvBaseUnits!type(this.value - rhs.value);
        }

        const(InvBaseUnits!type) opOpAssign(string op : "*")(const(double) rhs)
        {
            return InvBaseUnits!type(this.value *= rhs);
        }

        const(InvBaseUnits!type) opOpAssign(string op : "/")(const(double) rhs)
        {
            return InvBaseUnits!type(this.value /= rhs);
        }

        const(InvBaseUnits!type) opOpAssign(string op : "+")(const(InvBaseUnits!type) rhs)
        {
            return InvBaseUnits!type(this.value += rhs.value);
        }
        
        const(InvBaseUnits!type) opOpAssign(string op : "-")(const(InvBaseUnits!type) rhs)
        {
            return InvBaseUnits!type(this.value -= rhs.value);
        }
        
        int opCmp(const(InvBaseUnits!type) rhs) const
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
        
    bool opEquals(string type)(const(InvBaseUnits!type) a, const(InvBaseUnits!type) b)
    {
        return a.value == b.value;
    }
        
    const(InvBaseUnits!type) abs(string type)(const(InvBaseUnits!type) rhs)
    {
        if (rhs.value < 0.0)
        {
            return InvBaseUnits!type(-rhs.value);
        }
        else
        {
            return rhs;
        }
    }
    
    enum um = BaseUnits!"m"(1.0E-6);
    enum mm = BaseUnits!"m"(1.0E-3);
    enum cm = BaseUnits!"m"(1.0E-2);
    enum dm = BaseUnits!"m"(1.0E-1);
    enum  m = BaseUnits!"m"(1.0);
    enum km = BaseUnits!"m"(1.0E3);
    
    alias Length = BaseUnits!"m";
    
    enum um2 = BaseUnits!"m2"(1.0E-12);
    enum mm2 = BaseUnits!"m2"(1.0E-6);
    enum cm2 = BaseUnits!"m2"(1.0E-4);
    enum dm2 = BaseUnits!"m2"(1.0E-2);
    enum  m2 = BaseUnits!"m2"(1.0);
    enum km2 = BaseUnits!"m2"(1.0E6);
    
    alias Area = BaseUnits!"m2";
    
    enum um3 = BaseUnits!"m3"(1.0E-18);
    enum mm3 = BaseUnits!"m3"(1.0E-9);
    enum cm3 = BaseUnits!"m3"(1.0E-6);
    enum dm3 = BaseUnits!"m3"(1.0E-3);
    enum  m3 = BaseUnits!"m3"(1.0);
    enum km3 = BaseUnits!"m3"(1.0E9);
    
    alias Volume = BaseUnits!"m3";
    
    alias Energy = BaseUnits!"m2g/s2";
    
    enum uJ = Energy(1.0E-3);
    enum mJ = Energy(1.0);
    enum cJ = Energy(1.0E1);
    enum dJ = Energy(1.0E2);
    enum  J = Energy(1.0E3);
    enum kJ = Energy(1.0E6);
    enum MJ = Energy(1.0E9);
    
    alias Power = BaseUnits!"m2g/s";
    
    enum uW = Power(1.0E-3);
    enum mW = Power(1.0);
    enum cW = Power(1.0E1);
    enum dW = Power(1.0E2);
    enum  W = Power(1.0E3);
    enum kW = Power(1.0E6);
    enum MW = Power(1.0E9);
}

// m, g, s, A, K, mol, cd, Hz, Error
enum int UNITS_LEN = 9;

// J = k(gm2/s2)
// W = Js = k(gm2/s)

string combine(string type1, string type2) pure
{
    int[UNITS_LEN] a;
    extract(type1, a);
    extract(type2, a);
    
    return build(a);
}

string combineDiv(string type1, string type2) pure
{
    int[UNITS_LEN] a;
    extract(type1, a);
    extract(type2, a, -1);
    
    return build(a);
}

string standard(string type) pure
{
    switch (type)
    {
        case "m2g/s2" : return "mJ";
        case "s2/m2g" : return "1/mJ";
        
        case "m2g/s" : return "mW";
        case "s/m2g" : return "1/mW";
        
        default: return type;
    }
}

void extract(string type, int[UNITS_LEN] a) pure
{
    extract(type, a, 1);
}

void extract(string type, int[UNITS_LEN] a, const(int)inv) pure
{
    // Count the number of each base unit
    if ((type.length > 0) && (type[0] == '1'))
    {
        type = type[1..$];
    }
    
    int mul = inv;
    
    while (type.length > 0)
    {
        if (type[0] == '/')
        {
            mul = -mul;
        }
        else
        {
            int idx = 8;   // Default ios error
            switch (type[0])
            {
                case 'm':
                {
                    if ((type.length > 2) && (type[0..3] == "mol"))
                    {
                        idx = 5;
                        type = type[3..$];
                    }
                    else
                    {
                        idx = 0;
                        type = type[1..$];
                    }
                }
                break;
                
                case 'g': idx = 1; type = type[1..$]; break;
                case 's': idx = 2; type = type[1..$]; break;
                case 'A': idx = 3; type = type[1..$]; break;
                case 'K': idx = 4; type = type[1..$]; break;
                case 'c':
                {
                    if ((type.length > 2) && (type[0..2] == "cd"))
                    {
                        idx = 6;
                        type = type[2..$];
                    }
                    else
                    {
                        // Error
                        idx = 8;
                        type = type[1..$];
                    }
                }
                break;
                
                case 'H': idx = 7; type = type[1..$]; break;
                {
                    if ((type.length > 2) && (type[0..2] == "Hz"))
                    {
                        idx = 7;
                        type = type[2..$];
                    }
                    else
                    {
                        // Error
                        idx = 8;
                        type = type[1..$];
                    }
                }
                break;
                
                default:  idx = 8; type = type[1..$]; break; // Error
            }
            
            if (type.length > 0)
            {
                switch (type[0])
                {
                    case '0': a[idx] += 0*mul; type = type[1..$]; break;
                    case '1': a[idx] += 1*mul; type = type[1..$]; break;
                    case '2': a[idx] += 2*mul; type = type[1..$]; break;
                    case '3': a[idx] += 3*mul; type = type[1..$]; break;
                    case '4': a[idx] += 4*mul; type = type[1..$]; break;
                    case '5': a[idx] += 5*mul; type = type[1..$]; break;
                    case '6': a[idx] += 6*mul; type = type[1..$]; break;
                    case '7': a[idx] += 7*mul; type = type[1..$]; break;
                    case '8': a[idx] += 8*mul; type = type[1..$]; break;
                    case '9': a[idx] += 9*mul; type = type[1..$]; break;
                    default:  a[idx] += mul; break;
                }
            }
            else
            {
                a[idx] += mul;
            }
        }
    }
}


string build(int[UNITS_LEN] a) pure
{
    int idx = 0;
    char[64] type;
    
    for (int i = 0; (i < 8); i += 1)
    {
        if (a[i] > 0)
        {
            switch(i)
            {
                // m, g, s, A, K, mol, cd, Hz, Error
                case 0: type[idx++] = 'm'; break;
                case 1: type[idx++] = 'g'; break;
                case 2: type[idx++] = 's'; break;
                case 3: type[idx++] = 'A'; break;
                case 4: type[idx++] = 'K'; break;
                case 5: type[idx..idx+3] = "mol"; idx += 3; break;
                case 6: type[idx..idx+2] = "cd";  idx += 2; break;
                case 7: type[idx..idx+2] = "Hz";  idx += 2; break;
                default: break;
            }
        
            switch(a[i])
            {
                case 1: break;
                case 2: type[idx++] = '2'; break;
                case 3: type[idx++] = '3'; break;
                case 4: type[idx++] = '4'; break;
                case 5: type[idx++] = '5'; break;
                case 6: type[idx++] = '6'; break;
                case 7: type[idx++] = '7'; break;
                case 8: type[idx++] = '8'; break;
                case 9: type[idx++] = '9'; break;
                default: break;
            }
        }
    }
    
    if (idx == 0)
    {
        type[idx++] = '1';
    }
    
    bool first = true;
    
    for (int i = 0; (i < 8); i += 1)
    {
        if (a[i] < 0)
        {
            if (first)
            {
                first = false;
                type[idx++] = '/';
            }
            
            switch(i)
            {
                // m, g, s, A, K, mol, cd, Hz, Error
                case 0: type[idx++] = 'm'; break;
                case 1: type[idx++] = 'g'; break;
                case 2: type[idx++] = 's'; break;
                case 3: type[idx++] = 'A'; break;
                case 4: type[idx++] = 'K'; break;
                case 5: type[idx..idx+3] = "mol"; idx += 3; break;
                case 6: type[idx..idx+2] = "cd";  idx += 2; break;
                case 7: type[idx..idx+2] = "Hz";  idx += 2; break;
                default: break;
            }
        
            switch(-a[i])
            {
                case 1: break;
                case 2: type[idx++] = '2'; break;
                case 3: type[idx++] = '3'; break;
                case 4: type[idx++] = '4'; break;
                case 5: type[idx++] = '5'; break;
                case 6: type[idx++] = '6'; break;
                case 7: type[idx++] = '7'; break;
                case 8: type[idx++] = '8'; break;
                case 9: type[idx++] = '9'; break;
                default: break;
            }
        }
    }
    
    return type[0..idx].idup;
}
        
string InverseUnits(string type)pure
{
    string a;
    string b;
    
    auto idx = indexOf(type, '/');
    if (idx > 0)
    {
        a = type[0..idx];
        b = type[idx+1 ..$];
    }
    else if (idx == 0)
    {
        a = "";
        b = type[1 ..$];
    }
    else
    {
        a = type[0 ..$];
        b = " 1";
    }
    return format!("%s/%s")(b,a);
}

unittest
{
	writeln("Units Test 1");
	assert(um.toString() == "1E-06m");
	assert(mm.toString() == "0.001m");
	assert(cm.toString() == "0.01m");
	assert(dm.toString() == "0.1m");
	assert(m.toString () == "1m");
	assert(km.toString() == "1000m");
}

unittest
{
	writeln("Units Test 2");
    auto a = 7*m;
    auto b = m*5;
    //auto c = a* b;
    writeln(a.toString());
    writeln(b.toString());
    //writeln(c.toString());
}

unittest
{
	writeln("Units Test 3");
    auto a = 7*m;
    auto b = m*5;
    
	assert(a == a);
	assert(a != b);
	assert(a > b);
	assert(a >= b);
	assert(a >= a);
	assert(b < a);
	assert(b <= a);
	assert(b <= b);
}

unittest
{
	writeln("Units Test 4");
    Length a = 7*m;
    Length b = m*5;
    
    b = a;
    
	assert(a == b);
	assert(b == a);
    
    a += 5*m;
	assert(abs(a - (12*m)) < 1E-6*m);
    
    a -= 5*m;
	assert(abs(a - (7*m)) < 1E-6*m);
    
    a *= 2;
	assert(abs(a - (14*m)) < 1E-6*m);
    
    a /= 2;
	assert(abs(a - (7*m)) < 1E-6*m);
}

unittest
{
	writeln("Units Test 5");
    Length a = 7*m;
    
    InvBaseUnits!"m" b = 2/a;
	assert(abs(b - InvBaseUnits!"m"(2.0/7.0)) < InvBaseUnits!"m"(1E-6));
    
    a = 2/b;
	assert(abs(a - (7*m)) < 1E-6*m);
}

unittest
{
	writeln("Units Test 6");
    Length a = 2*m;
    Area b = 3*m2;
    
    Volume c = a*b;
    writeln(c.toString());
}

unittest
{
	writeln("Units Test 7");
    Length a = 2*m;
    Area   b = 3*m2;
    
    double c = a/m;
    Length d = b/m;
    
	assert(abs(c - 2.0) < 1E-6);
	assert(abs(d - BaseUnits!"m"(3.0)) < BaseUnits!"m"(1E-6));
}

unittest
{
	writeln("Units Test 8");
    
    writeln(J.toString());
    writeln(W.toString());
    
	assert(J.toString() == "1000mJ");
	assert(W.toString() == "1000mW");
}
