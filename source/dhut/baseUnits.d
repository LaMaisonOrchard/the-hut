import std.stdio;
import std.format;
import std.string;

public   // BaseUnits
{
    struct BaseUnits(string type)
    {
        this(const(BaseUnits!type) other)
        {
            this.value = other.value;
        }
        
        static auto unity()
        {
            return BaseUnits!type(1.0);
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
            return BaseUnits!(combineDiv(type, type2))(this.value / rhs.value);
        }
        
        const(BaseUnits!type) opBinaryRight(string op : "*")(const(double) lhs) const
        {
            return BaseUnits!type(this.value * lhs);
        }
        
        auto opBinaryRight(string op : "/")(const(double) lhs) const
        {
            return BaseUnits!(inverseType(type))(lhs/this.value);
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
    
    auto make(string type)(double value)
    {
        return BaseUnits!(standardInv(type))(value);
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
}

public
{ 
    alias Area         = BaseUnits!"m2";
    alias Volume       = BaseUnits!"m3";
    alias Energy       = BaseUnits!"kgm2s-2";
    alias Power        = BaseUnits!"kgm2s-3";
    alias Force        = BaseUnits!"kgms-2";
    alias Pressure     = BaseUnits!"kgm-1s-2";
    alias Volts        = BaseUnits!"kgm2s-3A-1";
    alias Resistance   = BaseUnits!"kgm2s-3A-2";
    alias Wavelength   = BaseUnits!"mCyl-1";
    alias Velocity     = BaseUnits!"ms-1";
    alias Acceleration = BaseUnits!"ms-2";
    alias Density      = BaseUnits!"kgm-2";
}
 
private  // Units manipulation
{

    // kg, m, s, A, K, mol, cd, Cyl, Error
    enum int UNITS_LEN = 9;

    // J = kgm2/s2
    // W = Js = kgm2/s

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

    string standardType(string type2) pure
    {
        int[UNITS_LEN] a;
        extract(type2, a);
        
        return build(a);
    }

    string inverseType(string type2) pure
    {
        int[UNITS_LEN] a;
        extract(type2, a, -1);
        
        return build(a);
    }

    string powerType(string type, int pwr) pure
    {
        int[UNITS_LEN] a;
        extract(type, a);
        
        foreach(ref b ; a)
        {
            b *= pwr;
        }
        
        return build(a);
    }

    string rootType(string type, int pwr) pure
    {
        int[UNITS_LEN] a;
        extract(type, a);
        
        foreach(ref b ; a)
        {
            assert((b%pwr) == 0);
            b /= pwr;
        }
        
        return build(a);
    }

    string standard(string type) pure
    {
        switch (type)
        {
            case "kgm2s-2" : return "J";
            case "kg-1m-2s2" : return " 1/J";
            
            case "kgm2s-3" : return "W";
            case "kg-1m-2s3" : return " 1/W";
            
            case "kgms-2" : return "N";
            case "kg-1m-1s2" : return " 1/N";
            
            case "kgm-1s-2" : return "Pa";
            case "kg-1ms2" : return " 1/Pa";
            
            case "kgm2s-3A-1" : return "V";
            case "kg-1m-2s3A" : return " 1/V";
            
            case "kgm2s-3A-2" : return "Ohm";
            case "kg-1m-2s3A2/" : return " 1/Ohm";
            
            case "Cyl" : return "Cycles";
            case "Cyl-1" : return " 1/Cycles";
            
            case "s-1Cy" : return "Hz";
            case "sCyl-1" : return " 1/Hz";
            
            case "K" : return "'K";
            
            default: return type;
        }
    }

    string standardInv(string type) pure
    {
        switch (type)
        {
            case "J" : return "kgm2s-2";
            
            case "W" : return "kgm2s-3";
            
            case "N" : return "kgms-2";
            
            case "Pa" : return "kgm-1s-2";
            
            case "V" : return "kgm2s-3A-1";
            
            case "Ohm" : return "kgm2s-3A-2";
            
            case "Hz" : return "s-1Cyl";
            
            case "'K" : return "K";
            
            default: return standardType(type);
        }
    }

    void extract(string type, int[] a) pure
    {
        extract(type, a, 1);
    }

    void extract(string type, int[] a, const(int)inv) pure
    {
        while (type.length > 0)
        {
            int mul = inv;
            
            if (type[0] == ' ')
            {
                // Ignore spaces
                type = type[1..$];
            }
            else
            {
                int idx = 8;   // Default is error
                
                // Read the SI unit
                switch (type[0])
                {
                    case 'k':
                    {
                        if ((type.length > 2) && (type[0..2] == "kg"))
                        {
                            idx = 0;
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
                    
                    case 'm':
                    {
                        if ((type.length > 2) && (type[0..3] == "mol"))
                        {
                            idx = 5;
                            type = type[3..$];
                        }
                        else
                        {
                            idx = 1;
                            type = type[1..$];
                        }
                    }
                    break;
                    
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
                    
                    case 'C': idx = 7; type = type[1..$]; break;
                    {
                        if ((type.length > 2) && (type[0..3] == "Cyl"))
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
            
                // Check the sign of the power
                if ((type.length > 0) && (type[0] == '-'))
                {
                    mul = -mul;
                    type = type[1..$];
                }
                
                // Read the power
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


    string build(int[] a) pure
    {
        int idx = 0;
        char[32] type;
        
        for (int i = 0; (i < 8); i += 1)
        {
            if (a[i] != 0)
            {
                // Write the SI unit
                switch(i)
                {
                    // kg, m, s, A, K, mol, cd, Cyl, Error
                    case 0: type[idx..idx+2] = "kg"; idx += 2; break;
                    case 1: type[idx++] = 'm'; break;
                    case 2: type[idx++] = 's'; break;
                    case 3: type[idx++] = 'A'; break;
                    case 4: type[idx++] = 'K'; break;
                    case 5: type[idx..idx+3] = "mol"; idx += 3; break;
                    case 6: type[idx..idx+2] = "cd";  idx += 2; break;
                    case 7: type[idx..idx+3] = "Cyl"; idx += 2; break;
                    default: break;
                }
                
                // Check the sign
                int power  = a[i];
                bool force = false;
                if (power < 0)
                {
                    power = -power;
                    force = true;
                    type[idx++] = '-';
                }
            
                switch(power)
                {
                    case 1: if (force) type[idx++] = '1'; break;
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
}

private
{
    unittest
    {
        writeln("BaseUnits Test 1");
        
        assert(powerType("ms-2", 2) == "m2s-4");
        assert(rootType("m2s-4", 2) == "ms-2");
    }
}
