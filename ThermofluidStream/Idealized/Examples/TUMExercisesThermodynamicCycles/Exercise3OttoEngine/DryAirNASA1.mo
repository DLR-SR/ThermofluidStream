within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise3OttoEngine;
model DryAirNASA1
  extends ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise3OttoEngine.BaseModel(redeclare package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa);

  ThermofluidStream.Idealized.Processes.Adiabatic compression(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-90,-38},{-70,-18}})));
  Processes.Isochoric combustion(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Cycle.Isochoric.OutletTemperature,
    T_out_fixed(displayUnit="K") = T3) annotation (Placement(transformation(extent={{-30,-38},{-10,-18}})));
  ThermofluidStream.Idealized.Processes.Adiabatic expansion(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{10,-38},{30,-18}})));
  Processes.Isochoric gasExchange(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Cycle.Isochoric.OutletTemperature,
    T_out_fixed(displayUnit="K") = T1) annotation (Placement(transformation(extent={{70,-38},{90,-18}})));
  Modelica.Blocks.Sources.RealExpression density1(y=d1) annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Sources.RealExpression density2(y=d2) annotation (Placement(transformation(extent={{-120,40},{-100,60}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints annotation (Placement(transformation(extent={{-80,38},{-40,62}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints1 annotation (Placement(transformation(extent={{20,38},{60,62}})));
  ThermofluidStream.Sensors.SingleSensorSelect sensorDensity1(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3,
    outputValue=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,-6})));
  ThermofluidStream.Sensors.SingleSensorSelect sensorDensity2(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3,
    outputValue=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-4})));
  LoopBreaker_m loopBreaker(
    redeclare package Medium = Medium,
    m_flow_in_par=1,
    p_out_fixed=p1,
    thermalSpec=ThermofluidStream.Idealized.Utilities.Types.ThermalSpecification.Temperature,
    T_out_fixed=T1) annotation (Placement(transformation(extent={{10,10},{-10,30}})));
  ThermofluidStream.Utilities.showRealValue maximumPressure(
    description="p_max",
    use_numberPort=false,
    number=combustion.outlet.state.p,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  ThermofluidStream.Utilities.showRealValue netWork(
    description="w_n",
    use_numberPort=false,
    number=shaftPower.E_flow_out/expansion.m_flow,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="eff",
    use_numberPort=false,
    number=shaftPower.E_flow_out/combustion.Q_flow,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
  EnergyFlow.Components.Sum shaftPower(n_in=4) annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
equation
  connect(compression.outlet, combustion.inlet)
    annotation (Line(
      points={{-70,-28},{-30,-28}},
      color={28,108,200},
      thickness=0.5));
  connect(combustion.outlet, expansion.inlet)
    annotation (Line(
      points={{-10,-28},{10,-28}},
      color={28,108,200},
      thickness=0.5));
  connect(expansion.outlet, gasExchange.inlet)
    annotation (Line(
      points={{30,-28},{70,-28}},
      color={28,108,200},
      thickness=0.5));
  connect(density2.y, inverseBlockConstraints.u1) annotation (Line(points={{-99,50},{-82,50}}, color={0,0,127}));
  connect(density1.y, inverseBlockConstraints1.u1) annotation (Line(points={{1,50},{18,50}}, color={0,0,127}));
  connect(sensorDensity1.inlet, expansion.outlet) annotation (Line(
      points={{40,-16},{40,-28},{30,-28}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorDensity1.value_out, inverseBlockConstraints1.u2) annotation (Line(points={{40,2.2},{40,50},{24,50}}, color={0,0,127}));
  connect(inverseBlockConstraints1.y2, expansion.outletSpec_prescribed) annotation (Line(points={{57,50},{54,50},{54,-46},{30,-46},{30,-40}}, color={0,0,127}));
  connect(sensorDensity2.inlet, compression.outlet) annotation (Line(
      points={{-60,-14},{-60,-28},{-70,-28}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorDensity2.value_out, inverseBlockConstraints.u2) annotation (Line(points={{-60,4.2},{-60,50},{-76,50}}, color={0,0,127}));
  connect(inverseBlockConstraints.y1, compression.outletSpec_prescribed) annotation (Line(points={{-39,50},{-46,50},{-46,-46},{-70,-46},{-70,-40}}, color={0,0,127}));
  connect(gasExchange.outlet, loopBreaker.inlet) annotation (Line(
      points={{90,-28},{100,-28},{100,20},{10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(compression.inlet, loopBreaker.outlet) annotation (Line(
      points={{-90,-28},{-100,-28},{-100,20},{-10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(compression.P_out, shaftPower.E_flow_in[1]) annotation (Line(points={{-80,-35},{-80,-64},{100,-64},{100,-62.25}},
                                                                                                                          color={255,170,85}));
  connect(expansion.P_out, shaftPower.E_flow_in[2]) annotation (Line(points={{20,-35},{20,-60.75},{100,-60.75}},color={255,170,85}));
  connect(gasExchange.P_out, shaftPower.E_flow_in[3]) annotation (Line(points={{90,-39},{90,-59.25},{100,-59.25}}, color={255,170,85}));
  connect(combustion.P_out, shaftPower.E_flow_in[4]) annotation (Line(points={{-10,-39},{-10,-62},{100,-62},{100,-57.75}}, color={255,170,85}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-100},{180,100}}), graphics={
        Text(
          extent={{-100,-22},{-94,-28}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-68,-22},{-62,-28}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-6,-22},{0,-28}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{30,-22},{36,-28}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{94,-22},{100,-28}},
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
    Example of an otto engine cycle. The setup of this example is identical to
    <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise3OttoEngine.PerfectGasAdiabaticFlow\">Exercise3OttoEngine.SimpleAir1</a> (see for problem description).
  </p>

  <p>
    This example uses the <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.DryAirNasa\">DryAirNasa</a> medium
    (ideal gas with temperature-dependent <code>cp</code>)
    instead of the <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.SimpleAir\">SimpleAir</a> medium
    (perfect gas with constant <code>cp</code>).
  </p>

  <p>
    This example uses the 
    <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Processes.Adiabatic\">Adiabatic</a> model, which uses the outlet pressure as the setpoint. 
    The calculation of outlet pressure for given outlet density is achieved by the use of the <a href=\"modelica://Modelica.Blocks.Math.InverseBlockConstraints\">InverseBlockConstraints</a> model.
    An implicit nonlinear equation is introduced, which requires suitable start values.
  </p> 

  <p>
    The <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Processes.Adiabatic\">Adiabatic</a> model should only be used to represent 
    a periodic closed-cycle process when the isentropic efficiency is equal to unity, or when the working fluid is an ideal gas with constant isentropic exponent.
    Otherwise, discrepancies arise because the isentropic efficiency is defined based on shaft work (i.e., changes in specific enthalpy) in the first case, 
    and based on net expansion work (i.e., changes in specific internal energy) in the second case.
  </p>
</html>"));
end DryAirNASA1;
