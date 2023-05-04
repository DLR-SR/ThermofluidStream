within ThermofluidStream.Undirected.FlowControl;
model TanValve "Valve with tan-shaped flow resistance"
  extends ThermofluidStream.Undirected.Interfaces.SISOBiFlow(final clip_p_out=
        true);

  Modelica.Blocks.Interfaces.RealInput u(unit="1") "Valve control input []"
    annotation (Placement(
        transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80})));

  parameter Utilities.Units.Inertance L = dropOfCommons.L "Inertance of the flow"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean invertInput = false "Zero represents a closed valve for non-inverted, open for inverted";
  parameter SI.MassFlowRate m_flow_ref = 0.1 "Reference mass flow";
  parameter SI.Pressure p_ref = 1e5 "Reference pressure";
  parameter Real relativeLeakiness(unit="1") = 1e-3 "Imperfection of valve";

protected
  outer DropOfCommons dropOfCommons;

  Real k(unit="(Pa.s)/kg");
  Real u2(unit="1");

equation
  if invertInput then
    u2 = max(relativeLeakiness,min(1-relativeLeakiness,u));
  else
    u2 = max(relativeLeakiness,min(1-relativeLeakiness,1-u));
  end if;

  k = p_ref/m_flow_ref*tan(u2*Modelica.Constants.pi/2);

  //forwards model
  dp_fore = -k*m_flow;
  h_fore_out = h_rear_in;
  Xi_fore_out = Xi_rear_in;

  //rearwards model
  dp_rear = - dp_fore; // - because of the inverted direction
  h_rear_out = h_fore_in;
  Xi_rear_out = Xi_fore_in;

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
<p>Undirected implementation of the Tan valve. </p>
<p>The TanValve is the most basic valve and can be used when no valve type is set yet. </p>
<p>It adjusts its flow resistance coefficient according to a tangens of the input. The pole of the tan function can lead to numerical problems.</p>
</html>"));
end TanValve;
