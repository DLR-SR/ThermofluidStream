within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Adiabatic;
model Step8Cooler1
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconNeglectInertance;

  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.He
                                                                              constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(
    neglectInertance=true,                            displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{-20,180},{0,200}})));
  Processes.Isobaric reactor(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed(displayUnit="K") = 1180) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-100,20})));
  Processes.Adiabatic turbine1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.94,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_out(start=7000000)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,150})));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={30,110})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints annotation (Placement(transformation(
        extent={{-20,-12},{20,12}},
        rotation=180,
        origin={40,130})));
  Modelica.Blocks.Sources.RealExpression turbine1OutletTemperature(y(unit="K") = 1110) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={38,130})));
  Processes.Adiabatic turbine2(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    etaSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=5240000,
    eta_is(start=1),
    h_out(start=Medium.h_default)) annotation (Placement(transformation(extent={{-10,10},{10,-10}}, rotation=270)));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor1(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={30,-40})));
  Modelica.Blocks.Sources.RealExpression turbine2OutletTemperature(y(unit="K") = 1060) annotation (Placement(transformation(extent={{28,-30},{48,-10}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints1 annotation (Placement(transformation(extent={{60,-32},{20,-8}})));
  Processes.Adiabatic turbine3(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_out(start=5240000)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,-90})));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor2(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={30,-134})));
  Modelica.Blocks.Sources.RealExpression turbine3OutletTemperature(y(unit="K") = 844.5) annotation (Placement(transformation(extent={{28,-122},{48,-102}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints2 annotation (Placement(transformation(extent={{58,-124},{18,-100}})));
  Processes.Isobaric heatExchangerHotSide(
    h_out(start=Medium.h_default),
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    T_out_fixed(displayUnit="K")) annotation (Placement(transformation(extent={{20,-180},{40,-160}})));
  Processes.Isobaric cooler2(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    specifyOutlet=true,
    T_out_fixed(displayUnit="K") = 285) annotation (Placement(transformation(extent={{60,-180},{80,-160}})));
  Processes.Isobaric heatExchangerColdSide(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    T_out_fixed(displayUnit="K") = 780) annotation (Placement(transformation(extent={{40,-190},{20,-210}})));
  Processes.Adiabatic compressor1(
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    redeclare package Medium = Medium,

    eta_fixed=0.96,
    p_out_fixed=7000000,
    h_out(start=Medium.h_default)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={160,150})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints3(y1(start=300))
                                                                        annotation (Placement(transformation(extent={{212,158},{252,182}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y(unit="K") = 376) annotation (Placement(transformation(extent={{242,160},{222,180}})));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor3(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={180,170})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints4(y1(start=60e5))
                                                                        annotation (Placement(transformation(extent={{88,60},{128,84}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y(unit="W") = 0)   annotation (Placement(transformation(extent={{118,62},{98,82}})));
  Processes.Adiabatic compressor2(
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    etaSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    eta_is(start=1)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={160,0})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y(unit="W") = 0)   annotation (Placement(transformation(extent={{120,-40},{100,-20}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints5 annotation (Placement(transformation(extent={{90,-42},{130,-18}})));
  Processes.Isobaric cooler1(
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    specifyOutlet=true,
    T_out_fixed(displayUnit="K"),
    h_out(start=Medium.h_default)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={160,70})));
  Sources.LoopBreaker loopBreaker1(
    redeclare package Medium = Medium,
    p_out_fixed=7000000,
    T_out_fixed(displayUnit="K") = 780)
                     annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-52,-200})));
  EnergyFlow.Sources.FixedEnergyFlow reactorHeatFlow(E_flow(displayUnit="MW") = 6000000) annotation (Placement(transformation(extent={{-140,10},{-120,30}})));
  EnergyFlow.Components.Sum turbine3HeatLosses(n_in=2) annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
  EnergyFlow.Components.FixedTransferEfficiency turbine3ShaftLosses(eta=0.95) annotation (Placement(transformation(extent={{60,-80},{40,-100}})));
  EnergyFlow.Sources.FixedEnergyFlow generator(E_flow(displayUnit="MW") = -3015000) annotation (Placement(transformation(extent={{100,-100},{80,-80}})));
  EnergyFlow.Components.FixedTransferEfficiency turbine1Losses(eta=0.95) annotation (Placement(transformation(extent={{40,160},{60,140}})));
  EnergyFlow.Components.Sum pseudoSink(n_in=2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,130})));
  EnergyFlow.Components.FixedTransferEfficiency turbine2Losses(eta=0.95) annotation (Placement(transformation(extent={{30,10},{50,-10}})));
  EnergyFlow.Components.Sum pseudoSink1(n_in=2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,-14})));
equation
  connect(reactor.outlet,turbine1. inlet) annotation (Line(
      points={{-100,30},{-100,170},{0,170},{0,160}},
      color={28,108,200},
      thickness=0.5));
  connect(temperatureSensor.inlet, turbine1.outlet) annotation (Line(
      points={{20,110},{0,110},{0,140}},
      color={28,108,200},
      thickness=0.5));
  connect(inverseBlockConstraints.y1, turbine1.outletSpec_prescribed) annotation (Line(points={{19,130},{16,130},{16,140},{12,140}},
                                                                                                                        color={0,0,127}));
  connect(turbine1.outlet,turbine2. inlet)
    annotation (Line(
      points={{0,140},{0,10}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine2.outlet, temperatureSensor1.inlet) annotation (Line(
      points={{0,-10},{0,-40},{20,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine2.eta_prescribed, inverseBlockConstraints1.y1) annotation (Line(points={{12,-6},{16,-6},{16,-20},{19,-20}}, color={0,0,127}));
  connect(turbine2OutletTemperature.y, inverseBlockConstraints1.u2) annotation (Line(points={{49,-20},{56,-20}}, color={0,0,127}));
  connect(temperatureSensor1.value_out, inverseBlockConstraints1.u1) annotation (Line(points={{38.2,-40},{70,-40},{70,-20},{62,-20}}, color={0,0,127}));
  connect(turbine1OutletTemperature.y, inverseBlockConstraints.u2) annotation (Line(points={{49,130},{56,130}},
                                                                                                              color={0,0,127}));
  connect(temperatureSensor.value_out, inverseBlockConstraints.u1) annotation (Line(points={{38.2,110},{70,110},{70,130},{62,130}},
                                                                                                                                color={0,0,127}));
  connect(turbine2.outlet,turbine3. inlet)
    annotation (Line(
      points={{0,-10},{0,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(temperatureSensor2.inlet, turbine3.outlet) annotation (Line(
      points={{20,-134},{0,-134},{0,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(inverseBlockConstraints2.y1, turbine3.outletSpec_prescribed) annotation (Line(points={{17,-112},{16,-112},{16,-100},{12,-100}}, color={0,0,127}));
  connect(inverseBlockConstraints2.u2, turbine3OutletTemperature.y) annotation (Line(points={{54,-112},{49,-112}}, color={0,0,127}));
  connect(temperatureSensor2.value_out, inverseBlockConstraints2.u1) annotation (Line(points={{38.2,-134},{72,-134},{72,-112},{60,-112}}, color={0,0,127}));
  connect(heatExchangerHotSide.outlet, cooler2.inlet) annotation (Line(
      points={{40,-170},{60,-170}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerHotSide.inlet, turbine3.outlet) annotation (Line(
      points={{20,-170},{0,-170},{0,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerColdSide.inlet, compressor1.outlet) annotation (Line(
      points={{40,-200},{200,-200},{200,190},{160,190},{160,160}},
      color={28,108,200},
      thickness=0.5));
  connect(inverseBlockConstraints3.u2, realExpression3.y) annotation (Line(points={{216,170},{221,170}}, color={0,0,127}));
  connect(compressor1.outlet, temperatureSensor3.inlet) annotation (Line(
      points={{160,160},{160,170},{170,170}},
      color={28,108,200},
      thickness=0.5));
  connect(temperatureSensor3.value_out, inverseBlockConstraints3.u1) annotation (Line(points={{188.2,170},{210,170}}, color={0,0,127}));
  connect(inverseBlockConstraints4.u2, realExpression1.y) annotation (Line(points={{92,72},{97,72}},   color={0,0,127}));
  connect(cooler2.outlet, compressor2.inlet) annotation (Line(
      points={{80,-170},{160,-170},{160,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor2.outletSpec_prescribed, inverseBlockConstraints4.y1) annotation (Line(points={{148,10},{132,10},{132,72},{129,72}}, color={0,0,127}));
  connect(inverseBlockConstraints5.u2, realExpression2.y) annotation (Line(points={{94,-30},{99,-30}}, color={0,0,127}));
  connect(inverseBlockConstraints5.y1, compressor2.eta_prescribed) annotation (Line(points={{131,-30},{132,-30},{132,6},{148,6}}, color={0,0,127}));
  connect(compressor2.outlet, cooler1.inlet) annotation (Line(
      points={{160,10},{160,60}},
      color={28,108,200},
      thickness=0.5));
  connect(cooler1.outlet, compressor1.inlet) annotation (Line(
      points={{160,80},{160,140}},
      color={28,108,200},
      thickness=0.5));
  connect(cooler1.outletSpec_prescribed, inverseBlockConstraints3.y1) annotation (Line(points={{172,80},{260,80},{260,170},{253,170}}, color={0,0,127}));
  connect(heatExchangerColdSide.outlet, loopBreaker1.inlet) annotation (Line(
      points={{20,-200},{-42,-200}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker1.outlet, reactor.inlet) annotation (Line(
      points={{-62,-200},{-100,-200},{-100,10}},
      color={28,108,200},
      thickness=0.5));
  connect(reactorHeatFlow.E_flow_out, reactor.Q_flow_in) annotation (Line(points={{-119,20},{-108,20}}, color={255,170,85}));
  connect(generator.E_flow_out, turbine3ShaftLosses.E_flow_in) annotation (Line(points={{79,-90},{62,-90}}, color={255,170,85}));
  connect(turbine3.P_out, turbine3HeatLosses.E_flow_in[1]) annotation (Line(points={{7,-90},{30,-90},{30,-71.5},{40,-71.5}},   color={255,170,85}));
  connect(turbine3ShaftLosses.E_flow_out, turbine3HeatLosses.E_flow_in[2]) annotation (Line(points={{39,-90},{28,-90},{28,-68},{34,-68},{34,-68.5},{40,-68.5}},
                                                                                                                                                color={255,170,85}));
  connect(heatExchangerColdSide.Q_flow_out, heatExchangerHotSide.Q_flow_in) annotation (Line(points={{30,-193},{30,-178}}, color={255,170,85}));
  connect(turbine1.P_out, turbine1Losses.E_flow_in) annotation (Line(points={{7,150},{38,150}}, color={255,170,85}));
  connect(pseudoSink.E_flow_out, inverseBlockConstraints4.u1) annotation (Line(points={{80,118.3},{80,72},{86,72}}, color={255,170,85}));
  connect(turbine1Losses.E_flow_out, pseudoSink.E_flow_in[1]) annotation (Line(points={{61,150},{78,150},{78,140},{81.5,140}},
                                                                                                                          color={255,170,85}));
  connect(compressor1.P_out, pseudoSink.E_flow_in[2]) annotation (Line(points={{153,150},{82,150},{82,140},{78.5,140}},
                                                                                                                   color={255,170,85}));
  connect(turbine2.P_out, turbine2Losses.E_flow_in) annotation (Line(points={{7,0},{28,0}}, color={255,170,85}));
  connect(turbine2Losses.E_flow_out, pseudoSink1.E_flow_in[1]) annotation (Line(points={{51,0},{78,0},{78,-4},{81.5,-4}},
                                                                                                                      color={255,170,85}));
  connect(compressor2.P_out, pseudoSink1.E_flow_in[2]) annotation (Line(points={{153,0},{82,0},{82,-4},{78.5,-4}},
                                                                                                               color={255,170,85}));
  connect(pseudoSink1.E_flow_out, inverseBlockConstraints5.u1) annotation (Line(points={{80,-25.7},{80,-26},{82,-26},{82,-30},{88,-30}},
                                                                                                                        color={255,170,85}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-240},{200,200}}), graphics={
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
          textString="6"),
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
</html>"));
end Step8Cooler1;
