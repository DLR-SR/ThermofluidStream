within ThermofluidStream.Sensors.Internal;
package Types "Types used in the Sensor Package"

  extends Modelica.Icons.TypesPackage;

  type TemperatureUnit
  extends String;

    annotation (choices(
        choice="degC" "°C",
        choice="K" "Kelvin"));

  end TemperatureUnit;

  type PressureUnit
  extends String;

    annotation (choices(
        choice="Pa" "Pa",
        choice="bar" "bar"));

  end PressureUnit;

  type Quantities = enumeration(
      T_K "Temperature (K)",
      T_C "Temperature (°C)",
      p_Pa "Steadystate pressure (Pa)",
      p_bar "Steadystate pressure (bar)",
      r_Pa "Inertial pressure (Pa)",
      r_bar "Inertial pressure (bar)",
      p_total_Pa "Total pressure (Pa)",
      p_total_bar "Total pressure (bar)",
      h_Jpkg "Specific enthalpy (J/kg)",
      s_JpkgK "Specific enthropy (J/(kg.K))",
      rho_kgpm3 "Density (kg/m3)",
      v_m3pkg "Specific volume (m3/kg)",
      a_mps "Velocity of sound (m/s)",
      cv_JpkgK "Specific isochoric heatcapacity (J/(kg.K))",
      cp_JpkgK "Specific isobaric heatcapacity (J/(kg.K))",
      kappa_1 "Isentropic Exponent (1))",
      MM_kgpmol "Molar Mass (kg/Mol)");
  type MassFlowQuantities = enumeration(
      m_flow_kgps "Mass flow rate (kg/s)",
      m_flow_gps "Mass flow rate (g/s)",
      H_flow_Jps "Enthalpy flow rate (J/s)",
      S_flow_JpKs "Enthopy flow rate (J/(K.s))",
      Cp_flow_JpKs "Heat capacity flow rate (J/(K.s))",
      V_flow_m3ps "Volume flow rate (m3/s)",
      V_flow_lpMin "Volume flow rate (l/min)");
  type TwoPhaseQuantities = enumeration(
      x_kgpkg "Vapor quality (kg/kg)",
      p_sat_Pa "Saturation pressure (Pa)",
      p_sat_bar "Saturation pressure (bar)",
      T_sat_K "Saturation temperature (K)",
      T_sat_C "Saturation temperature (°C)",
      T_oversat_K "Temperature above saturation (K)",
      p_oversat_Pa "Pressure above saturation (Pa)",
      p_oversat_bar "Pressure above saturation (bar)");
  type MassFlowUnit
  extends String;

    annotation (choices(
        choice="(kg/s)" "kg/s",
        choice="(g/s)" "g/s"));

  end MassFlowUnit;

  type InitializationModelSensor = enumeration(
      steadyState
      "Steady state initialization (derivatives of states are zero)",
      state
      "Initialization with initial output state") "Initialization modes for sensor lowpass";
   annotation (Documentation(info="<html>
<p>
Types used in the Sensor Package.
</p>
</html>"));
end Types;
