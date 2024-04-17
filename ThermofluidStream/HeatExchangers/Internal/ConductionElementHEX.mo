within ThermofluidStream.HeatExchangers.Internal;
model ConductionElementHEX "ConductionElement for single-phase fluids"
  extends PartialConductionElementHEX;

  parameter SI.CoefficientOfHeatTransfer U_nom = 3000 "Nominal thermal transmittance";
  parameter SI.MassFlowRate m_flow_nom = 1 "Nominal mass flow rate (for heat transfer calculation)";

  constant Real Re_exp(unit="1") = 0.8 "Reynolds-exponent for heat transfer calculation";

equation
  //Estimation of heat transfer coefficient
  U = max(U_min, U_nom*(abs(m_flow/(m_flow_nom/nCellsParallel)))^Re_exp);

  annotation (Icon(coordinateSystem(preserveAspectRatio=true)),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Implementation of the Conduction Element for the DiscritizedHex.</p>
<p>Concerning the heat transfer it is assumed, that the main term influencing the coefficient of heat transfer is the mass flow rate. Therefore a nominal value for the heat transfer coefficient at a nominal mass flow rate can be set. Furthermore a minimum value U_min for the coefficient of heat transfer is set to ensure heat transfer at zero mass flow.</p>
<p>For further documentation see the documentation of the motherclass.</p>
</html>"));
end ConductionElementHEX;
