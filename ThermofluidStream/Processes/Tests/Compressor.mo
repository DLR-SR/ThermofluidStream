within ThermofluidStream.Processes.Tests;
model Compressor "Test for compressors"
  extends Modelica.Icons.Example;

  import tf = ThermofluidStream;

  replaceable package medium =
      ThermofluidStream.Media.myMedia.CompressibleLiquids.LinearWater_pT_Ambient
                                                                           "Medium model" annotation (Documentation(info="<html>
<p><span style=\"font-size: 12pt;\">Medium model for the test. Should be an ideal gas or close to that.</span></p>
</html>"));                                                                                         // ThermofluidStream.myMedia.Air.SimpleAir;


  tf.Boundaries.Source source(
    redeclare package Medium = medium,
    T0_par=300,
    p0_par=100000)
    annotation (Placement(transformation(extent={{-100,6},{-80,26}})));
  tf.Boundaries.Sink sink(
    redeclare package Medium = medium,
    pressureFromInput=false,
    p0_par=300000)
    annotation (Placement(transformation(extent={{86,6},{106,26}})));

  inner tf.DropOfCommons dropOfCommons(L=1, stopOnFailedAssert=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={68,-78})));

  tf.Processes.Compressor compressor(
    redeclare package Medium = medium,
    L=1e6,
    m_flowStateSelect=StateSelect.never,
    omega_from_input=true,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=-1,
    redeclare function dp_tau_compressor =
        tf.Processes.Internal.TurboComponent.dp_tau_const_isentrop (
        redeclare package Medium = medium,
		omega_ref=3000,
        skew=1,
        m_flow_ref=1))
                annotation (Placement(transformation(extent={{-6,10},{14,30}})));
  Modelica.Blocks.Sources.Constant const(k=6000)
    annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
  tf.Processes.Compressor compressor1(
    redeclare package Medium = medium,
    omega_from_input=false,
    J_p=2,
    m_flow_reg=0.001,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    initOmega=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    omega_0=-150,
    initPhi=true,
    redeclare function dp_tau_compressor =
        tf.Processes.Internal.TurboComponent.dp_tau_const_isentrop (
        redeclare package Medium = medium,
		omega_ref=500,
        skew=1,
        m_flow_ref=0.01,
        eta=0.8,
        V_ref=0.0001)) annotation (Placement(transformation(extent={{-6,-30},{14,-10}})));
  Power power1(P=50000, tau_max=300)
    annotation (Placement(transformation(extent={{-28,-50},{-8,-30}})));
  tf.Topology.SplitterN splitterN(N=2, redeclare package Medium = medium)
    annotation (Placement(transformation(extent={{-74,6},{-54,26}})));
  tf.Topology.JunctionN junctionN(N=2, redeclare package Medium = medium)
    annotation (Placement(transformation(extent={{60,6},{80,26}})));

equation

  connect(compressor.omega_input, const.y)
    annotation (Line(points={{4,10},{4,0},{-7,0}},    color={0,0,127}));
  connect(power1.flange, compressor1.flange)
    annotation (Line(points={{-10.4,-40},{4,-40},{4,-30}},
                                                        color={0,0,0}));
  connect(splitterN.inlet, source.outlet) annotation (Line(
      points={{-74,16},{-80,16}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, junctionN.outlet) annotation (Line(
      points={{86,16},{80,16}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.inlet, splitterN.outlets[2]) annotation (Line(
      points={{-6,20},{-30,20},{-30,17},{-54,17}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor1.inlet, splitterN.outlets[1]) annotation (Line(
      points={{-6,-20},{-32,-20},{-32,15},{-54,15}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor1.outlet, junctionN.inlets[1]) annotation (Line(
      points={{14,-20},{38,-20},{38,15},{60,15}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.outlet, junctionN.inlets[2]) annotation (Line(
      points={{14,20},{38,20},{38,17},{60,17}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    experiment(StopTime=30, Tolerance=1e-5),
        Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end Compressor;
