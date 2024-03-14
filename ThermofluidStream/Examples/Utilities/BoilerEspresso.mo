within ThermofluidStream.Examples.Utilities;
model BoilerEspresso
  "Model of a boiler in a espresso machine."

  replaceable package Medium = Media.myMedia.Interfaces.PartialTwoPhaseMedium
    "Medium model"
    annotation (Documentation(info="<html>
<p>
Medium model for the water in the boiler. We always want both
phases of the water in the boiler.
</p>
</html>"));

  parameter SI.Pressure p_0 = 1e5 "Start pressure";
  parameter SI.Volume V = 1 "Boiler volume";
  parameter SI.ThermalConductance UA_HX = 200 "Heat transfer coefficient times contact area to medium to Water Pipe";
  parameter SI.ThermalConductance UA_heat = 200 "Heat transfer coefficient times contact area to medium to left Heatport";
  parameter Medium.MassFraction x_0 = 0.05 "Initial vapor quality of steam.";


  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport_heat "heatport to add heat"
    annotation(Placement(transformation(extent={{-20,-20}, {20,20}}, origin={-60,0}, rotation=0),
      iconTransformation(extent={{-10,-10}, {10,10}}, origin={-60,0}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport_HX "heatport to add heat"
    annotation(Placement(transformation(extent={{-20,-20}, {20,20}}, origin={60,0}, rotation=0),
    iconTransformation(extent={{-10,-10}, {10,10}}, origin={60,0}, rotation=0)));

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
         origin={-40,100},
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

  Boundaries.PhaseSeparator2 phaseSeparator2_1(
    redeclare package Medium = Medium,
    useHeatport=true,
    A=2e5,
    U=2e5,
    p_start=p_0,
    V_par=V,
    pipe1_low=0.05,
    pipe1_high=0.1,
    pipe2_low=0.9,
    pipe2_high=0.95,
    init_method=ThermofluidStream.Boundaries.Internal.InitializationMethodsPhaseSeperator.x,
    x_0=x_0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,0})));


  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=UA_heat)
    annotation (Placement(transformation(extent={{-38,-10},{-18,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G=UA_HX)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.RealExpression p(y=phaseSeparator2_1.medium.p) annotation (Placement(transformation(extent={{-50,50},{-70,70}})));
  Modelica.Blocks.Sources.RealExpression p1(y=phaseSeparator2_1.liquid_level) annotation (Placement(transformation(extent={{-50,-70},{-70,-50}})));
equation
  connect(phaseSeparator2_1.outlet[1], water_out)
    annotation (Line(
      points={{0,10},{-1,10},{-1,40},{-40,40},{-40,100}},
      color={28,108,200},
      thickness=0.5));
  connect(phaseSeparator2_1.outlet[2], steam_out)
    annotation (Line(
      points={{0,10},{1,10},{1,40},{40,40},{40,100}},
      color={28,108,200},
      thickness=0.5));
  connect(inlet, phaseSeparator2_1.inlet)
    annotation (Line(
      points={{0,-100},{0,-10},{-6.66134e-16,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(heatport_HX, thermalConductor1.port_b) annotation (Line(points={{60,0},{40,0}}, color={191,0,0}));
  connect(thermalConductor1.port_a, phaseSeparator2_1.heatPort) annotation (Line(points={{20,0},{8,0}}, color={191,0,0}));
  connect(thermalConductor.port_b, phaseSeparator2_1.heatPort)
    annotation (Line(points={{-18,0},{-12,0},{-12,-22},{14,-22},{14,0},{8,0},{8,-4.44089e-16}}, color={191,0,0}));
  connect(thermalConductor.port_a, heatport_heat) annotation (Line(points={{-38,0},{-60,0}}, color={191,0,0}));
  connect(p.y, p_out) annotation (Line(points={{-71,60},{-100,60}}, color={0,0,127}));
  connect(p1.y, y_out) annotation (Line(points={{-71,-60},{-79.5,-60},{-79.5,-60},{-100,-60}}, color={0,0,127}));
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
          points={{40,54},{40,100}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-40,-54},{-40,100}},
          color={28,108,200},
          thickness=0.5)}),
     Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
A boiler with a heatport to add heat and a heatport to connect
a tube as a heat exchanger.
</p>
<p>
There is also an inlet for water and two outlets, one for water,
one for steam.
</p>
</html>"));
end BoilerEspresso;
