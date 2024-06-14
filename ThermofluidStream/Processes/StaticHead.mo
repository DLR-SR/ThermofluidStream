within ThermofluidStream.Processes;
model StaticHead "Static head model"
  extends ThermofluidStream.Interfaces.SISOFlow(final L=L_value, final clip_p_out=true);

  parameter Modelica.Units.SI.Length fromPosition[3]
    "Coordinates for the position the static head is computed from" annotation (Dialog(group="Geometry",
        enable=true));
  parameter Modelica.Units.SI.Length toPosition[3]
    "Coordinates for the position the static head is computed to" annotation (Dialog(group="Geometry",
        enable=true));

  parameter ThermofluidStream.Utilities.Units.Inertance L_value=dropOfCommons.L
    "Inertance of pipe" annotation (Dialog(tab="Advanced", enable=not computeL));

  parameter Modelica.Units.SI.Density rho_min=dropOfCommons.rho_min
    "Minimal input density" annotation (Dialog(tab="Advanced"));

    Modelica.Units.SI.Length staticHead "static head in m";
    Modelica.Units.SI.Pressure staticHead_Pa_relative "static head measured i Pa, taking current acceleration and limitations into account";
 parameter Boolean displayPositions=true "show positions in icon";
protected
  Modelica.Units.SI.Density rho_in=max(rho_min, Medium.density(inlet.state))
    "Density of medium entering";
    outer ThermofluidStream.Boundaries.AccelerationBoundary acceleration;
equation
  dp = -(fromPosition - toPosition)*acceleration.a*rho_in;
  h_out = h_in;
  Xi_out = Xi_in;
  // If the inlet pressure is not sufficient to overcome the acceleration field
  // between the pipe ends the static head is less than the length given by
  // the position difference in the direction of the acceleration field.
  // The outlet pressure is set to >= p_min automatically when clip_p_out = true

  staticHead= sign(dp)*(p_out-p_in)/max(abs(dp),1e-12)*(fromPosition - toPosition)*Modelica.Math.Vectors.normalize(acceleration.a);
  staticHead_Pa_relative=p_out-p_in;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-56,54},{64,-66}},
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
          extent={{-60,60},{60,-60}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(visible=displayPositions,
          extent={{-164,118},{0,18}},
          textColor={28,108,200},
          textString="%fromPosition"),
        Text(
          visible=displayPositions,
          extent={{0,-20},{162,-118}},
          textColor={28,108,200},
textString="%toPosition"),
        Line(
          points={{28,72},{-16,14}},
          color={206,103,0},
          thickness=1),
        Text(
          extent={{-46,4},{8,-38}},
          textColor={206,103,0},
          textString="a"),
        Line(
          points={{-18,12},{-16,28}},
          color={206,103,0},
          thickness=1),
        Line(
          points={{-18,12},{-4,16}},
          color={206,103,0},
          thickness=1),
        Line(
          points={{-2,0},{0,16}},
          color={206,103,0},
          thickness=1),
        Line(
          points={{44,60},{0,2}},
          color={206,103,0},
          thickness=1),
        Line(
          points={{-2,0},{12,4}},
          color={206,103,0},
          thickness=1),
        Line(
          points={{14,-12},{16,4}},
          color={206,103,0},
          thickness=1),
        Line(
          points={{60,48},{16,-10}},
          color={206,103,0},
          thickness=1),
        Line(
          points={{14,-12},{28,-8}},
          color={206,103,0},
          thickness=1)}),  Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Implementation of static head in a pipe. </p>
<p><span style=\"font-family: Arial;\">To specify the acceleration vector, please use the&nbsp;<a href=\"modelica://ThermofluidStream.Boundaries.AccelerationBoundary\">AccelerationBoundary</a>&nbsp;component.</span></p>
<p>Default is pure graviation in the negative z-direction.</p>
<p>Energy is moved between potential energy in an acceleration field and internal energy (pressure).</p>
<p>The main assumption is that the density is constant for the pressure change along the pipe. That would be the case for non-compressible fluids and many gases at low Mach numbers. For more insight in this look into the difference between the simplified and generalised forms of the Bernoulli equation.</p>
<p>Note that it is only the position difference that influence the pressure difference, not the absolute positions. If&nbsp;the&nbsp;inlet&nbsp;pressure&nbsp;is&nbsp;not&nbsp;sufficient&nbsp;to&nbsp;overcome&nbsp;the&nbsp;acceleration&nbsp;field between&nbsp;the&nbsp;pipe&nbsp;ends&nbsp;the&nbsp;static&nbsp;head&nbsp;is&nbsp;less&nbsp;than&nbsp;the&nbsp;length&nbsp;given&nbsp;by&nbsp;the&nbsp;position&nbsp;difference in the acceleration direction.</p>
<p><span style=\"font-family: Arial; color: #ff5500;\">Beware: This is a new addition to the library. It may be subject to design reconsiderations in future versions</span></p>
</html>", revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"));
end StaticHead;
