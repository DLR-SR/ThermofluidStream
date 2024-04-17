within ThermofluidStream.Undirected.Boundaries;
model Reservoir "Simple open tank model"

  extends Internal.PartialVolume(final useHeatport=false, final initialize_pressure=false, final A=0, final U=0);

  parameter Boolean pEnvFromInput = false "=true, if environmental pressure input connector is enabled"
    annotation(Dialog(group="Environmental pressure"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Pressure p_env_par=1e5 "Environmental pressure set value"
    annotation(Dialog(group="Environmental pressure",enable=not pEnvFromInput));
  parameter SI.Area A_surf(displayUnit="cm2")=0.01 "Base area";
  parameter SI.Height height_0(displayUnit="cm")=0.1 "Start value of tank level"
    annotation(Dialog(tab="Initialization"));
  parameter SI.Acceleration g = dropOfCommons.g "Gravitational acceleration";
  parameter SI.Height height_min = 0.01 "Minimum tank level"
    annotation(Dialog(tab="Advanced"));

  Modelica.Blocks.Interfaces.RealInput pEnv_input(unit="Pa") = p_env if pEnvFromInput "Environmental pressure input connector [Pa]"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,100}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));

  SI.Height height "Tank level";

protected
  SI.Pressure p_env "Environmental pressure";

initial equation
  height = height_0;

equation
  assert(height > height_min, "Tank level must be greater than height_min", dropOfCommons.assertionLevel);

  density_derp_h = 1/(height*g);

  V = A_surf*height;
  medium.p = p_env + M/A_surf*g;
  W_v = -der(V)*p_env;

  if not pEnvFromInput then
    p_env = p_env_par;
  end if;

  state_out_rear = medium.state;
  state_out_fore = medium.state;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Rectangle(
          extent={{-62,98},{64,12}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
       Text(visible=displayInstanceName,
          extent={{-150,60},{150,100}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Line(visible= not displayInstanceName and pEnvFromInput, points={{0,60},{0,100}}, color={0,0,127}),
        Ellipse(
          extent={{-56,52},{64,-8}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-58,22},{64,-56}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-56,-28},{64,-88}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-100,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-60,-20},{60,-80}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,28},{60,-50}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-60,28},{-60,-52}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{60,28},{60,-52}},
          color={28,108,200},
          thickness=0.5),
       Ellipse(
          extent={{-54,-46},{54,6}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Backward),
        Polygon(
          points={{0,-12},{20,-32},{-20,-32}},
          fillPattern=FillPattern.Solid,
          fillColor={28,108,200},
          pattern=LinePattern.None),
        Line(
          points={{0,-72},{0,-12}},
          color={28,108,200},
          thickness=0.5),
        Polygon(
          points={{0,-74},{20,-54},{-20,-54}},
          fillPattern=FillPattern.Solid,
          fillColor={28,108,200},
          pattern=LinePattern.None),
        Ellipse(
          extent={{-60,60},{60,0}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid)}),
            Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>
This is a volume, that is open at the top and therefore maintains environmental
pressure at the top and adds pressure depending on fill height.
</p>
<p>
Conceptually it is a Sink and a Source. It therefore defines the level of inertial
pressure r and acts as a loop breaker in a closed loop.
</p>
<p>
This component uses a simplification (medium.p is set to p_env + height*g, which
is only correct at the bottom of the reservoir) which is intended to hold for
media with low compressibility.
</p>
<p>
<strong>Note that the energy equation requires the mass in the system to be 
positive and will not give valid results otherwise (if the assert of 
height &gt; 0 fails).</strong>
</p>
</html>"));
end Reservoir;
