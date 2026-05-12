within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise7MixingPreheater;
model Inversion
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconNeglectInertance;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
                                                                              constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true,
    neglectInertance=true)
    annotation (Placement(transformation(extent={{140,80},{160,100}})));

  ThermofluidStream.Idealized.Processes.Adiabatic highPressurePump(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=2000000) annotation (Placement(transformation(extent={{-70,-30},{-90,-10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic lowPressureTurbineStage(
    redeclare package Medium = Medium,
    eta_fixed=0.889,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=5000) annotation (Placement(transformation(extent={{90,40},{110,60}})));
  ThermofluidStream.Idealized.Processes.Isobaric heater(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    specifyOutlet=true,

    T_out_fixed=813.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-100,20})));
  ThermofluidStream.Idealized.Processes.Isobaric condensor(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
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
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=1000000) annotation (Placement(transformation(extent={{50,-30},{30,-10}})));
  Topology.JunctionT2 mixingPreheater(
    displayInstanceName=true,
    redeclare package Medium = Medium)
                           annotation (Placement(transformation(extent={{10,-30},{-10,-10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic highPressureTurbineStage(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.none,
    m_flow_0=1,
    eta_fixed=0.889,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=1000000) annotation (Placement(transformation(extent={{10,40},{30,60}})));
  ThermofluidStream.Topology.SplitterT2  splitter(displayInstanceName=false, redeclare package Medium = Medium)
                                                                                                              annotation (Placement(transformation(extent={{50,60},{70,40}})));
  Sources.MassFlowRate massFlowRateSource(
    redeclare package Medium = Medium,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    outlet(m_flow(start=0))) annotation (Placement(transformation(extent={{30,10},{10,30}})));
  Sources.LoopBreaker loopBreaker(
    redeclare package Medium = Medium,
    p_out_fixed(displayUnit="bar") = 1000000,
    T_out_fixed=403.15)
                     annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-40,-20})));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-2,-40})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints
    annotation (Placement(transformation(extent={{-10,-84},{30,-60}})));
  Modelica.Blocks.Sources.RealExpression mixingTemperature(y(
      unit="K",
      displayUnit="degC") = 403.15)
    annotation (Placement(transformation(extent={{-50,-82},{-30,-62}})));
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
  EnergyFlow.Sources.FixedEnergyFlow heatFlow(E_flow(displayUnit="MW") = 288000000) annotation (Placement(transformation(extent={{-140,10},{-120,30}})));
equation
  connect(highPressurePump.outlet, heater.inlet)
    annotation (Line(
      points={{-90,-20},{-100,-20},{-100,10}},
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
      points={{-100,30},{-100,50},{10,50}},
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
      points={{-50,-20},{-70,-20}},
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
      points={{-10,-20},{-20,-20},{-20,-40},{-12,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(temperatureSensor.value_out, inverseBlockConstraints.u2)
    annotation (Line(points={{6.2,-40},{10,-40},{10,-72},{-6,-72}}, color={0,0,127}));
  connect(inverseBlockConstraints.y2, massFlowRateSource.m_flow_prescribed)
    annotation (Line(points={{27,-72},{20,-72},{20,12}}, color={0,0,127}));
  connect(mixingTemperature.y, inverseBlockConstraints.u1)
    annotation (Line(points={{-29,-72},{-12,-72}}, color={0,0,127}));
  connect(mixingPreheater.outlet, loopBreaker.inlet) annotation (Line(
      points={{-10,-20},{-30,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(h_bubble.y, condensor.outletSpec_prescribed) annotation (Line(points={{79,-40},{70,-40},{70,-32}}, color={0,0,127}));
  connect(heatFlow.E_flow_out, heater.Q_flow_in) annotation (Line(points={{-119,20},{-108,20}}, color={255,170,85}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-140},{160,120}}), graphics={
        Text(
          extent={{60,-14},{66,-20}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{22,-14},{28,-20}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-58,-14},{-52,-20}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-100,-14},{-94,-20}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{-100,50},{-94,44}},
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
          textString="8"),
        Polygon(
          points={{-160,60},{-120,60},{-120,80},{-140,80},{-140,120},{-160,120},{-160,60}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-130,110},{-50,90}},
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
    Extension of the <a href=\"modelica://ThermoFluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise6SteamPowerPlant\">example 6</a> of a steam power plant by a mixing preheater.
  </p>

  <p>
    This example uses the 
    <a href=\"modelica://Modelica.Blocks.Math.InverseBlockConstraints\">InverseBlockConstraints</a> model
    resulting in implicit nonlinear equations. These equations require suitable start values to be solvable.
  </p>

  <h4>Problem description</h4>

  <p>
    A small increase in the efficiency of a stationary steam power plant (compared to example 6) is achieved by installing a 
    mixing preheater. Saturated liquid water at state 1 (<code>50.0 mbar</code>, <code>32.90 °C</code>) 
    is pumped by the reversible adiabatic feedwater <code>lowPressurePump</code> to <code>10.0 bar</code>.
  </p>

  <p>
    In the isobaric, externally adiabatic <code>mixingPreheater</code>, a portion of the mass flow (state <code>7</code>)
    from the process steam extracted from the turbine is mixed with the water 
    from state <code>2</code>. This results in a feedwater temperature of <code>T3 = 130 degC</code>. The reversible adiabatic 
    feedwater <code>highPressurePump</code> then raises the water pressure to <code>20.0 bar</code>.
  </p>

  <p>
    In the isobaric <code>heater</code>, the water is heated, vaporized and superheated (<code>288 MW</code>) to <code>540 degC</code>.
  </p>

  <p>
    In the steam turbine (isentropic efficiency <code>eta_is = 0.889</code>), after the first turbine stage 
    (<code>highPressureTurbineStage</code>, <code>10.0 bar</code>), a portion of the steam (state <code>7</code>) is extracted and fed to the 
    <code>mixingPreheater</code>. The remaining steam in the turbine is further expanded 
    (<code>lowPressureTurbineStage</code>, <code>50.0 mbar</code>), condensed in the isobaric <code>condenser</code> and returned to the <code>lowPressurePump</code>, closing the cycle.
  </p>
</html>"));
end Inversion;
