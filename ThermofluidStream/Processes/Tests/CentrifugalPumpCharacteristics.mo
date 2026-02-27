within ThermofluidStream.Processes.Tests;
model CentrifugalPumpCharacteristics "Test model for CentrifugalPump"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    annotation(choicesAllMatching = true);
  parameter Real w_n=0.2 "Normalized speed";
  parameter SI.Temperature T=293.15
                             "Temperature";
  parameter SI.Pressure p=100000
                          "Pressue";
  final parameter Medium.ThermodynamicState state = Medium.setState_pT(p,T);
  final parameter SI.Density rho = Medium.density(state);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T)    annotation (Placement(transformation(extent={{-130,20},{-110,40}})));
  Boundaries.Sink  sink(redeclare package Medium = Medium, pressureFromInput=true) annotation (Placement(transformation(extent={{-10,20},{10,40}})));

  ThermofluidStream.Processes.CentrifugalPump coefficients(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    dataFromMeasurements=false,
    redeclare ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients.Wilo.Stratos25slash1to4 coefficients(rho_ref=rho),
    redeclare ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.Wilo.Stratos25slash1to4 measurements,
    pumpMode=ThermofluidStream.Processes.Internal.Types.PumpMode.speedControlled,
    setpointFromInput=true,
    P_reg=0.01,
    phi(fixed=true)) annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  Modelica.Blocks.Sources.RealExpression rotationalSpeed(y=w_n*coefficients.coefficients.w_ref) annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Sources.Ramp massFlowRamp(height=coefficients.coefficients.V_flow_peak*coefficients.coefficients.V_0n*rho*w_n, duration=1) annotation (Placement(transformation(extent={{130,-10},{110,10}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T)    annotation (Placement(transformation(extent={{-130,-40},{-110,-20}})));
  Boundaries.Sink  sink1(redeclare package Medium = Medium, pressureFromInput=true) annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  ThermofluidStream.Processes.CentrifugalPump measurements(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    dataFromMeasurements=true,
    redeclare ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients.Wilo.Stratos25slash1to4 coefficients(rho_ref=rho),
    redeclare ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.Wilo.Stratos25slash1to4 measurements(rho_ref=rho),
    pumpMode=ThermofluidStream.Processes.Internal.Types.PumpMode.speedControlled,
    setpointFromInput=true,
    P_reg=0.01,
    phi(fixed=true)) annotation (Placement(transformation(extent={{-90,-20},{-70,-40}})));
  Sensors.SingleFlowSensor massFlowSensor(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    outputValue=true) annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Sensors.SingleFlowSensor singleFlowSensor1(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    outputValue=true) annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  Modelica.Blocks.Continuous.PI         PI(
    k=-1e6,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=p) annotation (Placement(transformation(extent={{50,20},{30,40}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(extent={{90,40},{70,20}})));
  Modelica.Blocks.Continuous.PI         PI1(
    k=-1e6,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=p) annotation (Placement(transformation(extent={{50,-40},{30,-20}})));
  Modelica.Blocks.Math.Feedback feedback1 annotation (Placement(transformation(extent={{90,-20},{70,-40}})));
equation
  connect(source.outlet, coefficients.inlet) annotation (Line(
      points={{-110,30},{-90,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, measurements.inlet) annotation (Line(
      points={{-110,-30},{-90,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(rotationalSpeed.y, coefficients.setpoint_var) annotation (Line(points={{-89,0},{-80,0},{-80,22}}, color={0,0,127}));
  connect(measurements.setpoint_var, rotationalSpeed.y) annotation (Line(points={{-80,-22},{-80,0},{-89,0}},                         color={0,0,127}));
  connect(coefficients.outlet, massFlowSensor.inlet) annotation (Line(
      points={{-70,30},{-50,30}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowSensor.outlet, sink.inlet) annotation (Line(
      points={{-30,30},{-10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(measurements.outlet, singleFlowSensor1.inlet) annotation (Line(
      points={{-70,-30},{-50,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor1.outlet, sink1.inlet) annotation (Line(
      points={{-30,-30},{-10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.p0_var, PI.y) annotation (Line(points={{2,30},{29,30}}, color={0,0,127}));
  connect(PI.u, feedback.y) annotation (Line(points={{52,30},{71,30}}, color={0,0,127}));
  connect(feedback.u1, massFlowRamp.y) annotation (Line(points={{88,30},{101.5,30},{101.5,0},{109,0}},
                                                                                                color={0,0,127}));
  connect(feedback.u2, massFlowSensor.value_out) annotation (Line(points={{80,38},{80,50},{-20,50},{-20,36},{-32,36}}, color={0,0,127}));
  connect(sink1.p0_var, PI1.y) annotation (Line(points={{2,-30},{29,-30}}, color={0,0,127}));
  connect(PI1.u, feedback1.y) annotation (Line(points={{52,-30},{71,-30}}, color={0,0,127}));
  connect(feedback1.u2, singleFlowSensor1.value_out) annotation (Line(points={{80,-22},{80,-10},{-20,-10},{-20,-24},{-32,-24}}, color={0,0,127}));
  connect(massFlowRamp.y, feedback1.u1) annotation (Line(points={{109,0},{101.5,0},{101.5,-30},{88,-30}},
                                                                                                   color={0,0,127}));
  annotation (experiment(StartTime=-0.1, StopTime=1.0, Tolerance=1e-6, Interval=1e-3, __Dymola_Algorithm="Dassl"),
    Icon(coordinateSystem(extent={{-100,-80},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{140,100}}), graphics={Text(
          extent={{-40,100},{38,82}},
          textColor={28,108,200},
          textString="Use the same pump (coefficients, measurements)")}),
    experiment(StopTime=1),
        Documentation(info="<html>
  <p>
    Test model for centrifugal pump characteristics used in the
    <a href=\"modelica://ThermofluidStream.Processes.CentrifugalPump\">
      CentrifugalPump
    </a> model.
  </p>

  <p>
    The model compares the measurements option
    (<code>dataFromMeasurements = true</code>) with the coefficients option
    (<code>dataFromMeasurements = false</code>).
  </p>

  <p>
    In particular, the pump pressure rise
    <code>measurements.dp</code> is compared against
    <code>coefficients.dp</code> for varying flow rates at design rotational speed. 
  </p>

  <p>
    Time is used as a proxy for the mass flow rate (linear relation): <code>time = 0</code> corresponds to zero mass flow rate, and <code>time = 1</code> corresponds to the reference mass flow rate.<br>
    Time <code>time &lt; 0</code> is used for \"start up\".
  </p>

  <p>
    Time is used as a proxy for the mass flow rate (linear relation): <code>time = 0</code> corresponds to zero mass flow rate, and <code>time = 1</code> corresponds to the reference mass flow rate.<br>
    Time <code>time &lt; 0</code> is used for \"start up\".
  </p>

  <p>
    <code>measurements</code> and <code>coefficients</code> may differ slightly. 
    Their difference depends on the number of significant used to create the coeffiencts records, see 
    <a href=\"modelica://ThermofluidStream.Processes.Internal.CentrifugalPump.CalculateCoefficientsFromMeasurements\">CalculateCoefficientsFromMeasurements</a>.
  </p>
</html>",                      revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end CentrifugalPumpCharacteristics;
