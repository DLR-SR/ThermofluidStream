within ThermofluidStream.Undirected.HeatExchangers.Internal;
model ConductionElementHEX "ConductionElement for single-phase fluids"

  extends PartialConductionElementHEX;

  parameter SI.CoefficientOfHeatTransfer U_nom = 3000 "Nominal heat transfer coefficient to medium";
  parameter SI.MassFlowRate m_flow_nom = 1 "Nominal mass flow rate for heat transfer calculation"
    annotation(Dialog(group = "Heat transfer parameters"));

  constant Real Re_exp = 0.8 "Reynolds-exponent for heat transfer calculation";

initial equation
  assert(init <> Processes.Internal.InitializationMethodsCondElement.port, "This initialization will lead to large nonlinear equation systems. Please choose 'T0', 'h0', 'rear' or 'fore'.");

equation
  //Estimation of heat transfer coefficient
  U = max(U_min, U_nom*(abs(m_flow/(m_flow_nom/nCellsParallel)))^Re_exp);

  annotation (Dialog(tab="Initialization", group="Enthalpy"),
              Icon(coordinateSystem(preserveAspectRatio=true)),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Undirected implementation of the Conduction Element for the DiscritizedHex.</p>
<p>Concerning the heat transfer it is assumed, that the main term influencing the coefficient of heat transfer is the mass flow rate. Therefore a nominal value for the heat transfer coefficient at a nominal mass flow rate can be set. Furthermore a minimum value U_min for the coefficient of heat transfer is set to ensure heat transfer at zero mass flow.</p>
<p>For further documentation see the documentation of the motherclass.</p>
</html>"));
end ConductionElementHEX;
