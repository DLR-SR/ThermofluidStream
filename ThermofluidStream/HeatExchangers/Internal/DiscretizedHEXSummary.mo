within ThermofluidStream.HeatExchangers.Internal;
record DiscretizedHEXSummary "Summary record for discretized heat exchangers"

  //In- and outlet temperatures
  SI.Temperature Tin_A "Temperature at A inlet";
  SI.Temperature Tout_A "Temperature at A outlet";
  SI.Temperature Tin_B "Temperature at B inlet";
  SI.Temperature Tout_B "Temperature at B outlet";

  SI.TemperatureDifference dT_A "Temperature difference A";
  SI.TemperatureDifference dT_B "Temperature difference B";

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
