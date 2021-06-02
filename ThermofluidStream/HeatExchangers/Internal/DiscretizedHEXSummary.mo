within ThermofluidStream.HeatExchangers.Internal;
record DiscretizedHEXSummary "Summary Record for Discretized Heat Exchangers"

  //In- and outlet temperatures
  SI.Temperature Tin_air "Temperature at air outlet";
  SI.Temperature Tout_air "Temperature at air outlet";
  SI.Temperature Tin_ref "Temperature at refrigerant inlet";
  SI.Temperature Tout_ref "Temperature at refrigerant outlet";

  //In- and outlet enthalpies
  SI.SpecificEnthalpy hin_air "Enthalpy at air inlet";
  SI.SpecificEnthalpy hout_air "Enthalpy at air outlet";
  SI.SpecificEnthalpy hin_ref "Enthalpy at refrigerant inlet";
  SI.SpecificEnthalpy hout_ref "Enthalpy at refrigerant outlet";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DiscretizedHEXSummary;
