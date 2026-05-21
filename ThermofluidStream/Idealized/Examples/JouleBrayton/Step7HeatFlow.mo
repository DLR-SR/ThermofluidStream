within ThermofluidStream.Idealized.Examples.JouleBrayton;
model Step7HeatFlow
  extends Modelica.Icons.Example;

  replaceable package Air = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);
  replaceable package Water = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{180,80},{200,100}})));

  Processes.Adiabatic lowPressureCompressor(
    redeclare package Medium = Air,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    pRatio_fixed=2,
    p_out_fixed=1000000) annotation(Placement(transformation(extent={{-150,-10},{-130,10}})));
  Processes.Adiabatic highPressureTurbine(
    redeclare package Medium = Air,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=0.8,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    enableFilter=true) annotation(Placement(transformation(extent={{20,-10},{40,10}})));
  ThermofluidStream.Boundaries.Source
                    airSource(
    redeclare package Medium = Air,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-186,-10},{-166,10}})));
  Processes.Isobaric firstCombustion(
    redeclare package Medium = Air,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed=1673.15) annotation(Placement(transformation(extent={{-20,-10},{0,10}})));
  .ThermofluidStream.Boundaries.Sink_m airSink(redeclare package Medium = Air, m_flow_fixed=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,52})));
  Processes.Adiabatic highPressureCompressor(
    redeclare package Medium = Air,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=2000000) annotation(Placement(transformation(extent={{-90,-10},{-70,10}})));
  Processes.Isobaric secondCombustion(
    redeclare package Medium = Air,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed=1673.15) annotation(Placement(transformation(extent={{60,-10},{80,10}})));
  Processes.Adiabatic lowPressureTurbine(
    redeclare package Medium = Air,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=100000) annotation(Placement(transformation(extent={{100,-10},{120,10}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="efficiency",
    use_numberPort=false,
    number=generatorPower.E_flow_out/(firstCombustion.Q_flow + secondCombustion.Q_flow),
    displayVariable=false) annotation(Placement(transformation(extent={{-30,60},{-10,80}})));
  EnergyFlow.Components.FixedTransferEfficiency highPressureShaft(eta=0.95, outputDissipation=true)
                                                                           annotation(Placement(transformation(extent={{-40,-30},{-20,-10}})));
  EnergyFlow.Components.FixedTransferEfficiency lowPressureShaft(eta=0.95, outputDissipation=true)
                                                                          annotation(Placement(transformation(extent={{-10,-50},{10,-30}})));
  EnergyFlow.Components.FixedTransferEfficiency generatorPower(eta=0.99) annotation(Placement(transformation(extent={{170,-40},{190,-20}})));
  EnergyFlow.Components.Sum lowPressurePower(n_in=2) annotation(Placement(transformation(extent={{130,-40},{150,-20}})));
  ThermofluidStream.Boundaries.Source
                    waterSource(
    redeclare package Medium = Water,
    p0_par=100000,
    T0_par=293.15) annotation(
    Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-80,30})));
  Boundaries.Sink_free waterSink(redeclare package Medium = Water) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-140,30})));
  Processes.Isobaric coolerWaterSide(
    redeclare package Medium = Water,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.TemperatureDifference,
    dT_fixed=10) annotation(Placement(transformation(extent={{-100,20},{-120,40}})));
  Processes.Isobaric coolerAirSide(
    redeclare package Medium = Air,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    T_out_fixed=293.15) annotation(Placement(transformation(extent={{-120,10},{-100,-10}})));
  Processes.Isobaric recuperatorB(
    redeclare package Medium = Air,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.TemperatureDifference) annotation(Placement(transformation(extent={{-30,20},{-50,40}})));
  Processes.Isobaric recuperatorA(
    redeclare package Medium = Air,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-50,10},{-30,-10}})));
  ThermofluidStream.Sensors.SingleSensorSelect singleSensorSelect(
    displayInstanceName=false,
    redeclare package Medium = Air,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation(Placement(transformation(extent={{-6,10},{-26,30}})));

equation
  connect(airSource.outlet, lowPressureCompressor.inlet) annotation(
    Line(
      points={{-166,0},{-150,0}},
      color={28,108,200},
      thickness=0.5));
  connect(firstCombustion.outlet, highPressureTurbine.inlet) annotation(
    Line(
      points={{0,0},{20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(highPressureTurbine.outlet, secondCombustion.inlet) annotation(
    Line(
      points={{40,0},{60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(secondCombustion.outlet, lowPressureTurbine.inlet) annotation(
    Line(
      points={{80,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(highPressureCompressor.P_out, highPressureShaft.E_flow_in) annotation(Line(points={{-80,-7},{-80,-20},{-42,-20}},  color={255,170,85}));
  connect(highPressureShaft.E_flow_out, highPressureTurbine.P_in) annotation(Line(points={{-19,-20},{30,-20},{30,-8}}, color={255,170,85}));
  connect(lowPressureTurbine.P_out, lowPressurePower.E_flow_in[1]) annotation(Line(points={{110,-7},{110,-28},{130,-28},{130,-31.5}},
                                                                                                                                 color={255,170,85}));
  connect(lowPressureShaft.E_flow_out, lowPressurePower.E_flow_in[2]) annotation(Line(points={{11,-40},{110,-40},{110,-32},{130,-32},{130,-28.5}},
                                                                                                                                   color={255,170,85}));
  connect(lowPressurePower.E_flow_out, generatorPower.E_flow_in) annotation(Line(points={{151.7,-30},{168,-30}},    color={255,170,85}));
  connect(lowPressureCompressor.P_out, lowPressureShaft.E_flow_in) annotation(Line(points={{-140,-7},{-140,-40},{-12,-40}},  color={255,170,85}));
  connect(coolerWaterSide.inlet,waterSource. outlet) annotation(
    Line(
      points={{-100,30},{-90,30}},
      color={28,108,200},
      thickness=0.5));
  connect(waterSink.inlet,coolerWaterSide. outlet) annotation(
    Line(
      points={{-130,30},{-120,30}},
      color={28,108,200},
      thickness=0.5));
  connect(highPressureCompressor.outlet, recuperatorA.inlet) annotation(Line(
      points={{-70,0},{-50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(recuperatorA.outlet, firstCombustion.inlet) annotation(Line(
      points={{-30,0},{-20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(airSink.inlet, recuperatorB.outlet) annotation(Line(
      points={{-60,42},{-60,30},{-50,30}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.value_out, recuperatorA.outletSpec_prescribed) annotation(Line(points={{-24.2,20},{-30,20},{-30,12}},
                                                                                                                             color={0,0,127}));
  connect(lowPressureTurbine.outlet, recuperatorB.inlet) annotation(Line(
      points={{120,0},{130,0},{130,30},{-30,30}},
      color={28,108,200},
      thickness=0.5));
  connect(recuperatorB.inlet, singleSensorSelect.inlet) annotation(Line(
      points={{-30,30},{6,30},{6,20},{-6,20}},
      color={28,108,200},
      thickness=0.5));
  connect(recuperatorA.Q_flow_out, recuperatorB.Q_flow_in) annotation(Line(points={{-40,7},{-40,22}}, color={255,170,85}));
  connect(lowPressureCompressor.outlet, coolerAirSide.inlet) annotation(Line(
      points={{-130,0},{-120,0}},
      color={28,108,200},
      thickness=0.5));
  connect(coolerAirSide.outlet, highPressureCompressor.inlet) annotation(Line(
      points={{-100,0},{-90,0}},
      color={28,108,200},
      thickness=0.5));
  connect(coolerAirSide.Q_flow_out, coolerWaterSide.Q_flow_in) annotation(Line(points={{-110,7},{-110,22}},
                                                                                                          color={255,170,85}));

  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(
        extent={{-200,-100},{200,100}}),
      graphics={
        Text(
          extent={{-162,6},{-156,0}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-128,6},{-122,0}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-98,6},{-92,0}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-68,6},{-62,0}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{-30,6},{-24,0}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{6,6},{12,0}},
          textColor={28,108,200},
          textString="6"),
        Text(
          extent={{46,6},{52,0}},
          textColor={28,108,200},
          textString="7"),
        Text(
          extent={{86,6},{92,0}},
          textColor={28,108,200},
          textString="8"),
        Text(
          extent={{122,6},{128,0}},
          textColor={28,108,200},
          textString="9"),
        Text(
          extent={{-68,18},{-62,12}},
          textColor={28,108,200},
          textString="10"),
        Text(
          extent={{-98,36},{-92,30}},
          textColor={28,108,200},
          textString="11"),
        Text(
          extent={{-128,36},{-122,30}},
          textColor={28,108,200},
          textString="12")}),
    Documentation(info="<html>
  <p>
    In a seventh step, the heat exchangers are modeled differently.
  </p>

  <p>
    Further documentation is available in the 
    <a href=\"modelica://ThermofluidStream.Idealized.Examples.JouleBrayton\">JouleBrayton</a> package.
  </p>
</html>",
      revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Step7HeatFlow;
