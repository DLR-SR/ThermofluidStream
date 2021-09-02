within ThermofluidStream.HeatExchangers.Internal;
model ConductionElementHEX "Volume with quasisationary mass and heatport"
  extends Processes.Internal.PartialConductionElement(
    final init= Processes.Internal.InitializationMethodsCondElement.inlet,
    final neglectPressureChanges=true);

  parameter SI.Area A = 1 "Contact area of volume with medium";
  parameter SI.CoefficientOfHeatTransfer U_nom "Nominal coefficient of heat transfer";
  parameter SI.MassFlowRate m_flow_nom = 0.5 "Nominal mass-flow rate for heat transfer calculation";

  constant Real Re_exp(unit="1") = 0.8 "Reynolds-exponent for heat transfer calculation";
  constant SI.CoefficientOfHeatTransfer U_min = 1 "Minimum heat transfer coefficient for temperature adaption at zero massflow";

protected
  SI.CoefficientOfHeatTransfer U "Heat transfer coefficient to medium";

equation
  //Estimation of heat transfer coefficient
  U = max(U_min, U_nom*(abs(m_flow/m_flow_nom))^Re_exp);

  k = U*A;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Implementation of the Conduction Element for the DiscritizedHex.</p>
<p>Concerning the heat transfer it is assumed, that the main term influencing the coefficient of heat transfer is the mass flow rate. Therefore a nominal value for the heat transfer coefficient at a nominal mass flow rate can be set. Furthermore a minimum value U_min for the coefficent of heat transfer is set to ensure heat transfer at zero mass flow.</p>
<p>For further documentation see the documentation of the motherclass.</p>
</html>"));
end ConductionElementHEX;
