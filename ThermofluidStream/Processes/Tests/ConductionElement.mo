within ThermofluidStream.Processes.Tests;
model ConductionElement "Test for ConductionElement"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Incompressible.Examples.Glycol47
    constrainedby Media.myMedia.Interfaces.PartialMedium
    "Medium Model"
    annotation(choicesAllMatching=true, Documentation(info="<html>
<p>
Medium Model for the test. Be aware that the Component is mainly
meant for liquids with low compressablility.
</p>
</html>"));

  ThermofluidStream.Processes.ConductionElement conductionElement(
    redeclare package Medium = Medium,
    L=0.2,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    V(displayUnit="l") = 0.001,
    A=35,
    U=500,
    init=ThermofluidStream.Processes.Internal.InitializationMethodsCondElement.T,
    T_0=263.15) annotation (Placement(transformation(extent={{-10,62},{10,42}})));
  Boundaries.Sink sink(redeclare package Medium=Medium,
    p0_par=100000,
    L=dropOfCommons.L/3)
    annotation (Placement(transformation(extent={{60,0},{80,20}})));
  Boundaries.Source source(redeclare package Medium=Medium,pressureFromInput=true,
    T0_par=288.15,
    L=dropOfCommons.L/3)
    annotation (Placement(transformation(extent={{-78,0},{-58,20}})));
  Modelica.Blocks.Sources.Step step(
    height=1e2,
    offset=1.000001e5,
    startTime=0.5)
    annotation (Placement(transformation(extent={{-100,-1},{-80,19}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=373.15)
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  inner DropOfCommons dropOfCommons(assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
  ThermofluidStream.Processes.ConductionElement conductionElement1(
    redeclare package Medium = Medium,
    L=0.2,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    V(displayUnit="l") = 0.001,
    enforce_global_energy_conservation=true,
    A=35,
    U=500,
    init=ThermofluidStream.Processes.Internal.InitializationMethodsCondElement.h,
    T_0=263.15,
    h_0=7e4) annotation (Placement(transformation(extent={{-10,20},{10,0}})));
  ThermofluidStream.Processes.ConductionElement conductionElement2(
    redeclare package Medium = Medium,
    L=0.2,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    V(displayUnit="l") = 0.001,
    A=35,
    U=500,
    init=ThermofluidStream.Processes.Internal.InitializationMethodsCondElement.inlet,
    T_0=263.15,
    h_0=7e4) annotation (Placement(transformation(extent={{-10,-18},{10,-38}})));
  Topology.SplitterX splitterX(redeclare package Medium = Medium, L=0) annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Topology.JunctionX3 junctionX3_1(
    redeclare package Medium = Medium,
    assumeConstantDensity=true,
    L=0) annotation (Placement(transformation(extent={{30,0},{50,20}})));
  Boundaries.Source source1(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    T0_par=288.15,
    p0_par=80000,
    L=dropOfCommons.L/3)
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  ThermofluidStream.Processes.ConductionElement conductionElement3(
    redeclare package Medium = Medium,
    L=0.2,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    V(displayUnit="l") = 0.001,
    enforce_global_energy_conservation=true,
    A=35,
    U=500,
    init=ThermofluidStream.Processes.Internal.InitializationMethodsCondElement.inlet,
    T_0=263.15,
    h_0=7e4) annotation (Placement(transformation(extent={{-10,-50},{10,-70}})));
  Boundaries.Sink sink1(
    redeclare package Medium = Medium,
    p0_par=100000,
    L=dropOfCommons.L/3)
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  Boundaries.Source source2(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par=288.15,
    p0_par=80000,
    L=dropOfCommons.L/3)
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  ThermofluidStream.Processes.ConductionElement conductionElement4(
    redeclare package Medium = Medium,
    L=0.2,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    V(displayUnit="l") = 0.001,
    A=35,
    U=500,
    init=ThermofluidStream.Processes.Internal.InitializationMethodsCondElement.inlet,
    T_0=263.15,
    h_0=7e4,
    neglectPressureChanges=false) annotation (Placement(transformation(extent={{-10,-80},{10,-100}})));
  Boundaries.Sink sink2(
    redeclare package Medium = Medium,
    p0_par=100000,
    L=dropOfCommons.L/3)
    annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1e7,
    duration=0.02,
    offset=1e5,
    startTime=0.5) annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  FlowResistance flowResistance(
    redeclare package Medium = Medium,
    r(displayUnit="mm") = 0.003,
    l=10,
    redeclare function pLoss =
        Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
equation
  connect(step.y, source.p0_var) annotation (Line(points={{-79,9},{-74,9},{-74,16},{-70,16}},
                         color={0,0,127}));
  connect(fixedTemperature.port, conductionElement.heatPort) annotation (Line(points={{-40,80},{-20,80},{-20,70},{0,70},{0,62}},   color={191,0,0}));
  connect(conductionElement1.inlet, splitterX.outletC) annotation (Line(
      points={{-10,10},{-30,10}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, junctionX3_1.outlet) annotation (Line(
      points={{60,10},{50,10}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionX3_1.inletB, conductionElement1.outlet) annotation (Line(
      points={{30,10},{10,10}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, splitterX.inlet) annotation (Line(
      points={{-58,10},{-50,10}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterX.outletA, conductionElement.inlet)
    annotation (Line(
      points={{-40,20},{-40,52},{-10,52}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterX.outletB, conductionElement2.inlet)
    annotation (Line(
      points={{-40,0},{-40,-28},{-10,-28}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement2.outlet, junctionX3_1.inletC)
    annotation (Line(
      points={{10,-28},{40,-28},{40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement.outlet, junctionX3_1.inletA)
    annotation (Line(
      points={{10,52},{40,52},{40,20}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement2.heatPort, conductionElement.heatPort)
    annotation (Line(points={{0,-18},{0,-10},{-20,-10},{-20,70},{0,70},{0,62}},     color={191,0,0}));
  connect(conductionElement1.heatPort, conductionElement.heatPort)
    annotation (Line(points={{0,20},{0,30},{-20,30},{-20,70},{0,70},{0,62}},     color={191,0,0}));
  connect(source1.outlet, conductionElement3.inlet) annotation (Line(
      points={{-60,-60},{-10,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement3.outlet, sink1.inlet) annotation (Line(
      points={{10,-60},{60,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement3.heatPort, conductionElement.heatPort)
    annotation (Line(points={{0,-50},{0,-42},{-20,-42},{-20,70},{0,70},{0,62}},     color={191,0,0}));
  connect(source2.outlet, conductionElement4.inlet) annotation (Line(
      points={{-60,-90},{-10,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement4.heatPort, conductionElement.heatPort)
    annotation (Line(points={{0,-80},{0,-72},{-20,-72},{-20,70},{0,70},{0,62}},     color={191,0,0}));
  connect(source2.p0_var, ramp.y) annotation (Line(points={{-72,-84},{-76,-84},{-76,-90},{-79,-90}},
                                                                                 color={0,0,127}));
  connect(conductionElement4.outlet, flowResistance.inlet)
    annotation (Line(
      points={{10,-90},{20,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(sink2.inlet, flowResistance.outlet) annotation (Line(
      points={{60,-90},{40,-90}},
      color={28,108,200},
      thickness=0.5));
  annotation (experiment(StopTime=1, Tolerance=1e-6, Interval=0.001),
  Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end ConductionElement;
