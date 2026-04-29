within ThermofluidStream.Processes.Tests;
model Pump_dp_tau_centrifugal_DesignPoint "Tests dp_tau_isentrop design point"
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
  parameter SI.Pressure dp_D = TDH_D*rho_in*Modelica.Constants.g_n "Design pressure difference";
  final parameter SI.MassFlowRate m_flow_D = V_flow_D*rho_in "Design mass flow rate";

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    T0_par=T_in,
    p0_par=p_in)
    annotation (Placement(transformation(extent={{-270,20},{-250,40}})));
  ThermofluidStream.Boundaries.Sink sink(
    redeclare package Medium = Medium, pressureFromInput=true)
    annotation (Placement(transformation(extent={{-170,20},{-150,40}})));

  inner ThermofluidStream.DropOfCommons dropOfCommons(L=1,
    p_min=10000,
    displayInstanceNames=true,
    displayParameters=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={330,90})));

  ThermofluidStream.Processes.Pump correctedPump(
    redeclare package Medium = Medium,
    L=100000,
    omega_from_input=true,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function dp_tau_pump = ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal (
        useLegacyReynolds=false,
        TDH_D=TDH_D,
        V_flow_D=V_flow_D,
        omega_D=omega_D)) annotation (Placement(transformation(extent={{-240,20},{-220,40}})));

  Modelica.Blocks.Sources.Constant rotationalSpeed(k=omega_D) annotation (Placement(transformation(extent={{-300,-10},{-280,10}})));
  Modelica.Blocks.Sources.Constant
                               massFlowRate(k=m_flow_D) annotation (Placement(transformation(extent={{-70,-10},{-90,10}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(extent={{-100,40},{-120,20}})));
  Modelica.Blocks.Continuous.PI PI(
    k=-1e8,
    T=0.05,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=p_in) annotation (Placement(transformation(extent={{-130,20},{-150,40}})));
  ThermofluidStream.Sensors.SingleFlowSensor flowSensor(
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    outputValue=true) annotation (Placement(transformation(extent={{-210,20},{-190,40}})));
  Boundaries.Source                   source1(
    redeclare package Medium = Medium,
    T0_par=T_in,
    p0_par=p_in)
    annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  Boundaries.Sink                   sink1(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    p0_par=p_in + dp_D)
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  ThermofluidStream.Processes.Pump correctedPump1(
    redeclare package Medium = Medium,
    L=100000,
    omega_from_input=true,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function dp_tau_pump = Internal.TurboComponent.dp_tau_centrifugal (
        useLegacyReynolds=false,
        TDH_D=TDH_D,
        V_flow_D=V_flow_D,
        omega_D=omega_D)) annotation (Placement(transformation(extent={{0,40},{20,20}})));
  Modelica.Blocks.Math.Feedback feedback1
                                         annotation (Placement(transformation(extent={{100,50},{80,70}})));
  Modelica.Blocks.Continuous.PI PI1(
    k=1,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=320)
               annotation (Placement(transformation(extent={{50,50},{30,70}})));
  Sensors.SingleFlowSensor flowSensor1(
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    outputValue=true) annotation (Placement(transformation(extent={{60,20},{80,40}})));
  Modelica.Blocks.Sources.Constant
                               massFlowRate1(k=m_flow_D)
                                                        annotation (Placement(transformation(extent={{160,-10},{140,10}})));
  FlowControl.CheckValve checkValve(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{30,20},{50,40}})));
  Boundaries.Source                   source2(
    redeclare package Medium = Medium,
    T0_par=T_in,
    p0_par=p_in)
    annotation (Placement(transformation(extent={{-270,-40},{-250,-20}})));
  Boundaries.Sink                   sink2(redeclare package Medium = Medium, pressureFromInput=true)
    annotation (Placement(transformation(extent={{-170,-40},{-150,-20}})));
  ThermofluidStream.Processes.Pump legacyPump(
    redeclare package Medium = Medium,
    L=100000,
    omega_from_input=true,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function dp_tau_pump = Internal.TurboComponent.dp_tau_centrifugal (
        TDH_D=TDH_D,
        V_flow_D=V_flow_D,
        omega_D=omega_D)) annotation (Placement(transformation(extent={{-240,-20},{-220,-40}})));
  Modelica.Blocks.Math.Feedback feedback2
                                         annotation (Placement(transformation(extent={{-100,-40},{-120,-20}})));
  Modelica.Blocks.Continuous.PI PI2(
    k=-1e8,
    T=0.05,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=p_in) annotation (Placement(transformation(extent={{-130,-40},{-150,-20}})));
  Sensors.SingleFlowSensor                   flowSensor2(
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    outputValue=true) annotation (Placement(transformation(extent={{-210,-20},{-190,-40}})));
  Boundaries.Source                   source3(
    redeclare package Medium = Medium,
    T0_par=T_in,
    p0_par=p_in)
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
  Boundaries.Sink                   sink3(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    p0_par=p_in + dp_D)
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  ThermofluidStream.Processes.Pump legacyPump1(
    redeclare package Medium = Medium,
    L=100000,
    omega_from_input=true,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function dp_tau_pump = Internal.TurboComponent.dp_tau_centrifugal (
        TDH_D=TDH_D,
        V_flow_D=V_flow_D,
        omega_D=omega_D)) annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Sensors.SingleFlowSensor flowSensor3(
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    outputValue=true) annotation (Placement(transformation(extent={{60,-20},{80,-40}})));
  FlowControl.CheckValve checkValve1(redeclare package Medium = Medium)
                                                                       annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
  Modelica.Blocks.Continuous.PI PI3(
    k=1,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=320)
               annotation (Placement(transformation(extent={{50,-70},{30,-50}})));
  Modelica.Blocks.Math.Feedback feedback3
                                         annotation (Placement(transformation(extent={{100,-50},{80,-70}})));
  Boundaries.Source                   source4(
    redeclare package Medium = Medium,
    T0_par=T_in,
    p0_par=p_in)
    annotation (Placement(transformation(extent={{220,22},{240,42}})));
  Boundaries.Sink                   sink4(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    p0_par=p_in + dp_D)
    annotation (Placement(transformation(extent={{280,22},{300,42}})));
  ThermofluidStream.Processes.Pump correctedPump2(
    redeclare package Medium = Medium,
    L=100000,
    omega_from_input=true,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function dp_tau_pump = Internal.TurboComponent.dp_tau_centrifugal (
        useLegacyReynolds=false,
        TDH_D=TDH_D,
        V_flow_D=V_flow_D,
        omega_D=omega_D)) annotation (Placement(transformation(extent={{250,22},{270,42}})));
  Boundaries.Source                   source5(
    redeclare package Medium = Medium,
    T0_par=T_in,
    p0_par=p_in)
    annotation (Placement(transformation(extent={{220,-40},{240,-20}})));
  Boundaries.Sink                   sink5(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    p0_par=p_in + dp_D)
    annotation (Placement(transformation(extent={{280,-40},{300,-20}})));
  ThermofluidStream.Processes.Pump legacyPump2(
    redeclare package Medium = Medium,
    L=100000,
    omega_from_input=true,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function dp_tau_pump = Internal.TurboComponent.dp_tau_centrifugal (
        TDH_D=TDH_D,
        V_flow_D=V_flow_D,
        omega_D=omega_D)) annotation (Placement(transformation(extent={{250,-20},{270,-40}})));
  Modelica.Blocks.Sources.Constant rotationalSpeed1(k=omega_D)
                                                              annotation (Placement(transformation(extent={{200,-10},{220,10}})));
equation
  connect(source.outlet, correctedPump.inlet) annotation (Line(
      points={{-250,30},{-240,30}},
      color={28,108,200},
      thickness=0.5));
  connect(rotationalSpeed.y, correctedPump.omega_input) annotation (Line(points={{-279,0},{-230,0},{-230,18}}, color={0,0,127}));
  connect(feedback.y, PI.u) annotation (Line(points={{-119,30},{-128,30}},
                                                                       color={0,0,127}));
  connect(sink.p0_var, PI.y) annotation (Line(points={{-158,30},{-151,30}},
                                                                        color={0,0,127}));
  connect(feedback.u1, massFlowRate.y) annotation (Line(points={{-102,30},{-96,30},{-96,0},{-91,0}},
                                                                                  color={0,0,127}));
  connect(correctedPump.outlet, flowSensor.inlet) annotation (Line(
      points={{-220,30},{-210,30}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, flowSensor.outlet) annotation (Line(
      points={{-170,30},{-190,30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowSensor.value_out, feedback.u2) annotation (Line(points={{-192,36},{-180,36},{-180,60},{-110,60},{-110,38}},
                                                                                                                   color={0,0,127}));
  connect(source1.outlet, correctedPump1.inlet) annotation (Line(
      points={{-10,30},{0,30}},
      color={28,108,200},
      thickness=0.5));
  connect(PI1.y, correctedPump1.omega_input) annotation (Line(points={{29,60},{10,60},{10,42}}, color={0,0,127}));
  connect(source2.outlet, legacyPump.inlet) annotation (Line(
      points={{-250,-30},{-240,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(feedback2.y, PI2.u) annotation (Line(points={{-119,-30},{-128,-30}}, color={0,0,127}));
  connect(sink2.p0_var, PI2.y) annotation (Line(points={{-158,-30},{-151,-30}}, color={0,0,127}));
  connect(legacyPump.outlet, flowSensor2.inlet) annotation (Line(
      points={{-220,-30},{-210,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(sink2.inlet, flowSensor2.outlet) annotation (Line(
      points={{-170,-30},{-190,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowSensor2.value_out, feedback2.u2) annotation (Line(points={{-192,-36},{-180,-36},{-180,-58},{-110,-58},{-110,-38}}, color={0,0,127}));
  connect(legacyPump.omega_input, rotationalSpeed.y) annotation (Line(points={{-230,-18},{-230,0},{-279,0}}, color={0,0,127}));
  connect(massFlowRate.y, feedback2.u1) annotation (Line(points={{-91,0},{-96,0},{-96,-30},{-102,-30}}, color={0,0,127}));
  connect(source3.outlet, legacyPump1.inlet) annotation (Line(
      points={{-10,-30},{0,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet, correctedPump2.inlet) annotation (Line(
      points={{240,32},{250,32}},
      color={28,108,200},
      thickness=0.5));
  connect(source5.outlet, legacyPump2.inlet) annotation (Line(
      points={{240,-30},{250,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(correctedPump2.outlet, sink4.inlet) annotation (Line(
      points={{270,32},{280,32}},
      color={28,108,200},
      thickness=0.5));
  connect(legacyPump2.outlet, sink5.inlet) annotation (Line(
      points={{270,-30},{280,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(legacyPump1.outlet, checkValve1.inlet) annotation (Line(
      points={{20,-30},{30,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(correctedPump1.outlet, checkValve.inlet) annotation (Line(
      points={{20,30},{30,30}},
      color={28,108,200},
      thickness=0.5));
  connect(checkValve.outlet, flowSensor1.inlet) annotation (Line(
      points={{50,30},{60,30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowSensor1.outlet, sink1.inlet) annotation (Line(
      points={{80,30},{100,30}},
      color={28,108,200},
      thickness=0.5));
  connect(PI1.u, feedback1.y) annotation (Line(points={{52,60},{81,60}}, color={0,0,127}));
  connect(feedback1.u2, flowSensor1.value_out) annotation (Line(points={{90,52},{90,36},{78,36}}, color={0,0,127}));
  connect(massFlowRate1.y, feedback1.u1) annotation (Line(points={{139,0},{130,0},{130,60},{98,60}}, color={0,0,127}));
  connect(checkValve1.outlet, flowSensor3.inlet) annotation (Line(
      points={{50,-30},{60,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowSensor3.outlet, sink3.inlet) annotation (Line(
      points={{80,-30},{100,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(PI3.y, legacyPump1.omega_input) annotation (Line(points={{29,-60},{10,-60},{10,-42}}, color={0,0,127}));
  connect(PI3.u, feedback3.y) annotation (Line(points={{52,-60},{81,-60}}, color={0,0,127}));
  connect(flowSensor3.value_out, feedback3.u2) annotation (Line(points={{78,-36},{90,-36},{90,-52}}, color={0,0,127}));
  connect(massFlowRate1.y, feedback3.u1) annotation (Line(points={{139,0},{130,0},{130,-60},{98,-60}}, color={0,0,127}));
  connect(rotationalSpeed1.y, legacyPump2.omega_input) annotation (Line(points={{221,0},{260,0},{260,-18}}, color={0,0,127}));
  connect(rotationalSpeed1.y, correctedPump2.omega_input) annotation (Line(points={{221,0},{260,0},{260,20}}, color={0,0,127}));
  annotation (
    experiment(StopTime=100, Tolerance=1e-6, Interval=0.1),
        Documentation(info="<html>
  <p>
    Test model for the design point of the pump characteristics according to
    <a href=\"modelica://ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal\">
      dp_tau_centrifugal
    </a>:
  </p>
  
  <ul>
    <li>
      flow at design head and design rotational speed (top left)
    </li>

    <li>
      head at design flow and design rotational speed (bottom left)
    </li>

    <li>
      rotational speed at design flow and design head (top right)
    </li>
  </ul>

  <p>
    The model compares the legacy formulation
    (<code>useLegacyReynolds = true</code>) with the corrected formulation
    (<code>useLegacyReynolds = false</code>).
  </p>

  <p>
    Only the stationary solution is of interest. Transient behavior is introduced
    by the controllers solely to drive the system to the correct stationary
    operating point.
  </p>

  <p>
    The legacy version does not reproduce the specified design point.
    The corrected version is much closer to the specified design point, but still
    shows a small offset of about 5&nbsp;%.
    This remaining deviation is caused by viscosity effects that are not
    compensated at the design point.
    An initial attempt to compensate these effects was only able to slightly
    reduce the offset.
  </p>

  <p>
    <img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Processes.Tests.Pump_dp_tau_centrifugal_DesignPoint.png\" width=\"750\">
  </p>



</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"),
    Diagram(coordinateSystem(extent={{-340,-100},{340,100}})));
end Pump_dp_tau_centrifugal_DesignPoint;
