within ThermofluidStream.FlowControl.Tests;
model PCV "Test for PCV"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium package"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Test.
</p>
</html>"));

  inner ThermofluidStream.DropOfCommons dropOfCommons(assertionLevel=AssertionLevel.warning)
    annotation (Placement(transformation(extent={{70,-88},{90,-68}})));
  ThermofluidStream.FlowControl.PCV pCV(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=2,
    pressure_set_par(displayUnit="Pa") = 20000) annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  ThermofluidStream.Boundaries.VolumeFlex
                                      volumeFlex2(
    redeclare package Medium = Medium,
    useInlet=false,
    p_start=200000,
    T_start=373.15,
    p_ref=100000,
    V_ref=0.1) annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
  ThermofluidStream.Boundaries.VolumeFlex
                                    volumeFlex(
    redeclare package Medium = Medium,
    useOutlet=false,
    V_ref=0.1)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  ThermofluidStream.FlowControl.PCV pCV1(
    redeclare package Medium = Medium,
    L=10,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.PressureControlValveMode.outlet,
    pressure_set_par=150000) annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  ThermofluidStream.Boundaries.VolumeFlex
                                    volumeFlex1(
    redeclare package Medium = Medium,
    useOutlet=false,
    V_ref=0.1)
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    r(displayUnit="mm") = 0.02,
    l=3,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{10,-50},{30,-30}})));
  ThermofluidStream.Boundaries.VolumeFlex
                                      volumeFlex3(
    redeclare package Medium = Medium,
    useInlet=false,
    p_start=200000,
    T_start=373.15,
    p_ref=100000,
    V_ref=0.1) annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
  ThermofluidStream.Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    r(displayUnit="mm") = 0.02,
    l=3,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{10,-20},{30,0}})));
  ThermofluidStream.Boundaries.Source source(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
  ThermofluidStream.Processes.FlowResistance flowResistance3(
    redeclare package Medium = Medium,
    m_flow_0=10,
    r(displayUnit="mm") = 0.02,
    l=3,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  ThermofluidStream.FlowControl.PCV pCV2(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=10,
    pressure_set_par(displayUnit="Pa") = 20000) annotation (Placement(transformation(extent={{10,-80},{30,-60}})));
  ThermofluidStream.Boundaries.Source source1(redeclare package Medium = Medium, p0_par=200000)
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  ThermofluidStream.Boundaries.Sink sink1(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{40,10},{60,30}})));
  ThermofluidStream.Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    m_flow_0=10,
    r(displayUnit="mm") = 0.02,
    l=3,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{10,10},{30,30}})));
  ThermofluidStream.FlowControl.PCV pCV3(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=10,
    pressureFromInput=true,
    pressure_set_par(displayUnit="Pa")) annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  ThermofluidStream.Boundaries.Source source2(redeclare package Medium = Medium, p0_par=200000)
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
  ThermofluidStream.Boundaries.Sink sink2(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{40,50},{60,70}})));
  ThermofluidStream.Processes.FlowResistance flowResistance4(
    redeclare package Medium = Medium,
    m_flow_0=10,
    r(displayUnit="mm") = 0.02,
    l=3,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{10,50},{30,70}})));
  ThermofluidStream.FlowControl.PCV pCV4(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=10,
    mode=ThermofluidStream.FlowControl.Internal.Types.PressureControlValveMode.outlet,
    pressureFromInput=true,
    pressure_set_par(displayUnit="bar")) annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=0.5e5,
    duration=0.6,
    offset=1.5e5,
    startTime=0.1) annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=-0.2e5,
    duration=0.6,
    offset=0.2e5,
    startTime=0.1)
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
equation

  connect(volumeFlex2.outlet, pCV1.inlet) annotation (Line(
      points={{-30,-40},{-20,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(volumeFlex.inlet, flowResistance.outlet) annotation (Line(
      points={{40,-40},{30,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.inlet, pCV1.outlet) annotation (Line(
      points={{10,-40},{0,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(volumeFlex3.outlet, pCV.inlet) annotation (Line(
      points={{-30,-10},{-20,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(volumeFlex1.inlet, flowResistance1.outlet) annotation (Line(
      points={{40,-10},{30,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.inlet, pCV.outlet) annotation (Line(
      points={{10,-10},{0,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, flowResistance3.inlet) annotation (Line(
      points={{-30,-70},{-20,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.outlet, pCV2.inlet) annotation (Line(
      points={{0,-70},{10,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(pCV2.outlet, sink.inlet) annotation (Line(
      points={{30,-70},{40,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, pCV3.inlet) annotation (Line(
      points={{-30,20},{-20,20}},
      color={28,108,200},
      thickness=0.5));
  connect(pCV3.outlet, flowResistance2.inlet) annotation (Line(
      points={{0,20},{10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, sink1.inlet) annotation (Line(
      points={{30,20},{40,20}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, pCV4.inlet)
    annotation (Line(
      points={{-30,60},{-20,60}},
      color={28,108,200},
      thickness=0.5));
  connect(pCV4.outlet, flowResistance4.inlet) annotation (Line(
      points={{0,60},{10,60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.outlet, sink2.inlet) annotation (Line(
      points={{30,60},{40,60}},
      color={28,108,200},
      thickness=0.5));
  connect(ramp1.y, pCV3.pressure_set_var) annotation (Line(points={{-49,40},{-10,40},{-10,28}}, color={0,0,127}));
  connect(ramp.y, pCV4.pressure_set_var) annotation (Line(points={{-49,80},{-10,80},{-10,68}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    experiment(
      StopTime=1,
      __Dymola_NumberOfIntervals=1500,
      __Dymola_Algorithm="Dassl"),
        Documentation(info="<html>
<p>Test for the PCV.</p>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end PCV;
