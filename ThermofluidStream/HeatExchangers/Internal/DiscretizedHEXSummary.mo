within ThermofluidStream.HeatExchangers.Internal;
record DiscretizedHEXSummary "Summary Record for Discretized Heat Exchangers"

  replaceable package Medium = myMedia.Interfaces.PartialMedium;

  //In- and outlet temperatures
  Medium.Temperature Tin_air "Temperature at air outlet";
  Medium.Temperature Tout_air "Temperature at air outlet";
  Medium.Temperature Tin_ref "Temperature at refrigerant inlet";
  Medium.Temperature Tout_ref "Temperature at refrigerant outlet";

  //In- and outlet enthalpies
  Medium.SpecificEnthalpy hin_air "Enthalpy at air inlet";
  Medium.SpecificEnthalpy hout_air "Enthalpy at air outlet";
  Medium.SpecificEnthalpy hin_ref "Enthalpy at refrigerant inlet";
  Medium.SpecificEnthalpy hout_ref "Enthalpy at refrigerant outlet";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DiscretizedHEXSummary;
