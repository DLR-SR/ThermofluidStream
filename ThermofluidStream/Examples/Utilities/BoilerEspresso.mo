within ThermofluidStream.Examples.Utilities;
model BoilerEspresso
  "Model of a boiler in a espresso machine."

  replaceable package Medium = myMedia.Interfaces.PartialTwoPhaseMedium "Medium model"
    annotation (Documentation(info="<html>
<p><span style=\"font-family: Courier New;\">Medium model for the water in the boiler. We alwails want both phases of the water in the boiler.</span></p>
</html>"));

  parameter SI.Pressure p_0 = 1e5 "Start pressure";
  parameter SI.Volume V = 1 "Boiler volume";
  parameter SI.ThermalConductance UA_HX = 200 "Heat transfer coefficient times contact area to medium to Water Pipe";
  parameter SI.ThermalConductance UA_heat = 200 "Heat transfer coefficient times contact area to medium to left Heatport";
  parameter Medium.MassFraction x_0 = 0.05 "Initial vapor quality of steam.";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport_heat "heatport to add heat"
    annotation(Placement(transformation(extent={{-20,-20}, {20,20}}, origin={-60,0},  rotation=0),
      iconTransformation(extent={{-10,-10}, {10,10}}, origin={-60,0},  rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport_HX "heatport to add heat"
    annotation(Placement(transformation(extent={{-20,-20}, {20,20}}, origin={60,0},   rotation=0),
    iconTransformation(extent={{-10,-10}, {10,10}}, origin={60,0},   rotation=0)));
  Interfaces.Outlet steam_out(redeclare package Medium = Medium) "ontlet for steam"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        origin={40,100},
        rotation=90), iconTransformation(
        extent={{-20,-20},{20,20}},
        origin={40,100},
        rotation=90)));
  Interfaces.Outlet water_out(redeclare package Medium = Medium) "ontlet for hot water"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        origin={-60,100},
        rotation=90), iconTransformation(
        extent={{-20,-20},{20,20}},
        origin={-40,100},
        rotation=90)));
  Interfaces.Inlet inlet(redeclare package Medium=Medium) "inlet for fresh water"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100})));
  Modelica.Blocks.Interfaces.RealOutput y_out(unit="") "Water level percentage []"
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={-100,-60})));
  Modelica.Blocks.Interfaces.RealOutput p_out(unit="Pa") "Boiler pressure [Pa]"
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={-100,60})));

  Medium.BaseProperties medium(preferredMediumStates=true, u(stateSelect=StateSelect.always)) "Medium in boiler";
  Medium.MassFraction x = Medium.vapourQuality(medium.state) "vapour quality of medium in boiler";

  SI.Mass m(stateSelect=StateSelect.always) "mass of fluid in boiler";
  SI.Energy U = m*medium.u;

protected
  outer DropOfCommons dropOfCommons;

initial equation
  medium.p = p_0;
  x = x_0;

equation
  assert( noEvent(steam_out.m_flow <= 0), "boiler massflow must be positive", dropOfCommons.assertionLevel);
  assert( noEvent(water_out.m_flow <= 0), "boiler massflow must be positive", dropOfCommons.assertionLevel);
  assert( noEvent(inlet.m_flow <= 0), "boiler massflow must be positive", dropOfCommons.assertionLevel);
  assert( noEvent(0<x and x<1), "boiler must alwails contain steam and water", dropOfCommons.assertionLevel);
  assert( noEvent(inlet.m_flow <= 0), "boiler massflow must be positive", dropOfCommons.assertionLevel);

  medium.d = m/V;
  der(m) =inlet.m_flow + steam_out.m_flow +water_out.m_flow;
  der(U) =heatport_HX.Q_flow + heatport_heat.Q_flow
    + inlet.m_flow * Medium.specificEnthalpy(inlet.state)
    + steam_out.m_flow * Medium.specificEnthalpy(steam_out.state)
    + water_out.m_flow * Medium.specificEnthalpy(water_out.state);

  steam_out.state = Medium.setDewState(Medium.setSat_T(medium.T));
  water_out.state = Medium.setBubbleState(Medium.setSat_T(medium.T));

  steam_out.r = 0;
  water_out.r = 0;
  inlet.r = medium.p - Medium.pressure(inlet.state);

  y_out = m*(1 - x)/Medium.bubbleDensity(Medium.setSat_T(medium.T))/V;
  p_out = medium.p;

  heatport_heat.Q_flow = UA_heat*(heatport_heat.T - medium.T);
  heatport_HX.Q_flow = UA_HX*(heatport_HX.T - medium.T);

  annotation(Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{0,-100},{0,0}},
          color={28,108,200},
          thickness=0.5),Ellipse(
          extent={{-56,76},{64,16}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-56,46},{64,-56}},
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
        Ellipse(
          extent={{-60,-20},{60,-80}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,50},{60,-50}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-54,-26},{54,26}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Backward),
        Ellipse(
          extent={{-60,80},{60,20}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,50},{-60,-52}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{60,50},{60,-52}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{40,24},{40,100}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-40,-54},{-40,100}},
          color={28,108,200},
          thickness=0.5)}),
     Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><span style=\"font-family: Courier New;\">A boiler with a heatport to add heat and a heat port to connect a tube as an heat exchanger. </p><p>Also there is a inlet for water and two outlets, one for water, one for steam.</span></p>
</html>"));
end BoilerEspresso;
