within ThermofluidStream.HeatExchangers.Internal;
record DiscretizedHEXSummaryAB "Summary Record for Discretized Heat Exchangers"

  //In- and outlet temperatures
  SI.Temperature Tin_A "Temperature at air outlet";
  SI.Temperature Tout_A "Temperature at air outlet";
  SI.Temperature Tin_B "Temperature at refrigerant inlet";
  SI.Temperature Tout_B "Temperature at refrigerant outlet";

  //In- and outlet enthalpies
  SI.SpecificEnthalpy hin_A "Enthalpy at air inlet";
  SI.SpecificEnthalpy hout_A "Enthalpy at air outlet";
  SI.SpecificEnthalpy hin_B "Enthalpy at refrigerant inlet";
  SI.SpecificEnthalpy hout_B "Enthalpy at refrigerant outlet";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DiscretizedHEXSummaryAB;
