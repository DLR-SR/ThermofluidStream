within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Adiabatic;
model Step9FinalResults
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.He
                                                                              constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(  displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{-40,220},{-20,240}})));
  Processes.Isobaric reactor(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed(displayUnit="K") = 1180) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-160,50})));
  Processes.Adiabatic turbine1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.94,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_out(start=7000000)) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-80,180})));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-50,140})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints annotation(Placement(transformation(
        extent={{-20,-12},{20,12}},
        rotation=180,
        origin={-40,160})));
  Modelica.Blocks.Sources.RealExpression turbine1OutletTemperature(y(unit="K") = 1110) annotation(Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-42,160})));
  Processes.Adiabatic turbine2(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    etaSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=5240000,
    eta_is(start=1),
    h_out(start=Medium.h_default)) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-80,30})));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor1(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-50,-10})));
  Modelica.Blocks.Sources.RealExpression turbine2OutletTemperature(y(unit="K") = 1060) annotation(Placement(transformation(extent={{-52,0},{-32,20}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints1 annotation(Placement(transformation(extent={{-20,-2},{-60,22}})));
  Processes.Adiabatic turbine3(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_out(start=5240000)) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-80,-60})));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor2(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-50,-104})));
  Modelica.Blocks.Sources.RealExpression turbine3OutletTemperature(y(unit="K") = 844.5) annotation(Placement(transformation(extent={{-52,-92},{-32,-72}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints2 annotation(Placement(transformation(extent={{-22,-94},{-62,-70}})));
  Processes.Isobaric heatExchangerHotSide(
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    h_out(start=Medium.h_default),
    redeclare package Medium = Medium,
    specifyOutlet=false,
    T_out_fixed(displayUnit="K")) annotation(Placement(transformation(extent={{-60,-150},{-40,-130}})));
  Processes.Isobaric cooler2(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    specifyOutlet=true,
    T_out_fixed(displayUnit="K") = 285) annotation(Placement(transformation(extent={{10,-150},{30,-130}})));
  Processes.Isobaric heatExchangerColdSide(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    T_out_fixed(displayUnit="K") = 780) annotation(Placement(transformation(extent={{-40,-160},{-60,-180}})));
  Processes.Adiabatic compressor1(
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    redeclare package Medium = Medium,

    eta_fixed=0.96,
    p_out_fixed=7000000,
    h_out(start=Medium.h_default)) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={80,180})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints3(y1(start=300))
                                                                       annotation(Placement(transformation(extent={{132,196},{172,220}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y(unit="K") = 376) annotation(Placement(transformation(extent={{162,198},{142,218}})));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor3(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={100,208})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints4(y1(start=60e5))
                                                                       annotation(Placement(transformation(extent={{8,90},{48,114}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y(unit="W") = 0)  annotation(Placement(transformation(extent={{38,92},{18,112}})));
  Processes.Adiabatic compressor2(
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    etaSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    eta_is(start=1)) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={80,30})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y(unit="W") = 0)  annotation(Placement(transformation(extent={{40,-10},{20,10}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints5 annotation(Placement(transformation(extent={{10,-12},{50,12}})));
  Processes.Isobaric cooler1(
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    specifyOutlet=true,
    T_out_fixed(displayUnit="K"),
    h_out(start=Medium.h_default)) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,100})));
  Sources.LoopBreaker loopBreaker1(
    redeclare package Medium = Medium,
    p_out_fixed=7000000,
    T_out_fixed(displayUnit="K") = 780)
                    annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-120,-170})));
  ThermofluidStream.Utilities.showRealValue heatExchangerOutletTemperature(
    description="T_6",
    use_numberPort=false,
    number=heatExchangerHotSide.outlet.state.T,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-180,-220},{-160,-200}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="eff",
    use_numberPort=false,
    number=-generator.E_flow/reactorHeatFlow.E_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-140,-220},{-120,-200}})));
  ThermofluidStream.Utilities.showRealValue turbine1OutletPressure(
    description="p_3",
    use_numberPort=false,
    number=turbine1.outlet.state.p,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-100,-220},{-80,-200}})));
  ThermofluidStream.Utilities.showRealValue turbine2IsentropicEfficiency(
    description="eta_is_T2",
    use_numberPort=false,
    number=turbine2.eta_is,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-60,-220},{-40,-200}})));
  ThermofluidStream.Utilities.showRealValue compressor1Power(
    description="P_CMP1",
    use_numberPort=false,
    number=compressor1.P,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-20,-220},{0,-200}})));
  ThermofluidStream.Utilities.showRealValue compressor2Power(
    description="P_CMP2",
    use_numberPort=false,
    number=compressor2.P,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{20,-220},{40,-200}})));
  ThermofluidStream.Utilities.showRealValue turbine3HeatLoss(
    description="Q_T3",
    use_numberPort=false,
    number=turbine3HeatLosses.E_flow_out,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{60,-220},{80,-200}})));
  ThermofluidStream.Utilities.showRealValue compressor1EntropyProduction(
    description="S_irr_CMP1",
    use_numberPort=false,
    number=entropyDifferenceSensor.value*compressor1.m_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{100,-222},{120,-202}})));
  ThermofluidStream.Sensors.DifferenceSensorSelect entropyDifferenceSensor(
    displayInstanceName=true,
    displayParameters=false,
    redeclare package MediumA = Medium,
    redeclare package MediumB = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK) annotation(
    Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={98,158})));
  EnergyFlow.Sources.FixedEnergyFlow reactorHeatFlow(E_flow(displayUnit="MW") = 6000000) annotation(Placement(transformation(extent={{-200,40},{-180,60}})));
  EnergyFlow.Components.Sum turbine3HeatLosses(n_in=2) annotation(Placement(transformation(extent={{-40,-50},{-20,-30}})));
  EnergyFlow.Components.FixedTransferEfficiency turbine3ShaftLosses(eta=0.95) annotation(Placement(transformation(extent={{-20,-50},{-40,-70}})));
  EnergyFlow.Sources.FixedEnergyFlow generator(E_flow(displayUnit="MW") = -3015000) annotation(Placement(transformation(extent={{20,-70},{0,-50}})));
  EnergyFlow.Components.FixedTransferEfficiency turbine1Losses(eta=0.95) annotation(Placement(transformation(extent={{-30,190},{-10,170}})));
  EnergyFlow.Components.Sum pseudoSink(n_in=2) annotation(Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={10,140})));
  EnergyFlow.Components.FixedTransferEfficiency turbine2Losses(eta=0.95) annotation(Placement(transformation(extent={{-40,40},{-20,20}})));
  EnergyFlow.Components.Sum pseudoSink1(n_in=2) annotation(Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,16})));
equation
  connect(reactor.outlet,turbine1. inlet) annotation(Line(
      points={{-160,60},{-160,200},{-80,200},{-80,190}},
      color={28,108,200},
      thickness=0.5));
  connect(temperatureSensor.inlet, turbine1.outlet) annotation(Line(
      points={{-60,140},{-80,140},{-80,170}},
      color={28,108,200},
      thickness=0.5));
  connect(inverseBlockConstraints.y1, turbine1.outletSpec_prescribed) annotation(Line(points={{-61,160},{-64,160},{-64,170},{-68,170}},
                                                                                                                        color={0,0,127}));
  connect(turbine1.outlet,turbine2. inlet) annotation(
    Line(
      points={{-80,170},{-80,40}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine2.outlet, temperatureSensor1.inlet) annotation(Line(
      points={{-80,20},{-80,-10},{-60,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine2.eta_prescribed, inverseBlockConstraints1.y1) annotation(Line(points={{-68,24},{-64,24},{-64,10},{-61,10}}, color={0,0,127}));
  connect(turbine2OutletTemperature.y, inverseBlockConstraints1.u2) annotation(Line(points={{-31,10},{-24,10}}, color={0,0,127}));
  connect(temperatureSensor1.value_out, inverseBlockConstraints1.u1) annotation(Line(points={{-41.8,-10},{-10,-10},{-10,10},{-18,10}},color={0,0,127}));
  connect(turbine1OutletTemperature.y, inverseBlockConstraints.u2) annotation(Line(points={{-31,160},{-24,160}},
                                                                                                              color={0,0,127}));
  connect(temperatureSensor.value_out, inverseBlockConstraints.u1) annotation(Line(points={{-41.8,140},{-10,140},{-10,160},{-18,160}},
                                                                                                                                color={0,0,127}));
  connect(turbine2.outlet,turbine3. inlet) annotation(
    Line(
      points={{-80,20},{-80,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(temperatureSensor2.inlet, turbine3.outlet) annotation(Line(
      points={{-60,-104},{-80,-104},{-80,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(inverseBlockConstraints2.y1, turbine3.outletSpec_prescribed) annotation(Line(points={{-63,-82},{-64,-82},{-64,-70},{-68,-70}}, color={0,0,127}));
  connect(inverseBlockConstraints2.u2, turbine3OutletTemperature.y) annotation(Line(points={{-26,-82},{-31,-82}}, color={0,0,127}));
  connect(temperatureSensor2.value_out, inverseBlockConstraints2.u1) annotation(Line(points={{-41.8,-104},{-8,-104},{-8,-82},{-20,-82}}, color={0,0,127}));
  connect(heatExchangerHotSide.outlet, cooler2.inlet) annotation(Line(
      points={{-40,-140},{10,-140}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerHotSide.inlet, turbine3.outlet) annotation(Line(
      points={{-60,-140},{-80,-140},{-80,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerColdSide.inlet, compressor1.outlet) annotation(Line(
      points={{-40,-170},{120,-170},{120,220},{80,220},{80,190}},
      color={28,108,200},
      thickness=0.5));
  connect(inverseBlockConstraints3.u2, realExpression3.y) annotation(Line(points={{136,208},{141,208}}, color={0,0,127}));
  connect(compressor1.outlet, temperatureSensor3.inlet) annotation(Line(
      points={{80,190},{80,208},{90,208}},
      color={28,108,200},
      thickness=0.5));
  connect(temperatureSensor3.value_out, inverseBlockConstraints3.u1) annotation(Line(points={{108.2,208},{130,208}}, color={0,0,127}));
  connect(inverseBlockConstraints4.u2, realExpression1.y) annotation(Line(points={{12,102},{17,102}}, color={0,0,127}));
  connect(cooler2.outlet, compressor2.inlet) annotation(Line(
      points={{30,-140},{80,-140},{80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor2.outletSpec_prescribed, inverseBlockConstraints4.y1) annotation(Line(points={{68,40},{52,40},{52,102},{49,102}}, color={0,0,127}));
  connect(inverseBlockConstraints5.u2, realExpression2.y) annotation(Line(points={{14,0},{19,0}},   color={0,0,127}));
  connect(inverseBlockConstraints5.y1, compressor2.eta_prescribed) annotation(Line(points={{51,0},{52,0},{52,36},{68,36}},   color={0,0,127}));
  connect(compressor2.outlet, cooler1.inlet) annotation(Line(
      points={{80,40},{80,90}},
      color={28,108,200},
      thickness=0.5));
  connect(cooler1.outlet, compressor1.inlet) annotation(Line(
      points={{80,110},{80,170}},
      color={28,108,200},
      thickness=0.5));
  connect(cooler1.outletSpec_prescribed, inverseBlockConstraints3.y1) annotation(Line(points={{92,110},{180,110},{180,208},{173,208}}, color={0,0,127}));
  connect(heatExchangerColdSide.outlet, loopBreaker1.inlet) annotation(Line(
      points={{-60,-170},{-110,-170}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker1.outlet, reactor.inlet) annotation(Line(
      points={{-130,-170},{-160,-170},{-160,40}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor1.outlet, entropyDifferenceSensor.inletA) annotation(Line(
      points={{80,190},{80,220},{120,220},{120,158},{108,158}},
      color={28,108,200},
      thickness=0.5));
  connect(entropyDifferenceSensor.inletB, compressor1.inlet) annotation(Line(
      points={{88,158},{80,158},{80,170}},
      color={28,108,200},
      thickness=0.5));
  connect(reactorHeatFlow.E_flow_out, reactor.Q_flow_in) annotation(Line(points={{-179,50},{-168,50}}, color={255,170,85}));
  connect(generator.E_flow_out, turbine3ShaftLosses.E_flow_in) annotation(Line(points={{-1,-60},{-18,-60}}, color={255,170,85}));
  connect(turbine3ShaftLosses.E_flow_out, turbine3HeatLosses.E_flow_in[1]) annotation(Line(points={{-41,-60},{-50,-60},{-50,-41.5},{-40,-41.5}},   color={255,170,85}));
  connect(turbine3.P_out, turbine3HeatLosses.E_flow_in[2]) annotation(Line(points={{-73,-60},{-52,-60},{-52,-38},{-40,-38},{-40,-38.5}},
                                                                                                                                    color={255,170,85}));
  connect(heatExchangerColdSide.Q_flow_out, heatExchangerHotSide.Q_flow_in) annotation(Line(points={{-50,-163},{-50,-148}}, color={255,170,85}));
  connect(turbine1.P_out, turbine1Losses.E_flow_in) annotation(Line(points={{-73,180},{-32,180}}, color={255,170,85}));
  connect(turbine1Losses.E_flow_out, pseudoSink.E_flow_in[1]) annotation(Line(points={{-9,180},{8,180},{8,150},{11.5,150}},
                                                                                                                          color={255,170,85}));
  connect(compressor1.P_out, pseudoSink.E_flow_in[2]) annotation(Line(points={{73,180},{12,180},{12,150},{8.5,150}},
                                                                                                                color={255,170,85}));
  connect(pseudoSink.E_flow_out, inverseBlockConstraints4.u1) annotation(Line(points={{10,128.3},{10,124},{-6,124},{-6,102},{6,102}},  color={255,170,85}));
  connect(pseudoSink1.E_flow_out, inverseBlockConstraints5.u1) annotation(Line(points={{0,4.3},{0,4},{2,4},{2,0},{8,0}},
                                                                                                                  color={255,170,85}));
  connect(turbine2.P_out, turbine2Losses.E_flow_in) annotation(Line(points={{-73,30},{-42,30}}, color={255,170,85}));
  connect(turbine2Losses.E_flow_out, pseudoSink1.E_flow_in[1]) annotation(Line(points={{-19,30},{1.5,30},{1.5,26}},   color={255,170,85}));
  connect(compressor2.P_out, pseudoSink1.E_flow_in[2]) annotation(Line(points={{73,30},{-1.5,30},{-1.5,26}},   color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-220,-240},{220,240}}), graphics={
        Text(
          extent={{-160,0},{-154,-6}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-160,138},{-154,132}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-86,108},{-80,102}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-86,-14},{-80,-20}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{-86,-104},{-80,-110}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{-16,-134},{-10,-140}},
          textColor={28,108,200},
          textString="6"),
        Text(
          extent={{74,-54},{80,-60}},
          textColor={28,108,200},
          textString="7"),
        Text(
          extent={{74,72},{80,66}},
          textColor={28,108,200},
          textString="8"),
        Text(
          extent={{74,146},{80,140}},
          textColor={28,108,200},
          textString="9"),
        Text(
          extent={{10,-164},{16,-170}},
          textColor={28,108,200},
          textString="10"),
        Text(
          extent={{112,168},{118,162}},
          textColor={28,108,200},
          textString="10")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Step9FinalResults;
