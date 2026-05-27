within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.AdiabaticPseudoInversion;
model Step5HeatExchanger
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.He
                                                                              constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{-20,180},{0,200}})));
  ThermofluidStream.Idealized.Processes.Isobaric reactor(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
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
        origin={90,58})));
  ThermofluidStream.Idealized.Processes.Adiabatic turbine2(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    etaSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=5240000) annotation (Placement(transformation(extent={{-10,10},{10,-10}}, rotation=270)));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor1(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={30,-50})));
  Modelica.Blocks.Sources.RealExpression turbine2OutletTemperature(y(unit="K") = 1060) annotation(Placement(transformation(extent={{100,-32},{80,-12}})));
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
        origin={30,-136})));
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
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=7000000,
    T0_par(displayUnit="K") = 376) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={70,-200})));
  ThermofluidStream.Idealized.EnergyFlow.Sources.FixedEnergyFlow reactorHeatFlow(E_flow(displayUnit="MW") = 6000000) annotation (Placement(transformation(extent={{-140,10},{-120,30}})));
  ThermofluidStream.Idealized.EnergyFlow.Components.FixedTransferEfficiency turbine1Losses(eta=0.95) annotation (Placement(transformation(extent={{40,90},{60,70}})));
  ThermofluidStream.Idealized.EnergyFlow.Components.Sum turbine3HeatLosses(n_in=2) annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
  ThermofluidStream.Idealized.EnergyFlow.Components.FixedTransferEfficiency turbine3ShaftLosses(eta=0.95) annotation (Placement(transformation(extent={{60,-80},{40,-100}})));
  ThermofluidStream.Idealized.EnergyFlow.Sources.FixedEnergyFlow generator(E_flow(displayUnit="MW") = -3015000) annotation (Placement(transformation(extent={{100,-100},{80,-80}})));
  ThermofluidStream.Idealized.EnergyFlow.Components.FixedTransferEfficiency turbine2Losses(eta=0.95) annotation (Placement(transformation(extent={{42,10},{62,-10}})));
  Modelica.Blocks.Continuous.Integrator integrator(
    k=1e6,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=70e5)
              annotation(Placement(transformation(extent={{40,48},{20,68}})));
  Modelica.Blocks.Math.Feedback feedback annotation(Placement(transformation(extent={{70,48},{50,68}})));
  Modelica.Blocks.Continuous.Integrator integrator1(
    k=-0.5,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1) annotation(Placement(transformation(extent={{40,-32},{20,-12}})));
  Modelica.Blocks.Math.Feedback feedback1
                                        annotation(Placement(transformation(extent={{70,-32},{50,-12}})));
  Modelica.Blocks.Continuous.Integrator integrator2(
    k=5e5,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0) annotation(Placement(transformation(extent={{40,-122},{20,-102}})));
  Modelica.Blocks.Math.Feedback feedback2
                                        annotation(Placement(transformation(extent={{70,-122},{50,-102}})));
equation
  connect(reactor.outlet,turbine1. inlet) annotation(Line(
      points={{-100,30},{-100,100},{0,100},{0,90}},
      color={28,108,200},
      thickness=0.5));
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
      points={{0,-10},{0,-50},{20,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine2.outlet,turbine3. inlet) annotation(
    Line(
      points={{0,-10},{0,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(temperatureSensor2.inlet, turbine3.outlet) annotation(Line(
      points={{20,-136},{0,-136},{0,-100}},
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
  connect(heatExchangerColdSide.inlet, source.outlet) annotation(Line(
      points={{40,-200},{60,-200}},
      color={28,108,200},
      thickness=0.5));
  connect(reactorHeatFlow.E_flow_out, reactor.Q_flow_in) annotation(Line(points={{-119,20},{-108,20}}, color={255,170,85}));
  connect(turbine1.P_out, turbine1Losses.E_flow_in) annotation(Line(points={{7,80},{38,80}}, color={255,170,85}));
  connect(generator.E_flow_out, turbine3ShaftLosses.E_flow_in) annotation(Line(points={{79,-90},{62,-90}}, color={255,170,85}));
  connect(turbine3ShaftLosses.E_flow_out, turbine3HeatLosses.E_flow_in[1]) annotation(Line(points={{39,-90},{30,-90},{30,-71.5},{40,-71.5}},   color={255,170,85}));
  connect(turbine3.P_out, turbine3HeatLosses.E_flow_in[2]) annotation(Line(points={{7,-90},{26,-90},{26,-68.5},{40,-68.5}},   color={255,170,85}));
  connect(turbine2.P_out, turbine2Losses.E_flow_in) annotation(Line(points={{7,0},{40,0}}, color={255,170,85}));
  connect(heatExchangerColdSide.Q_flow_out, heatExchangerHotSide.Q_flow_in) annotation(Line(points={{30,-193},{30,-178}}, color={255,170,85}));
  connect(integrator.y, turbine1.outletSpec_prescribed) annotation(Line(points={{19,58},{16,58},{16,70},{12,70}}, color={0,0,127}));
  connect(integrator.u, feedback.y) annotation(Line(points={{42,58},{51,58}}, color={0,0,127}));
  connect(feedback.u1, turbine1OutletTemperature.y) annotation(Line(points={{68,58},{79,58}}, color={0,0,127}));
  connect(feedback.u2, temperatureSensor.value_out) annotation(Line(points={{60,50},{60,30},{38.2,30}}, color={0,0,127}));
  connect(turbine2.eta_prescribed, integrator1.y) annotation(Line(points={{12,-6},{16,-6},{16,-22},{19,-22}}, color={0,0,127}));
  connect(integrator1.u, feedback1.y) annotation(Line(points={{42,-22},{51,-22}}, color={0,0,127}));
  connect(feedback1.u1, turbine2OutletTemperature.y) annotation(Line(points={{68,-22},{79,-22}}, color={0,0,127}));
  connect(feedback1.u2, temperatureSensor1.value_out) annotation(Line(points={{60,-30},{60,-50},{38.2,-50}}, color={0,0,127}));
  connect(turbine3.outletSpec_prescribed, integrator2.y) annotation(Line(points={{12,-100},{16,-100},{16,-112},{19,-112}}, color={0,0,127}));
  connect(integrator2.u, feedback2.y) annotation(Line(points={{42,-112},{51,-112}}, color={0,0,127}));
  connect(turbine3OutletTemperature.y, feedback2.u1) annotation(Line(points={{79,-112},{68,-112}}, color={0,0,127}));
  connect(feedback2.u2, temperatureSensor2.value_out) annotation(Line(points={{60,-120},{60,-136},{38.2,-136}}, color={0,0,127}));
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
    See <a href=\"modelica://ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor\">TUMExercisesThermodynamicCycles.Exercise2NuclearReactor</a> 
    for the problem description.
  </p>
</html>"));
end Step5HeatExchanger;
