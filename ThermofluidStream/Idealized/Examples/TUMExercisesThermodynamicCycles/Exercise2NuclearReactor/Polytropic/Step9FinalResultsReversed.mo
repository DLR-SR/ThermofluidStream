within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Polytropic;
model Step9FinalResultsReversed
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.He
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

  SI.Temperature T1 = compressor1.T_out;
  SI.Temperature T2 = compressor1.T_in;
  Real x = T2/T1;
  Real eta = 0.96;
  Real eta1 = (1 + eta*(x-1))/(eta*x);
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{-20,180},{0,200}})));
  Processes.Isobaric reactor(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,

    T_out_fixed(displayUnit="K") = 1180) annotation (Placement(transformation(
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
    eta_is_fixed=0.94) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-80,80})));
  EnergyFlow.Sources.FixedEnergyFlow reactorHeatFlow(E_flow(displayUnit="MW") = 6000000) annotation (Placement(transformation(extent={{-180,-10},{-160,10}})));
  EnergyFlow.Components.FixedTransferEfficiency turbine1Losses(eta=0.95) annotation (Placement(transformation(extent={{-50,90},{-30,70}})));
  Processes.PolytropicPerfectGas
                      turbine2(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure,
    p_out_fixed=5240000,
    T_out_fixed(displayUnit="K") = 1060,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature)
                                   annotation (Placement(transformation(extent={{-10,10},{10,-10}}, rotation=270,
        origin={-80,0})));
  EnergyFlow.Components.FixedTransferEfficiency turbine2Losses(eta=0.95) annotation (Placement(transformation(extent={{-50,10},{-30,-10}})));
  Processes.PolytropicPerfectGas turbine3(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    T_out_fixed(displayUnit="K") = 844.5) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-80,-50})));
  EnergyFlow.Components.Sum turbine3HeatLosses(n_in=2) annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  EnergyFlow.Components.FixedTransferEfficiency turbine3ShaftLosses(eta=0.95) annotation (Placement(transformation(extent={{-20,-40},{-40,-60}})));
  EnergyFlow.Sources.FixedEnergyFlow generator(E_flow(displayUnit="MW") = -3015000) annotation (Placement(transformation(extent={{20,-60},{0,-40}})));
  Processes.Isobaric heatExchangerHotSide(
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    redeclare package Medium = Medium,
    specifyOutlet=false,
    T_out_fixed(displayUnit="K")) annotation (Placement(transformation(extent={{-70,-100},{-50,-80}})));
  Processes.Isobaric cooler2(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,
    specifyOutlet=true,
    T_out_fixed(displayUnit="K") = 285) annotation (Placement(transformation(extent={{-30,-100},{-10,-80}})));
  Processes.Isobaric heatExchangerColdSide(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,
    T_out_fixed(displayUnit="K") = 780)                    annotation (Placement(transformation(extent={{-50,-110},{-70,-130}})));
  Sources.Sink_free sink(redeclare package Medium = Medium) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,30})));
  Processes.PolytropicPerfectGas compressor1(
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified,
    redeclare package Medium = Medium,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.IsentropicEfficiency,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={90,80})));
  ThermofluidStream.Boundaries.Source reverseSource(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    p0_par=7000000,
    temperatureFromInput=false,
    T0_par(displayUnit="K") = 376) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={50,-120})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=7000000,
    T0_par(displayUnit="K") = 376) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={20,-120})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(extent={{-20,70},{0,90}})));
  Sources.MassFlowRate massFlowRate(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={90,-120})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=sink.inlet.m_flow) annotation (Placement(transformation(extent={{116,-166},{96,-146}})));
  Processes.PolytropicPerfectGas reversedCompressor2(
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified,
    redeclare package Medium = Medium,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletPressure,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={90,-30})));
  Processes.Isobaric cooler1(
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    specifyOutlet=true,
    T_out_fixed(displayUnit="K"),
    h_out(start=Medium.h_default)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,-2})));
  Sources.Sink_free reverseSink(redeclare package Medium = Medium) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={90,50})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
                                       annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=compressor1.outlet.state.p) annotation (Placement(transformation(extent={{30,-34},{50,-14}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=compressor1.outlet.state.T) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={124,8})));
  ThermofluidStream.Utilities.showRealValue heatExchangerOutletTemperature(
    description="T_6",
    use_numberPort=false,
    number=heatExchangerHotSide.outlet.state.T,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{-160,-200},{-140,-180}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="eff",
    use_numberPort=false,
    number=-generator.E_flow/reactorHeatFlow.E_flow,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{-120,-200},{-100,-180}})));
  ThermofluidStream.Utilities.showRealValue turbine1OutletPressure(
    description="p_3",
    use_numberPort=false,
    number=turbine1.outlet.state.p,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{-80,-200},{-60,-180}})));
  ThermofluidStream.Utilities.showRealValue turbine2IsentropicEfficiency(
    description="eta_is_T2",
    use_numberPort=false,
    number=turbine2.eta_is,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{-40,-200},{-20,-180}})));
  ThermofluidStream.Utilities.showRealValue compressor1Power(
    description="P_CMP1",
    use_numberPort=false,
    number=compressor1.P,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{0,-200},{20,-180}})));
  ThermofluidStream.Utilities.showRealValue compressor2Power(
    description="P_CMP2",
    use_numberPort=false,
    number=reversedCompressor2.P,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{40,-200},{60,-180}})));
  ThermofluidStream.Utilities.showRealValue turbine3HeatLoss(
    description="Q_T3",
    use_numberPort=false,
    number=turbine3HeatLosses.E_flow_out,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{80,-200},{100,-180}})));
  ThermofluidStream.Utilities.showRealValue compressor1EntropyProduction(
    description="S_irr_CMP1",
    use_numberPort=false,
    number=entropyDifferenceSensor.value*compressor1.m_flow,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{120,-202},{140,-182}})));
  ThermofluidStream.Sensors.DifferenceSensorSelect entropyDifferenceSensor(
    displayInstanceName=true,
    displayParameters=false,
    redeclare package MediumA = Medium,
    redeclare package MediumB = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={116,64})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=eta1)         annotation (Placement(transformation(extent={{20,50},{40,70}})));
equation
  connect(reactor.outlet,turbine1. inlet) annotation (Line(
      points={{-140,10},{-140,100},{-80,100},{-80,90}},
      color={28,108,200},
      thickness=0.5));
  connect(reactorHeatFlow.E_flow_out, reactor.Q_flow_in) annotation (Line(points={{-159,0},{-148,0}},   color={255,170,85}));
  connect(turbine1.P_out, turbine1Losses.E_flow_in) annotation (Line(points={{-73,80},{-52,80}},
                                                                                              color={255,170,85}));
  connect(turbine1.outlet, turbine2.inlet) annotation (Line(
      points={{-80,70},{-80,10}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine2.P_out, turbine2Losses.E_flow_in) annotation (Line(points={{-73,0},{-52,0}}, color={255,170,85}));
  connect(turbine2.outlet, turbine3.inlet) annotation (Line(
      points={{-80,-10},{-80,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine3ShaftLosses.E_flow_out, turbine3HeatLosses.E_flow_in[1]) annotation (Line(points={{-41,-50},{-48,-50},{-48,-32},{-40,-32},{-40,-31.5}}, color={255,170,85}));
  connect(turbine3.P_out, turbine3HeatLosses.E_flow_in[2]) annotation (Line(points={{-73,-50},{-52,-50},{-52,-28.5},{-40,-28.5}}, color={255,170,85}));
  connect(generator.E_flow_out, turbine3ShaftLosses.E_flow_in) annotation (Line(points={{-1,-50},{-18,-50}}, color={255,170,85}));
  connect(heatExchangerHotSide.outlet,cooler2. inlet) annotation (Line(
      points={{-50,-90},{-30,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerHotSide.inlet, turbine3.outlet) annotation (Line(
      points={{-70,-90},{-80,-90},{-80,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerColdSide.outlet, reactor.inlet) annotation (Line(
      points={{-70,-120},{-140,-120},{-140,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerColdSide.Q_flow_out,heatExchangerHotSide. Q_flow_in) annotation (Line(points={{-60,-113},{-60,-98}},color={255,170,85}));
  connect(source.outlet, heatExchangerColdSide.inlet) annotation (Line(
      points={{10,-120},{-50,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine1Losses.E_flow_out, gain.u) annotation (Line(points={{-29,80},{-22,80}}, color={255,170,85}));
  connect(realExpression.y, massFlowRate.m_flow_prescribed) annotation (Line(points={{95,-156},{90,-156},{90,-128}},color={0,0,127}));
  connect(compressor1.P_in, gain.y) annotation (Line(points={{82,80},{1,80}}, color={255,170,85}));
  connect(compressor1.outlet, reverseSink.inlet) annotation (Line(
      points={{90,70},{90,60}},
      color={28,108,200},
      thickness=0.5));
  connect(reverseSource.outlet, massFlowRate.inlet) annotation (Line(
      points={{60,-120},{80,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate.outlet, compressor1.inlet) annotation (Line(
      points={{100,-120},{140,-120},{140,100},{90,100},{90,90}},
      color={28,108,200},
      thickness=0.5));
  connect(cooler2.outlet, reversedCompressor2.inlet) annotation (Line(
      points={{-10,-90},{90,-90},{90,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(reversedCompressor2.outlet, cooler1.inlet) annotation (Line(
      points={{90,-20},{90,-12}},
      color={28,108,200},
      thickness=0.5));
  connect(cooler1.outlet, sink.inlet) annotation (Line(
      points={{90,8},{90,20}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine2Losses.E_flow_out, gain1.u) annotation (Line(points={{-29,0},{-2,0}}, color={255,170,85}));
  connect(reversedCompressor2.P_in, gain1.y) annotation (Line(points={{82,-30},{60,-30},{60,0},{21,0}}, color={255,170,85}));
  connect(realExpression1.y, reversedCompressor2.processSpec_prescribed) annotation (Line(points={{51,-24},{78,-24}}, color={0,0,127}));
  connect(realExpression2.y, cooler1.outletSpec_prescribed) annotation (Line(points={{113,8},{102,8}}, color={0,0,127}));
  connect(realExpression4.y, compressor1.processSpec_prescribed) annotation (Line(points={{41,60},{70,60},{70,74},{78,74}}, color={0,0,127}));
  connect(entropyDifferenceSensor.inletA, compressor1.inlet) annotation (Line(
      points={{126,64},{140,64},{140,100},{90,100},{90,90}},
      color={28,108,200},
      thickness=0.5));
  connect(entropyDifferenceSensor.inletB, reverseSink.inlet) annotation (Line(
      points={{106,64},{90,64},{90,60}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
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
          extent={{-86,70},{-80,64}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-86,-14},{-80,-20}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{-86,-64},{-80,-70}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{-42,-84},{-36,-90}},
          textColor={28,108,200},
          textString="6"),
        Text(
          extent={{-6,-84},{0,-90}},
          textColor={28,108,200},
          textString="7")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    Theoretically, the nonlinear equations can be avoided if the flow through <code>compressor1</code> is reversed. 
    In this case the inlet state of <code>reversedCompressor1</code> is known. 
    This however requires to calculate a modified isentropic efficiency, which is impractical, unless <code>eta_is = 1</code>.
  </p>
</html>"));
end Step9FinalResultsReversed;
