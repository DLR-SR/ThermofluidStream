within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise7MixingPreheater;
model PseudoInversion
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{140,80},{160,100}})));

  ThermofluidStream.Idealized.Processes.Adiabatic highPressurePump(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,

    p_out_fixed=2000000) annotation (Placement(transformation(extent={{-90,-30},{-110,-10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic lowPressureTurbineStage(
    redeclare package Medium = Medium,
    eta_fixed=0.889,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,
    p_out_fixed=5000) annotation (Placement(transformation(extent={{90,40},{110,60}})));
  ThermofluidStream.Idealized.Processes.Isobaric heater(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,
    specifyOutlet=true,

    T_out_fixed=813.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-120,20})));
  ThermofluidStream.Idealized.Processes.Isobaric condensor(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{90,-30},{70,-10}})));
  ThermofluidStream.Utilities.showRealValue MassFlowRate(
    description="m_flow_36",
    use_numberPort=false,
    number=heater.m_flow,
    displayVariable=false,
    significantDigits=3) annotation (Placement(transformation(extent={{-50,-120},{-30,-100}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect vaporQualitySensor(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{130,40},{150,60}})));
  Modelica.Blocks.Sources.RealExpression h_bubble(y=Medium.bubbleEnthalpy(Medium.setSat_p(0.05e5)))
    annotation (Placement(transformation(extent={{100,-50},{80,-30}})));
  ThermofluidStream.Idealized.Processes.Adiabatic lowPressurePump(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,

    p_out_fixed=1000000) annotation (Placement(transformation(extent={{50,-30},{30,-10}})));
  Topology.JunctionT2 mixingPreheater(
    displayInstanceName=true,
    redeclare package Medium = Medium)
                           annotation (Placement(transformation(extent={{10,-30},{-10,-10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic highPressureTurbineStage(
    redeclare package Medium = Medium,
    eta_fixed=0.889,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,
    p_out_fixed=1000000) annotation (Placement(transformation(extent={{10,40},{30,60}})));
  ThermofluidStream.Topology.SplitterT2  splitter(displayInstanceName=false, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{50,60},{70,40}})));
  Sources.MassFlowRate massFlowRateSource(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{30,10},{10,30}})));
  Sources.LoopBreaker loopBreaker(
    redeclare package Medium = Medium,
    p_out_fixed(displayUnit="bar") = 1000000,
    T_out_fixed=403.15)
                     annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-70,-20})));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true,
    filter_output=true,
    init=ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor.state,
    value_0=273.15 + 130)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-40})));
  Modelica.Blocks.Sources.RealExpression mixingTemperature(y(
      unit="K",
      displayUnit="degC") = 403.15)
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  ThermofluidStream.Utilities.showRealValue MassFlowRate1(
    description="efficency",
    use_numberPort=false,
    number=(-lowPressureTurbineStage.P - highPressureTurbineStage.P - lowPressurePump.P - highPressurePump.P)/heater.Q_flow,
    displayVariable=false,
    significantDigits=3) annotation (Placement(transformation(extent={{30,-120},{50,-100}})));
  ThermofluidStream.Utilities.showRealValue MassFlowRate2(
    description="m_flow_7/m_flow_36",
    use_numberPort=false,
    number=massFlowRateSource.m_flow/heater.m_flow,
    displayVariable=false,
    significantDigits=3) annotation (Placement(transformation(extent={{-10,-120},{10,-100}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(extent={{-30,-60},{-10,-80}})));
  Modelica.Blocks.Continuous.Integrator integrator(
    k=10,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0)
    annotation (Placement(transformation(extent={{-4,-80},{16,-60}})));
  EnergyFlow.Sources.FixedEnergyFlow heatFlow(E_flow(displayUnit="MW") = 288000000) annotation (Placement(transformation(extent={{-160,10},{-140,30}})));
  Processes.Isobaric pseudoHeatTransfer(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,
    T_out_fixed=403.15) annotation (Placement(transformation(extent={{-30,-30},{-50,-10}})));
equation
  connect(highPressurePump.outlet, heater.inlet)
    annotation (Line(
      points={{-110,-20},{-120,-20},{-120,10}},
      color={28,108,200},
      thickness=0.5));
  connect(vaporQualitySensor.inlet, lowPressureTurbineStage.outlet) annotation (Line(
      points={{130,50},{110,50}},
      color={28,108,200},
      thickness=0.5));
  connect(mixingPreheater.inletB, lowPressurePump.outlet) annotation (Line(
      points={{10,-20},{30,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(heater.outlet, highPressureTurbineStage.inlet) annotation (Line(
      points={{-120,30},{-120,50},{10,50}},
      color={28,108,200},
      thickness=0.5));
  connect(highPressureTurbineStage.outlet, splitter.inlet) annotation (Line(
      points={{30,50},{50,50}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter.outletB, lowPressureTurbineStage.inlet) annotation (Line(
      points={{70,50},{90,50}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateSource.inlet, splitter.outletA) annotation (Line(
      points={{30,20},{60,20},{60,40}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateSource.outlet, mixingPreheater.inletA) annotation (Line(
      points={{10,20},{0,20},{0,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker.outlet, highPressurePump.inlet)
    annotation (Line(
      points={{-80,-20},{-90,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(condensor.outlet, lowPressurePump.inlet)
    annotation (Line(
      points={{70,-20},{50,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(lowPressureTurbineStage.outlet, condensor.inlet) annotation (Line(
      points={{110,50},{120,50},{120,-20},{90,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(mixingPreheater.outlet, temperatureSensor.inlet) annotation (Line(
      points={{-10,-20},{-20,-20},{-20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(h_bubble.y, condensor.outletSpec_prescribed) annotation (Line(points={{79,-40},{70,-40},{70,-32}}, color={0,0,127}));
  connect(mixingTemperature.y, feedback.u1) annotation (Line(points={{-39,-70},{-28,-70}}, color={0,0,127}));
  connect(temperatureSensor.value_out, feedback.u2) annotation (Line(points={{-20,-48.2},{-20,-62}}, color={0,0,127}));
  connect(feedback.y, integrator.u) annotation (Line(points={{-11,-70},{-6,-70}}, color={0,0,127}));
  connect(integrator.y, massFlowRateSource.m_flow_prescribed) annotation (Line(points={{17,-70},{20,-70},{20,12}},                   color={0,0,127}));
  connect(heatFlow.E_flow_out, heater.Q_flow_in) annotation (Line(points={{-139,20},{-128,20}}, color={255,170,85}));
  connect(loopBreaker.inlet, pseudoHeatTransfer.outlet) annotation (Line(
      points={{-60,-20},{-50,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(pseudoHeatTransfer.inlet, mixingPreheater.outlet) annotation (Line(
      points={{-30,-20},{-10,-20}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-140},{160,140}}), graphics={
        Text(
          extent={{60,-14},{66,-20}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{22,-14},{28,-20}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-86,-14},{-80,-20}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-120,-14},{-114,-20}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{-120,50},{-114,44}},
          textColor={28,108,200},
          textString="6"),
        Text(
          extent={{54,26},{60,20}},
          textColor={28,108,200},
          textString="7"),
        Text(
          extent={{114,50},{120,44}},
          textColor={28,108,200},
          textString="8"),
        Text(
          extent={{114,-14},{120,-20}},
          textColor={28,108,200},
          textString="8")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    Extension of the <a href=\"modelica://ThermoFluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise6SteamPowerPlant\">Exercise6SteamPowerPlant</a> of a steam power plant by a mixing preheater.
    The setup of this example is identical to
    <a href=\"modelica://ThermoFluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise7MixingPreheater.Inversion\">Exercise7MixingPreheater.Inversion</a> (see for problem description)..
  </p>

  <p>
    This example uses <code>pseudoInversion</code> \"controllers\" instead of the <a href=\"modelica://Modelica.Blocks.Math.InverseBlockConstraints\">InverseBlockConstraints</a> model.
    With this the implicit nonlinear equations can be \"avoided\". 
    Note that also the time integration algorithm requires suitable start values and is also likely to be implicit and will likely solve implicit nonlinear equations aswell.
  </p>
</html>"));
end PseudoInversion;
