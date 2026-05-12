within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.AdiabaticPseudoInversion;
model Step9FinalResults
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.He
                                                                              constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(
    neglectInertance=false,                           displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{-20,180},{0,200}})));
  Processes.Isobaric reactor(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,

    T_out_fixed(displayUnit="K") = 1180) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-100,20})));
  Processes.Adiabatic turbine1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.94,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,150})));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={-30,100})));
  Modelica.Blocks.Sources.RealExpression turbine1OutletTemperature(y(unit="K") = 1110) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-84,130})));
  Processes.Adiabatic turbine2(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    etaSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,
    p_out_fixed=5240000) annotation (Placement(transformation(extent={{-10,10},{10,-10}}, rotation=270)));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor1(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={-20,-40})));
  Modelica.Blocks.Sources.RealExpression turbine2OutletTemperature(y(unit="K") = 1060) annotation (Placement(transformation(extent={{-94,-30},{-74,-10}})));
  Processes.Adiabatic turbine3(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,-90})));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor2(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={-30,-150})));
  Modelica.Blocks.Sources.RealExpression turbine3OutletTemperature(y(unit="K") = 844.5) annotation (Placement(transformation(extent={{-90,-130},{-70,-110}})));
  Processes.Isobaric heatExchangerHotSide(
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    h_out(start=Medium.h_default),
    redeclare package Medium = Medium,
    specifyOutlet=false,
    T_out_fixed(displayUnit="K")) annotation (Placement(transformation(extent={{20,-180},{40,-160}})));
  Processes.Isobaric cooler2(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,
    specifyOutlet=true,
    T_out_fixed(displayUnit="K") = 285) annotation (Placement(transformation(extent={{60,-180},{80,-160}})));
  Processes.Isobaric heatExchangerColdSide(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,
    T_out_fixed(displayUnit="K") = 780) annotation (Placement(transformation(extent={{40,-210},{20,-230}})));
  Processes.Adiabatic compressor1(
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,
    redeclare package Medium = Medium,

    eta_fixed=0.96,
    p_out_fixed=7000000) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={150,150})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y(unit="K") = 376) annotation (Placement(transformation(extent={{300,90},{280,110}})));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor3(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={180,170})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y(unit="W") = 0)   annotation (Placement(transformation(extent={{30,60},{50,80}})));
  Processes.Adiabatic compressor2(
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    etaSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    specifyOutlet=true,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={150,0})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y(unit="W") = 0)   annotation (Placement(transformation(extent={{40,-54},{60,-34}})));
  EnergyFlow.Components.Sum turbine3HeatLosses(n_in=2) annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
  EnergyFlow.Components.FixedTransferEfficiency turbine3ShaftLosses(eta=0.95) annotation (Placement(transformation(extent={{60,-80},{40,-100}})));
  EnergyFlow.Sources.FixedEnergyFlow generator(E_flow(displayUnit="MW") = -3015000) annotation (Placement(transformation(extent={{100,-100},{80,-80}})));
  EnergyFlow.Components.FixedTransferEfficiency turbine1Losses(eta=0.95) annotation (Placement(transformation(extent={{40,160},{60,140}})));
  EnergyFlow.Components.Sum pseudoSink(n_in=2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={70,130})));
  EnergyFlow.Components.FixedTransferEfficiency turbine2Losses(eta=0.95) annotation (Placement(transformation(extent={{30,10},{50,-10}})));
  EnergyFlow.Components.Sum pseudoSink1(n_in=2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,-16})));
  Modelica.Blocks.Continuous.Integrator integrator(
    k=1e6,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=70e5)
               annotation (Placement(transformation(extent={{-40,120},{-20,140}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(extent={{-68,120},{-48,140}})));
  Modelica.Blocks.Continuous.Integrator integrator1(
    k=-0.5,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1) annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Blocks.Math.Feedback feedback1
                                         annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  Modelica.Blocks.Continuous.Integrator integrator2(
    k=5e5,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0) annotation (Placement(transformation(extent={{-32,-130},{-12,-110}})));
  Modelica.Blocks.Math.Feedback feedback2
                                         annotation (Placement(transformation(extent={{-64,-130},{-44,-110}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y(
      unit="W",
      displayUnit="MW") = -6000000)                                    annotation (Placement(transformation(extent={{-200,60},{-180,80}})));
  Modelica.Blocks.Math.Feedback feedback5
                                         annotation (Placement(transformation(extent={{-170,60},{-150,80}})));
  Modelica.Blocks.Continuous.Integrator integrator5(
    k=-1e-5,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1) annotation (Placement(transformation(extent={{-140,60},{-120,80}})));
  Sources.MassFlowRate massFlowRate(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-100,70})));
  Modelica.Blocks.Math.Feedback feedback3
                                         annotation (Placement(transformation(extent={{60,80},{80,60}})));
  Modelica.Blocks.Continuous.Integrator integrator3(
    k=1e4,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=70e5)
               annotation (Placement(transformation(extent={{86,60},{106,80}})));
  Modelica.Blocks.Continuous.Integrator integrator4(
    k=100,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=400)
               annotation (Placement(transformation(extent={{240,90},{220,110}})));
  Modelica.Blocks.Math.Feedback feedback4
                                         annotation (Placement(transformation(extent={{270,110},{250,90}})));
  Modelica.Blocks.Continuous.Integrator integrator6(
    k=1e-3,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=1) annotation (Placement(transformation(extent={{100,-54},{120,-34}})));
  Modelica.Blocks.Math.Feedback feedback6
                                         annotation (Placement(transformation(extent={{70,-34},{90,-54}})));
  Processes.Isobaric cooler1(
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    specifyOutlet=true,
    T_out_fixed(displayUnit="K"),
    h_out(start=Medium.h_default)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={150,90})));
  Sources.LoopBreaker loopBreaker1(
    redeclare package Medium = Medium,
    p_out_fixed=7000000,
    T_out_fixed(displayUnit="K") = 780)
                     annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-50,-220})));
  Modelica.Blocks.Math.Feedback feedback7
                                         annotation (Placement(transformation(extent={{108,-206},{88,-186}})));
  Modelica.Blocks.Continuous.Integrator integrator7(
    k=-10,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0) annotation (Placement(transformation(extent={{78,-206},{58,-186}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y(
      unit="W",
      displayUnit="W") = 0)                                            annotation (Placement(transformation(extent={{132,-206},{112,-186}})));
  Modelica.Blocks.Math.Feedback feedback8
                                         annotation (Placement(transformation(extent={{60,-240},{80,-220}})));
  ThermofluidStream.Utilities.showRealValue heatExchangerOutletTemperature(
    description="T_6",
    use_numberPort=false,
    number=heatExchangerHotSide.outlet.state.T,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{-140,-280},{-120,-260}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="eff",
    use_numberPort=false,
    number=-generator.E_flow/reactor.Q_flow,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{-100,-280},{-80,-260}})));
  ThermofluidStream.Utilities.showRealValue turbine1OutletPressure(
    description="p_3",
    use_numberPort=false,
    number=turbine1.outlet.state.p,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{-60,-280},{-40,-260}})));
  ThermofluidStream.Utilities.showRealValue turbine2IsentropicEfficiency(
    description="eta_is_T2",
    use_numberPort=false,
    number=turbine2.eta_is,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{-20,-280},{0,-260}})));
  ThermofluidStream.Utilities.showRealValue compressor1Power(
    description="P_CMP1",
    use_numberPort=false,
    number=compressor1.P,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{20,-280},{40,-260}})));
  ThermofluidStream.Utilities.showRealValue compressor2Power(
    description="P_CMP2",
    use_numberPort=false,
    number=compressor2.P,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{60,-280},{80,-260}})));
  ThermofluidStream.Utilities.showRealValue turbine3HeatLoss(
    description="Q_T3",
    use_numberPort=false,
    number=turbine3HeatLosses.E_flow_out,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{100,-280},{120,-260}})));
  ThermofluidStream.Utilities.showRealValue compressor1EntropyProduction(
    description="S_irr_CMP1",
    use_numberPort=false,
    number=entropyDifferenceSensor.value*compressor1.m_flow,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{140,-282},{160,-262}})));
  ThermofluidStream.Sensors.DifferenceSensorSelect entropyDifferenceSensor(
    displayInstanceName=true,
    displayParameters=false,
    redeclare package MediumA = Medium,
    redeclare package MediumB = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={170,130})));
equation
  connect(temperatureSensor.inlet, turbine1.outlet) annotation (Line(
      points={{-20,100},{0,100},{0,140}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine1.outlet,turbine2. inlet)
    annotation (Line(
      points={{0,140},{0,10}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine2.outlet, temperatureSensor1.inlet) annotation (Line(
      points={{0,-10},{0,-40},{-10,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine2.outlet,turbine3. inlet)
    annotation (Line(
      points={{0,-10},{0,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(temperatureSensor2.inlet, turbine3.outlet) annotation (Line(
      points={{-20,-150},{0,-150},{0,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerHotSide.outlet, cooler2.inlet) annotation (Line(
      points={{40,-170},{60,-170}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerHotSide.inlet, turbine3.outlet) annotation (Line(
      points={{20,-170},{0,-170},{0,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerColdSide.inlet, compressor1.outlet) annotation (Line(
      points={{40,-220},{200,-220},{200,190},{150,190},{150,160}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor1.outlet, temperatureSensor3.inlet) annotation (Line(
      points={{150,160},{150,170},{170,170}},
      color={28,108,200},
      thickness=0.5));
  connect(cooler2.outlet, compressor2.inlet) annotation (Line(
      points={{80,-170},{150,-170},{150,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(generator.E_flow_out, turbine3ShaftLosses.E_flow_in) annotation (Line(points={{79,-90},{62,-90}}, color={255,170,85}));
  connect(turbine3ShaftLosses.E_flow_out, turbine3HeatLosses.E_flow_in[1]) annotation (Line(points={{39,-90},{30,-90},{30,-71.5},{40,-71.5}},   color={255,170,85}));
  connect(turbine3.P_out, turbine3HeatLosses.E_flow_in[2]) annotation (Line(points={{7,-90},{26,-90},{26,-68.5},{40,-68.5}},   color={255,170,85}));
  connect(turbine1.P_out, turbine1Losses.E_flow_in) annotation (Line(points={{7,150},{38,150}}, color={255,170,85}));
  connect(turbine1Losses.E_flow_out, pseudoSink.E_flow_in[1]) annotation (Line(points={{61,150},{68,150},{68,140},{71.5,140}},
                                                                                                                          color={255,170,85}));
  connect(compressor1.P_out, pseudoSink.E_flow_in[2]) annotation (Line(points={{143,150},{72,150},{72,140},{68.5,140}},
                                                                                                                   color={255,170,85}));
  connect(turbine2.P_out, turbine2Losses.E_flow_in) annotation (Line(points={{7,0},{28,0}}, color={255,170,85}));
  connect(turbine2Losses.E_flow_out, pseudoSink1.E_flow_in[1]) annotation (Line(points={{51,0},{78,0},{78,-6},{81.5,-6}},
                                                                                                                      color={255,170,85}));
  connect(compressor2.P_out, pseudoSink1.E_flow_in[2]) annotation (Line(points={{143,0},{82,0},{82,-6},{78.5,-6}},
                                                                                                               color={255,170,85}));
  connect(temperatureSensor.value_out, feedback.u2) annotation (Line(points={{-38.2,100},{-58,100},{-58,122}}, color={0,0,127}));
  connect(turbine1OutletTemperature.y, feedback.u1) annotation (Line(points={{-73,130},{-66,130}}, color={0,0,127}));
  connect(feedback.y, integrator.u) annotation (Line(points={{-49,130},{-42,130}}, color={0,0,127}));
  connect(integrator.y, turbine1.outletSpec_prescribed) annotation (Line(points={{-19,130},{22,130},{22,140},{12,140}}, color={0,0,127}));
  connect(turbine2OutletTemperature.y, feedback1.u1) annotation (Line(points={{-73,-20},{-68,-20}}, color={0,0,127}));
  connect(feedback1.y, integrator1.u) annotation (Line(points={{-51,-20},{-42,-20}}, color={0,0,127}));
  connect(feedback1.u2, temperatureSensor1.value_out) annotation (Line(points={{-60,-28},{-60,-40},{-28.2,-40}}, color={0,0,127}));
  connect(integrator1.y, turbine2.eta_prescribed) annotation (Line(points={{-19,-20},{20,-20},{20,-6},{12,-6}}, color={0,0,127}));
  connect(feedback2.y, integrator2.u) annotation (Line(points={{-45,-120},{-34,-120}}, color={0,0,127}));
  connect(turbine3OutletTemperature.y, feedback2.u1) annotation (Line(points={{-69,-120},{-62,-120}}, color={0,0,127}));
  connect(temperatureSensor2.value_out, feedback2.u2) annotation (Line(points={{-38.2,-150},{-54,-150},{-54,-128}}, color={0,0,127}));
  connect(integrator2.y, turbine3.outletSpec_prescribed) annotation (Line(points={{-11,-120},{20,-120},{20,-100},{12,-100}}, color={0,0,127}));
  connect(reactor.outlet, massFlowRate.inlet) annotation (Line(
      points={{-100,30},{-100,60}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate.outlet, turbine1.inlet) annotation (Line(
      points={{-100,80},{-100,170},{0,170},{0,160}},
      color={28,108,200},
      thickness=0.5));
  connect(integrator5.y, massFlowRate.m_flow_prescribed) annotation (Line(points={{-119,70},{-108,70}}, color={0,0,127}));
  connect(feedback5.y, integrator5.u) annotation (Line(points={{-151,70},{-142,70}}, color={0,0,127}));
  connect(realExpression.y, feedback5.u1) annotation (Line(points={{-179,70},{-168,70}}, color={0,0,127}));
  connect(reactor.Q_flow_out, feedback5.u2) annotation (Line(points={{-107,20},{-160,20},{-160,62}}, color={255,170,85}));
  connect(realExpression1.y, feedback3.u1) annotation (Line(points={{51,70},{62,70}}, color={0,0,127}));
  connect(pseudoSink.E_flow_out, feedback3.u2) annotation (Line(points={{70,118.3},{70,78}}, color={255,170,85}));
  connect(compressor2.outletSpec_prescribed, integrator3.y) annotation (Line(points={{138,10},{120,10},{120,70},{107,70}}, color={0,0,127}));
  connect(integrator3.u, feedback3.y) annotation (Line(points={{84,70},{79,70}}, color={0,0,127}));
  connect(integrator4.u, feedback4.y) annotation (Line(points={{242,100},{251,100}}, color={0,0,127}));
  connect(feedback4.u1, realExpression3.y) annotation (Line(points={{268,100},{279,100}}, color={0,0,127}));
  connect(temperatureSensor3.value_out, feedback4.u2) annotation (Line(points={{188.2,170},{260,170},{260,108}}, color={0,0,127}));
  connect(pseudoSink1.E_flow_out, feedback6.u2) annotation (Line(points={{80,-27.7},{80,-36}}, color={255,170,85}));
  connect(realExpression2.y, feedback6.u1) annotation (Line(points={{61,-44},{72,-44}}, color={0,0,127}));
  connect(feedback6.y, integrator6.u) annotation (Line(points={{89,-44},{98,-44}}, color={0,0,127}));
  connect(integrator6.y, compressor2.eta_prescribed) annotation (Line(points={{121,-44},{128,-44},{128,6},{138,6}}, color={0,0,127}));
  connect(compressor1.inlet, cooler1.outlet) annotation (Line(
      points={{150,140},{150,100}},
      color={28,108,200},
      thickness=0.5));
  connect(integrator4.y, cooler1.outletSpec_prescribed) annotation (Line(points={{219,100},{162,100}}, color={0,0,127}));
  connect(compressor2.outlet, cooler1.inlet) annotation (Line(
      points={{150,10},{150,80}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerColdSide.outlet, loopBreaker1.inlet) annotation (Line(
      points={{20,-220},{-40,-220}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker1.outlet, reactor.inlet) annotation (Line(
      points={{-60,-220},{-100,-220},{-100,10}},
      color={28,108,200},
      thickness=0.5));
  connect(integrator7.u, feedback7.y) annotation (Line(points={{80,-196},{89,-196}}, color={0,0,127}));
  connect(feedback7.u1, realExpression4.y) annotation (Line(points={{106,-196},{111,-196}}, color={0,0,127}));
  connect(heatExchangerColdSide.Q_flow_out, feedback8.u1) annotation (Line(points={{30,-213},{30,-204},{52,-204},{52,-230},{62,-230}}, color={255,170,85}));
  connect(integrator7.y, feedback8.u2) annotation (Line(points={{57,-196},{48,-196},{48,-246},{70,-246},{70,-238}}, color={0,0,127}));
  connect(feedback8.y, feedback7.u2) annotation (Line(points={{79,-230},{98,-230},{98,-204}}, color={0,0,127}));
  connect(integrator7.y, heatExchangerHotSide.Q_flow_in) annotation (Line(points={{57,-196},{30,-196},{30,-178}}, color={0,0,127}));
  connect(cooler1.outlet, entropyDifferenceSensor.inletB) annotation (Line(
      points={{150,100},{150,130},{160,130}},
      color={28,108,200},
      thickness=0.5));
  connect(entropyDifferenceSensor.inletA, compressor1.outlet) annotation (Line(
      points={{180,130},{200,130},{200,190},{150,190},{150,160}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-280},{200,200}}), graphics={
        Text(
          extent={{-100,6},{-94,0}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-100,40},{-94,34}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-6,140},{0,134}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-6,-14},{0,-20}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{-8,-104},{-2,-110}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{48,-164},{54,-170}},
          textColor={28,108,200},
          textString="6")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Step9FinalResults;
