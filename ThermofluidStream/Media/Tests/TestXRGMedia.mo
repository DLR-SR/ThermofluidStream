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
        origin={-16,60})));
  HeatExchangers.DiscretizedCounterFlowHEX discretizedHEX1(
    redeclare package MediumA = XRGMedia.NH3_ph,
    redeclare package MediumB = XRGMedia.CO2_ph,
    redeclare model ConductionElementA =
        HeatExchangers.Internal.ConductionElementHEX,
    redeclare model ConductionElementB =
        HeatExchangers.Internal.ConductionElementHEX_twoPhase,
    initializeMassFlow=false) annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={32,48})));
  HeatExchangers.DiscretizedCounterFlowHEX discretizedHEX2(
    redeclare package MediumA = XRGMedia.CO2_ph,
    redeclare package MediumB = XRGMedia.R134a_ph,
    redeclare model ConductionElementB = HeatExchangers.Internal.ConductionElementHEX_twoPhase,
    initializeMassFlow=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-16,36})));
  HeatExchangers.CounterFlowNTU counterFlowNTU(
    redeclare package MediumA = XRGMedia.R1234yf_ph,
    redeclare package MediumB = XRGMedia.R134a_ph,
    A=10) annotation (Placement(transformation(extent={{20,14},{40,34}})));
  Boundaries.Source source(redeclare package Medium = XRGMedia.R134a_ph, p0_par=200000)
    annotation (Placement(transformation(extent={{-64,56},{-44,76}})));
  Boundaries.Volume volume(
    redeclare package Medium = XRGMedia.NH3_ph,
    useInlet=false,
    p_start=200000,
    V_par=0.1) annotation (Placement(transformation(extent={{98,44},{78,64}})));
  Boundaries.Sink sink1(redeclare package Medium = XRGMedia.NH3_ph) annotation (Placement(transformation(extent={{-32,44},{-52,64}})));
  HeatExchangers.DiscretizedCounterFlowHEX discretizedHEX4(
    redeclare package MediumA = XRGMedia.R1234yf_ph,
    redeclare package MediumB = XRGMedia.R134a_ph,
    redeclare model ConductionElementB = HeatExchangers.Internal.ConductionElementHEX_twoPhase,
    initializeMassFlow=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-34,12})));
  Boundaries.Sink sink2(redeclare package Medium = XRGMedia.CO2_ph) annotation (Placement(transformation(extent={{98,32},{118,52}})));
  Boundaries.Source source1(redeclare package Medium = XRGMedia.CO2_ph, p0_par=130000)
    annotation (Placement(transformation(extent={{-92,32},{-72,52}})));
  Boundaries.VolumeFlex volumeFlex(redeclare package Medium = XRGMedia.CO2_ph) annotation (Placement(transformation(extent={{-2,32},{18,52}})));
  Examples.Utilities.Receiver receiver(redeclare package Medium =
        XRGMedia.R134a_ph, p_start=200000)
    annotation (Placement(transformation(extent={{-32,20},{-52,40}})));
  Boundaries.Sink sink3(redeclare package Medium = XRGMedia.R134a_ph, p0_par=180000)
    annotation (Placement(transformation(extent={{-156,-4},{-176,16}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = XRGMedia.NH3_ph,
    r(displayUnit="mm") = 0.005,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={58,54})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = XRGMedia.CO2_ph,
    r(displayUnit="mm") = 0.005,
    l=15,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-52,42})));
  Processes.FlowResistance flowResistance3(
    redeclare package Medium = XRGMedia.CO2_ph,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.002,
    l=50,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={66,42})));
  Processes.FlowResistance flowResistance4(
    redeclare package Medium = XRGMedia.R134a_ph,
    r(displayUnit="mm") = 0.02,
    l=5,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={76,6})));
  Processes.FlowResistance flowResistance5(
    redeclare package Medium = XRGMedia.R134a_ph,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.005,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-118,30})));
  Processes.ConductionElement conductionElement(redeclare package Medium =
        XRGMedia.R134a_ph)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={34,6})));
  Topology.JunctionT2 junctionT2_1(redeclare package Medium = XRGMedia.R134a_ph)
    annotation (Placement(transformation(extent={{-142,-4},{-122,16}})));
  Topology.SplitterT2 splitterT2_1(redeclare package Medium = XRGMedia.R134a_ph)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={142,30})));
  Processes.Nozzle nozzle(redeclare package Medium = XRGMedia.R1234yf_ph, A_out=5) annotation (Placement(transformation(extent={{-14,8},{6,28}})));
  Boundaries.Source source2(redeclare package Medium = XRGMedia.R1234yf_ph) annotation (Placement(transformation(extent={{-116,8},{-96,28}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow(redeclare package Medium =
        XRGMedia.R1234yf_ph, v_in_par=1)
    annotation (Placement(transformation(extent={{-76,8},{-56,28}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow(redeclare package Medium =
        XRGMedia.R1234yf_ph, A_par=2)
    annotation (Placement(transformation(extent={{52,8},{72,28}})));
  Boundaries.Sink sink(redeclare package Medium = XRGMedia.R1234yf_ph) annotation (Placement(transformation(extent={{114,8},{134,28}})));
  Processes.FlowResistance flowResistance6(
    redeclare package Medium = XRGMedia.R1234yf_ph,
    r(displayUnit="mm") = 0.02,
    l=20,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=500, k2=500))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={94,18})));
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
        XRGMedia.R245fa_ph, initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={34,-28})));
  Modelica.Blocks.Sources.Ramp ramp(duration=1, startTime=4.5) annotation (Placement(transformation(extent={{-38,-60},{-18,-40}})));
  Processes.Pump pump(
    redeclare package Medium = XRGMedia.R134a_ph,
    omega_from_input=true,
    redeclare function dp_tau_pump =
        Processes.Internal.TurboComponent.dp_tau_nominal_flow)
    annotation (Placement(transformation(extent={{-78,40},{-98,20}})));
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
        origin={78,30})));
equation
  connect(discretizedHEX.inletB, discretizedHEX1.outletA)
    annotation (Line(
      points={{-6,54},{22,54}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, discretizedHEX.inletA) annotation (Line(
      points={{-44,66},{-26,66}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, discretizedHEX.outletB) annotation (Line(
      points={{-32,54},{-26,54}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX1.inletB, volumeFlex.outlet) annotation (Line(
      points={{22,42},{18,42}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX2.outletA, volumeFlex.inlet) annotation (Line(
      points={{-6,42},{-2,42}},
      color={28,108,200},
      thickness=0.5));
  connect(receiver.inlet, discretizedHEX2.outletB) annotation (Line(
      points={{-32,30},{-26,30}},
      color={28,108,200},
      thickness=0.5));
  connect(volume.outlet, flowResistance1.inlet) annotation (Line(
      points={{78,54},{68,54}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, discretizedHEX1.inletA) annotation (Line(
      points={{48,54},{42,54}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowResistance2.inlet) annotation (Line(
      points={{-72,42},{-62,42}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, discretizedHEX2.inletA)
    annotation (Line(
      points={{-42,42},{-26,42}},
      color={28,108,200},
      thickness=0.5));
  connect(sink2.inlet, flowResistance3.outlet) annotation (Line(
      points={{98,42},{76,42}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.outlet, conductionElement.inlet)
    annotation (Line(
      points={{66,6},{44,6}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement.outlet, discretizedHEX4.inletB)
    annotation (Line(
      points={{24,6},{-24,6}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance5.outlet, junctionT2_1.inletA)
    annotation (Line(
      points={{-128,30},{-132,30},{-132,16}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX4.outletB, junctionT2_1.inletB)
    annotation (Line(
      points={{-44,6},{-142,6}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT2_1.outlet, sink3.inlet) annotation (Line(
      points={{-122,6},{-156,6}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX4.outletA, nozzle.inlet) annotation (Line(
      points={{-24,18},{-14,18}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX.outletA, splitterT2_1.inlet)
    annotation (Line(
      points={{-6,66},{142,66},{142,40}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT2_1.outletB, flowResistance4.inlet)
    annotation (Line(
      points={{142,20},{142,6},{86,6}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX1.outletB, flowResistance3.inlet)
    annotation (Line(
      points={{42,42},{56,42}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureOutflow.outlet, flowResistance6.inlet)
    annotation (Line(
      points={{72,18},{84,18}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, flowResistance6.outlet) annotation (Line(
      points={{114,18},{104,18}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureInflow.outlet, discretizedHEX4.inletA)
    annotation (Line(
      points={{-56,18},{-44,18}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, dynamicPressureInflow.inlet)
    annotation (Line(
      points={{-96,18},{-76,18}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement.heatPort, conductionElement1.heatPort) annotation (Line(points={{34,-4},{34,-18}},    color={191,0,0}));
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
  connect(ramp.y, basicControlValve.u_in) annotation (Line(points={{-17,-50},{6,-50},{6,-36}}, color={0,0,127}));
  connect(flowResistance5.inlet, pump.outlet) annotation (Line(
      points={{-108,30},{-98,30}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.inlet, receiver.outlet) annotation (Line(
      points={{-78,30},{-52,30}},
      color={28,108,200},
      thickness=0.5));
  connect(const.y, pump.omega_input) annotation (Line(points={{-107,62},{-88,62},{-88,42}}, color={0,0,127}));
  connect(splitterT2_1.outletA, flowResistance8.inlet) annotation (Line(
      points={{132,30},{88,30}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX2.inletB, counterFlowNTU.outletB)
    annotation (Line(
      points={{-6,30},{20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.inletB, flowResistance8.outlet)
    annotation (Line(
      points={{40,30},{68,30}},
      color={28,108,200},
      thickness=0.5));
  connect(nozzle.outlet, counterFlowNTU.inletA)
    annotation (Line(
      points={{6,18},{20,18}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.outletA, dynamicPressureOutflow.inlet)
    annotation (Line(
      points={{40,18},{52,18}},
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
