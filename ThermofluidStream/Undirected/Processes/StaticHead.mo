within ThermofluidStream.Undirected.Processes;
model StaticHead "Static head model"
  extends ThermofluidStream.Undirected.Interfaces.SISOBiFlow(final clip_p_out=
        true);
  parameter Modelica.Units.SI.Length forePosition[3]
    "Coordinates for the position the static head is computed from" annotation (Dialog(group="Geometry",
        enable=true));
  parameter Modelica.Units.SI.Length rearPosition[3]
    "Coordinates for the position the static head is computed to" annotation (Dialog(group="Geometry",
        enable=true));

  parameter ThermofluidStream.Utilities.Units.Inertance L_value=dropOfCommons.L
    "Inertance of pipe" annotation (Dialog(tab="Advanced", enable=not computeL));

  parameter Modelica.Units.SI.Density rho_min=dropOfCommons.rho_min
    "Minimal input density" annotation (Dialog(tab="Advanced"));

    Modelica.Units.SI.Length staticHead_forwards "static head in m";
    Modelica.Units.SI.Pressure staticHead_forwards_Pa_relative "static head measured i Pa, taking current acceleration and limitations into account";
    Modelica.Units.SI.Length staticHead_rearwards "static head in m";
    Modelica.Units.SI.Pressure staticHead_rearwards_Pa_relative "static head measured i Pa, taking current acceleration and limitations into account";
 parameter Boolean displayPositions=true "show positions in icon";

protected
    outer ThermofluidStream.Boundaries.AccelerationBoundary acceleration;

equation

  //forwards model
  dp_fore = (forePosition - rearPosition)*acceleration.a*Medium.density(rear.state_forwards);
  h_fore_out = h_rear_in;
  Xi_fore_out = Xi_rear_in;
  staticHead_forwards= (p_fore_out-p_rear_in)/max(abs(dp_fore),1e-12)*(forePosition - rearPosition)*Modelica.Math.Vectors.normalize(acceleration.a);
  staticHead_forwards_Pa_relative=p_fore_out-p_rear_in;

  //rearwards model
  dp_rear = -(forePosition - rearPosition)*acceleration.a*Medium.density(fore.state_rearwards);
  h_rear_out = h_fore_in;
  Xi_rear_out = Xi_fore_in;
  staticHead_rearwards= (p_rear_out-p_fore_in)/max(abs(dp_rear),1e-12)*(forePosition - rearPosition)*Modelica.Math.Vectors.normalize(acceleration.a);
  staticHead_rearwards_Pa_relative=p_rear_out-p_fore_in;


  annotation (Documentation(info="<html>
<p><span style=\"font-family: Arial;\">Implementation of static head in a pipe. Bidirectional implementation.</span></p>
<p><span style=\"font-family: Arial;\">To specify the acceleration vector, please use the&nbsp;<a href=\"modelica://ThermofluidStream.Boundaries.AccelerationBoundary\">AccelerationBoundary</a>&nbsp;component.</span></p>
<p><span style=\"font-family: Arial;\">Default is pure graviation in the negative z-direction.</span></p>
<p>Energy is moved between potential energy in an acceleration field and internal energy (pressure).</p>
<p>The main assumption is that the density is constant for the pressure change along the pipe. That would be the case for non-compressible fluids and many gases at low Mach numbers. For more insight in this look into the difference between the simplified and generalised forms of the Bernoulli equation.</p>
<p>Note that it is only the position difference that influence the pressure difference, not the absolute positions. If&nbsp;the&nbsp;inlet&nbsp;pressure&nbsp;is&nbsp;not&nbsp;sufficient&nbsp;to&nbsp;overcome&nbsp;the&nbsp;acceleration&nbsp;field between&nbsp;the&nbsp;pipe&nbsp;ends&nbsp;the&nbsp;static&nbsp;head&nbsp;is&nbsp;less&nbsp;than&nbsp;the&nbsp;length&nbsp;given&nbsp;by&nbsp;the&nbsp;position&nbsp;difference in the acceleration direction.</p>
<p><span style=\"color: #ff5500;\">Beware: This is a new addition to the library. It may be subject to design reconsiderations in future versions</span></p>
</html>", revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"),
Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-56,54},{64,-66}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-56,52},{64,-68}},
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
          textString="%rearPosition"),
        Text(
          visible=displayPositions,
          extent={{-2,-22},{160,-120}},
          textColor={28,108,200},
          textString="%forePosition"),
        Line(
          points={{28,70},{-16,12}},
          color={206,103,0},
          thickness=1),
        Text(
          extent={{-46,4},{8,-38}},
          textColor={206,103,0},
          textString="a"),
        Line(
          points={{-18,10},{-16,26}},
          color={206,103,0},
          thickness=1),
        Line(
          points={{-18,10},{-4,14}},
          color={206,103,0},
          thickness=1),
        Line(
          points={{-2,-2},{0,14}},
          color={206,103,0},
          thickness=1),
        Line(
          points={{44,58},{0,0}},
          color={206,103,0},
          thickness=1),
        Line(
          points={{-2,-2},{12,2}},
          color={206,103,0},
          thickness=1),
        Line(
          points={{14,-14},{16,2}},
          color={206,103,0},
          thickness=1),
        Line(
          points={{60,46},{16,-12}},
          color={206,103,0},
          thickness=1),
        Line(
          points={{14,-14},{28,-10}},
          color={206,103,0},
          thickness=1)}));
end StaticHead;
