within ThermofluidStream.Processes;
model TransportDelay "Delay model based on fluid velocity"

  extends Interfaces.SISOFlow(final clip_p_out=false);

  parameter SI.Length l "Length";
  parameter SI.Radius r "Radius";
  parameter SI.Density rho_min = dropOfCommons.rho_min "Minimum density"
    annotation(Dialog(tab="Advanced"));
  parameter Real v_min(unit="1/s", min=0) = 0.01 "Minimum nondimensional speed"
    annotation(Dialog(tab="Advanced"));
  parameter Real v_max(unit="1/s", min=0) = 50 "Maximum nondimensional speed"
    annotation(Dialog(tab="Advanced"));

  // ------ Parameter Display Configuration  ------------------------
  parameter Boolean displayLength = true "= true, if length l is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayRadius = true "= true, if radius r is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter Boolean d1l = displayParameters and displayLength  "displayLength at position 1"
    annotation(Evaluate=true, HideResult=true); //d1l -> Display at position 1 l=length
  final parameter Boolean d1r = displayParameters and displayRadius and not d1l  "displayRadius at position 1"
    annotation(Evaluate=true, HideResult=true);
  final parameter Boolean d2r = displayParameters and displayRadius and not d1r  "displayRadius at position 2"
    annotation(Evaluate=true, HideResult=true);
  //-----------------------------------------------------------------


  constant Medium.ThermodynamicState state_0 = Medium.setState_phX(Medium.p_default, Medium.h_default, Medium.X_default[1:Medium.nXi]) "Default state";
  constant SI.MassFraction Xi_0[Medium.nXi] = Medium.massFraction(state_0) "Default mass fractions";
  constant SI.SpecificVolume v_0 = 1/Medium.density(state_0) "Default specific volume";

  Real x(unit="1") "Relative position s/l";
  Real v(unit="1/s") = der(x) "Relative speed v/l";

protected
  SI.SpecificInternalEnergy u_in = Medium.specificInternalEnergy(inlet.state) "Inlet internal energy";
  SI.SpecificVolume v_in = 1/max(rho_min, Medium.density(inlet.state)) "Inlet specific volume";

  SI.SpecificInternalEnergy u_out "Outlet internal energy";
  SI.SpecificVolume v_out "Outlet specific volume";

  SI.Area A = r^2*Modelica.Constants.pi "Cross-sectional area";

initial equation
  x = 0;

equation
  v = min(v_max, max(v_min, inlet.m_flow*v_in/A/l));

  (,u_out) = spatialDistribution(u_in,
    Medium.specificInternalEnergy(Medium.setState_phX(p_out, Medium.h_default, Medium.X_default[1:Medium.nXi])),
    x,
    true,
    initialPoints = {0.0,1.0},
    initialValues = {Medium.specificInternalEnergy(state_0), Medium.specificInternalEnergy(state_0)});
  (,v_out) = spatialDistribution(v_in,
    1/max(rho_min, Medium.density(Medium.setState_phX(p_out, Medium.h_default, Medium.X_default[1:Medium.nXi]))),
    x,
    true,
    initialPoints = {0.0,1.0},
    initialValues = {v_0, v_0});
  for i in 1:Medium.nXi loop
    (,Xi_out[i]) = spatialDistribution(Xi_in[i],
      0,
      x,
      true,
      initialPoints = {0.0,1.0},
      initialValues = {Xi_0[i], Xi_0[i]});
  end for;

  dp = 0;
  h_out = u_out + p_out * v_out;
  Xi_out = Xi_in;
  annotation (Documentation(info="<html>
<p>Delays the temperature and massFraction, not pressure, since pressure differences propagate with speed of sound, and since delaying only steady state pressure p not inertial pressure r might lead to undesirable behavior.</p>
<p>Note that this component uses the spatialDistribution operator, that has some artefacts (see Fig. 1) for high and low non-dimensional speeds v (possibly due to inerpolation or extrapolation of the function). Therefore minimum and maximum speed in the non-dimensional coordinate x (inlet @ x=0, outlet @ x=1) is limited. The default limits are [0.01, 50], so the delay is limited by default to [0.02s, 100s]. This limit can be adjusted in the advanced parameters tab.</p>
<p><img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Processes.Tests.TransportDelay_artefacts2.PNG\"/> <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Processes.Tests.TransportDelay_artefacts.PNG\"/> </p>
<p style=\"margin-left: 250px;\">Fig. 1: artefacts of the TransportDelay</p>
</html>"),
Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Text(visible=d1l,
          extent={{-150,-90},{150,-120}},
          textColor={0,0,0},
          textString="l = %l"),
        Text(visible=d1r,
          extent={{-150,-90},{150,-120}},
          textColor={0,0,0},
          textString="r = %r"),
        Text(visible=d2r,
          extent={{-150,-130},{150,-160}},
          textColor={0,0,0},
          textString="r = %r"),
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
        Polygon(
           points={{-25,-43},{25,-43},{-25,43},{25,43}},
           lineColor= {28,108,200},
           lineThickness=0.5),
        Line(
          points={{0,0},{0,-30}},
          color={28,108,200},
          thickness=0.5,
          pattern=LinePattern.Dot),
        Polygon(
           points={{-25,-43},{25,-43}, {0,-30}},
           lineColor= {28,108,200},
           fillColor={28,108,200},
           fillPattern=FillPattern.Solid),
        Polygon(
           points={{-15,26},{15,26}, {0,0}},
           lineColor= {28,108,200},
           fillColor={28,108,200},
           fillPattern=FillPattern.Solid)}));
end TransportDelay;
