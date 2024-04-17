within ThermofluidStream.Boundaries.Tests;
model Reservoir "Test for Reservoir"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.CompressibleLiquids.LinearColdWater
    constrainedby Media.myMedia.Interfaces.PartialMedium
    "Medium Model"
    annotation(choicesAllMatching=true, Documentation(info="<html>
<p>Medium Model for the test. Be aware that the Component is mainly meant for liquids with low compressablility.</p>
</html>"));

  inner DropOfCommons dropOfCommons(assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  ThermofluidStream.Boundaries.Reservoir reservoir(redeclare package Medium=Medium,
    pEnvFromInput=true,
    A_surf=0.01,
    T_start=293.15,
    height_0=0.1)
    annotation (Placement(transformation(extent={{-14,-66},{6,-46}})));
  ThermofluidStream.Boundaries.Reservoir reservoir1(redeclare package Medium=Medium,
    A_surf=0.05,
    T_start(displayUnit="degC") = 293.15,
    height_0(displayUnit="m") = 0.05)
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Processes.Pump pump(redeclare package Medium=Medium,
    initM_flow= ThermofluidStream.Utilities.Types.InitializationMethods.state,
    omega_from_input=true,
    redeclare function dp_tau_pump =
        Processes.Internal.TurboComponent.dp_tau_nominal_flow (
        V_r_input(displayUnit="m3") = 0.1,
        k_p_input=500,
        k_fric_input=0))
    annotation (Placement(transformation(extent={{34,10},{54,30}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium=Medium,
    r=0.03,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{10,50},{-10,70}})));
  Source source(redeclare package Medium=Medium, p0_par=101200)
    annotation (Placement(transformation(extent={{-74,-66},{-54,-46}})));
  Sink sink(redeclare package Medium=Medium, p0_par=101000)
    annotation (Placement(transformation(extent={{44,-66},{64,-46}})));
  Modelica.Blocks.Sources.Constant const(k=320)
    annotation (Placement(transformation(extent={{8,-12},{28,8}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=2e2,
    duration=0.01,
    offset=1e5,
    startTime=3)
    annotation (Placement(transformation(extent={{-80,-28},{-60,-8}})));
  Processes.ConductionElement conductionElement(
    redeclare package Medium = Medium,
    V=0.001,
    A=10,
    U=300,
    T_0=293.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-28,42})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow=1e6)
    annotation (Placement(transformation(extent={{-78,32},{-58,52}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=100))
    annotation (Placement(transformation(extent={{-46,-66},{-26,-46}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=100))
    annotation (Placement(transformation(extent={{16,-66},{36,-46}})));
equation
  connect(pump.inlet, reservoir1.outlet) annotation (Line(
      points={{34,20},{10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.outlet, flowResistance.inlet) annotation (Line(
      points={{54,20},{60,20},{60,60},{10,60}},
      color={28,108,200},
      thickness=0.5));
  connect(const.y, pump.omega_input)
    annotation (Line(points={{29,-2},{44,-2},{44,8}},  color={0,0,127}));


  connect(flowResistance.outlet, conductionElement.inlet)
    annotation (Line(
      points={{-10,60},{-28,60},{-28,52}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement.outlet, reservoir1.inlet)
    annotation (Line(
      points={{-28,32},{-28,20},{-10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(fixedHeatFlow.port, conductionElement.heatPort) annotation (Line(points={{-58,42},{-38,42},{-38,42}},     color={191,0,0}));
  connect(reservoir.inlet, flowResistance1.outlet) annotation (Line(
      points={{-14,-56},{-26,-56}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, flowResistance1.inlet) annotation (Line(
      points={{-54,-56},{-46,-56}},
      color={28,108,200},
      thickness=0.5));
  connect(reservoir.outlet, flowResistance2.inlet) annotation (Line(
      points={{6,-56},{16,-56}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, flowResistance2.outlet) annotation (Line(
      points={{44,-56},{36,-56}},
      color={28,108,200},
      thickness=0.5));
  connect(ramp.y, reservoir.pEnv_input) annotation (Line(points={{-59,-18},{-4,-18},{-4,-44.1}}, color={0,0,127}));
  annotation (experiment(
      StopTime=10,
   Tolerance=1e-6,
   Interval=0.01,
      __Dymola_Algorithm="Dassl"),
  Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end Reservoir;
