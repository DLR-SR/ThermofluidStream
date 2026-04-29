within ThermofluidStream.Processes.Tests;
model Pump_dp_tau_centrifugal_Characteristics "Tests dp_tau_isentrop characteristics"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (
      choicesAllMatching=true,
      Documentation(info="<html>
<p>
Medium model for the test. Should be incompressible or with low compressibility.
</p>
</html>"));
  parameter SI.Pressure p_in=100000 "Inlet pressure";
  parameter SI.Temperature T_in=293.15 "Inlet temperature";
  parameter SI.Density rho_in = Medium.density_pT(p_in, T_in) "Inlet density";
  parameter SI.Height TDH_D=3.6610 "Design pressure head (max efficiency)";
  parameter SI.VolumeFlowRate V_flow_D=3.06e-3 "Design volume flow (max efficiency)";
  parameter SI.AngularVelocity omega_D=314.2 "Design angular velocity";
  parameter Real k=-1     "Start value";

  final parameter SI.MassFlowRate m_flow_D = V_flow_D*rho_in "Design mass flow rate";

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    T0_par=T_in,
    p0_par=p_in)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  ThermofluidStream.Boundaries.Sink sink(
    redeclare package Medium = Medium, pressureFromInput=true)
    annotation (Placement(transformation(extent={{0,30},{20,50}})));

  inner ThermofluidStream.DropOfCommons dropOfCommons(L=1,
    displayInstanceNames=true,
    displayParameters=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,90})));

  ThermofluidStream.Processes.Pump correctedPump(
    redeclare package Medium = Medium,
    L=100000,
    omega_from_input=true,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function dp_tau_pump = ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal (
        useLegacyReynolds=false,
        TDH_D=TDH_D,
        V_flow_D=V_flow_D,
        omega_D=omega_D)) annotation (Placement(transformation(extent={{-70,30},{-50,50}})));

  Modelica.Blocks.Sources.Constant rotationalSpeed(k=omega_D) annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.Ramp massFlowRate(
    height=(1.55 - k)*m_flow_D,
    duration=1.55 - k,
    offset=k*m_flow_D,
    startTime=k)                                        annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(extent={{70,30},{50,50}})));
  Modelica.Blocks.Continuous.PI         PI(
    k=-1e8,
    T=0.01,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=p_in) annotation (Placement(transformation(extent={{40,30},{20,50}})));
  ThermofluidStream.Sensors.SingleFlowSensor flowSensor(
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    outputValue=true) annotation (Placement(transformation(extent={{-40,50},{-20,30}})));
  Boundaries.Source                   source1(
    redeclare package Medium = Medium,
    T0_par=T_in,
    p0_par=p_in)
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
  Boundaries.Sink                   sink1(redeclare package Medium = Medium, pressureFromInput=true)
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  ThermofluidStream.Processes.Pump legacyPump(
    redeclare package Medium = Medium,
    L=100000,
    omega_from_input=true,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function dp_tau_pump = Internal.TurboComponent.dp_tau_centrifugal (
        TDH_D=TDH_D,
        V_flow_D=V_flow_D,
        omega_D=omega_D)) annotation (Placement(transformation(extent={{-70,-30},{-50,-50}})));
  Modelica.Blocks.Math.Feedback feedback1
                                         annotation (Placement(transformation(extent={{70,-30},{50,-50}})));
  Modelica.Blocks.Continuous.PI         PI1(
    k=-1e9,
    T=0.01,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=p_in) annotation (Placement(transformation(extent={{40,-50},{20,-30}})));
  Sensors.SingleFlowSensor flowSensor1(
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    outputValue=true) annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
equation
  connect(source.outlet, correctedPump.inlet) annotation (Line(
      points={{-80,40},{-70,40}},
      color={28,108,200},
      thickness=0.5));
  connect(rotationalSpeed.y, correctedPump.omega_input) annotation (Line(points={{-79,0},{-60,0},{-60,28}}, color={0,0,127}));
  connect(feedback.y, PI.u) annotation (Line(points={{51,40},{42,40}}, color={0,0,127}));
  connect(sink.p0_var, PI.y) annotation (Line(points={{12,40},{19,40}}, color={0,0,127}));
  connect(feedback.u1, massFlowRate.y) annotation (Line(points={{68,40},{74,40},{74,0},{79,0}},
                                                                                  color={0,0,127}));
  connect(correctedPump.outlet, flowSensor.inlet) annotation (Line(
      points={{-50,40},{-40,40}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, flowSensor.outlet) annotation (Line(
      points={{0,40},{-20,40}},
      color={28,108,200},
      thickness=0.5));
  connect(flowSensor.value_out, feedback.u2) annotation (Line(points={{-22,34},{-10,34},{-10,12},{60,12},{60,32}}, color={0,0,127}));
  connect(source1.outlet, legacyPump.inlet) annotation (Line(
      points={{-80,-40},{-70,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(feedback1.y, PI1.u) annotation (Line(points={{51,-40},{42,-40}}, color={0,0,127}));
  connect(sink1.p0_var, PI1.y) annotation (Line(points={{12,-40},{19,-40}}, color={0,0,127}));
  connect(legacyPump.outlet, flowSensor1.inlet) annotation (Line(
      points={{-50,-40},{-40,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, flowSensor1.outlet) annotation (Line(
      points={{0,-40},{-20,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(flowSensor1.value_out, feedback1.u2) annotation (Line(points={{-22,-34},{-10,-34},{-10,-20},{60,-20},{60,-32}}, color={0,0,127}));
  connect(rotationalSpeed.y, legacyPump.omega_input) annotation (Line(points={{-79,0},{-60,0},{-60,-28}}, color={0,0,127}));
  connect(massFlowRate.y, feedback1.u1) annotation (Line(points={{79,0},{74,0},{74,-40},{68,-40}}, color={0,0,127}));
  annotation (
    experiment(StopTime=1.55, StartTime = -1, Tolerance=1e-6, Interval=0.01),
        Documentation(info="<html>
  <p>
    Test model for the pump characteristics according to
    <a href=\"modelica://ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal\">
      dp_tau_centrifugal
    </a>.
  </p>

  <p>
    The model compares the legacy formulation
    (<code>useLegacyReynolds = true</code>) with the corrected formulation
    (<code>useLegacyReynolds = false</code>).
  </p>

  <p>
    In particular, the pump pressure rise
    <code>correctedPump.dp</code> is compared against
    <code>legacyPump.dp</code> for varying flow rates at design rotational speed.
  </p>

  <p>
    Time is used as a proxy for the mass flow rate (linear relation): <code>time = 0</code> corresponds to zero mass flow rate, and <code>time = 1</code> corresponds to the reference mass flow rate.<br>
    Note that <code>time &lt; 0</code> corresponds to negative mass flow rates.
  </p>
  
  <p>
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Processes.Tests.Pump_dp_tau_centrifugal_Characteristics.png\" width=\"750\">
  </p>

</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"),
    Diagram(coordinateSystem(extent={{-120,-100},{120,100}})));
end Pump_dp_tau_centrifugal_Characteristics;
