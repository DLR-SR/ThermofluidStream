within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Polytropic;
model Step9FinalResults
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconNeglectInertance;

  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.He
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(
    considerInertance=false,                            displayInstanceNames=true, displayParameters=true)annotation(
    Placement(transformation(extent={{-20,180},{0,200}})));
  Processes.Isobaric reactor(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed(displayUnit="K") = 1180) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-140,0})));
  Processes.PolytropicPerfectGas turbine1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    T_out_fixed(displayUnit="K") = 1110,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.IsentropicEfficiency,
    eta_is_fixed=0.94) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-80,92})));
  EnergyFlow.Sources.FixedEnergyFlow reactorHeatFlow(E_flow(displayUnit="MW") = 6000000) annotation(Placement(transformation(extent={{-180,-10},{-160,10}})));
  EnergyFlow.Components.FixedTransferEfficiency turbine1Losses(eta=0.95) annotation(Placement(transformation(extent={{-50,102},{-30,82}})));
  Processes.PolytropicPerfectGas
                      turbine2(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure,
    p_out_fixed=5240000,
    T_out_fixed(displayUnit="K") = 1060,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature)
                                   annotation(Placement(transformation(extent={{-10,10},{10,-10}}, rotation=270,
        origin={-80,0})));
  EnergyFlow.Components.FixedTransferEfficiency turbine2Losses(eta=0.95) annotation(Placement(transformation(extent={{-50,10},{-30,-10}})));
  Processes.PolytropicPerfectGas turbine3(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    T_out_fixed(displayUnit="K") = 844.5) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-80,-80})));
  EnergyFlow.Components.Sum turbine3HeatLosses(n_in=2) annotation(Placement(transformation(extent={{-40,-70},{-20,-50}})));
  EnergyFlow.Components.FixedTransferEfficiency turbine3ShaftLosses(eta=0.95) annotation(Placement(transformation(extent={{-20,-70},{-40,-90}})));
  EnergyFlow.Sources.FixedEnergyFlow generator(E_flow(displayUnit="MW") = -3015000) annotation(Placement(transformation(extent={{20,-90},{0,-70}})));
  Processes.Isobaric heatExchangerHotSide(
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    redeclare package Medium = Medium,
    specifyOutlet=false,
    T_out_fixed(displayUnit="K")) annotation(Placement(transformation(extent={{-70,-130},{-50,-110}})));
  Processes.Isobaric cooler2(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    specifyOutlet=true,
    T_out_fixed(displayUnit="K") = 285) annotation(Placement(transformation(extent={{-30,-130},{-10,-110}})));
  Processes.Isobaric heatExchangerColdSide(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    T_out_fixed(displayUnit="K") = 780) annotation(Placement(transformation(extent={{-50,-140},{-70,-160}})));
  Sources.Sink_free sink(redeclare package Medium = Medium) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,30})));
  Processes.PolytropicPerfectGas
                      compressor1(
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure,
    redeclare package Medium = Medium,
    p_out_fixed=7000000,
    outlet(state(p(start=7000000), T(start=649.15))),
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.IsentropicEfficiency,
    eta_is_fixed=0.96,
    h_out(start=Medium.specificEnthalpy_pT(70e5, 376)))
                                   annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={40,92})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints2 annotation(Placement(transformation(extent={{90,98},{130,122}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y(unit="K") = 376) annotation(Placement(transformation(extent={{120,100},{100,120}})));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={70,110})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true,
    T0_par(displayUnit="K"),
    T0_var(start=300),
    p0_var(start=50e5),
    outlet(state(p(start=6000000), T(start=500)))) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={40,62})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints1 annotation(Placement(transformation(extent={{-10,28},{30,52}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y(unit="W") = 0) annotation(Placement(transformation(extent={{22,30},{2,50}})));
  EnergyFlow.Components.Sum pseudoSink(n_in=2) annotation(Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-20,62})));
  EnergyFlow.Components.Sum pseudoSink1(n_in=2) annotation(Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-20,-22})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y(unit="W") = 0)   annotation(Placement(transformation(extent={{20,-50},{0,-30}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints5 annotation(Placement(transformation(extent={{-10,-52},{30,-28}})));
  Processes.PolytropicPerfectGas compressor2(
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={50,0})));
  ThermofluidStream.Utilities.showRealValue heatExchangerOutletTemperature(
    description="T_6",
    use_numberPort=false,
    number=heatExchangerHotSide.outlet.state.T,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-140,-200},{-120,-180}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="eff",
    use_numberPort=false,
    number=-generator.E_flow/reactorHeatFlow.E_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-100,-200},{-80,-180}})));
  ThermofluidStream.Utilities.showRealValue turbine1OutletPressure(
    description="p_3",
    use_numberPort=false,
    number=turbine1.outlet.state.p,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-60,-200},{-40,-180}})));
  ThermofluidStream.Utilities.showRealValue turbine2IsentropicEfficiency(
    description="eta_is_T2",
    use_numberPort=false,
    number=turbine2.eta_is,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-20,-200},{0,-180}})));
  ThermofluidStream.Utilities.showRealValue compressor1Power(
    description="P_CMP1",
    use_numberPort=false,
    number=compressor1.P,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{20,-200},{40,-180}})));
  ThermofluidStream.Utilities.showRealValue compressor2Power(
    description="P_CMP2",
    use_numberPort=false,
    number=compressor2.P,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{60,-200},{80,-180}})));
  ThermofluidStream.Utilities.showRealValue turbine3HeatLoss(
    description="Q_T3",
    use_numberPort=false,
    number=turbine3HeatLosses.E_flow_out,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{100,-200},{120,-180}})));
  ThermofluidStream.Utilities.showRealValue compressor1EntropyProduction(
    description="S_irr_CMP1",
    use_numberPort=false,
    number=entropyDifferenceSensor.value*compressor1.m_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{140,-202},{160,-182}})));
  ThermofluidStream.Sensors.DifferenceSensorSelect entropyDifferenceSensor(
    displayInstanceName=true,
    displayParameters=false,
    redeclare package MediumA = Medium,
    redeclare package MediumB = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK)annotation(
    Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={90,78})));
equation
  connect(reactor.outlet,turbine1. inlet) annotation(Line(
      points={{-140,10},{-140,120},{-80,120},{-80,102}},
      color={28,108,200},
      thickness=0.5));
  connect(reactorHeatFlow.E_flow_out, reactor.Q_flow_in) annotation(Line(points={{-159,0},{-148,0}},   color={255,170,85}));
  connect(turbine1.P_out, turbine1Losses.E_flow_in) annotation(Line(points={{-73,92},{-52,92}},
                                                                                              color={255,170,85}));
  connect(turbine1.outlet, turbine2.inlet) annotation(Line(
      points={{-80,82},{-80,10}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine2.P_out, turbine2Losses.E_flow_in) annotation(Line(points={{-73,0},{-52,0}}, color={255,170,85}));
  connect(turbine2.outlet, turbine3.inlet) annotation(Line(
      points={{-80,-10},{-80,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine3ShaftLosses.E_flow_out, turbine3HeatLosses.E_flow_in[1]) annotation(Line(points={{-41,-80},{-48,-80},{-48,-62},{-40,-62},{-40,-61.5}}, color={255,170,85}));
  connect(turbine3.P_out, turbine3HeatLosses.E_flow_in[2]) annotation(Line(points={{-73,-80},{-52,-80},{-52,-58.5},{-40,-58.5}}, color={255,170,85}));
  connect(generator.E_flow_out, turbine3ShaftLosses.E_flow_in) annotation(Line(points={{-1,-80},{-18,-80}}, color={255,170,85}));
  connect(heatExchangerHotSide.outlet,cooler2. inlet) annotation(Line(
      points={{-50,-120},{-30,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerHotSide.inlet, turbine3.outlet) annotation(Line(
      points={{-70,-120},{-80,-120},{-80,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerColdSide.outlet, reactor.inlet) annotation(Line(
      points={{-70,-150},{-140,-150},{-140,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerColdSide.Q_flow_out,heatExchangerHotSide. Q_flow_in) annotation(Line(points={{-60,-143},{-60,-128}},
                                                                                                                           color={255,170,85}));
  connect(heatExchangerColdSide.inlet,compressor1. outlet) annotation(Line(
      points={{-50,-150},{156,-150},{156,140},{40,140},{40,102}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, compressor1.inlet) annotation(Line(
      points={{40,72},{40,82}},
      color={28,108,200},
      thickness=0.5));
  connect(inverseBlockConstraints2.u2,realExpression1. y) annotation(Line(points={{94,110},{99,110}},   color={0,0,127}));
  connect(compressor1.outlet, temperatureSensor.inlet) annotation(Line(
      points={{40,102},{40,110},{60,110}},
      color={28,108,200},
      thickness=0.5));
  connect(temperatureSensor.value_out, inverseBlockConstraints2.u1) annotation(Line(points={{78.2,110},{88,110}}, color={0,0,127}));
  connect(inverseBlockConstraints1.u2, realExpression.y) annotation(Line(points={{-6,40},{1,40}}, color={0,0,127}));
  connect(source.p0_var, inverseBlockConstraints1.y1) annotation(Line(points={{46,60},{46,40},{31,40}}, color={0,0,127}));
  connect(inverseBlockConstraints2.y1, source.T0_var) annotation(Line(points={{131,110},{140,110},{140,36},{40,36},{40,60}}, color={0,0,127}));
  connect(pseudoSink.E_flow_out,inverseBlockConstraints1. u1) annotation(Line(points={{-20,50.3},{-20,40},{-12,40}},color={255,170,85}));
  connect(turbine1Losses.E_flow_out, pseudoSink.E_flow_in[1]) annotation(Line(points={{-29,92},{-18.5,92},{-18.5,72}}, color={255,170,85}));
  connect(compressor1.P_out, pseudoSink.E_flow_in[2]) annotation(Line(points={{33,92},{-21.5,92},{-21.5,72}}, color={255,170,85}));
  connect(pseudoSink1.E_flow_out, inverseBlockConstraints5.u1) annotation(Line(points={{-20,-33.7},{-20,-40},{-12,-40}}, color={255,170,85}));
  connect(turbine2Losses.E_flow_out, pseudoSink1.E_flow_in[1]) annotation(Line(points={{-29,0},{-18.5,0},{-18.5,-12}}, color={255,170,85}));
  connect(inverseBlockConstraints5.y1, compressor2.processSpec_prescribed) annotation(Line(points={{31,-40},{34,-40},{34,6},{38,6}}, color={0,0,127}));
  connect(sink.inlet, compressor2.outlet) annotation(Line(
      points={{50,20},{50,10}},
      color={28,108,200},
      thickness=0.5));
  connect(inverseBlockConstraints1.y1, compressor2.outletSpec_prescribed) annotation(Line(points={{31,40},{34,40},{34,10},{38,10}}, color={0,0,127}));
  connect(compressor2.inlet, cooler2.outlet) annotation(Line(
      points={{50,-10},{50,-120},{-10,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(inverseBlockConstraints5.u2, realExpression2.y) annotation(Line(points={{-6,-40},{-1,-40}}, color={0,0,127}));
  connect(compressor2.P_out, pseudoSink1.E_flow_in[2]) annotation(Line(points={{43,0},{-21.5,0},{-21.5,-12}}, color={255,170,85}));
  connect(entropyDifferenceSensor.inletA, compressor1.outlet) annotation(Line(
      points={{100,78},{156,78},{156,140},{40,140},{40,102}},
      color={28,108,200},
      thickness=0.5));
  connect(entropyDifferenceSensor.inletB, compressor1.inlet) annotation(Line(
      points={{80,78},{40,78},{40,82}},
      color={28,108,200},
      thickness=0.5));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-200},{200,200}}), graphics={
        Text(
          extent={{-140,-14},{-134,-20}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-140,20},{-134,14}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-86,82},{-80,76}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-86,-14},{-80,-20}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{-86,-94},{-80,-100}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{-42,-114},{-36,-120}},
          textColor={28,108,200},
          textString="6"),
        Text(
          extent={{-6,-114},{0,-120}},
          textColor={28,108,200},
          textString="7"),
        Polygon(
          points={{-200,140},{-160,140},{-160,160},{-180,160},{-180,200},{-200,200},{-200,140}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-170,190},{-90,170}},
          textColor={238,46,47},
          textString="requires neglectInertance = true
see User's Guide",
          horizontalAlignment=TextAlignment.Left)}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    The nonlinear solver only converges for <code>neglectInertance = true</code>.
  </p>
</html>"));
end Step9FinalResults;
