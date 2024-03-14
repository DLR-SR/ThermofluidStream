within ThermofluidStream.Processes.Tests;
model Turbine "Test for turbines"
  extends Modelica.Icons.Example;

  import tf = ThermofluidStream;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir "Medium model"
    annotation (Documentation(info="<html>
<p>
Medium model for the test. Should be an ideal gas or close to that.
</p>
</html>"));

  tf.Boundaries.Source source(
    redeclare package Medium = Medium,
    T0_par=300,
    p0_par=300000)
    annotation (Placement(transformation(extent={{-100,6},{-80,26}})));
  tf.Boundaries.Sink sink(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    p0_par=100000)
    annotation (Placement(transformation(extent={{86,6},{106,26}})));

  inner tf.DropOfCommons dropOfCommons(L=1, assertionLevel = AssertionLevel.warning,
    displayParameters=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={68,-78})));

  tf.Processes.Turbine turbine(
    redeclare package Medium = Medium,
    L=1e6,
    omega_from_input=true,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=1e-5,
    redeclare function dp_tau_turbine =
        tf.Processes.Internal.TurboComponent.dp_tau_const_isentrop (omega_ref=1e6))
    annotation (Placement(transformation(extent={{-6,10},{14,30}})));
  Modelica.Blocks.Sources.Constant const(k=1000)
    annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
  tf.Topology.SplitterN splitterN(N=2, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-66,6},{-46,26}})));
  tf.Topology.JunctionN junctionN(N=2, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{46,6},{66,26}})));
  tf.Processes.Turbine turbine1(
    redeclare package Medium = Medium,
    L=1e5,
    omega_from_input=false,
    J_p=1,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    initOmega=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    omega_0=-1,
    initPhi=true,
    redeclare function dp_tau_turbine =
        tf.Processes.Internal.TurboComponent.dp_tau_const_isentrop (omega_ref=1e6, eta=1))
    annotation (Placement(transformation(extent={{-8,-38},{12,-18}})));
  Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque
    linearSpeedDependentTorque(
    tau_nominal=-1,
    TorqueDirection=false,
    w_nominal=1)
    annotation (Placement(transformation(extent={{-54,-72},{-34,-52}})));

equation
  connect(turbine.omega_input, const.y) annotation (Line(points={{4,8},{4,0},{-7,0}},  color={0,0,127}));
  connect(source.outlet, splitterN.inlet) annotation (Line(
      points={{-80,16},{-66,16}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, junctionN.outlet) annotation (Line(
      points={{86,16},{66,16}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionN.inlets[2], turbine.outlet) annotation (Line(
      points={{46,16.5},{30,16.5},{30,20},{14,20}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterN.outlets[2], turbine.inlet) annotation (Line(
      points={{-46,16.5},{-26,16.5},{-26,20},{-6,20}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine1.inlet, splitterN.outlets[1]) annotation (Line(
      points={{-8,-28},{-34,-28},{-34,15.5},{-46,15.5}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine1.outlet, junctionN.inlets[1]) annotation (Line(
      points={{12,-28},{30,-28},{30,15.5},{46,15.5}},
      color={28,108,200},
      thickness=0.5));
  connect(linearSpeedDependentTorque.flange, turbine1.flange)
    annotation (Line(points={{-34,-62},{2,-62},{2,-38}}, color={0,0,0}));
  annotation (
    experiment(StopTime=30, Tolerance=1e-6, Interval=0.03),
        Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end Turbine;
