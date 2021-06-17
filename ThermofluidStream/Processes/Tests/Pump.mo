within ThermofluidStream.Processes.Tests;
model Pump "Test for pumps"
  extends Modelica.Icons.Example;

  import tf = ThermofluidStream;
  replaceable package Medium =
      tf.Media.myMedia.CompressibleLiquids.LinearWater_pT_Ambient
                                                            constrainedby tf.Media.myMedia.Interfaces.PartialMedium
                                                   "Medium model"
    annotation (
      choicesAllMatching=true,
      Documentation(info="<html>
        <p><span style=\"font-size: 12pt;\">Medium model for the test. Should be incompressible or with low compressibility.</span></p>
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
    m_acceleraton_0=0.2,
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
        tf.Processes.Internal.TurboComponent.dp_tau_nominal_flow (                             V_r=0.0001, k_p=1e7))
    annotation (Placement(transformation(extent={{-2,-18},{18,2}})));
  Modelica.Blocks.Sources.Constant const1(k=500)
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
        tf.Processes.Internal.TurboComponent.dp_tau_nominal_flow (                             V_r=0.0001, k_p=1e8))
    annotation (Placement(transformation(extent={{-2,-56},{18,-36}})));
  tf.Processes.Tests.Power power2(P=5000, tau_max=150)
    annotation (Placement(transformation(extent={{-24,-78},{-4,-58}})));

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        283.15) annotation (Placement(transformation(extent={{60,0},{40,20}})));
equation

  connect(pump.omega_input, const.y)
    annotation (Line(points={{8,62},{8,52},{-3,52}},     color={0,0,127}));
  connect(power1.flange, pump1.flange)
    annotation (Line(points={{-6.4,12},{8,12},{8,22}},     color={0,0,0}));
  connect(splitterN.inlet, source.outlet) annotation (Line(
      points={{-70,68},{-82,68}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, junctionN.outlet) annotation (Line(
      points={{82,68},{68,68}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.inlet, splitterN.outlets[4]) annotation (Line(
      points={{-2,72},{-32,72},{-32,69.5},{-50,69.5}},
      color={28,108,200},
      thickness=0.5));
  connect(pump2.omega_input, const1.y)
    annotation (Line(points={{8,-18},{8,-28},{-3,-28}},  color={0,0,127}));
  connect(power2.flange,pump3. flange)
    annotation (Line(points={{-6.4,-68},{8,-68},{8,-56}},  color={0,0,0}));
  connect(pump1.inlet, splitterN.outlets[3]) annotation (Line(
      points={{-2,32},{-30,32},{-30,68.5},{-50,68.5}},
      color={28,108,200},
      thickness=0.5));
  connect(pump2.inlet, splitterN.outlets[2]) annotation (Line(
      points={{-2,-8},{-32,-8},{-32,67.5},{-50,67.5}},
      color={28,108,200},
      thickness=0.5));
  connect(pump3.inlet, splitterN.outlets[1]) annotation (Line(
      points={{-2,-46},{-34,-46},{-34,66.5},{-50,66.5}},
      color={28,108,200},
      thickness=0.5));
  connect(pump3.outlet, junctionN.inlets[1]) annotation (Line(
      points={{18,-46},{30,-46},{30,66.5},{48,66.5}},
      color={28,108,200},
      thickness=0.5));
  connect(pump2.outlet, junctionN.inlets[2]) annotation (Line(
      points={{18,-8},{28,-8},{28,67.5},{48,67.5}},
      color={28,108,200},
      thickness=0.5));
  connect(pump1.outlet, junctionN.inlets[3]) annotation (Line(
      points={{18,32},{26,32},{26,68.5},{48,68.5}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.outlet, junctionN.inlets[4]) annotation (Line(
      points={{18,72},{28,72},{28,69.5},{48,69.5}},
      color={28,108,200},
      thickness=0.5));
  connect(fixedTemperature.port, pump2.heatport)
    annotation (Line(points={{40,10},{8,10},{8,2}}, color={191,0,0}));
  annotation (
    experiment(StopTime=30),
        Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end Pump;
