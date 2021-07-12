within ThermofluidStream.Examples;
model SimpleAirCycle "Basic bootstrap cooling cycle"
  import ThermofluidStream;
  extends Modelica.Icons.Example;

  replaceable package medium_ram = ThermofluidStream.Media.myMedia.Air.MoistAir
                                                                          constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
                                                        annotation(choicesAllMatching = true);
  replaceable package medium_bleed = ThermofluidStream.Media.myMedia.Air.MoistAir
                                                                            constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
                                                     annotation(choicesAllMatching = true);


  Boundaries.Source source(redeclare package Medium=medium_ram,
    T0_par=243.15,
    p0_par=30000,
    Xi0_par={0})
    annotation (Placement(transformation(extent={{-144,96},{-124,116}})));
  Boundaries.Sink sink(redeclare package Medium=medium_ram,pressureFromInput=false,
    p0_par=22000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={104,-100})));
  Boundaries.Source source1(redeclare package Medium=medium_bleed,
    T0_par=493.15,
    p0_par=250000,
    Xi0_par={0})
    annotation (Placement(transformation(extent={{-142,-64},{-122,-42}})));
  Boundaries.Sink sink1(redeclare package Medium=medium_bleed, p0_par=75000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={152,80})));
  ThermofluidStream.HeatExchangers.CounterFlowNTU heatExchange_CounterFlowNTU(
    redeclare package MediumA = medium_ram,
    redeclare package MediumB = medium_bleed,
    A=7,
    L=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-74,36})));
  ThermofluidStream.HeatExchangers.CounterFlowNTU heatExchange_CounterFlowNTU1(
    redeclare package MediumA = medium_ram,
    redeclare package MediumB = medium_bleed,
    A=3,
    L=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-74,-26})));
  Processes.Compressor compressor(
    redeclare package Medium = medium_bleed,
    omega_from_input=false,
    initOmega=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    initPhi=true,
    redeclare function dp_tau_compressor =
        ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_const_isentrop (
  redeclare package Medium = medium_bleed,
        omega_ref=2000,
        skew=1,
        m_flow_ref=1,
        eta=0.9)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-68,8})));
  inner DropOfCommons dropOfCommons(assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-136,4},
            {-116,24}})));

  Processes.Turbine turbine(
    redeclare package Medium = medium_bleed,
    L=5e2,
    omega_from_input=false,
    redeclare function dp_tau_turbine =
        ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_const_isentrop (
        redeclare package Medium = medium_bleed,
  omega_ref=Modelica.Constants.inf,
        m_flow_ref=0.36,
        skew=-0.2,
        k=2,
        eta=0.93))
    annotation (Placement(transformation(extent={{-58,48},{-38,68}})));
  ThermofluidStream.HeatExchangers.CounterFlowNTU heatExchange_CounterFlowNTU2(
    redeclare package MediumA = medium_ram,
    redeclare package MediumB = medium_bleed,
    A=10,
    L=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={62,6})));
  Processes.Turbine turbine1(
    redeclare package Medium = medium_bleed,
    L=5e2,
    omega_from_input=false,
    initOmega=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    initPhi=true,
    redeclare function dp_tau_turbine =
        ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_const_isentrop (
        redeclare package Medium = medium_bleed,
  omega_ref=Modelica.Constants.inf,
        m_flow_ref=0.39,
        skew=-0.2,
        k=2,
        eta=0.93))
    annotation (Placement(transformation(extent={{82,48},{102,68}})));
  Topology.SplitterT1 splitterT1_1(redeclare package Medium=medium_bleed) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-44})));
  Topology.JunctionT1 junctionT1_1(redeclare package Medium=medium_ram) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-84})));
  Topology.JunctionT2 junctionT2_1(redeclare package Medium=medium_bleed) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={116,80})));
  Topology.SplitterT1 splitterT1_2(redeclare package Medium=medium_ram) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,96})));
  Processes.Fan fan(redeclare package Medium = medium_ram, redeclare function dp_tau_fan =
        ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_const_isentrop (
        redeclare package Medium = medium_ram,
  omega_ref=500,
        skew=1,
        m_flow_ref=0.21,
        eta=0.7)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-80,-66})));
  Processes.Fan fan1(redeclare package Medium = medium_ram, redeclare function dp_tau_fan =
        ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_const_isentrop (
        redeclare package Medium = medium_ram,
  omega_ref=1000,
        skew=1,
        eta=0.7)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={56,-60})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = medium_ram,
    r=0.05,
    l=40,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-40,-94},{-20,-74}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = medium_ram,
    r=0.05,
    l=40,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{40,-94},{20,-74}})));
  ThermofluidStream.Utilities.Icons.DLRLogo dLRLogo annotation (Placement(transformation(extent={{118,-120},{158,-80}})));
initial equation
  heatExchange_CounterFlowNTU.inletA.m_flow = 0.1;
  heatExchange_CounterFlowNTU.inletB.m_flow = 0.1;
  heatExchange_CounterFlowNTU2.inletA.m_flow = 0.1;
  heatExchange_CounterFlowNTU2.inletB.m_flow = 0.1;
equation
  connect(heatExchange_CounterFlowNTU.outletA, heatExchange_CounterFlowNTU1.inletA)
    annotation (Line(
      points={{-80,25},{-80,-14.8}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchange_CounterFlowNTU1.outletB, compressor.inlet)
    annotation (Line(
      points={{-68,-15},{-68,-8.5},{-68,-8.5},{-68,-2}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.outlet, heatExchange_CounterFlowNTU.inletB)
    annotation (Line(
      points={{-68,18},{-68,24.8},{-68,24.8}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine.flange, compressor.flange)
    annotation (Line(points={{-48,48},{-48,8},{-58,8}},color={0,0,0}));
  connect(turbine.inlet, heatExchange_CounterFlowNTU.outletB) annotation (Line(
      points={{-58,58},{-68,58},{-68,47},{-68,47}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine1.inlet, heatExchange_CounterFlowNTU2.outletB) annotation (
      Line(
      points={{82,58},{68,58},{68,16},{68,17},{68,17}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT1_1.outletA, heatExchange_CounterFlowNTU1.inletB)
    annotation (Line(
      points={{-10,-44},{-68,-44},{-68,-37.2},{-68,-37.2}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT1_1.outletB, heatExchange_CounterFlowNTU2.inletB)
    annotation (Line(
      points={{10,-44},{68,-44},{68,-5.2},{68,-5.2}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, splitterT1_1.inlet) annotation (Line(
      points={{-122,-53},{-6.66134e-16,-53},{-6.66134e-16,-54}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT1_1.outlet, sink.inlet) annotation (Line(
      points={{-6.66134e-16,-94},{-6.66134e-16,-100},{94,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, junctionT2_1.outlet) annotation (Line(
      points={{142,80},{126,80}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine1.outlet, junctionT2_1.inletA) annotation (Line(
      points={{102,58},{116,58},{116,70}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine.outlet, junctionT2_1.inletB) annotation (Line(
      points={{-38,58},{-30,58},{-30,80},{106,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, splitterT1_2.inlet) annotation (Line(
      points={{-124,106},{1.77636e-15,106}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT1_2.outletB, heatExchange_CounterFlowNTU.inletA) annotation (
     Line(
      points={{-10,96},{-80,96},{-80,47.2}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT1_2.outletA, heatExchange_CounterFlowNTU2.inletA)
    annotation (Line(
      points={{10,96},{56,96},{56,17.2},{56,17.2}},
      color={28,108,200},
      thickness=0.5));
  connect(fan.inlet, heatExchange_CounterFlowNTU1.outletA) annotation (Line(
      points={{-80,-56},{-80,-37},{-80,-37}},
      color={28,108,200},
      thickness=0.5));
  connect(fan.flange, turbine.flange) annotation (Line(
  points={{-70,-66},{-48,-66},{-48,48}},
  color={0,0,0}));
  connect(fan1.flange, turbine1.flange) annotation (Line(
  points={{66,-60},{92,-60},{92,48}},
  color={0,0,0}));
  connect(fan1.inlet, heatExchange_CounterFlowNTU2.outletA) annotation (Line(
      points={{56,-50},{56,-5},{56,-5}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, junctionT1_1.inletA) annotation (Line(
      points={{-20,-84},{-10,-84}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.inlet, fan.outlet) annotation (Line(
      points={{-40,-84},{-80,-84},{-80,-76}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.inlet, fan1.outlet) annotation (Line(
      points={{40,-84},{56,-84},{56,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, junctionT1_1.inletB) annotation (Line(
      points={{20,-84},{10,-84}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},{160,
            120}}),
    graphics={
        Text(
          extent={{-142,96},{-114,90}},
          lineColor={28,108,200},
          textString="ram inlet"),
        Text(
          extent={{-144,-64},{-110,-72}},
          lineColor={28,108,200},
          textString="bleed inlet"),
        Text(
          extent={{134,70},{174,62}},
          lineColor={28,108,200},
          textString="pack discharge"),
        Text(
          extent={{86,-82},{120,-90}},
          lineColor={28,108,200},
          textString="ram outlet"),
        Rectangle(extent={{-102,70},{-22,-74}}, lineColor={28,108,200}),
        Text(
          extent={{-96,78},{-38,70}},
          lineColor={28,108,200},
          textString="three weel bootsrap"),
        Rectangle(extent={{32,72},{112,-72}}, lineColor={28,108,200}),
        Text(
          extent={{60,80},{118,72}},
          lineColor={28,108,200},
          textString="simple cycle")}),
        experiment(StopTime=100, tolerance=1e-6, Interval=0.1),
        Documentation(info="<html>
<p>Very simple implementation of a bootstrap air cycle used in a aircraft ecs.</p>
<p><br>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"),
    __Dymola_experimentSetupOutput(
      derivatives=false,
      inputs=false,
      outputs=true,
      auxiliaries=false,
      events=false));
end SimpleAirCycle;
