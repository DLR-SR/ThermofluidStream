within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Polytropic;
model Step6Compressor1
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconNeglectInertance;

  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.He
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(
    neglectInertance=true,                            displayInstanceNames=true, displayParameters=true)annotation(
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
        origin={-80,80})));
  EnergyFlow.Sources.FixedEnergyFlow reactorHeatFlow(E_flow(displayUnit="MW") = 6000000) annotation(Placement(transformation(extent={{-180,-10},{-160,10}})));
  EnergyFlow.Components.FixedTransferEfficiency turbine1Losses(eta=0.95) annotation(Placement(transformation(extent={{-50,90},{-30,70}})));
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
        origin={-80,-50})));
  EnergyFlow.Components.Sum turbine3HeatLosses(n_in=2) annotation(Placement(transformation(extent={{-40,-40},{-20,-20}})));
  EnergyFlow.Components.FixedTransferEfficiency turbine3ShaftLosses(eta=0.95) annotation(Placement(transformation(extent={{-20,-40},{-40,-60}})));
  EnergyFlow.Sources.FixedEnergyFlow generator(E_flow(displayUnit="MW") = -3015000) annotation(Placement(transformation(extent={{20,-60},{0,-40}})));
  Processes.Isobaric heatExchangerHotSide(
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    redeclare package Medium = Medium,
    specifyOutlet=false,
    T_out_fixed(displayUnit="K")) annotation(Placement(transformation(extent={{-70,-100},{-50,-80}})));
  Processes.Isobaric cooler2(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    specifyOutlet=true,
    T_out_fixed(displayUnit="K") = 285) annotation(Placement(transformation(extent={{-30,-100},{-10,-80}})));
  Processes.Isobaric heatExchangerColdSide(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    T_out_fixed(displayUnit="K") = 780) annotation(Placement(transformation(extent={{-50,-110},{-70,-130}})));
  Sources.Sink_free sink(redeclare package Medium = Medium) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={20,-90})));
  Processes.Adiabatic compressor1(
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    redeclare package Medium = Medium,
    eta_fixed=0.96,
    p_out_fixed=7000000,
    outlet(state(p(start=7000000), T(start=649.15)))) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={40,80})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints2 annotation(Placement(transformation(extent={{80,88},{120,112}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y(unit="K") = 376) annotation(Placement(transformation(extent={{110,90},{90,110}})));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={60,100})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true,
    T0_par(displayUnit="K"),
    T0_var(start=300),
    p0_var(start=50e5),
    outlet(state(p(start=5000000), T(start=300)))) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={40,50})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints1 annotation(Placement(transformation(extent={{-10,16},{30,40}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y(unit="W") = 0) annotation(Placement(transformation(extent={{22,18},{2,38}})));
  EnergyFlow.Components.Sum pseudoSink(n_in=2) annotation(Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-20,50})));
equation
  connect(reactor.outlet,turbine1. inlet) annotation(Line(
      points={{-140,10},{-140,100},{-80,100},{-80,90}},
      color={28,108,200},
      thickness=0.5));
  connect(reactorHeatFlow.E_flow_out, reactor.Q_flow_in) annotation(Line(points={{-159,0},{-148,0}},   color={255,170,85}));
  connect(turbine1.P_out, turbine1Losses.E_flow_in) annotation(Line(points={{-73,80},{-52,80}},
                                                                                              color={255,170,85}));
  connect(turbine1.outlet, turbine2.inlet) annotation(Line(
      points={{-80,70},{-80,10}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine2.P_out, turbine2Losses.E_flow_in) annotation(Line(points={{-73,0},{-52,0}}, color={255,170,85}));
  connect(turbine2.outlet, turbine3.inlet) annotation(Line(
      points={{-80,-10},{-80,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine3ShaftLosses.E_flow_out, turbine3HeatLosses.E_flow_in[1]) annotation(Line(points={{-41,-50},{-48,-50},{-48,-32},{-40,-32},{-40,-31.5}}, color={255,170,85}));
  connect(turbine3.P_out, turbine3HeatLosses.E_flow_in[2]) annotation(Line(points={{-73,-50},{-52,-50},{-52,-28.5},{-40,-28.5}}, color={255,170,85}));
  connect(generator.E_flow_out, turbine3ShaftLosses.E_flow_in) annotation(Line(points={{-1,-50},{-18,-50}}, color={255,170,85}));
  connect(cooler2.outlet, sink.inlet) annotation(Line(
      points={{-10,-90},{10,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerHotSide.outlet,cooler2. inlet) annotation(Line(
      points={{-50,-90},{-30,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerHotSide.inlet, turbine3.outlet) annotation(Line(
      points={{-70,-90},{-80,-90},{-80,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerColdSide.outlet, reactor.inlet) annotation(Line(
      points={{-70,-120},{-140,-120},{-140,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerColdSide.Q_flow_out,heatExchangerHotSide. Q_flow_in) annotation(Line(points={{-60,-113},{-60,-98}},color={255,170,85}));
  connect(heatExchangerColdSide.inlet,compressor1. outlet) annotation(Line(
      points={{-50,-120},{156,-120},{156,120},{40,120},{40,90}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, compressor1.inlet) annotation(Line(
      points={{40,60},{40,70}},
      color={28,108,200},
      thickness=0.5));
  connect(inverseBlockConstraints2.u2,realExpression1. y) annotation(Line(points={{84,100},{89,100}},   color={0,0,127}));
  connect(compressor1.outlet, temperatureSensor.inlet) annotation(Line(
      points={{40,90},{40,100},{50,100}},
      color={28,108,200},
      thickness=0.5));
  connect(temperatureSensor.value_out, inverseBlockConstraints2.u1) annotation(Line(points={{68.2,100},{78,100}}, color={0,0,127}));
  connect(inverseBlockConstraints1.u2, realExpression.y) annotation(Line(points={{-6,28},{1,28}}, color={0,0,127}));
  connect(source.p0_var, inverseBlockConstraints1.y1) annotation(Line(points={{46,48},{46,28},{31,28}}, color={0,0,127}));
  connect(inverseBlockConstraints2.y1, source.T0_var) annotation(Line(points={{121,100},{130,100},{130,36},{40,36},{40,48}}, color={0,0,127}));
  connect(pseudoSink.E_flow_out,inverseBlockConstraints1. u1) annotation(Line(points={{-20,38.3},{-20,28},{-12,28}},color={255,170,85}));
  connect(turbine1Losses.E_flow_out, pseudoSink.E_flow_in[1]) annotation(Line(points={{-29,80},{-18.5,80},{-18.5,60}}, color={255,170,85}));
  connect(compressor1.P_out, pseudoSink.E_flow_in[2]) annotation(Line(points={{33,80},{-21.5,80},{-21.5,60}}, color={255,170,85}));
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
end Step6Compressor1;
