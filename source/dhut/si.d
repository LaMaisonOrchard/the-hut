import std.stdio;
import std.format;
import std.string;
public import baseUnits;
public import baseUnits : abs, opEquals;

public // Specific Types and Constants 
{
    ///////////////////////////////////////////////////
    // kg, m, s, A, K, mol, cd, Cyl
    
    alias Length = BaseUnits!"m";
    
    enum um = Length.unity * 1.0E-6;
    enum mm = Length.unity * 1.0E-3;
    enum cm = Length.unity * 1.0E-2;
    enum dm = Length.unity * 1.0E-1;
    enum  m = Length.unity * 1.0;
    enum km = Length.unity * 1.0E3;
    
    alias Mass = BaseUnits!"kg";
    
    enum mg = Mass.unity * 1.0E-3;
    enum cg = Mass.unity * 1.0E-2;
    enum dg = Mass.unity * 1.0E-1;
    enum  g = Mass.unity * 1.0;
    enum kg = Mass.unity * 1.0E3;
    
    alias Time = BaseUnits!"s";
    
    enum ms   = Time.unity * 1.0E-3;
    enum cs   = Time.unity * 1.0E-2;
    enum ds   = Time.unity * 1.0E-1;
    enum  s   = Time.unity * 1.0;
    enum min  = Time.unity * 60.0;
    enum hour = Time.unity * 3600.0;
    enum day  = Time.unity * 24.0*3600.0;
    
    alias Current = BaseUnits!"A";
    
    enum mA = Current.unity * 1.0E-3;
    enum cA = Current.unity * 1.0E-2;
    enum dA = Current.unity * 1.0E-1;
    enum  A = Current.unity * 1.0;
    enum kA = Current.unity * 1.0E3;
    
    alias Temperature = BaseUnits!"K";
    
    enum K = Temperature.unity;
    
    alias Substance = BaseUnits!"mol";
    
    enum mol = Substance.unity;
    
    alias Luminosity = BaseUnits!"cd";
    
    enum cd = Luminosity.unity;
    
    alias Cycles = BaseUnits!"Cyl";
    
    enum Cyl = Luminosity.unity;
    
    ////////////////////////////////////////////////////////////////
    
    alias Area = BaseUnits!"m2";
    
    enum um2 = Area.unity * 1.0E-12;
    enum mm2 = Area.unity * 1.0E-6;
    enum cm2 = Area.unity * 1.0E-4;
    enum dm2 = Area.unity * 1.0E-2;
    enum  m2 = Area.unity * 1.0;
    enum km2 = Area.unity * 1.0E6;
    
    alias Volume = BaseUnits!"m3";
    
    enum um3 = Volume.unity * 1.0E-18;
    enum mm3 = Volume.unity * 1.0E-9;
    enum cm3 = Volume.unity * 1.0E-6;
    enum dm3 = Volume.unity * 1.0E-3;
    enum  m3 = Volume.unity * 1.0;
    enum km3 = Volume.unity * 1.0E9;
    
    alias Energy = BaseUnits!"kgm2s-2";
    
    enum uJ = Energy.unity * 1.0E-6;
    enum mJ = Energy.unity * 1.0E-3;
    enum cJ = Energy.unity * 1.0E-2;
    enum dJ = Energy.unity * 1.0E-1;
    enum  J = Energy.unity * 1.0;
    enum kJ = Energy.unity * 1.0E3;
    enum MJ = Energy.unity * 1.0E6;
    
    alias Power = BaseUnits!"kgm2s-3";
    
    enum uW = Power.unity * 1.0E-6;
    enum mW = Power.unity * 1.0E-3;
    enum cW = Power.unity * 1.0E-2;
    enum dW = Power.unity * 1.0E-1;
    enum  W = Power.unity * 1.0;
    enum kW = Power.unity * 1.0E3;
    enum MW = Power.unity * 1.0E6;
    
    alias Force = BaseUnits!"kgms-2";
    
    enum uN = Force.unity * 1.0E-6;
    enum mN = Force.unity * 1.0E-3;
    enum cN = Force.unity * 1.0E-2;
    enum dN = Force.unity * 1.0E-1;
    enum  N = Force.unity * 1.0;
    enum kN = Force.unity * 1.0E3;
    enum MN = Force.unity * 1.0E6;
    
    alias Pressure = BaseUnits!"kgm-1s-2";
    
    enum uPa = Pressure.unity * 1.0E-6;
    enum mPa = Pressure.unity * 1.0E-3;
    enum cPa = Pressure.unity * 1.0E-2;
    enum dPa = Pressure.unity * 1.0E-1;
    enum  Pa = Pressure.unity * 1.0;
    enum kPa = Pressure.unity * 1.0E3;
    enum MPa = Pressure.unity * 1.0E6;
    
    enum ubar = Pressure.unity * 1.0E-1;
    enum mbar = Pressure.unity * 1.0E2;
    enum cbar = Pressure.unity * 1.0E1;
    enum dbar = Pressure.unity * 1.0E2;
    enum  bar = Pressure.unity * 1.0E3;
    enum kbar = Pressure.unity * 1.0E8;
    enum Mbar = Pressure.unity * 1.0E11;
    
    enum upsi = Pressure.unity * 6894.757E-6;
    enum mpsi = Pressure.unity * 6894.757E-3;
    enum cpsi = Pressure.unity * 6894.757E-2;
    enum dpsi = Pressure.unity * 6894.757E-1;
    enum  psi = Pressure.unity * 6894.757;
    enum kpsi = Pressure.unity * 6894.757E3;
    enum Mpsi = Pressure.unity * 6894.757E6;
    
    alias Volts = BaseUnits!"kgm2s-3A-1";
    
    enum uV = Volts.unity * 1.0E-6;
    enum mV = Volts.unity * 1.0E-3;
    enum cV = Volts.unity * 1.0E-2;
    enum dV = Volts.unity * 1.0E-1;
    enum  V = Volts.unity * 1.0;
    enum kV = Volts.unity * 1.0E3;
    enum MV = Volts.unity * 1.0E6;
    
    alias Resistance = BaseUnits!"kgm2s-3A-2";
    
    enum uOhm = Resistance.unity * 1.0E-6;
    enum mOhm = Resistance.unity * 1.0E-3;
    enum cOhm = Resistance.unity * 1.0E-2;
    enum dOhm = Resistance.unity * 1.0E-1;
    enum  Ohm = Resistance.unity * 1.0;
    enum kOhm = Resistance.unity * 1.0E3;
    enum MOhm = Resistance.unity * 1.0E6;
    
    alias Wavelength = BaseUnits!"mCyl-1";
    
    alias Velocity = BaseUnits!"ms-1";
    
    alias Acceleration = BaseUnits!"ms-2";
    
    /////////////////////////////////////////////////////
}

public   // Centigrade
{
    struct Centigrade
    {
        this(const(Centigrade) other)
        {
            this.value = other.value;
        }
        
        this(const(Temperature) other)
        {
            this.value = (other/Temperature.unity) - 273.15;
        }
        
        Temperature opCast(T)()
            if (is(T == Temperature))
        {
            return Temperature.unity*(value + 273.15);
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
    
    bool opEquals(const(Centigrade) a, const(Centigrade) b)
    {
        return a.value == b.value;
    }
    
        
    auto abs(const(Centigrade) rhs)
    {
        if (rhs.value < 0.0)
        {
            return Centigrade(-rhs.value);
        }
        else
        {
            return rhs;
        }
    } 
    
    enum Centigrade C = Centigrade(1.0);
}

private  // Unit Tests
{
    unittest
    {
        writeln("SI Units Test 1");
        assert(um.toString() == "1E-06m");
        assert(mm.toString() == "0.001m");
        assert(cm.toString() == "0.01m");
        assert(dm.toString() == "0.1m");
        assert(m.toString () == "1m");
        assert(km.toString() == "1000m");
    }

    unittest
    {
        writeln("SI Units Test 2");
        auto a = 7*m;
        auto b = m*5;
        auto c = a* b;
        assert(c.toString() == "35m2");
    }

    unittest
    {
        writeln("SI Units Test 3");
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
        writeln("SI Units Test 4");
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
        writeln("SI Units Test 5");
        Length a = 7*m;
        
        BaseUnits!"m-1" b = 2/a;
        assert(abs(b - BaseUnits!"m-1".unity*(2.0/7.0)) < BaseUnits!"m-1".unity*(1E-6));
        
        a = 2/b;
        assert(abs(a - (7*m)) < 1E-6*m);
        
        auto c = 1/m;
        auto d = 1/c;
        assert(c.toString() == "1m-1");
        assert(d.toString() == "1m");
    }

    unittest
    {
        writeln("SI Units Test 6");
        Length a = 2*m;
        Area b = 3*m2;
        
        Volume c = a*b;
    }

    unittest
    {
        writeln("SI Units Test 7");
        Length a = 2*m;
        Area   b = 3*m2;
        
        double c = a/m;
        Length d = b/m;
        
        assert(abs(c - 2.0) < 1E-6);
        assert(abs(d - BaseUnits!"m".unity*(3.0)) < BaseUnits!"m".unity*(1E-6));
    }

    unittest
    {
        writeln("SI Units Test 8");
        
        assert(J.toString() == "1J");
        assert(W.toString() == "1W");
    }

    unittest
    {
        writeln("SI Units Test 9");
        
        Temperature a = 2*K;
        Centigrade  b = 3*C;
        
        assert(a.toString() == "2'K");
        assert(b.toString() == "3'C");
        
        a = cast(Temperature)b;
        assert(a.toString() == "276.15'K");
        b = cast(Centigrade)a;
        assert(b.toString() == "3'C");
    }

    unittest
    {
        writeln("SI Units Test 10");
        
        Volts   a = 5*V;
        Current b = 2*A;
        
        Power      c = a*b;
        Resistance d = a/b;
        
        assert(c.toString() == "10W");
        assert(d.toString() == "2.5Ohm");
    }
}
