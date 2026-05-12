within ThermofluidStream.Idealized.Examples.JouleBrayton;
model Step7HeatFlow
  extends Modelica.Icons.Example;

  replaceable package Air = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);
  replaceable package Water = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{140,80},{160,100}})));

  Processes.Adiabatic lowPressureCompressor(
    redeclare package Medium = Air,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,

    pr_fixed=2,
    p_out_fixed=1000000) annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Processes.Adiabatic highPressureTurbine(
    redeclare package Medium = Air,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=0.8,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,
    enableFilter=true) annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  ThermofluidStream.Boundaries.Source
                    airSource(
    redeclare package Medium = Air,
    p0_par=100000,
    T0_par=293.15) annotation (Placement(transformation(extent={{-156,-10},{-136,10}})));
  Processes.Isobaric firstCombustion(
    redeclare package Medium = Air,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,

    T_out_fixed=1673.15) annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Sink_m airSink(redeclare package Medium = Air, m_flow_fixed=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,52})));
  Processes.Adiabatic highPressureCompressor(
    redeclare package Medium = Air,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,

    p_out_fixed=2000000) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Processes.Isobaric secondCombustion(
    redeclare package Medium = Air,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,

    T_out_fixed=1673.15) annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Processes.Adiabatic lowPressureTurbine(
    redeclare package Medium = Air,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,

    p_out_fixed=100000) annotation (Placement(transformation(extent={{130,-10},{150,10}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="efficiency",
    use_numberPort=false,
    number=generatorPower.E_flow_out/(firstCombustion.Q_flow + secondCombustion.Q_flow),
    displayVariable=false) annotation (Placement(transformation(extent={{0,60},{20,80}})));
  EnergyFlow.Components.FixedTransferEfficiency highPressureShaft(eta=0.95, outputDissipation=true)
                                                                            annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  EnergyFlow.Components.FixedTransferEfficiency lowPressureShaft(eta=0.95, outputDissipation=true)
                                                                           annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  EnergyFlow.Components.FixedTransferEfficiency generatorPower(eta=0.99) annotation (Placement(transformation(extent={{200,-40},{220,-20}})));
  EnergyFlow.Components.Sum lowPressurePower(n_in=2) annotation (Placement(transformation(extent={{160,-40},{180,-20}})));
  ThermofluidStream.Boundaries.Source
                    waterSource(
    redeclare package Medium = Water,
    p0_par=100000,
    T0_par=293.15)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-50,30})));
  Sources.Sink_free waterSink(redeclare package Medium = Water) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-110,30})));
  Processes.Isobaric coolerWaterSide(
    redeclare package Medium = Water,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.TemperatureDifference,
    dT_fixed=10) annotation (Placement(transformation(extent={{-70,20},{-90,40}})));
  Processes.Isobaric coolerAirSide(
    redeclare package Medium = Air,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,
    T_out_fixed=293.15) annotation (Placement(transformation(extent={{-90,10},{-70,-10}})));
  Processes.Isobaric recuperatorB(
    redeclare package Medium = Air,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.TemperatureDifference)     annotation (Placement(transformation(extent={{0,20},{-20,40}})));
  Processes.Isobaric recuperatorA(
    redeclare package Medium = Air,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-20,10},{0,-10}})));
  ThermofluidStream.Sensors.SingleSensorSelect singleSensorSelect(
    displayInstanceName=false,
    redeclare package Medium = Air,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation (Placement(transformation(extent={{24,10},{4,30}})));
equation
  connect(airSource.outlet, lowPressureCompressor.inlet)
    annotation (Line(
      points={{-136,0},{-120,0}},
      color={28,108,200},
      thickness=0.5));
  connect(firstCombustion.outlet, highPressureTurbine.inlet)
    annotation (Line(
      points={{30,0},{50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(highPressureTurbine.outlet, secondCombustion.inlet)
    annotation (Line(
      points={{70,0},{90,0}},
      color={28,108,200},
      thickness=0.5));
  connect(secondCombustion.outlet, lowPressureTurbine.inlet)
    annotation (Line(
      points={{110,0},{130,0}},
      color={28,108,200},
      thickness=0.5));
  connect(highPressureCompressor.P_out, highPressureShaft.E_flow_in) annotation (Line(points={{-50,-7},{-50,-20},{-12,-20}},  color={255,170,85}));
  connect(highPressureShaft.E_flow_out, highPressureTurbine.P_in) annotation (Line(points={{11,-20},{60,-20},{60,-8}},  color={255,170,85}));
  connect(lowPressureTurbine.P_out, lowPressurePower.E_flow_in[1]) annotation (Line(points={{140,-7},{140,-28},{160,-28},{160,-31.5}},
                                                                                                                                 color={255,170,85}));
  connect(lowPressureShaft.E_flow_out, lowPressurePower.E_flow_in[2]) annotation (Line(points={{41,-40},{140,-40},{140,-32},{160,-32},{160,-28.5}},
                                                                                                                                   color={255,170,85}));
  connect(lowPressurePower.E_flow_out, generatorPower.E_flow_in) annotation (Line(points={{181.7,-30},{198,-30}},    color={255,170,85}));
  connect(lowPressureCompressor.P_out, lowPressureShaft.E_flow_in) annotation (Line(points={{-110,-7},{-110,-40},{18,-40}},   color={255,170,85}));
  connect(coolerWaterSide.inlet,waterSource. outlet)
    annotation (Line(
      points={{-70,30},{-60,30}},
      color={28,108,200},
      thickness=0.5));
  connect(waterSink.inlet,coolerWaterSide. outlet)
    annotation (Line(
      points={{-100,30},{-90,30}},
      color={28,108,200},
      thickness=0.5));
  connect(highPressureCompressor.outlet, recuperatorA.inlet) annotation (Line(
      points={{-40,0},{-20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(recuperatorA.outlet, firstCombustion.inlet) annotation (Line(
      points={{0,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(airSink.inlet, recuperatorB.outlet) annotation (Line(
      points={{-30,42},{-30,30},{-20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.value_out, recuperatorA.outletSpec_prescribed) annotation (Line(points={{5.8,20},{0,20},{0,12}}, color={0,0,127}));
  connect(lowPressureTurbine.outlet, recuperatorB.inlet) annotation (Line(
      points={{150,0},{160,0},{160,30},{0,30}},
      color={28,108,200},
      thickness=0.5));
  connect(recuperatorB.inlet, singleSensorSelect.inlet) annotation (Line(
      points={{0,30},{36,30},{36,20},{24,20}},
      color={28,108,200},
      thickness=0.5));
  connect(recuperatorA.Q_flow_out, recuperatorB.Q_flow_in) annotation (Line(points={{-10,7},{-10,22}}, color={255,170,85}));
  connect(lowPressureCompressor.outlet, coolerAirSide.inlet) annotation (Line(
      points={{-100,0},{-90,0}},
      color={28,108,200},
      thickness=0.5));
  connect(coolerAirSide.outlet, highPressureCompressor.inlet) annotation (Line(
      points={{-70,0},{-60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(coolerAirSide.Q_flow_out, coolerWaterSide.Q_flow_in) annotation (Line(points={{-80,7},{-80,22}}, color={255,170,85}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-100},{160,100}}), graphics={
        Text(
          extent={{-132,6},{-126,0}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-98,6},{-92,0}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-68,6},{-62,0}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-38,6},{-32,0}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{0,6},{6,0}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{36,6},{42,0}},
          textColor={28,108,200},
          textString="6"),
        Text(
          extent={{76,6},{82,0}},
          textColor={28,108,200},
          textString="7"),
        Text(
          extent={{116,6},{122,0}},
          textColor={28,108,200},
          textString="8"),
        Text(
          extent={{152,6},{158,0}},
          textColor={28,108,200},
          textString="9"),
        Text(
          extent={{-38,18},{-32,12}},
          textColor={28,108,200},
          textString="10"),
        Text(
          extent={{-68,36},{-62,30}},
          textColor={28,108,200},
          textString="11"),
        Text(
          extent={{-98,36},{-92,30}},
          textColor={28,108,200},
          textString="12")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    In a seventh step, the heat exchangers are modeled differently.
  </p>

  <p>
    Further documentation is available in the 
    <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Examples.JouleBrayton\">JouleBrayton</a> package.
  </p>
</html>"));
end Step7HeatFlow;
