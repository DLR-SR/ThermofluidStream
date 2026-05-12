within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Adiabatic;
model Step6Compressor1
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconNeglectInertance;

  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.He
                                                                              constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation(choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(
    neglectInertance=true,                            displayInstanceNames=true, displayParameters=true)
    annotation(Placement(transformation(extent={{-20,180},{0,200}})));
  Processes.Isobaric reactor(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed(displayUnit="K") = 1180) annotation(Placement(transformation(
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
    p_out(start=7000000)) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,80})));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={30,40})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints annotation(Placement(transformation(
        extent={{-20,-12},{20,12}},
        rotation=180,
        origin={40,60})));
  Modelica.Blocks.Sources.RealExpression turbine1OutletTemperature(y(unit="K") = 1110) annotation(Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={38,60})));
  Processes.Adiabatic turbine2(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    etaSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=5240000,
    eta_is(start=1),
    h_out(start=Medium.h_default)) annotation(Placement(transformation(extent={{-10,10},{10,-10}}, rotation=270)));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor1(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={30,-40})));
  Modelica.Blocks.Sources.RealExpression turbine2OutletTemperature(y(unit="K") = 1060) annotation(Placement(transformation(extent={{28,-30},{48,-10}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints1 annotation(Placement(transformation(extent={{60,-32},{20,-8}})));
  Processes.Adiabatic turbine3(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_out(start=5240000)) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,-90})));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor2(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={30,-134})));
  Modelica.Blocks.Sources.RealExpression turbine3OutletTemperature(y(unit="K") = 844.5) annotation(Placement(transformation(extent={{28,-122},{48,-102}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints2 annotation(Placement(transformation(extent={{58,-124},{18,-100}})));
  Processes.Isobaric heatExchangerHotSide(
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    h_out(start=Medium.h_default),
    redeclare package Medium = Medium,
    specifyOutlet=false,
    T_out_fixed(displayUnit="K")) annotation(Placement(transformation(extent={{20,-180},{40,-160}})));
  Processes.Isobaric cooler2(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    specifyOutlet=true,
    T_out_fixed(displayUnit="K") = 285) annotation(Placement(transformation(extent={{60,-180},{80,-160}})));
  Processes.Isobaric heatExchangerColdSide(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    T_out_fixed(displayUnit="K") = 780) annotation(Placement(transformation(extent={{40,-190},{20,-210}})));
  Sources.Sink_free sink(redeclare package Medium = Medium) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-170})));
  Processes.Adiabatic compressor1(
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    redeclare package Medium = Medium,

    eta_fixed=0.96,
    p_out_fixed=7000000,
    h_out(start=Medium.h_default)) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={160,80})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints3(y1(start=300))
                                                                        annotation(Placement(transformation(extent={{212,88},{252,112}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y(unit="K") = 376) annotation(Placement(transformation(extent={{242,90},{222,110}})));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor3(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={180,100})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true,
    T0_par(displayUnit="K"),
    T0_var(start=300),
    p0_var(start=50e5))      annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={160,50})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints4 annotation(Placement(transformation(extent={{108,16},{148,40}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y(unit="W") = 0)   annotation(Placement(transformation(extent={{138,18},{118,38}})));
  EnergyFlow.Sources.FixedEnergyFlow reactorHeatFlow(E_flow(displayUnit="MW") = 6000000) annotation(Placement(transformation(extent={{-140,10},{-120,30}})));
  EnergyFlow.Components.Sum turbine3HeatLosses(n_in=2) annotation(Placement(transformation(extent={{40,-80},{60,-60}})));
  EnergyFlow.Components.FixedTransferEfficiency turbine3ShaftLosses(eta=0.95) annotation(Placement(transformation(extent={{60,-80},{40,-100}})));
  EnergyFlow.Sources.FixedEnergyFlow generator(E_flow(displayUnit="MW") = -3015000) annotation(Placement(transformation(extent={{100,-100},{80,-80}})));
  EnergyFlow.Components.FixedTransferEfficiency turbine2Losses(eta=0.95) annotation(Placement(transformation(extent={{40,10},{60,-10}})));
  EnergyFlow.Components.Sum pseudoSink(n_in=2) annotation(Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={90,50})));
  EnergyFlow.Components.FixedTransferEfficiency turbine1Losses(eta=0.95) annotation(Placement(transformation(extent={{42,90},{62,70}})));
equation
  connect(reactor.outlet,turbine1. inlet) annotation(Line(
      points={{-100,30},{-100,100},{0,100},{0,90}},
      color={28,108,200},
      thickness=0.5));
  connect(temperatureSensor.inlet, turbine1.outlet) annotation(Line(
      points={{20,40},{0,40},{0,70}},
      color={28,108,200},
      thickness=0.5));
  connect(inverseBlockConstraints.y1, turbine1.outletSpec_prescribed) annotation(Line(points={{19,60},{16,60},{16,70},{12,70}}, color={0,0,127}));
  connect(turbine1.outlet,turbine2. inlet)
    annotation(Line(
      points={{0,70},{0,10}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine2.outlet, temperatureSensor1.inlet) annotation(Line(
      points={{0,-10},{0,-40},{20,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine2.eta_prescribed, inverseBlockConstraints1.y1) annotation(Line(points={{12,-6},{16,-6},{16,-20},{19,-20}}, color={0,0,127}));
  connect(turbine2OutletTemperature.y, inverseBlockConstraints1.u2) annotation(Line(points={{49,-20},{56,-20}}, color={0,0,127}));
  connect(temperatureSensor1.value_out, inverseBlockConstraints1.u1) annotation(Line(points={{38.2,-40},{70,-40},{70,-20},{62,-20}}, color={0,0,127}));
  connect(turbine1OutletTemperature.y, inverseBlockConstraints.u2) annotation(Line(points={{49,60},{56,60}}, color={0,0,127}));
  connect(temperatureSensor.value_out, inverseBlockConstraints.u1) annotation(Line(points={{38.2,40},{70,40},{70,60},{62,60}}, color={0,0,127}));
  connect(turbine2.outlet,turbine3. inlet)
    annotation(Line(
      points={{0,-10},{0,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(temperatureSensor2.inlet, turbine3.outlet) annotation(Line(
      points={{20,-134},{0,-134},{0,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(inverseBlockConstraints2.y1, turbine3.outletSpec_prescribed) annotation(Line(points={{17,-112},{16,-112},{16,-100},{12,-100}}, color={0,0,127}));
  connect(inverseBlockConstraints2.u2, turbine3OutletTemperature.y) annotation(Line(points={{54,-112},{49,-112}}, color={0,0,127}));
  connect(temperatureSensor2.value_out, inverseBlockConstraints2.u1) annotation(Line(points={{38.2,-134},{72,-134},{72,-112},{60,-112}}, color={0,0,127}));
  connect(cooler2.outlet, sink.inlet) annotation(Line(
      points={{80,-170},{100,-170}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerHotSide.outlet, cooler2.inlet) annotation(Line(
      points={{40,-170},{60,-170}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerHotSide.inlet, turbine3.outlet) annotation(Line(
      points={{20,-170},{0,-170},{0,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerColdSide.outlet, reactor.inlet) annotation(Line(
      points={{20,-200},{-100,-200},{-100,10}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerColdSide.inlet, compressor1.outlet) annotation(Line(
      points={{40,-200},{200,-200},{200,120},{160,120},{160,90}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, compressor1.inlet) annotation(Line(
      points={{160,60},{160,70}},
      color={28,108,200},
      thickness=0.5));
  connect(inverseBlockConstraints3.u2, realExpression3.y) annotation(Line(points={{216,100},{221,100}}, color={0,0,127}));
  connect(compressor1.outlet, temperatureSensor3.inlet) annotation(Line(
      points={{160,90},{160,100},{170,100}},
      color={28,108,200},
      thickness=0.5));
  connect(temperatureSensor3.value_out, inverseBlockConstraints3.u1) annotation(Line(points={{188.2,100},{210,100}}, color={0,0,127}));
  connect(inverseBlockConstraints4.u2, realExpression1.y) annotation(Line(points={{112,28},{117,28}}, color={0,0,127}));
  connect(source.p0_var, inverseBlockConstraints4.y1) annotation(Line(points={{166,48},{166,28},{149,28}}, color={0,0,127}));
  connect(inverseBlockConstraints3.y1, source.T0_var) annotation(Line(points={{253,100},{258,100},{258,36},{160,36},{160,48}}, color={0,0,127}));
  connect(reactorHeatFlow.E_flow_out, reactor.Q_flow_in) annotation(Line(points={{-119,20},{-108,20}}, color={255,170,85}));
  connect(generator.E_flow_out, turbine3ShaftLosses.E_flow_in) annotation(Line(points={{79,-90},{62,-90}}, color={255,170,85}));
  connect(turbine3ShaftLosses.E_flow_out, turbine3HeatLosses.E_flow_in[1]) annotation(Line(points={{39,-90},{30,-90},{30,-71.5},{40,-71.5}},   color={255,170,85}));
  connect(turbine3.P_out, turbine3HeatLosses.E_flow_in[2]) annotation(Line(points={{7,-90},{28,-90},{28,-68.5},{40,-68.5}},   color={255,170,85}));
  connect(turbine2.P_out, turbine2Losses.E_flow_in) annotation(Line(points={{7,0},{38,0}}, color={255,170,85}));
  connect(turbine1.P_out, turbine1Losses.E_flow_in) annotation(Line(points={{7,80},{40,80}}, color={255,170,85}));
  connect(turbine1Losses.E_flow_out, pseudoSink.E_flow_in[1]) annotation(Line(points={{63,80},{88,80},{88,60},{91.5,60}},
                                                                                                                       color={255,170,85}));
  connect(compressor1.P_out, pseudoSink.E_flow_in[2]) annotation(Line(points={{153,80},{92,80},{92,60},{88.5,60}},
                                                                                                                color={255,170,85}));
  connect(pseudoSink.E_flow_out, inverseBlockConstraints4.u1) annotation(Line(points={{90,38.3},{90,28},{106,28}},  color={255,170,85}));
  connect(heatExchangerColdSide.Q_flow_out, heatExchangerHotSide.Q_flow_in) annotation(Line(points={{30,-193},{30,-178}}, color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
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
          extent={{-6,70},{0,64}},
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
        Text(
          extent={{84,-164},{90,-170}},
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
</html>"));
end Step6Compressor1;
