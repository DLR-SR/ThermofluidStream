within ThermofluidStream.Undirected.Processes.Tests;
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

  ThermofluidStream.Undirected.Processes.ConductionElement conductionElement(
    redeclare package Medium = Medium,
    L=0.2,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=-1,
    V(displayUnit="l") = 0.001,
    A=35,
    U=500,
    init=ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.T,
    T_0=263.15) annotation (Placement(transformation(extent={{-10,60},{10,80}})));

  Boundaries.BoundaryFore boundary_fore(
    redeclare package Medium = Medium,
    T0_par=328.15,
    p0_par=100000) annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Boundaries.BoundaryRear boundary_rear(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par=288.15) annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Modelica.Blocks.Sources.Step step(
    height=2e2,
    offset=0.999e5,
    startTime=0.33)
    annotation (Placement(transformation(extent={{-70,60},{-50,80}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=373.15)
    annotation (Placement(transformation(extent={{80,50},{60,70}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  ThermofluidStream.Undirected.Processes.ConductionElement conductionElement1(
    redeclare package Medium = Medium,
    L=0.2,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    V(displayUnit="l") = 0.001,
    A=35,
    U=500,
    init=ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.h,
    T_0=263.15,
    h_0=1000,
    neglectPressureChanges=false) annotation (Placement(transformation(extent={{-10,30},{10,50}})));

  Boundaries.BoundaryFore boundary_fore1(
    redeclare package Medium = Medium,
    T0_par=328.15,
    p0_par=100000) annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Boundaries.BoundaryRear boundary_rear1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par=288.15) annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=2e2,
    duration=0.001,
    offset=0.999e5,
    startTime=0.33)
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  ThermofluidStream.Undirected.Processes.ConductionElement conductionElement2(
    redeclare package Medium = Medium,
    L=0.2,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=-1,
    V(displayUnit="l") = 0.001,
    enforce_global_energy_conservation=true,
    A=35,
    U=500,
    init=ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.fore,
    T_0=263.15) annotation (Placement(transformation(extent={{-10,0},{10,20}})));

  Boundaries.BoundaryFore boundary_fore2(
    redeclare package Medium = Medium,
    T0_par=328.15,
    p0_par=100000) annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Boundaries.BoundaryRear boundary_rear2(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par=288.15) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.Step step1(
    height=2e2,
    offset=0.999e5,
    startTime=0.33)
    annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
  ThermofluidStream.Undirected.Processes.ConductionElement conductionElement3(
    redeclare package Medium = Medium,
    L=0.2,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=-1,
    V(displayUnit="l") = 0.001,
    A=35,
    U=500,
    init=ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.rear,
    T_0=263.15) annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));

  Boundaries.BoundaryFore boundary_fore3(
    redeclare package Medium = Medium,
    T0_par=328.15,
    p0_par=100000) annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  Boundaries.BoundaryRear boundary_rear3(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par=288.15) annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Blocks.Sources.Step step2(
    height=2e2,
    offset=0.999e5,
    startTime=0.33)
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  ThermofluidStream.Undirected.Processes.ConductionElement conductionElement4(
    redeclare package Medium = Medium,
    L=0.2,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    V(displayUnit="l") = 0.001,
    enforce_global_energy_conservation=true,
    A=35,
    U=500,
    init=ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.port,
    T_0=263.15) annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));

  Boundaries.BoundaryFore boundary_fore4(
    redeclare package Medium = Medium,
    T0_par=328.15,
    p0_par=100000) annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  Boundaries.BoundaryRear boundary_rear4(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par=288.15) annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Blocks.Sources.Step step3(
    height=2e2,
    offset=0.999e5,
    startTime=0.33)
    annotation (Placement(transformation(extent={{-70,-60},{-50,-40}})));
  ThermofluidStream.Undirected.Processes.ConductionElement conductionElement5(
    redeclare package Medium = Medium,
    L=0.2,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=-1,
    V(displayUnit="l") = 0.001,
    A=35,
    U=500,
    init=ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.port,
    T_0=263.15) annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));

  Boundaries.BoundaryFore boundary_fore5(
    redeclare package Medium = Medium,
    T0_par=328.15,
    p0_par=100000) annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
  Boundaries.BoundaryRear boundary_rear5(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par=288.15) annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  Modelica.Blocks.Sources.Step step4(
    height=2e2,
    offset=0.999e5,
    startTime=0.33)
    annotation (Placement(transformation(extent={{-70,-90},{-50,-70}})));
equation
  connect(step.y, boundary_rear.p0_var) annotation (Line(points={{-49,70},{-40,70},{-40,76},{-32,76}},
                                          color={0,0,127}));
  connect(conductionElement.rear, boundary_rear.fore) annotation (Line(
      points={{-10,70},{-20,70}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement.fore, boundary_fore.rear) annotation (Line(
      points={{10,70},{20,70}},
      color={28,108,200},
      thickness=0.5));
  connect(ramp.y, boundary_rear1.p0_var) annotation (Line(points={{-49,40},{-40,40},{-40,46},{-32,46}},
                                                                                        color={0,0,127}));
  connect(conductionElement1.rear, boundary_rear1.fore)
    annotation (Line(
      points={{-10,40},{-20,40}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement1.fore, boundary_fore1.rear) annotation (Line(
      points={{10,40},{20,40}},
      color={28,108,200},
      thickness=0.5));
  connect(step1.y, boundary_rear2.p0_var) annotation (Line(points={{-49,10},{-40,10},{-40,16},{-32,16}},
                                                                                       color={0,0,127}));
  connect(conductionElement2.rear, boundary_rear2.fore) annotation (Line(
      points={{-10,10},{-20,10}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement2.fore, boundary_fore2.rear) annotation (Line(
      points={{10,10},{20,10}},
      color={28,108,200},
      thickness=0.5));
  connect(step2.y, boundary_rear3.p0_var) annotation (Line(points={{-49,-20},{-40,-20},{-40,-14},{-32,-14}},
                                                                                         color={0,0,127}));
  connect(conductionElement3.rear, boundary_rear3.fore)
    annotation (Line(
      points={{-10,-20},{-20,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement3.fore, boundary_fore3.rear) annotation (Line(
      points={{10,-20},{20,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(step3.y, boundary_rear4.p0_var) annotation (Line(points={{-49,-50},{-40,-50},{-40,-44},{-32,-44}},
                                                                                         color={0,0,127}));
  connect(conductionElement4.rear, boundary_rear4.fore)
    annotation (Line(
      points={{-10,-50},{-20,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement4.fore, boundary_fore4.rear) annotation (Line(
      points={{10,-50},{20,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(step4.y, boundary_rear5.p0_var) annotation (Line(points={{-49,-80},{-40,-80},{-40,-74},{-32,-74}},
                                                                                         color={0,0,127}));
  connect(conductionElement5.rear, boundary_rear5.fore)
    annotation (Line(
      points={{-10,-80},{-20,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement5.fore, boundary_fore5.rear) annotation (Line(
      points={{10,-80},{20,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(fixedTemperature.port, conductionElement1.heatPort) annotation (Line(points={{60,60},{40,60},{40,56},{0,56},{0,49.8}}, color={191,0,0}));
  connect(conductionElement.heatPort, conductionElement1.heatPort)
    annotation (Line(points={{0,79.8},{0,88},{40,88},{40,56},{0,56},{0,49.8}}, color={191,0,0}));
  connect(conductionElement2.heatPort, conductionElement1.heatPort)
    annotation (Line(points={{0,19.8},{0,26},{40,26},{40,56},{0,56},{0,49.8}}, color={191,0,0}));
  connect(conductionElement3.heatPort, conductionElement1.heatPort)
    annotation (Line(points={{0,-10.2},{0,-4},{40,-4},{40,56},{0,56},{0,49.8}}, color={191,0,0}));
  connect(conductionElement4.heatPort, conductionElement1.heatPort)
    annotation (Line(points={{0,-40.2},{0,-34},{40,-34},{40,56},{0,56},{0,49.8}}, color={191,0,0}));
  connect(conductionElement5.heatPort, conductionElement1.heatPort)
    annotation (Line(points={{0,-70.2},{0,-66},{40,-66},{40,56},{0,56},{0,49.8}}, color={191,0,0}));
  annotation (experiment(StopTime=1, Tolerance=1e-6, Interval=0.001),
  Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end ConductionElement;
