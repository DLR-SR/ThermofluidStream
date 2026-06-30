within ThermofluidStream.Processes.Tests;
model Pump "Test for pumps"
  extends Modelica.Icons.Example;

  import tf = ThermofluidStream;
  replaceable package Medium = tf.Media.myMedia.CompressibleLiquids.LinearWater_pT_Ambient
    constrainedby tf.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (
      choicesAllMatching=true,
      Documentation(info="<html>
<p>
Medium model for the test. Should be incompressible or with low compressibility.
</p>
</html>"));

  tf.Boundaries.Source source(
    redeclare package Medium = Medium,
    T0_par=300,
    p0_par=100000)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  tf.Boundaries.Sink sink(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    p0_par=350000)
    annotation (Placement(transformation(extent={{96,20},{116,40}})));

  inner tf.DropOfCommons dropOfCommons(L=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,-50})));

  ThermofluidStream.Processes.Pump pump_defaultDesignPoint(
    redeclare package Medium = Medium,
    L=100000,
    omega_from_input=true,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function dp_tau_pump = tf.Processes.Internal.TurboComponent.dp_tau_centrifugal (useLegacyReynolds=false))
    annotation (Placement(transformation(extent={{-10,40},{10,20}})));

  Modelica.Blocks.Sources.Constant pump_speed_rad_s(k=800)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  ThermofluidStream.Processes.Pump pump_defaultDesignPoint_PowerIn(
    redeclare package Medium = Medium,
    L=1000000,
    omega_from_input=false,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    initOmega=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    initPhi=true,
    redeclare function dp_tau_pump = tf.Processes.Internal.TurboComponent.dp_tau_centrifugal (useLegacyReynolds=false))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  tf.Processes.Tests.Power powerSource1(P=8000, tau_max=150)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  tf.Topology.SplitterN splitterN(N=4, redeclare package Medium = Medium,
    L=0)
    annotation (Placement(transformation(extent={{-72,20},{-52,40}})));
  tf.Topology.JunctionN junctionN(N=4, redeclare package Medium = Medium,
    L=0)
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  tf.Processes.Pump pump_directParamWithHeatPort(
    redeclare package Medium = Medium,
    L=10000,
    omega_from_input=true,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    enableAccessHeatPort=true,
    redeclare function dp_tau_pump = tf.Processes.Internal.TurboComponent.dp_tau_nominal_flow (parametrizeByDesignPoint
          =false, k_p_input=1e7)) annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Blocks.Sources.Constant pump2_speed_rad_s(k=3200)
    annotation (Placement(transformation(extent={{40,-70},{20,-50}})));
  tf.Processes.Pump pump_directParamPowerIn(
    redeclare package Medium = Medium,
    L=10000,
    omega_from_input=false,
    enableOutput=true,
    outputQuantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.Cp_flow_JpKs,
    J_p=10,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    initOmega=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    initPhi=true,
    phi_0=-1745.3292519943,
    redeclare function dp_tau_pump = tf.Processes.Internal.TurboComponent.dp_tau_nominal_flow (
        parametrizeByDesignPoint=false,
        V_r_input=0.0006,
        k_p_input=1e8)) annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));
  tf.Processes.Tests.Power powerSource2(P=5000, tau_max=150)
    annotation (Placement(transformation(extent={{-40,-120},{-20,-100}})));

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        283.15) annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  tf.Processes.Pump pump_designPointOmega100(
    redeclare package Medium = Medium,
    L=10000,
    omega_from_input=true,
    enableOutput=true,
    outputQuantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_lpMin,
    J_p=10,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    phi_0=-1745.3292519943,
    redeclare function dp_tau_pump = tf.Processes.Internal.TurboComponent.dp_tau_nominal_flow (parametrizeByDesignPoint
          =true, omega_D(displayUnit="rad/s") = 100))
    "Design point: V_flow=100L/min at 100rad/s with a pressure increase of 5 bar"
    annotation (Placement(transformation(extent={{-10,90},{10,70}})));
  Modelica.Blocks.Sources.Constant pump4_speed_rad_s(k=100)
    annotation (Placement(transformation(extent={{-40,90},{-20,110}})));
  tf.Boundaries.Source source1(
    redeclare package Medium = Medium,
    T0_par=300,
    p0_par=100000)
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
  tf.Boundaries.Sink sink1(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    p0_par=600000)
    annotation (Placement(transformation(extent={{96,70},{116,90}})));
  Modelica.Blocks.Interaction.Show.RealValue show_v_flow_pump4_L_min
    annotation (Placement(transformation(extent={{20,90},{40,110}})));
  Modelica.Blocks.Interaction.Show.RealValue show_cp_flow_pump3_J_Ks
    annotation (Placement(transformation(extent={{20,-120},{40,-100}})));
equation
  connect(pump_defaultDesignPoint.omega_input, pump_speed_rad_s.y)
    annotation (Line(points={{0,42},{0,50},{-19,50}}, color={0,0,127}));
  connect(powerSource1.flange, pump_defaultDesignPoint_PowerIn.flange)
    annotation (Line(points={{-22.4,-20},{0,-20},{0,-10}}, color={0,0,0}));
  connect(splitterN.inlet, source.outlet) annotation (Line(
      points={{-72,30},{-80,30}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, junctionN.outlet) annotation (Line(
      points={{96,30},{80,30}},
      color={28,108,200},
      thickness=0.5));
  connect(pump_defaultDesignPoint.inlet, splitterN.outlets[4])
    annotation (Line(
      points={{-10,30},{-52,30},{-52,30.75}},
      color={28,108,200},
      thickness=0.5));
  connect(pump_directParamWithHeatPort.omega_input, pump2_speed_rad_s.y)
    annotation (Line(points={{0,-52},{0,-60},{19,-60}}, color={0,0,127}));
  connect(powerSource2.flange, pump_directParamPowerIn.flange)
    annotation (Line(points={{-22.4,-110},{0,-110},{0,-100}}, color={0,0,0}));
  connect(pump_defaultDesignPoint_PowerIn.inlet, splitterN.outlets[3]) annotation (Line(
      points={{-10,0},{-44,0},{-44,30.25},{-52,30.25}},
      color={28,108,200},
      thickness=0.5));
  connect(pump_directParamWithHeatPort.inlet, splitterN.outlets[2]) annotation (Line(
      points={{-10,-40},{-46,-40},{-46,29.75},{-52,29.75}},
      color={28,108,200},
      thickness=0.5));
  connect(pump_directParamPowerIn.inlet, splitterN.outlets[1]) annotation (Line(
      points={{-10,-90},{-48,-90},{-48,29.25},{-52,29.25}},
      color={28,108,200},
      thickness=0.5));
  connect(pump_directParamPowerIn.outlet, junctionN.inlets[1]) annotation (Line(
      points={{10,-90},{52,-90},{52,29.25},{60,29.25}},
      color={28,108,200},
      thickness=0.5));
  connect(pump_directParamWithHeatPort.outlet, junctionN.inlets[2]) annotation (Line(
      points={{10,-40},{48,-40},{48,29.75},{60,29.75}},
      color={28,108,200},
      thickness=0.5));
  connect(pump_defaultDesignPoint_PowerIn.outlet, junctionN.inlets[3])
    annotation (Line(
      points={{10,0},{40,0},{40,30.25},{60,30.25}},
      color={28,108,200},
      thickness=0.5));
  connect(pump_defaultDesignPoint.outlet, junctionN.inlets[4])
    annotation (Line(
      points={{10,30},{60,30},{60,30.75}},
      color={28,108,200},
      thickness=0.5));
  connect(fixedTemperature.port, pump_directParamWithHeatPort.heatport)
    annotation (Line(points={{-20,-60},{-6,-60},{-6,-50}}, color={191,0,0}));
  connect(pump4_speed_rad_s.y, pump_designPointOmega100.omega_input)
    annotation (Line(points={{-19,100},{0,100},{0,92}}, color={0,0,127}));
  connect(source1.outlet, pump_designPointOmega100.inlet)
    annotation (Line(
      points={{-80,80},{-10,80}},
      color={28,108,200},
      thickness=0.5));
  connect(pump_designPointOmega100.outlet, sink1.inlet)
    annotation (Line(
      points={{10,80},{96,80}},
      color={28,108,200},
      thickness=0.5));
  connect(pump_designPointOmega100.output_val, show_v_flow_pump4_L_min.numberPort)
    annotation (Line(points={{6,91},{6,100},{18.5,100}}, color={0,0,127}));
  connect(pump_directParamPowerIn.output_val, show_cp_flow_pump3_J_Ks.numberPort)
    annotation (Line(points={{6,-101},{6,-110},{18.5,-110}}, color={0,0,127}));
  annotation (
    experiment(StopTime=30, Tolerance=1e-6, Interval=0.03),
        Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Changed <code>pump.initM_flow</code> from <code>acceleration</code> to <code>state</code>.<br>
      Introduced new version of <code>dp_tau_const_isentrop</code> pump function.
    </li>
  </ul>
</html>"),
    Diagram(coordinateSystem(extent={{-120,-120},{120,120}})));
end Pump;
