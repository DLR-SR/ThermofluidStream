within ThermofluidStream.Undirected.FlowControl;
model BasicControlValve
  "Basic valve model with optional flow characteristics for incompressible fluids"
  extends ThermofluidStream.Undirected.FlowControl.Internal.PartialValve;

  import FlowCoeffType =
         ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypesBasic;

  replaceable function valveCharacteristics =
    ThermofluidStream.FlowControl.Internal.ControlValve.linearCharacteristics
    constrainedby ThermofluidStream.FlowControl.Internal.ControlValve.partialValveCharacteristics
    "Select valve characteristics"
    annotation (
      choicesAllMatching = true,
      Dialog(group = "Valve parameters"),
      Documentation(info="<html>
<p>Characteristic curve of the valve.</p>
</html>"));

  parameter FlowCoeffType flowCoefficient = FlowCoeffType.Kvs "Select type of flow coefficient" annotation(Dialog(group = "Valve parameters"));
  //Reference Values
  parameter Real Kvs(unit = "m3/h")  "Kvs-value (metric) from data sheet (valve fully open)" annotation(Evaluate = true,
    Dialog(group = "Valve parameters",enable = (flowCoefficient ==FlowCoeffType.
          Kvs)));
  parameter Real Cvs_US "Cvs-value (US [gal/min]) from data sheet (valve fully open)" annotation(Evaluate = true,
  Dialog(group = "Valve parameters",enable = (flowCoefficient ==FlowCoeffType.Cvs_US)));
  parameter Real Cvs_UK "Cvs-value (UK [gal/min]) from data sheet (valve fully open)" annotation(Evaluate = true,
  Dialog(group = "Valve parameters",enable = (flowCoefficient ==FlowCoeffType.Cvs_UK)));
  parameter SI.MassFlowRate m_flow_ref_set "Set reference mass flow in kg/s" annotation(Evaluate = true,
  Dialog(group = "Valve parameters",enable = (flowCoefficient ==FlowCoeffType.m_flow_set)));

protected
  SI.VolumeFlowRate V_flow_ref=
    if flowCoefficient == FlowCoeffType.Kvs then Kvs/secondsPerHour
    elseif flowCoefficient == FlowCoeffType.Cvs_US then (Cvs_US/1.1561)/secondsPerHour
    elseif flowCoefficient == FlowCoeffType.Cvs_UK then (Cvs_UK/0.9626)/secondsPerHour
    else m_flow_ref_set/rho_ref "Reference volume flow";

equation
  //Calculate reference mass flow from reference volume flow
  m_flow_ref = V_flow_ref*rho_ref;

  k_u = valveCharacteristics(u, k_min);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-84,0},{-40,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{40,0},{-40,0}},
          color={28,108,200},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Line(
          points={{0,0},{0,60}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{40,0},{84,0}},
          color={28,108,200},
          thickness=0.5),
        Polygon(
          points={{-20,40},{0,0},{20,40},{-20,40}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor=DynamicSelect({255,255,255}, if invertInput == true then
                  {28,108,200} else {255,255,255}),
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,20},{0,-20},{20,20},{-20,20}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor=DynamicSelect({255,255,255}, if invertInput == true then
                  {28,108,200} else {255,255,255}),
          fillPattern=FillPattern.Solid,
          origin={0,-20},
          rotation=180)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Undirected implementation of the Basic Control Valve.</p>
<p>This model serves for most incompressible applications where basic control valves are needed. </p>
<p><br>The modeler has the ability to choose between different valve characteristics and flow coefficients.</p>
<p>The three standard curve characteristics (linear, parabolic, equal-percentage) are implemented and can be chosen.</p>
<p><br>To conclude the parameterization, a flow coefficient has to be set. Most data sheets of valves deliver a corresponding &quot;KVs (CVs)&quot;-Value. Otherwise a nominal mass-flow rate can be set. </p>
<p>For incompressible flow, the reference values for density (1g/cm3) and pressure (1bar) should be unchanged.</p>
</html>"));
end BasicControlValve;
