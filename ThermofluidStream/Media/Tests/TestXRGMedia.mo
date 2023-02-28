within ThermofluidStream.Media.Tests;
model TestXRGMedia "Test for five XRG Media with various components"
  extends Modelica.Icons.Example;

  inner DropOfCommons dropOfCommons(assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-130,-68},{-110,-48}})));
  HeatExchangers.DiscretizedCounterFlowHEX discretizedHEX(
    redeclare package MediumA = XRGMedia.R134a_ph,
    redeclare package MediumB = XRGMedia.NH3_ph,
    redeclare model ConductionElementA = HeatExchangers.Internal.ConductionElementHEX,
    redeclare model ConductionElementB = HeatExchangers.Internal.ConductionElementHEX_twoPhase,
      initializeMassFlow=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-18,72})));
  HeatExchangers.DiscretizedCounterFlowHEX discretizedHEX1(
    redeclare package MediumA = XRGMedia.NH3_ph,
    redeclare package MediumB = XRGMedia.CO2_ph,
    redeclare model ConductionElementA =
        HeatExchangers.Internal.ConductionElementHEX,
    redeclare model ConductionElementB =
        HeatExchangers.Internal.ConductionElementHEX_twoPhase,
    initializeMassFlow=false) annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={30,56})));
  HeatExchangers.DiscretizedCounterFlowHEX discretizedHEX2(
    redeclare package MediumA = XRGMedia.CO2_ph,
    redeclare package MediumB = XRGMedia.R134a_ph,
    redeclare model ConductionElementB = HeatExchangers.Internal.ConductionElementHEX_twoPhase,
    initializeMassFlow=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-18,40})));
  HeatExchangers.CounterFlowNTU counterFlowNTU(
    redeclare package MediumA = XRGMedia.R1234yf_ph,
    redeclare package MediumB = XRGMedia.R134a_ph,
    A=10) annotation (Placement(transformation(extent={{20,14},{40,34}})));
  Boundaries.Source source(redeclare package Medium = XRGMedia.R134a_ph, p0_par=200000)
    annotation (Placement(transformation(extent={{-74,70},{-54,90}})));
  Boundaries.Volume volume(
    redeclare package Medium = XRGMedia.NH3_ph,
    useInlet=false,
    p_start=200000,
    V_par=0.1) annotation (Placement(transformation(extent={{102,54},{82,74}})));
  Boundaries.Sink sink1(redeclare package Medium = XRGMedia.NH3_ph) annotation (Placement(transformation(extent={{-38,54},{-58,74}})));
  HeatExchangers.DiscretizedCounterFlowHEX discretizedHEX4(
    redeclare package MediumA = XRGMedia.R1234yf_ph,
    redeclare package MediumB = XRGMedia.R134a_ph,
    redeclare model ConductionElementB = HeatExchangers.Internal.ConductionElementHEX_twoPhase,
    initializeMassFlow=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-34,8})));
  Boundaries.Sink sink2(redeclare package Medium = XRGMedia.CO2_ph) annotation (Placement(transformation(extent={{84,38},{104,58}})));
  Boundaries.Source source1(redeclare package Medium = XRGMedia.CO2_ph, p0_par=130000)
    annotation (Placement(transformation(extent={{-86,38},{-66,58}})));
  Boundaries.VolumeFlex volumeFlex(redeclare package Medium = XRGMedia.CO2_ph) annotation (Placement(transformation(extent={{-4,38},{16,58}})));
  Examples.Utilities.Receiver receiver(redeclare package Medium =
        XRGMedia.R134a_ph,                                                           p_start=200000)
    annotation (Placement(transformation(extent={{-36,22},{-56,42}})));
  Boundaries.Sink sink3(redeclare package Medium = XRGMedia.R134a_ph, p0_par=180000)
    annotation (Placement(transformation(extent={{-156,-10},{-176,10}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = XRGMedia.NH3_ph,
    r(displayUnit="mm") = 0.005,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={62,64})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = XRGMedia.CO2_ph,
    r(displayUnit="mm") = 0.005,
    l=15,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,48})));
  Processes.FlowResistance flowResistance3(
    redeclare package Medium = XRGMedia.CO2_ph,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.002,
    l=50,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={68,48})));
  Processes.FlowResistance flowResistance4(
    redeclare package Medium = XRGMedia.R134a_ph,
    r(displayUnit="mm") = 0.02,
    l=5,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={76,0})));
  Processes.FlowResistance flowResistance5(
    redeclare package Medium = XRGMedia.R134a_ph,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.005,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-118,32})));
  Processes.ConductionElement conductionElement(redeclare package Medium =
        XRGMedia.R134a_ph)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={34,0})));
  Topology.JunctionT2 junctionT2_1(redeclare package Medium = XRGMedia.R134a_ph)
    annotation (Placement(transformation(extent={{-142,-10},{-122,10}})));
  Topology.SplitterT2 splitterT2_1(redeclare package Medium = XRGMedia.R134a_ph)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={142,32})));
  Processes.Nozzle nozzle(redeclare package Medium = XRGMedia.R1234yf_ph, A_out=5) annotation (Placement(transformation(extent={{-14,6},{6,26}})));
  Boundaries.Source source2(redeclare package Medium = XRGMedia.R1234yf_ph) annotation (Placement(transformation(extent={{-102,6},{-82,26}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow(redeclare package
      Medium =
        XRGMedia.R1234yf_ph,                                                                             v_in_par=1)
    annotation (Placement(transformation(extent={{-74,6},{-54,26}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow(redeclare package
      Medium =
        XRGMedia.R1234yf_ph,                                                                               A_par=2)
    annotation (Placement(transformation(extent={{52,6},{72,26}})));
  Boundaries.Sink sink(redeclare package Medium = XRGMedia.R1234yf_ph) annotation (Placement(transformation(extent={{112,6},{132,26}})));
  Processes.FlowResistance flowResistance6(
    redeclare package Medium = XRGMedia.R1234yf_ph,
    r(displayUnit="mm") = 0.02,
    l=20,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss(
      k=500, k2=500))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={90,16})));
  Boundaries.Sink sink4(redeclare package Medium = XRGMedia.R245fa_ph, p0_par=100000)
    annotation (Placement(transformation(extent={{88,-38},{108,-18}})));
  Processes.FlowResistance flowResistance7(
    redeclare package Medium = XRGMedia.R245fa_ph,
    r(displayUnit="mm") = 0.02,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={62,-28})));
  Boundaries.Source source3(redeclare package Medium = XRGMedia.R245fa_ph,
    setEnthalpy=true,
    p0_par=120000)
    annotation (Placement(transformation(extent={{-32,-38},{-12,-18}})));
  FlowControl.BasicControlValve basicControlValve(redeclare package Medium =
        XRGMedia.R245fa_ph,
    redeclare function valveCharacteristics =
        FlowControl.Internal.ControlValve.linearCharacteristics,
    flowCoefficient=ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypesBasic.m_flow_set,
    m_flow_ref_set=1)
    annotation (Placement(transformation(extent={{-4,-18},{16,-38}})));
  Processes.ConductionElement conductionElement1(redeclare package Medium =
        XRGMedia.R245fa_ph,                                                                     initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={34,-28})));
  Modelica.Blocks.Sources.Ramp ramp(duration=1, startTime=4.5) annotation (Placement(transformation(extent={{-38,-60},{-18,-40}})));
  Processes.Pump pump(
    redeclare package Medium = XRGMedia.R134a_ph,
    omega_from_input=true,
    redeclare function dp_tau_pump =
        Processes.Internal.TurboComponent.dp_tau_nominal_flow)
    annotation (Placement(transformation(extent={{-80,42},{-100,22}})));
  Modelica.Blocks.Sources.Constant const(k=6300) annotation (Placement(transformation(extent={{-128,52},{-108,72}})));
  Processes.FlowResistance flowResistance8(
    redeclare package Medium = XRGMedia.R134a_ph,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.02,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={86,32})));
equation
  connect(discretizedHEX.inletB, discretizedHEX1.outletA)
    annotation (Line(
      points={{-8,64},{12,64},{12,64},{19.8,64}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, discretizedHEX.inletA) annotation (Line(
      points={{-54,80},{-36,80},{-36,80},{-28,80}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, discretizedHEX.outletB) annotation (Line(
      points={{-38,64},{-28.2,64}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX1.inletB, volumeFlex.outlet) annotation (Line(
      points={{20,48},{16,48}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX2.outletA, volumeFlex.inlet) annotation (Line(
      points={{-7.8,48},{-12,48},{-12,48},{-4,48}},
      color={28,108,200},
      thickness=0.5));
  connect(receiver.inlet, discretizedHEX2.outletB) annotation (Line(
      points={{-36,32},{-28.2,32}},
      color={28,108,200},
      thickness=0.5));
  connect(volume.outlet, flowResistance1.inlet) annotation (Line(
      points={{82,64},{72,64}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, discretizedHEX1.inletA) annotation (Line(
      points={{52,64},{42,64},{42,64},{40,64}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowResistance2.inlet) annotation (Line(
      points={{-66,48},{-60,48}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, discretizedHEX2.inletA)
    annotation (Line(
      points={{-40,48},{-30,48},{-30,48},{-28,48}},
      color={28,108,200},
      thickness=0.5));
  connect(sink2.inlet, flowResistance3.outlet) annotation (Line(
      points={{84,48},{78,48}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.outlet, conductionElement.inlet)
    annotation (Line(
      points={{66,0},{44,0}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement.outlet, discretizedHEX4.inletB)
    annotation (Line(
      points={{24,0},{-10,0},{-10,-1.77636e-15},{-24,-1.77636e-15}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance5.outlet, junctionT2_1.inletA)
    annotation (Line(
      points={{-128,32},{-132,32},{-132,10}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX4.outletB, junctionT2_1.inletB)
    annotation (Line(
      points={{-44.2,0},{-72,0},{-72,0},{-122,0}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT2_1.outlet, sink3.inlet) annotation (Line(
      points={{-142,0},{-156,0}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX4.outletA, nozzle.inlet) annotation (Line(
      points={{-23.8,16},{-24,16},{-24,16},{-14,16}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX.outletA, splitterT2_1.inlet)
    annotation (Line(
      points={{-7.8,80},{142,80},{142,42}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT2_1.outletB, flowResistance4.inlet)
    annotation (Line(
      points={{142,22},{142,0},{86,0}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX1.outletB, flowResistance3.inlet)
    annotation (Line(
      points={{40.2,48},{38,48},{38,48},{58,48}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureOutflow.outlet, flowResistance6.inlet)
    annotation (Line(
      points={{72,16},{80,16}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, flowResistance6.outlet) annotation (Line(
      points={{112,16},{100,16}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureInflow.outlet, discretizedHEX4.inletA)
    annotation (Line(
      points={{-54,16},{-44,16},{-44,16},{-44,16}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, dynamicPressureInflow.inlet)
    annotation (Line(
      points={{-82,16},{-74,16}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement.heatPort, conductionElement1.heatPort) annotation (Line(points={{34,-9.8},{34,-18.2}},color={191,0,0}));
  connect(source3.outlet, basicControlValve.inlet) annotation (Line(
      points={{-12,-28},{-4,-28}},
      color={28,108,200},
      thickness=0.5));
  connect(basicControlValve.outlet, conductionElement1.inlet)
    annotation (Line(
      points={{16,-28},{24,-28}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement1.outlet, flowResistance7.inlet)
    annotation (Line(
      points={{44,-28},{52,-28}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance7.outlet, sink4.inlet) annotation (Line(
      points={{72,-28},{88,-28}},
      color={28,108,200},
      thickness=0.5));
  connect(ramp.y, basicControlValve.u_in) annotation (Line(points={{-17,-50},{6,-50},{6,-36}},     color={0,0,127}));
  connect(flowResistance5.inlet, pump.outlet) annotation (Line(
      points={{-108,32},{-100,32}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.inlet, receiver.outlet) annotation (Line(
      points={{-80,32},{-56,32}},
      color={28,108,200},
      thickness=0.5));
  connect(const.y, pump.omega_input) annotation (Line(points={{-107,62},{-90,62},{-90,42}}, color={0,0,127}));
  connect(splitterT2_1.outletA, flowResistance8.inlet) annotation (Line(
      points={{132,32},{96,32}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX2.inletB, counterFlowNTU.outletB)
    annotation (Line(
      points={{-8,32},{6,32},{6,30},{19,30}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.inletB, flowResistance8.outlet)
    annotation (Line(
      points={{41.2,30},{60,30},{60,32},{76,32}},
      color={28,108,200},
      thickness=0.5));
  connect(nozzle.outlet, counterFlowNTU.inletA)
    annotation (Line(
      points={{6,16},{14,16},{14,18},{18.8,18}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.outletA, dynamicPressureOutflow.inlet)
    annotation (Line(
      points={{41,18},{46,18},{46,16},{52,16}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-180,-100},{160,100}})),
    experiment(
      StopTime=10,
   Tolerance=1e-6,
   Interval=0.01,
      __Dymola_Algorithm="Dassl"));
end TestXRGMedia;
