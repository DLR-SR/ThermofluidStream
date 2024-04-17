within ThermofluidStream.Examples;
model SimpleEngine "Simple steam engine"
  extends Modelica.Icons.Example;

  package Water = Media.myMedia.Water.StandardWater;


  inner DropOfCommons dropOfCommons(
    L=1e-3,
    assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{140,-34},{160,-14}})));
  Utilities.SteamSink steamSink(
    redeclare package Medium = Water,
    p0_par=100000,
    m_flow_animate=0.25)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={190,90})));

  Processes.ConductionElement conductionElement(
    redeclare package Medium = Water,
    A=20,
    init=ThermofluidStream.Processes.Internal.InitializationMethodsCondElement.T,
    T_0=573.15)
    annotation (Placement(transformation(extent={{-60,64},{-40,44}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(
    T(displayUnit="degC") = 873.15)
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Utilities.CrankDrive crankDrive(
    rodLength=3,
    crankPoint=0.25,
    translationMass=1e2,
    J_flyweel=1e2,
    phi0=-1.5707963267949)
    annotation (Placement(transformation(extent={{0,-40},{-120,-100}})));
  Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque
    linearSpeedDependentTorque(
    tau_nominal=-100,
    TorqueDirection=false,
    w_nominal=1)
    annotation (Placement(transformation(extent={{-160,-80},{-140,-60}})));

  Utilities.Piston piston(
    redeclare package Medium = Water,
    A=0.05,
    l_stroke=0.5,
    V_dead=0.2,
    outputX=false,
    initializeX=false,
    m0_left=0.1,
    m0_right=0.1,
    x0=0.5) annotation (Placement(transformation(extent={{80,-100},{20,-40}})));
  Undirected.Topology.ConnectorInletOutletFore switchConnector(
    redeclare package Medium = Water) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={70,34})));
  Undirected.Topology.ConnectorInletOutletFore switchConnector1(
    redeclare package Medium = Water) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,54})));
  FlowControl.Switch switch(redeclare package Medium = Water) annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-10,54})));
  Topology.JunctionT2 junctionT2_1(redeclare package Medium = Water)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={150,54})));
  Processes.FlowResistance flowResistance3(
    redeclare package Medium = Water,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.015,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{10,44},{30,64}})));
  Processes.FlowResistance flowResistance4(
    redeclare package Medium = Water,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.015,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-2,24},{18,44}})));
  Processes.FlowResistance flowResistance5(
    redeclare package Medium = Water,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.015,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{70,44},{90,64}})));
  Processes.FlowResistance flowResistance6(
    redeclare package Medium = Water,
    m_flowStateSelect=StateSelect.prefer,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.015,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{88,24},{108,44}})));
  FlowControl.TanValve tanValve(redeclare package Medium = Water, invertInput=false) annotation (Placement(transformation(extent={{100,64},{120,44}})));
  FlowControl.TanValve tanValve1(redeclare package Medium = Water, invertInput=true) annotation (Placement(transformation(extent={{120,24},{140,44}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal(realTrue=0.0, realFalse=1.0)
    annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=180,
        origin={-70,-16})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=0.01, initType=Modelica.Blocks.Types.Init.SteadyState)
    annotation (Placement(transformation(extent={{8,8},{-8,-8}},
        rotation=180,
        origin={-40,-16})));
  Boundaries.PhaseSeparator boiler(
    redeclare package Medium = Water,
    useHeatport=true,
    A=20,
    p_start=400000,
    V_par=0.1,
    pipe_low=0.9,
    pipe_high=0.95,
    init_method=ThermofluidStream.Boundaries.Internal.InitializationMethodsPhaseSeperator.l)
    annotation (Placement(transformation(extent={{-100,44},{-80,64}})));
  Modelica.Blocks.Continuous.LimPID PI1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e6,
    Ti=2,
    yMax=10000000,
    yMin=0,
    y_start=0) annotation (Placement(transformation(extent={{-150,24},{-130,44}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heating_element
    annotation (Placement(transformation(extent={{-120,24},{-100,44}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=4) annotation (Placement(transformation(extent={{-180,24},{-160,44}})));
  Sensors.SingleSensorSelect singleSensorSelect(
    redeclare package Medium = Water,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar,
    outputValue=true,
    filter_output=false) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-96,16})));
  Boundaries.TerminalSource terminalSource(redeclare package Medium = Water) annotation (Placement(transformation(extent={{-130,44},{-110,64}})));
  ThermofluidStream.Utilities.Icons.DLRLogo dLRLogo annotation (Placement(transformation(extent={{162,-118},{218,-62}})));
equation
  connect(fixedTemperature.port, conductionElement.heatPort) annotation (Line(points={{-60,80},{-50,80},{-50,64}},   color={191,0,0}));
  connect(linearSpeedDependentTorque.flange, crankDrive.flange_a)
    annotation (Line(points={{-140,-70},{-90,-70}},
                                                 color={0,0,0}));
  connect(switchConnector.fore, piston.port_left)
    annotation (Line(
      points={{70,24},{70,-57.4},{80,-57.4}},
      color={28,108,200},
      thickness=0.5));
  connect(switchConnector1.fore, piston.port_right)
    annotation (Line(
      points={{50,44},{50,-44},{20,-44},{20,-57.4}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.outlet, switchConnector1.inlet)
    annotation (Line(
      points={{30,54},{40,54}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.outlet,switchConnector. inlet)
    annotation (Line(
      points={{18,34},{60,34}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance5.inlet,switchConnector1. outlet) annotation (Line(
      points={{70,54},{60,54}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance6.inlet,switchConnector. outlet) annotation (Line(
      points={{88,34},{80,34}},
      color={28,108,200},
      thickness=0.5));
  connect(tanValve.inlet,flowResistance5. outlet) annotation (Line(
      points={{100,54},{90,54}},
      color={28,108,200},
      thickness=0.5));
  connect(tanValve1.inlet,flowResistance6. outlet) annotation (Line(
      points={{120,34},{108,34}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT2_1.inletB,tanValve. outlet) annotation (Line(
      points={{140,54},{120,54}},
      color={28,108,200},
      thickness=0.5));
  connect(tanValve1.outlet,junctionT2_1. inletA) annotation (Line(
      points={{140,34},{150,34},{150,44}},
      color={28,108,200},
      thickness=0.5));
  connect(switch.outletA, flowResistance3.inlet) annotation (Line(
      points={{0,54},{10,54}},
      color={28,108,200},
      thickness=0.5));
  connect(switch.outletB, flowResistance4.inlet)
    annotation (Line(
      points={{-10,44},{-10,34},{-2,34}},
      color={28,108,200},
      thickness=0.5));
  connect(crankDrive.h_out, booleanToReal.u) annotation (Line(points={{-90,-40},{-90,-16},{-79.6,-16}}, color={255,0,255}));
  connect(steamSink.inlet, junctionT2_1.outlet) annotation (Line(
      points={{190,80},{190,54},{160,54}},
      color={28,108,200},
      thickness=0.5));
  connect(booleanToReal.y, firstOrder.u) annotation (Line(points={{-61.2,-16},{-49.6,-16}},
                                                                                      color={0,0,127}));
  connect(firstOrder.y, tanValve.u) annotation (Line(points={{-31.2,-16},{-24,-16},{-24,14},{110,14},{110,46}},
                                                                                                         color={0,0,127}));
  connect(boiler.outlet, conductionElement.inlet) annotation (Line(
      points={{-80,54},{-60,54}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression1.y, PI1.u_s) annotation (Line(points={{-159,34},{-152,34}}, color={0,0,127}));
  connect(heating_element.port, boiler.heatPort) annotation (Line(points={{-100,34},{-90,34},{-90,46}}, color={191,0,0}));
  connect(singleSensorSelect.inlet, conductionElement.inlet)
    annotation (Line(
      points={{-86,16},{-70,16},{-70,54},{-60,54}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.value_out, PI1.u_m) annotation (Line(points={{-104.2,16},{-140,16},{-140,22}}, color={0,0,127}));
  connect(heating_element.Q_flow, PI1.y) annotation (Line(points={{-120,34},{-129,34}}, color={0,0,127}));
  connect(terminalSource.outlet, boiler.inlet) annotation (Line(
      points={{-110,54},{-100,54}},
      color={28,108,200},
      thickness=0.5));
  connect(switch.inlet, conductionElement.outlet) annotation (Line(
      points={{-20,54},{-40,54}},
      color={28,108,200},
      thickness=0.5));
  connect(switch.u, tanValve.u) annotation (Line(points={{-10,66},{-10,74},{-24,74},{-24,14},{110,14},{110,46}}, color={0,0,127}));
  connect(tanValve1.u, tanValve.u) annotation (Line(points={{130,42},{130,48},{122,48},{122,40},{110,40},{110,46}}, color={0,0,127}));
  connect(crankDrive.flange_b, piston.flange) annotation (Line(points={{0,-70},{20,-70}},  color={0,127,0}));
  annotation (
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    Diagram(
      coordinateSystem(preserveAspectRatio=false, extent={{-220,-120},{220,120}}),
      graphics={
        Rectangle(extent={{-192,96},{-38,6}}, lineColor={28,108,200}),
        Text(
          extent={{-188,94},{-96,82}},
          textColor={28,108,200},
          textString="Boiler and Preheater"),
        Rectangle(extent={{-30,80},{168,20}}, lineColor={28,108,200}),
        Text(
          extent={{118,78},{180,66}},
          textColor={28,108,200},
          textString="Valves"),
        Text(
          extent={{-8,-82},{86,-100}},
          textColor={28,108,200},
          textString="Piston and Crank Drive"),
        Rectangle(
          extent={{-118,-32},{90,-100}},
          lineColor={28,108,200})}),
        experiment(StopTime=25, Tolerance=1e-6, Interval=0.025),
    Documentation(info="<html>
<p>Basic model of a steam engine. STEAM AND POWER!</p>
<p><br>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end SimpleEngine;
