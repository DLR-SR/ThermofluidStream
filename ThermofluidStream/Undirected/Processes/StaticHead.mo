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
<p>Undirected implementation of the transport delay.</p>
<p>Delays the temperature and massFraction, not pressure, since pressure differences propagate with speed of sound, and since delaying only steady state pressure p not inertial pressure r might lead to undesirable behavior.</p>
<p>Note that this component uses the spatialDistribution operator, that has some artefacts (see Fig. 1) for high and low non-dimensional speeds v (possibly due to inerpolation or extrapolation of the function). Therefore minimum and maximum speed in the non-dimensional coordinate x (inlet @ x=0, outlet @ x=1) is limited. The default limits are [0.01, 50], so the delay is limited by default to [0.02s, 100s]. This limit can be adjusted in the advanced parameters tab.</p>
<p><img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Processes.Tests.TransportDelay_artefacts2.PNG\"/> <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Processes.Tests.TransportDelay_artefacts.PNG\"/> </p>
<p style=\"margin-left: 250px;\">Fig. 1: artefacts of the TransportDelay</p>
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
          points={{-100,-2},{100,-2}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-56,52},{64,-68}},
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
          color={28,108,200},
          thickness=1),
        Text(
          extent={{-46,2},{8,-40}},
          textColor={28,108,200},
          textString="a"),
        Line(
          points={{-18,10},{-16,26}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-18,10},{-4,14}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-2,-2},{0,14}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{44,58},{0,0}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-2,-2},{12,2}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{14,-14},{16,2}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{60,46},{16,-12}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{14,-14},{28,-10}},
          color={28,108,200},
          thickness=1)}));
end StaticHead;
