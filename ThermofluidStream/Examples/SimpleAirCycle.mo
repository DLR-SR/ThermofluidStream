within ThermofluidStream.Examples;
model SimpleAirCycle "Basic bootstrap cooling cycle"
  extends Modelica.Icons.Example;

  replaceable package Medium_ram = ThermofluidStream.Media.myMedia.Air.MoistAir
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Ram air"
    annotation(choicesAllMatching = true);
  replaceable package Medium_bleed = ThermofluidStream.Media.myMedia.Air.MoistAir
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Bleed air"
    annotation(choicesAllMatching = true);

  Boundaries.Source source(
    redeclare package Medium=Medium_ram,
    T0_par=243.15,
    p0_par=30000,
    Xi0_par={0})
    annotation (Placement(transformation(extent={{-120,100},{-100,120}})));
  Boundaries.Sink sink(
    redeclare package Medium=Medium_ram,
    pressureFromInput=false,
    p0_par=22000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-110})));
  Boundaries.Source source1(
    redeclare package Medium=Medium_bleed,
    T0_par=493.15,
    p0_par=250000,
    Xi0_par={0})
    annotation (Placement(transformation(extent={{-120,-120},{-100,-100}})));
  Boundaries.Sink sink1(
    redeclare package Medium=Medium_bleed,
    p0_par=75000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,110})));
  ThermofluidStream.HeatExchangers.CounterFlowNTU heatExchange_CounterFlowNTU(
    redeclare package MediumA = Medium_ram,
    redeclare package MediumB = Medium_bleed,
    A=7,
    L=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,40})));
  ThermofluidStream.HeatExchangers.CounterFlowNTU heatExchange_CounterFlowNTU1(
    redeclare package MediumA = Medium_ram,
    redeclare package MediumB = Medium_bleed,
    A=3,
    L=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-20})));
  Processes.Compressor compressor(
    redeclare package Medium = Medium_bleed,
    omega_from_input=false,
    initOmega=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    initPhi=true,
    redeclare function dp_tau_compressor =
        ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_const_isentrop (
      omega_ref=2000,
      skew=1,
      m_flow_ref=1,
      eta=0.9)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-54,10})));
  inner DropOfCommons dropOfCommons(assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-140,0},{-120,20}})));

  Processes.Turbine turbine(
    redeclare package Medium = Medium_bleed,
    L=5e2,
    omega_from_input=false,
    redeclare function dp_tau_turbine =
        ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_const_isentrop (
      omega_ref=Modelica.Constants.inf,
      m_flow_ref=0.36,
      skew=-0.2,
      k=2,
      eta=0.93))
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
  ThermofluidStream.HeatExchangers.CounterFlowNTU heatExchange_CounterFlowNTU2(
    redeclare package MediumA = Medium_ram,
    redeclare package MediumB = Medium_bleed,
    A=10,
    L=1) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={60,10})));
  Processes.Turbine turbine1(
    redeclare package Medium = Medium_bleed,
    L=5e2,
    omega_from_input=false,
    initOmega=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    initPhi=true,
    redeclare function dp_tau_turbine =
        ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_const_isentrop (
      omega_ref=Modelica.Constants.inf,
      m_flow_ref=0.39,
      skew=-0.2,
      k=2,
      eta=0.93))
    annotation (Placement(transformation(extent={{50,50},{30,70}})));
  Topology.SplitterT1 splitterT1_1(redeclare package Medium=Medium_bleed) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-40})));
  Topology.JunctionT1 junctionT1_1(redeclare package Medium=Medium_ram) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={20,-94})));
  ThermofluidStream.Topology.JunctionT1
                      junctionT1_2(redeclare package Medium=Medium_bleed) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={0,60})));
  Topology.SplitterT1 splitterT1_2(redeclare package Medium=Medium_ram) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,90})));
  Processes.Fan fan(
    redeclare package Medium = Medium_ram,
    redeclare function dp_tau_fan =
        ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_const_isentrop (
      omega_ref=500,
      skew=1,
      m_flow_ref=0.21,
      eta=0.7)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-66,-60})));
  Processes.Fan fan1(
    redeclare package Medium = Medium_ram,
    redeclare function dp_tau_fan =
        ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_const_isentrop (
      omega_ref=1000,
      skew=1,
      eta=0.7)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={66,-60})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium_ram,
    r=0.05,
    l=40,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-40,-104},{-20,-84}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium_ram,
    r=0.05,
    l=40,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{60,-104},{40,-84}})));
  ThermofluidStream.Utilities.Icons.DLRLogo dLRLogo annotation (Placement(transformation(extent={{102,-18},{138,18}})));
initial equation
  heatExchange_CounterFlowNTU.inletA.m_flow = 0.1;
  heatExchange_CounterFlowNTU.inletB.m_flow = 0.1;
  heatExchange_CounterFlowNTU2.inletA.m_flow = 0.1;
  heatExchange_CounterFlowNTU2.inletB.m_flow = 0.1;
equation
  connect(heatExchange_CounterFlowNTU.outletA, heatExchange_CounterFlowNTU1.inletA)
    annotation (Line(
      points={{-66,30},{-66,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchange_CounterFlowNTU1.outletB, compressor.inlet)
    annotation (Line(
      points={{-54,-10},{-54,0}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.outlet, heatExchange_CounterFlowNTU.inletB)
    annotation (Line(
      points={{-54,20},{-54,30}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine.flange, compressor.flange)
    annotation (Line(points={{-40,50},{-40,10},{-44,10}},
        color={0,0,0}));
  connect(turbine.inlet, heatExchange_CounterFlowNTU.outletB) annotation (Line(
      points={{-50,60},{-54,60},{-54,50}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine1.inlet, heatExchange_CounterFlowNTU2.outletB) annotation (
      Line(
      points={{50,60},{54,60},{54,20}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT1_1.outletA, heatExchange_CounterFlowNTU1.inletB)
    annotation (Line(
      points={{-10,-40},{-54,-40},{-54,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT1_1.outletB, heatExchange_CounterFlowNTU2.inletB)
    annotation (Line(
      points={{10,-40},{54,-40},{54,5.32907e-15}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, splitterT1_1.inlet) annotation (Line(
      points={{-100,-110},{-4.44089e-16,-110},{-4.44089e-16,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT1_1.outlet, sink.inlet) annotation (Line(
      points={{20,-104},{20,-110},{100,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet,junctionT1_2. outlet) annotation (Line(
      points={{100,110},{0,110},{0,70}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine1.outlet,junctionT1_2. inletA) annotation (Line(
      points={{30,60},{10,60}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine.outlet,junctionT1_2. inletB) annotation (Line(
      points={{-30,60},{-10,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, splitterT1_2.inlet) annotation (Line(
      points={{-100,110},{-30,110},{-30,100}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT1_2.outletB, heatExchange_CounterFlowNTU.inletA) annotation (
     Line(
      points={{-40,90},{-66,90},{-66,50}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT1_2.outletA, heatExchange_CounterFlowNTU2.inletA)
    annotation (Line(
      points={{-20,90},{66,90},{66,20}},
      color={28,108,200},
      thickness=0.5));
  connect(fan.inlet, heatExchange_CounterFlowNTU1.outletA) annotation (Line(
      points={{-66,-50},{-66,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(fan.flange, turbine.flange) annotation (Line(
        points={{-56,-60},{-40,-60},{-40,50}},
        color={0,0,0}));
  connect(fan1.flange, turbine1.flange) annotation (Line(
        points={{56,-60},{40,-60},{40,50}},
        color={0,0,0}));
  connect(fan1.inlet, heatExchange_CounterFlowNTU2.outletA) annotation (Line(
      points={{66,-50},{66,0}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, junctionT1_1.inletA) annotation (Line(
      points={{-20,-94},{10,-94}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.inlet, fan.outlet) annotation (Line(
      points={{-40,-94},{-66,-94},{-66,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.inlet, fan1.outlet) annotation (Line(
      points={{60,-94},{66,-94},{66,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, junctionT1_1.inletB) annotation (Line(
      points={{40,-94},{30,-94}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    experiment(
      StopTime=100,
      Tolerance=1e-6,
      Interval=0.1),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    Diagram(
      coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},{140,120}}),
      graphics={
        Text(
          extent={{-122,98},{-94,92}},
          textColor={28,108,200},
          textString="ram inlet"),
        Text(
          extent={{-114,-90},{-80,-98}},
          textColor={28,108,200},
          textString="bleed inlet"),
        Text(
          extent={{90,100},{130,92}},
          textColor={28,108,200},
          textString="pack discharge"),
        Text(
          extent={{94,-88},{128,-96}},
          textColor={28,108,200},
          textString="ram outlet"),
        Rectangle(extent={{-78,70},{-24,-72}},  lineColor={28,108,200},
          fillColor={239,248,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-80,80},{-22,72}},
          textColor={28,108,200},
          textString="three wheel bootstrap"),
        Rectangle(extent={{26,70},{78,-72}},  lineColor={28,108,200},
          fillColor={239,248,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{26,80},{80,72}},
          textColor={28,108,200},
          textString="simple cycle")}),
    Documentation(info="<html>
<p>
Very simple implementation of a bootstrap air cycle used in an aircraft&apos;s
environmental control system (ecs).
</p>
<p>
<br>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a>
</p>
</html>"));
end SimpleAirCycle;
