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
        
        auto unity()
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
            return BaseUnits!(combineDiv("1", type))(lhs/this.value);
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
}
 
public // Specific Types and Constants 
{
    ///////////////////////////////////////////////////
    // km, g, s, A, K, mol, cd, Cyl
    
    alias Length = BaseUnits!"m";
    
    enum um = Length(1.0E-6);
    enum mm = Length(1.0E-3);
    enum cm = Length(1.0E-2);
    enum dm = Length(1.0E-1);
    enum  m = Length(1.0);
    enum km = Length(1.0E3);
    
    alias Mass = BaseUnits!"kg";
    
    enum mg = Mass(1.0E-3);
    enum cg = Mass(1.0E-2);
    enum dg = Mass(1.0E-1);
    enum  g = Mass(1.0);
    enum kg = Mass(1.0E3);
    
    alias Time = BaseUnits!"s";
    
    enum ms   = Time(1.0E-3);
    enum cs   = Time(1.0E-2);
    enum ds   = Time(1.0E-1);
    enum  s   = Time(1.0);
    enum min  = Time(60.0);
    enum hour = Time(3600.0);
    enum day  = Time(24.0*3600.0);
    
    alias Current = BaseUnits!"A";
    
    enum mA = Current(1.0E-3);
    enum cA = Current(1.0E-2);
    enum dA = Current(1.0E-1);
    enum  A = Current(1.0);
    enum kA = Current(1.0E3);
    
    alias Kelvin = BaseUnits!"K";
    
    enum K = Kelvin(1.0);
    
    alias Substance = BaseUnits!"mol";
    
    enum mol = Substance(1.0);
    
    alias Luminosity = BaseUnits!"cd";
    
    enum cd = Luminosity(1.0);
    
    alias Cycles = BaseUnits!"Cyl";
    
    enum Cyl = Luminosity(1.0);
    
    ////////////////////////////////////////////////////////////////
    
    alias Area = BaseUnits!"m2";
    
    enum um2 = Area(1.0E-12);
    enum mm2 = Area(1.0E-6);
    enum cm2 = Area(1.0E-4);
    enum dm2 = Area(1.0E-2);
    enum  m2 = Area(1.0);
    enum km2 = Area(1.0E6);
    
    alias Volume = BaseUnits!"m3";
    
    enum um3 = Volume(1.0E-18);
    enum mm3 = Volume(1.0E-9);
    enum cm3 = Volume(1.0E-6);
    enum dm3 = Volume(1.0E-3);
    enum  m3 = Volume(1.0);
    enum km3 = Volume(1.0E9);
    
    alias Energy = BaseUnits!"kgm2/s2";
    
    enum uJ = Energy(1.0E-6);
    enum mJ = Energy(1.0E-3);
    enum cJ = Energy(1.0E-2);
    enum dJ = Energy(1.0E-1);
    enum  J = Energy(1.0);
    enum kJ = Energy(1.0E3);
    enum MJ = Energy(1.0E6);
    
    alias Power = BaseUnits!"kgm2/s3";
    
    enum uW = Power(1.0E-6);
    enum mW = Power(1.0E-3);
    enum cW = Power(1.0E-2);
    enum dW = Power(1.0E-1);
    enum  W = Power(1.0);
    enum kW = Power(1.0E3);
    enum MW = Power(1.0E6);
    
    alias Force = BaseUnits!"kgm/s2";
    
    enum uN = Force(1.0E-6);
    enum mN = Force(1.0E-3);
    enum cN = Force(1.0E-2);
    enum dN = Force(1.0E-1);
    enum  N = Force(1.0);
    enum kN = Force(1.0E3);
    enum MN = Force(1.0E6);
    
    alias Pressure = BaseUnits!"kg/ms2";
    
    enum uPa = Pressure(1.0E-6);
    enum mPa = Pressure(1.0E-3);
    enum cPa = Pressure(1.0E-2);
    enum dPa = Pressure(1.0E-1);
    enum  Pa = Pressure(1.0);
    enum kPa = Pressure(1.0E3);
    enum MPa = Pressure(1.0E6);
    
    enum ubar = Pressure(1.0E-1);
    enum mbar = Pressure(1.0E2);
    enum cbar = Pressure(1.0E1);
    enum dbar = Pressure(1.0E2);
    enum  bar = Pressure(1.0E3);
    enum kbar = Pressure(1.0E8);
    enum Mbar = Pressure(1.0E11);
    
    enum upsi = Pressure(6894.757E-6);
    enum mpsi = Pressure(6894.757-3);
    enum cpsi = Pressure(6894.757E-2);
    enum dpsi = Pressure(6894.757E-1);
    enum  psi = Pressure(6894.757);
    enum kpsi = Pressure(6894.757E3);
    enum Mpsi = Pressure(6894.757E6);
    
    alias Volts = BaseUnits!"kgm2/s3A";
    
    enum uV = Volts(1.0E-6);
    enum mV = Volts(1.0E-3);
    enum cV = Volts(1.0E-2);
    enum dV = Volts(1.0E-1);
    enum  V = Volts(1.0);
    enum kV = Volts(1.0E3);
    enum MV = Volts(1.0E6);
    
    alias Ohms = BaseUnits!"kgm2/s3A2";
    
    enum uOhm = Ohms(1.0E-6);
    enum mOhm = Ohms(1.0E-3);
    enum cOhm = Ohms(1.0E-2);
    enum dOhm = Ohms(1.0E-1);
    enum  Ohm = Ohms(1.0);
    enum kOhm = Ohms(1.0E3);
    enum MOhm = Ohms(1.0E6);
    
    alias Wavelength = BaseUnits!"m/Cyl";
    
    alias Velocity = BaseUnits!"m/s";
    
    alias Acceleration = BaseUnits!"m/s2";
    
    /////////////////////////////////////////////////////
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

    string standard(string type) pure
    {
        switch (type)
        {
            case "kgm2/s2" : return "J";
            case "s2/kgm2" : return " 1/J";
            
            case "kgm2/s3" : return "W";
            case "kgs3/m2" : return " 1/W";
            
            case "kgm/s2" : return "N";
            case "s2/kgm" : return " 1/N";
            
            case "kg/ms2" : return "Pa";
            case "ms2/kg" : return " 1/Pa";
            
            case "kgm2/s3A" : return "V";
            case "s3A/kgm2" : return " 1/V";
            
            case "kgm2/s3A2" : return "Ohm";
            case "s3A2/kgm2" : return " 1/Ohm";
            
            case "Cyl" : return "Cycles";
            case "1/Cyl" : return " 1/Cycles";
            
            case "Cyl/s" : return "Hz";
            case "s/Cyl" : return " 1/Hz";
            
            case "K" : return "'K";
            
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
                type = type[1..$];
            }
            else if (type[0] == '1')
            {
                type = type[1..$];
            }
            else if (type[0] == ' ')
            {
                type = type[1..$];
            }
            else
            {
                int idx = 8;   // Default ios error
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
            type[idx++] = ' ';
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
                    // kg, m, s, A, K, mol, cd, Cyl, Error
                    case 0: type[idx..idx+2] = "kg"; idx += 2; break;
                    case 1: type[idx++] = 'm'; break;
                    case 2: type[idx++] = 's'; break;
                    case 3: type[idx++] = 'A'; break;
                    case 4: type[idx++] = 'K'; break;
                    case 5: type[idx..idx+3] = "mol"; idx += 3; break;
                    case 6: type[idx..idx+2] = "cd";  idx += 2; break;
                    case 7: type[idx..idx+2] = "Cyl"; idx += 2; break;
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
}

public   // Centigrade
{
    struct Centigrade
    {
        this(const(Centigrade) other)
        {
            this.value = other.value;
        }
        
        this(const(Kelvin) other)
        {
            this.value = other.value - 273.15;
        }
        
        Kelvin opCast(T)()
            if (is(T == Kelvin))
        {
            return Kelvin(value + 273.15);
        }
        
        string toString() const
        {
            return format!("%G'C")(this.value);
        }
        
        private this(const(double) value)
        {
            this.value = value;
        }

        auto opBinary(string op : "*")(const(double) rhs) const
        {
            return Centigrade(this.value * rhs);
        }

        const(double) opBinary(string op : "/")(const(Centigrade) rhs) const
        {
            return (this.value * rhs.value);
        }
        
        auto opBinaryRight(string op : "*")(const(double) lhs) const
        {
            return Centigrade(this.value * lhs);
        }

        auto opBinary(string op : "/")(const(double) rhs) const
        {
            return Centigrade(this.value / rhs);
        }

        auto opBinary(string op : "+")(const(Centigrade) rhs) const
        {
            return Centigrade(this.value + rhs.value);
        }
        
        auto opBinary(string op : "-")(const(Centigrade) rhs) const
        {
            return Centigrade(this.value - rhs.value);
        }

        auto opOpAssign(string op : "*")(const(double) rhs)
        {
            return Centigrade(this.value *= rhs);
        }

        auto opOpAssign(string op : "/")(const(double) rhs)
        {
            return Centigrade(this.value /= rhs);
        }

        auto opOpAssign(string op : "+")(const(Centigrade) rhs)
        {
            return Centigrade(this.value += rhs.value);
        }
        
        auto opOpAssign(string op : "-")(const(Centigrade) rhs)
        {
            return Centigrade(this.value -= rhs.value);
        }
        
        int opCmp(const(Centigrade) rhs) const
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
    
    bool opEquals(string type)(const(Centigrade) a, const(Centigrade) b)
    {
        return a.value == b.value;
    }
    
        
    auto abs(string type)(const(Centigrade) rhs)
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
    
    enum Centigrade C = Centigrade(1.0);
}

public   // Rankine
{
    struct Rankine
    {
        this(const(Rankine) other)
        {
            this.value = other.value;
        }
        
        this(const(Kelvin) other)
        {
            this.value = other.value*9.0/5.0;
        }
        
        Kelvin opCast(T)()
            if (is(T == Kelvin))
        {
            return Kelvin(value*5.0/9.0);
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
        
        this(const(Kelvin) other)
        {
            this.value = ((other.value - 273.15)*9.0/5.0)+32.0;
        }
        
        Kelvin opCast(T)()
            if (is(T == Kelvin))
        {
            return Kelvin(((value - 32.0)*5.0/9.0) +273.15);
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

private  // Unit Tests
{
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
        auto c = a* b;
        assert(c.toString() == "35m2");
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
        
        BaseUnits!" 1/m" b = 2/a;
        assert(abs(b - BaseUnits!" 1/m"(2.0/7.0)) < BaseUnits!" 1/m"(1E-6));
        
        a = 2/b;
        assert(abs(a - (7*m)) < 1E-6*m);
        
        auto c = 1/m;
        auto d = 1/c;
        assert(c.toString() == "1 1/m");
        assert(d.toString() == "1m");
    }

    unittest
    {
        writeln("Units Test 6");
        Length a = 2*m;
        Area b = 3*m2;
        
        Volume c = a*b;
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
        
        assert(J.toString() == "1J");
        assert(W.toString() == "1W");
    }

    unittest
    {
        writeln("Units Test 9");
        
        Kelvin     a = 2*K;
        Centigrade b = 3*C;
        Rankine    c = 4*R;
        Fahrenheit d = 5*F;
        
        assert(a.toString() == "2'K");
        assert(b.toString() == "3'C");
        assert(c.toString() == "4'R");
        assert(d.toString() == "5'F");
        
        a = cast(Kelvin)b;
        assert(a.toString() == "276.15'K");
        b = cast(Centigrade)a;
        assert(b.toString() == "3'C");
        
        a = cast(Kelvin)c;
        assert(a.toString() == "2.22222'K");
        c = cast(Rankine)a;
        assert(c.toString() == "4'R");
        
        a = cast(Kelvin)d;
        assert(a.toString() == "258.15'K");
        d = cast(Fahrenheit)a;
        assert(d.toString() == "5'F");
    }

    unittest
    {
        writeln("Units Test 10");
        
        Volts   a = 5*V;
        Current b = 2*A;
        
        Power c = a*b;
        Ohms  d = a/b;
        
        assert(c.toString() == "10W");
        assert(d.toString() == "2.5Ohm");
    }
}
