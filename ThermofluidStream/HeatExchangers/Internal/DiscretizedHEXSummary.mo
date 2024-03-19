within ThermofluidStream.HeatExchangers.Internal;
record DiscretizedHEXSummary "Summary record for discretized heat exchangers"

  //Inlet and outlet temperatures
  SI.Temperature Tin_A "Temperature at inlet A";
  SI.Temperature Tout_A "Temperature at outlet A";
  SI.Temperature Tin_B "Temperature at inlet B";
  SI.Temperature Tout_B "Temperature at outlet B";

  SI.TemperatureDifference dT_A "Temperature difference of medium A";
  SI.TemperatureDifference dT_B "Temperature difference of medium B";

  //Inlet and outlet enthalpies
  SI.SpecificEnthalpy hin_A "Specific enthalpy at inlet A";
  SI.SpecificEnthalpy hout_A "Specific enthalpy at outlet A";
  SI.SpecificEnthalpy hin_B "Specific enthalpy at inlet B";
  SI.SpecificEnthalpy hout_B "Specific enthalpy at outlet B";

  SI.SpecificEnthalpy dh_A "Difference in specific enthalpy of medium A";
  SI.SpecificEnthalpy dh_B "Difference in specific enthalpy of medium B";

  SI.Power Q_flow_A "Heat flow rate into medium A";
  SI.Power Q_flow_B "Heat flow rate into medium B";

  Real efficiency(unit="1") "Heat exchanger efficiency";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DiscretizedHEXSummary;
