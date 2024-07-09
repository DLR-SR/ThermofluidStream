within ThermofluidStream.Sensors.Internal;
package Types "Types used in the Sensor Package"

  extends Modelica.Icons.TypesPackage;

  type TemperatureUnit
  extends String;

    annotation (choices(
        choice="K" "Kelvin",
        choice="degC" "°C"));

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
      rho_kgpm3 "Density (kg/m3)",
      v_m3pkg "Specific volume (m3/kg)",
      h_Jpkg "Specific enthalpy (J/kg)",
      s_JpkgK "Specific entropy (J/(kg.K))",
      cp_JpkgK "Specific isobaric heatcapacity (J/(kg.K))",
      cv_JpkgK "Specific isochoric heatcapacity (J/(kg.K))",
      kappa_1 "Isentropic Exponent (1))",
      a_mps "Velocity of sound (m/s)",
      MM_kgpmol "Molar Mass (kg/mol)",
      r_Pa "Inertial pressure (Pa)",
      r_bar "Inertial pressure (bar)",
      p_total_Pa "Steadystate pressure + inertial pressure (Pa)",
      p_total_bar "Steadystate pressure + inertial pressure (bar)");
  type MassFlowQuantities = enumeration(
      m_flow_kgps "Mass flow rate (kg/s)",
      m_flow_gps "Mass flow rate (g/s)",
      V_flow_m3ps "Volume flow rate (m3/s)",
      V_flow_lpMin "Volume flow rate (l/min)",
      H_flow_Jps "Enthalpy flow rate (W)",
      S_flow_JpKs "Entropy flow rate (W/K)",
      Cp_flow_JpKs "Heat capacity flow rate (W/K)");
  type TwoPhaseQuantities = enumeration(
      x_kgpkg "Vapor quality (kg/kg)",
      T_sat_K "Saturation temperature (K)",
      T_sat_C "Saturation temperature (°C)",
      p_sat_Pa "Saturation pressure (Pa)",
      p_sat_bar "Saturation pressure (bar)",
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
