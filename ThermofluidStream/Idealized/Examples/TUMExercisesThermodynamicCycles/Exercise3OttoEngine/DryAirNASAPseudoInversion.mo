within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise3OttoEngine;
model DryAirNASAPseudoInversion
  extends ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise3OttoEngine.BaseModel(redeclare package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa);

  ThermofluidStream.Idealized.Processes.Adiabatic compression(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-80,-40},{-60,-20}})));
  ThermofluidStream.Idealized.Processes.Isochoric combustion(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    T_out_fixed(displayUnit="K") = T3) annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  ThermofluidStream.Idealized.Processes.Adiabatic expansion(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{20,-40},{40,-20}})));
  ThermofluidStream.Idealized.Processes.Isochoric gasExchange(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    T_out_fixed(displayUnit="K") = T1) annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
  Modelica.Blocks.Sources.RealExpression density1(y=d1) annotation(Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Sources.RealExpression density2(y=d2) annotation(Placement(transformation(extent={{-130,40},{-110,60}})));
  ThermofluidStream.Sensors.SingleSensorSelect sensorDensity1(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3,
    outputValue=true) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-8})));
  ThermofluidStream.Sensors.SingleSensorSelect sensorDensity2(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3,
    outputValue=true) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-6})));
  ThermofluidStream.Idealized.Boundaries.LoopBreaker_m loopBreaker(
    redeclare package Medium = Medium,
    m_flow_in_par=1,
    p_out_fixed=p1,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.Temperature,
    T_out_fixed=T1) annotation (Placement(transformation(extent={{20,8},{0,28}})));
  ThermofluidStream.Idealized.EnergyFlow.Components.Sum shaftPower(n_in=4) annotation (Placement(transformation(extent={{110,-70},{130,-50}})));
  Modelica.Blocks.Continuous.Integrator integrator(
    k=1e7,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
              annotation(Placement(transformation(extent={{-70,40},{-50,60}})));
  Modelica.Blocks.Math.Feedback feedback annotation(Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Math.Feedback feedback1
                                        annotation(Placement(transformation(extent={{10,40},{30,60}})));
  Modelica.Blocks.Continuous.Integrator integrator1(
    k=1e7,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
              annotation(Placement(transformation(extent={{40,40},{60,60}})));
  ThermofluidStream.Utilities.showRealValue maximumPressure(
    description="p_max",
    use_numberPort=false,
    number=combustion.outlet.state.p,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-60,-100},{-40,-80}})));
  ThermofluidStream.Utilities.showRealValue netWork(
    description="w_n",
    use_numberPort=false,
    number=shaftPower.E_flow_out/expansion.m_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-20,-100},{0,-80}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="eff",
    use_numberPort=false,
    number=shaftPower.E_flow_out/combustion.Q_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{20,-100},{40,-80}})));
equation
  connect(compression.outlet, combustion.inlet) annotation(
    Line(
      points={{-60,-30},{-20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(combustion.outlet, expansion.inlet) annotation(
    Line(
      points={{0,-30},{20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(expansion.outlet, gasExchange.inlet) annotation(
    Line(
      points={{40,-30},{80,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorDensity1.inlet, expansion.outlet) annotation(Line(
      points={{50,-18},{50,-30},{40,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorDensity2.inlet, compression.outlet) annotation(Line(
      points={{-50,-16},{-50,-30},{-60,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(gasExchange.outlet, loopBreaker.inlet) annotation(Line(
      points={{100,-30},{110,-30},{110,18},{20,18}},
      color={28,108,200},
      thickness=0.5));
  connect(compression.inlet, loopBreaker.outlet) annotation(Line(
      points={{-80,-30},{-90,-30},{-90,18},{0,18}},
      color={28,108,200},
      thickness=0.5));
  connect(compression.P_out, shaftPower.E_flow_in[1]) annotation(Line(points={{-70,-37},{-70,-64},{110,-64},{110,-62.25}},color={255,170,85}));
  connect(expansion.P_out, shaftPower.E_flow_in[2]) annotation(Line(points={{30,-37},{30,-60.75},{110,-60.75}},color={255,170,85}));
  connect(density2.y, feedback.u1) annotation(Line(points={{-109,50},{-98,50}},  color={0,0,127}));
  connect(sensorDensity2.value_out, feedback.u2) annotation(Line(points={{-50,2.2},{-50,32},{-90,32},{-90,42}},                   color={0,0,127}));
  connect(integrator.y, compression.outletSpec_prescribed) annotation(Line(points={{-49,50},{-40,50},{-40,-50},{-60,-50},{-60,-42}}, color={0,0,127}));
  connect(feedback.y, integrator.u) annotation(Line(points={{-81,50},{-72,50}}, color={0,0,127}));
  connect(density1.y, feedback1.u1) annotation(Line(points={{1,50},{12,50}}, color={0,0,127}));
  connect(feedback1.y, integrator1.u) annotation(Line(points={{29,50},{38,50}}, color={0,0,127}));
  connect(sensorDensity1.value_out, feedback1.u2) annotation(Line(points={{50,0.2},{50,32},{20,32},{20,42}},                 color={0,0,127}));
  connect(integrator1.y, expansion.outletSpec_prescribed) annotation(Line(points={{61,50},{70,50},{70,-50},{40,-50},{40,-42}}, color={0,0,127}));
  connect(gasExchange.P_out, shaftPower.E_flow_in[3]) annotation(Line(points={{100,-41},{100,-59.25},{110,-59.25}},
                                                                                                                  color={255,170,85}));
  connect(combustion.P_out, shaftPower.E_flow_in[4]) annotation(Line(points={{0,-41},{0,-62},{110,-62},{110,-57.75}},     color={255,170,85}));
  annotation(Diagram(coordinateSystem(extent={{-140,-100},{140,100}}),
                     graphics={
        Text(
          extent={{-90,-24},{-84,-30}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-58,-24},{-52,-30}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{4,-24},{10,-30}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{40,-24},{46,-30}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{104,-24},{110,-30}},
          textColor={28,108,200},
          textString="1")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    Example of an Otto cycle engine model. See <a href=\"modelica://ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise3OttoEngine\">TUMExercisesThermodynamicCycles.Exercise3OttoEngine</a> 
    for the problem description.
  </p>

  <p>
    This example makes use of the following components and settings:
  </p>

  <ul>
    <li>
      <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.DryAirNasa\">DryAirNasa</a> medium (ideal gas with temperature-dependent <code>cp</code>)
    </li>
    <li>
      <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a> process model (which is only available for <code>systemSpec = Flow</code>)
    </li>
  </ul>

  <p>
    The calculation of outlet pressure for given outlet density is achieved by the use of a <code>pseudoInversion</code> \"controller\" instead of the <a href=\"modelica://Modelica.Blocks.Math.InverseBlockConstraints\">InverseBlockConstraints</a> model.
    With this the implicit nonlinear equation can be \"avoided\". 
    Note that the introduced state of the controller requires a suitable start values and the time integration algorithm is likely to be implicit and will likely solve implicit nonlinear equations aswell.
  </p>

  <p>
    The <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a> model defines isentropic efficiency based on shaft work (i.e., changes in specific enthalpy), 
    whereas for a closed-cycle process the isentropic efficiency is commonly defined based on the net expansion work (i.e., changes in specific internal energy).
    In general both definitions are not equivalent and discrepancies can arise. 
    The results will however be identical when the isentropic efficiency is equal to unity, or when the working fluid is an ideal gas with constant isentropic exponent.
  </p>

  <p>
    This setup is based on the fact that the specific work of a thermodynamic cycle is given by the closed integral in the <code>p–v</code> diagram (pressure - specific volume).
    Therefore, integrating with respect to volume, <code>p*dv</code> (boundary work as typically transferred in a piston–cylinder system),
    and integrating with respect to pressure, <code>v*dp</code> (“artificial” shaft work of a dual stationary-flow process),
    yield the same net cycle work, even though the individual contributions of each process step differ.
  </p>

</html>"),
    Icon(coordinateSystem(grid={2,2})));
end DryAirNASAPseudoInversion;
