within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.AdiabaticPseudoInversion;
model Step6bMassFlowRate
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.He
                                                                              constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{-20,180},{0,200}})));
  ThermofluidStream.Idealized.Processes.Isobaric reactor(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed(displayUnit="K") = 1180) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-100,20})));
  ThermofluidStream.Idealized.Processes.Adiabatic turbine1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.94,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(
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
        origin={30,30})));
  Modelica.Blocks.Sources.RealExpression turbine1OutletTemperature(y(unit="K") = 1110) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={80,60})));
  ThermofluidStream.Idealized.Processes.Adiabatic turbine2(
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
    outputValue=true) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={30,-48})));
  Modelica.Blocks.Sources.RealExpression turbine2OutletTemperature(y(unit="K") = 1060) annotation(Placement(transformation(extent={{100,-30},{80,-10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic turbine3(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(
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
  Modelica.Blocks.Sources.RealExpression turbine3OutletTemperature(y(unit="K") = 844.5) annotation(Placement(transformation(extent={{100,-122},{80,-102}})));
  ThermofluidStream.Idealized.Processes.Isobaric heatExchangerHotSide(
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    h_out(start=Medium.h_default),
    redeclare package Medium = Medium,
    specifyOutlet=false,
    T_out_fixed(displayUnit="K")) annotation (Placement(transformation(extent={{20,-180},{40,-160}})));
  ThermofluidStream.Idealized.Processes.Isobaric cooler2(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    specifyOutlet=true,
    T_out_fixed(displayUnit="K") = 285) annotation (Placement(transformation(extent={{60,-180},{80,-160}})));
  ThermofluidStream.Idealized.Processes.Isobaric heatExchangerColdSide(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    T_out_fixed(displayUnit="K") = 780) annotation (Placement(transformation(extent={{40,-190},{20,-210}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink(redeclare package Medium = Medium) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-170})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressor1(
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    redeclare package Medium = Medium,

    eta_fixed=0.96,
    p_out_fixed=7000000) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={160,80})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y(unit="K") = 376) annotation(Placement(transformation(extent={{296,30},{276,50}})));
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
    p0_var(start=50e5))     annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={160,50})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y(unit="W") = 0)  annotation(Placement(transformation(extent={{72,10},{92,30}})));
  ThermofluidStream.Idealized.EnergyFlow.Components.Sum turbine3HeatLosses(n_in=2) annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
  ThermofluidStream.Idealized.EnergyFlow.Components.FixedTransferEfficiency turbine3ShaftLosses(eta=0.95) annotation (Placement(transformation(extent={{60,-80},{40,-100}})));
  ThermofluidStream.Idealized.EnergyFlow.Sources.FixedEnergyFlow generator(E_flow(displayUnit="MW") = -3015000) annotation (Placement(transformation(extent={{100,-100},{80,-80}})));
  ThermofluidStream.Idealized.EnergyFlow.Components.FixedTransferEfficiency turbine2Losses(eta=0.95) annotation (Placement(transformation(extent={{40,10},{60,-10}})));
  ThermofluidStream.Idealized.EnergyFlow.Components.Sum pseudoSink(n_in=2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={110,50})));
  ThermofluidStream.Idealized.EnergyFlow.Components.FixedTransferEfficiency turbine1Losses(eta=0.95) annotation (Placement(transformation(extent={{42,90},{62,70}})));
  Modelica.Blocks.Continuous.Integrator integrator(
    k=1e6,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=70e5)
              annotation(Placement(transformation(extent={{40,50},{20,70}})));
  Modelica.Blocks.Math.Feedback feedback annotation(Placement(transformation(extent={{66,50},{46,70}})));
  Modelica.Blocks.Continuous.Integrator integrator1(
    k=-0.5,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1) annotation(Placement(transformation(extent={{40,-30},{20,-10}})));
  Modelica.Blocks.Math.Feedback feedback1
                                        annotation(Placement(transformation(extent={{70,-30},{50,-10}})));
  Modelica.Blocks.Continuous.Integrator integrator2(
    k=5e5,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0) annotation(Placement(transformation(extent={{40,-122},{20,-102}})));
  Modelica.Blocks.Math.Feedback feedback2
                                        annotation(Placement(transformation(extent={{70,-122},{50,-102}})));
  Modelica.Blocks.Continuous.Integrator integrator3(
    k=1e4,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=70e5)
              annotation(Placement(transformation(extent={{126,10},{146,30}})));
  Modelica.Blocks.Math.Feedback feedback3
                                        annotation(Placement(transformation(extent={{100,30},{120,10}})));
  Modelica.Blocks.Continuous.Integrator integrator4(
    k=100,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=400)
              annotation(Placement(transformation(extent={{240,30},{220,50}})));
  Modelica.Blocks.Math.Feedback feedback4
                                        annotation(Placement(transformation(extent={{270,50},{250,30}})));
  ThermofluidStream.Idealized.Boundaries.MassFlowRate massFlowRate(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-100,60})));
  Modelica.Blocks.Sources.RealExpression realExpression(y(
      unit="W",
      displayUnit="MW") = -6000000)                                   annotation(Placement(transformation(extent={{-200,50},{-180,70}})));
  Modelica.Blocks.Math.Feedback feedback5
                                        annotation(Placement(transformation(extent={{-176,50},{-156,70}})));
  Modelica.Blocks.Continuous.Integrator integrator5(
    k=-1e-5,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1) annotation(Placement(transformation(extent={{-150,50},{-130,70}})));
equation
  connect(temperatureSensor.inlet, turbine1.outlet) annotation(Line(
      points={{20,30},{0,30},{0,70}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine1.outlet,turbine2. inlet) annotation(
    Line(
      points={{0,70},{0,10}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine2.outlet, temperatureSensor1.inlet) annotation(Line(
      points={{0,-10},{0,-48},{20,-48}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine2.outlet,turbine3. inlet) annotation(
    Line(
      points={{0,-10},{0,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(temperatureSensor2.inlet, turbine3.outlet) annotation(Line(
      points={{20,-134},{0,-134},{0,-100}},
      color={28,108,200},
      thickness=0.5));
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
  connect(compressor1.outlet, temperatureSensor3.inlet) annotation(Line(
      points={{160,90},{160,100},{170,100}},
      color={28,108,200},
      thickness=0.5));
  connect(generator.E_flow_out, turbine3ShaftLosses.E_flow_in) annotation(Line(points={{79,-90},{62,-90}}, color={255,170,85}));
  connect(turbine3ShaftLosses.E_flow_out, turbine3HeatLosses.E_flow_in[1]) annotation(Line(points={{39,-90},{30,-90},{30,-71.5},{40,-71.5}},   color={255,170,85}));
  connect(turbine3.P_out, turbine3HeatLosses.E_flow_in[2]) annotation(Line(points={{7,-90},{26,-90},{26,-68.5},{40,-68.5}},   color={255,170,85}));
  connect(turbine2.P_out, turbine2Losses.E_flow_in) annotation(Line(points={{7,0},{38,0}}, color={255,170,85}));
  connect(turbine1.P_out, turbine1Losses.E_flow_in) annotation(Line(points={{7,80},{40,80}}, color={255,170,85}));
  connect(turbine1Losses.E_flow_out, pseudoSink.E_flow_in[1]) annotation(Line(points={{63,80},{108,80},{108,60},{111.5,60}},
                                                                                                                       color={255,170,85}));
  connect(compressor1.P_out, pseudoSink.E_flow_in[2]) annotation(Line(points={{153,80},{112,80},{112,60},{108.5,60}},
                                                                                                                color={255,170,85}));
  connect(heatExchangerColdSide.Q_flow_out, heatExchangerHotSide.Q_flow_in) annotation(Line(points={{30,-193},{30,-178}}, color={255,170,85}));
  connect(integrator.y, turbine1.outletSpec_prescribed) annotation(Line(points={{19,60},{16,60},{16,70},{12,70}}, color={0,0,127}));
  connect(feedback.y, integrator.u) annotation(Line(points={{47,60},{42,60}}, color={0,0,127}));
  connect(turbine1OutletTemperature.y, feedback.u1) annotation(Line(points={{69,60},{64,60}}, color={0,0,127}));
  connect(temperatureSensor.value_out, feedback.u2) annotation(Line(points={{38.2,30},{56,30},{56,52}}, color={0,0,127}));
  connect(integrator1.y, turbine2.eta_prescribed) annotation(Line(points={{19,-20},{16,-20},{16,-6},{12,-6}}, color={0,0,127}));
  connect(feedback1.y, integrator1.u) annotation(Line(points={{51,-20},{42,-20}}, color={0,0,127}));
  connect(feedback1.u2, temperatureSensor1.value_out) annotation(Line(points={{60,-28},{60,-48},{38.2,-48}}, color={0,0,127}));
  connect(turbine2OutletTemperature.y, feedback1.u1) annotation(Line(points={{79,-20},{68,-20}}, color={0,0,127}));
  connect(turbine3.outletSpec_prescribed, integrator2.y) annotation(Line(points={{12,-100},{16,-100},{16,-112},{19,-112}}, color={0,0,127}));
  connect(integrator2.u, feedback2.y) annotation(Line(points={{42,-112},{51,-112}}, color={0,0,127}));
  connect(feedback2.u2, temperatureSensor2.value_out) annotation(Line(points={{60,-120},{60,-134},{38.2,-134}}, color={0,0,127}));
  connect(feedback2.u1, turbine3OutletTemperature.y) annotation(Line(points={{68,-112},{79,-112}}, color={0,0,127}));
  connect(pseudoSink.E_flow_out, feedback3.u2) annotation(Line(points={{110,38.3},{110,28}}, color={255,170,85}));
  connect(realExpression1.y, feedback3.u1) annotation(Line(points={{93,20},{102,20}}, color={0,0,127}));
  connect(feedback3.y, integrator3.u) annotation(Line(points={{119,20},{124,20}}, color={0,0,127}));
  connect(integrator3.y, source.p0_var) annotation(Line(points={{147,20},{166,20},{166,48}}, color={0,0,127}));
  connect(feedback4.u1, realExpression3.y) annotation(Line(points={{268,40},{275,40}}, color={0,0,127}));
  connect(integrator4.u, feedback4.y) annotation(Line(points={{242,40},{251,40}}, color={0,0,127}));
  connect(integrator4.y, source.T0_var) annotation(Line(points={{219,40},{160,40},{160,48}}, color={0,0,127}));
  connect(temperatureSensor3.value_out, feedback4.u2) annotation(Line(points={{188.2,100},{260,100},{260,48}}, color={0,0,127}));
  connect(reactor.outlet, massFlowRate.inlet) annotation(Line(
      points={{-100,30},{-100,50}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate.outlet, turbine1.inlet) annotation(Line(
      points={{-100,70},{-100,100},{0,100},{0,90}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression.y, feedback5.u1) annotation(Line(points={{-179,60},{-174,60}}, color={0,0,127}));
  connect(feedback5.y, integrator5.u) annotation(Line(points={{-157,60},{-152,60}}, color={0,0,127}));
  connect(integrator5.y, massFlowRate.m_flow_prescribed) annotation(Line(points={{-129,60},{-108,60}}, color={0,0,127}));
  connect(reactor.Q_flow_out, feedback5.u2) annotation(Line(points={{-107,20},{-166,20},{-166,52}}, color={255,170,85}));
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
    By introducing a <code>pseudoInversion</code> \"controller\" for the mass flow rate,
    <code>considerInertance</code> becomes possible again.
  </p>

  <p>
    See <a href=\"modelica://ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor\">TUMExercisesThermodynamicCycles.Exercise2NuclearReactor</a> 
    for the problem description.
  </p>
</html>"));
end Step6bMassFlowRate;
