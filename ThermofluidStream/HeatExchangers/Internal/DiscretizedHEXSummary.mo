within ThermofluidStream.HeatExchangers.Internal;
record DiscretizedHEXSummary "Summary Record for Discretized Heat Exchangers"

  //In- and outlet temperatures
  SI.Temperature Tin_A "Temperature at A outlet";
  SI.Temperature Tout_A "Temperature at A outlet";
  SI.Temperature Tin_B "Temperature at B B";
  SI.Temperature Tout_B "Temperature at refrigerant outlet";

  SI.Temperature dT_A "Temperature differnce A";
  SI.Temperature dT_B "Temperature differnce B";

  //In- and outlet enthalpies
  SI.SpecificEnthalpy hin_A "Enthalpy at A inlet";
  SI.SpecificEnthalpy hout_A "Enthalpy at A outlet";
  SI.SpecificEnthalpy hin_B "Enthalpy at B inlet";
  SI.SpecificEnthalpy hout_B "Enthalpy at B outlet";

  SI.SpecificEnthalpy dh_A "Enthalpy difference A";
  SI.SpecificEnthalpy dh_B "Enthalpy difference B";

  SI.Power Q_flow_A "Heat going into A";
  SI.Power Q_flow_B "Heat going into B";

  Real efficiency(unit="1") "Heat exchanger efficiency";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DiscretizedHEXSummary;
