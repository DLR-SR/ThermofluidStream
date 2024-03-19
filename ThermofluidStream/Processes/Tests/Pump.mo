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
    annotation (Placement(transformation(extent={{-102,58},{-82,78}})));
  tf.Boundaries.Sink sink(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    p0_par=350000)
    annotation (Placement(transformation(extent={{82,58},{102,78}})));

  inner tf.DropOfCommons dropOfCommons(L=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={68,-54})));

  ThermofluidStream.Processes.Pump pump(
    redeclare package Medium = Medium,
    L=100000,
    omega_from_input=true,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.derivative,
    m_acceleration_0=0.2,
    redeclare function dp_tau_pump =
        tf.Processes.Internal.TurboComponent.dp_tau_centrifugal)
    annotation (Placement(transformation(extent={{-2,62},{18,82}})));

  Modelica.Blocks.Sources.Constant const(k=800)
    annotation (Placement(transformation(extent={{-24,42},{-4,62}})));
  ThermofluidStream.Processes.Pump pump1(
    redeclare package Medium = Medium,
    L=1000000,
    omega_from_input=false,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    initOmega=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    initPhi=true,
    redeclare function dp_tau_pump =
        tf.Processes.Internal.TurboComponent.dp_tau_centrifugal)
    annotation (Placement(transformation(extent={{-2,22},{18,42}})));
  tf.Processes.Tests.Power power1(P=8000, tau_max=150)
    annotation (Placement(transformation(extent={{-24,2},{-4,22}})));
  tf.Topology.SplitterN splitterN(N=4, redeclare package Medium = Medium,
    L=0)
    annotation (Placement(transformation(extent={{-70,58},{-50,78}})));
  tf.Topology.JunctionN junctionN(N=4, redeclare package Medium = Medium,
    L=0)
    annotation (Placement(transformation(extent={{48,58},{68,78}})));
  tf.Processes.Pump pump2(
    redeclare package Medium = Medium,
    L=10000,
    omega_from_input=true,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    enableAccessHeatPort=true,
    redeclare function dp_tau_pump =
        tf.Processes.Internal.TurboComponent.dp_tau_nominal_flow (
        parametrizeByDesignPoint=false,
        k_p_input=1e7))
    annotation (Placement(transformation(extent={{-2,-18},{18,2}})));
  Modelica.Blocks.Sources.Constant const1(k=3200)
    annotation (Placement(transformation(extent={{-24,-38},{-4,-18}})));
  tf.Processes.Pump pump3(
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
    redeclare function dp_tau_pump =
        tf.Processes.Internal.TurboComponent.dp_tau_nominal_flow (
        parametrizeByDesignPoint=false,
        V_r_input=0.0006,
        k_p_input=1e8))
    annotation (Placement(transformation(extent={{-2,-56},{18,-36}})));
  tf.Processes.Tests.Power power2(P=5000, tau_max=150)
    annotation (Placement(transformation(extent={{-24,-78},{-4,-58}})));

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        283.15) annotation (Placement(transformation(extent={{62,-36},{42,-16}})));
  tf.Processes.Pump pump4(
    redeclare package Medium = Medium,
    L=10000,
    omega_from_input=true,
    enableOutput=true,
    outputQuantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_lpMin,
    J_p=10,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    phi_0=-1745.3292519943,
    redeclare function dp_tau_pump =
        tf.Processes.Internal.TurboComponent.dp_tau_nominal_flow (
        parametrizeByDesignPoint=true,
        omega_D(displayUnit="rad/s") = 100))
    annotation (Placement(transformation(extent={{-10,130},{10,150}})));
  Modelica.Blocks.Sources.Constant const2(k=100)
    annotation (Placement(transformation(extent={{-36,102},{-16,122}})));
  tf.Boundaries.Source source1(
    redeclare package Medium = Medium,
    T0_par=300,
    p0_par=100000)
    annotation (Placement(transformation(extent={{-58,130},{-38,150}})));
  tf.Boundaries.Sink sink1(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    p0_par=600000)
    annotation (Placement(transformation(extent={{34,130},{54,150}})));
equation
  connect(pump.omega_input, const.y)
    annotation (Line(points={{8,60},{8,52},{-3,52}}, color={0,0,127}));
  connect(power1.flange, pump1.flange)
    annotation (Line(points={{-6.4,12},{8,12},{8,22}}, color={0,0,0}));
  connect(splitterN.inlet, source.outlet) annotation (Line(
      points={{-70,68},{-82,68}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, junctionN.outlet) annotation (Line(
      points={{82,68},{68,68}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.inlet, splitterN.outlets[4]) annotation (Line(
      points={{-2,72},{-32,72},{-32,68.75},{-50,68.75}},
      color={28,108,200},
      thickness=0.5));
  connect(pump2.omega_input, const1.y)
    annotation (Line(points={{8,-20},{8,-28},{-3,-28}}, color={0,0,127}));
  connect(power2.flange,pump3. flange)
    annotation (Line(points={{-6.4,-68},{8,-68},{8,-56}}, color={0,0,0}));
  connect(pump1.inlet, splitterN.outlets[3]) annotation (Line(
      points={{-2,32},{-30,32},{-30,68.25},{-50,68.25}},
      color={28,108,200},
      thickness=0.5));
  connect(pump2.inlet, splitterN.outlets[2]) annotation (Line(
      points={{-2,-8},{-32,-8},{-32,67.75},{-50,67.75}},
      color={28,108,200},
      thickness=0.5));
  connect(pump3.inlet, splitterN.outlets[1]) annotation (Line(
      points={{-2,-46},{-34,-46},{-34,67.25},{-50,67.25}},
      color={28,108,200},
      thickness=0.5));
  connect(pump3.outlet, junctionN.inlets[1]) annotation (Line(
      points={{18,-46},{30,-46},{30,67.25},{48,67.25}},
      color={28,108,200},
      thickness=0.5));
  connect(pump2.outlet, junctionN.inlets[2]) annotation (Line(
      points={{18,-8},{28,-8},{28,67.75},{48,67.75}},
      color={28,108,200},
      thickness=0.5));
  connect(pump1.outlet, junctionN.inlets[3]) annotation (Line(
      points={{18,32},{26,32},{26,68.25},{48,68.25}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.outlet, junctionN.inlets[4]) annotation (Line(
      points={{18,72},{28,72},{28,68.75},{48,68.75}},
      color={28,108,200},
      thickness=0.5));
  connect(fixedTemperature.port, pump2.heatport)
    annotation (Line(points={{42,-26},{2,-26},{2,-18}},
                                                    color={191,0,0}));
  connect(const2.y, pump4.omega_input) annotation (Line(points={{-15,112},{0,112},{0,128}}, color={0,0,127}));
  connect(source1.outlet, pump4.inlet) annotation (Line(
      points={{-38,140},{-10,140}},
      color={28,108,200},
      thickness=0.5));
  connect(pump4.outlet, sink1.inlet) annotation (Line(
      points={{10,140},{34,140}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    experiment(StopTime=30, Tolerance=1e-6, Interval=0.03),
        Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end Pump;
