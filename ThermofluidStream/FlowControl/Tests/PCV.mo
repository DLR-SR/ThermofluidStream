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
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
  ThermofluidStream.FlowControl.PCV pCValve3(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=2,
    pressure_set_par(displayUnit="Pa") = 20000) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  ThermofluidStream.Boundaries.VolumeFlex volumeFlex1Valve4(
    redeclare package Medium = Medium,
    useInlet=false,
    p_start=200000,
    T_start=373.15,
    p_ref=100000,
    V_ref=0.1) annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  ThermofluidStream.Boundaries.VolumeFlex volumeFlex2Valve4(
    redeclare package Medium = Medium,
    useOutlet=false,
    V_ref=0.1) annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
  ThermofluidStream.FlowControl.PCV pCValve4(
    redeclare package Medium = Medium,
    L=10,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.PressureControlValveMode.outlet_pressure,
    pressure_set_par=150000) annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  ThermofluidStream.Boundaries.VolumeFlex volumeFlex2Valve3(
    redeclare package Medium = Medium,
    useOutlet=false,
    V_ref=0.1) annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  ThermofluidStream.Processes.FlowResistance flowResValve4(
    redeclare package Medium = Medium,
    r(displayUnit="mm") = 0.02,
    l=3,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss) annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  ThermofluidStream.Boundaries.VolumeFlex volumeFlex1Valve3(
    redeclare package Medium = Medium,
    useInlet=false,
    p_start=200000,
    T_start=373.15,
    p_ref=100000,
    V_ref=0.1) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  ThermofluidStream.Processes.FlowResistance flowResValve3(
    redeclare package Medium = Medium,
    r(displayUnit="mm") = 0.02,
    l=3,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  ThermofluidStream.Boundaries.Source sourceValve5(redeclare package Medium = Medium, p0_par=100000) annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  ThermofluidStream.Boundaries.Sink sinkValve5(redeclare package Medium = Medium, p0_par=100000) annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
  ThermofluidStream.Processes.FlowResistance flowResValve5(
    redeclare package Medium = Medium,
    m_flow_0=10,
    r(displayUnit="mm") = 0.02,
    l=3,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss) annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
  ThermofluidStream.FlowControl.PCV pCValve5(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=10,
    pressure_set_par(displayUnit="Pa") = 20000) annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  ThermofluidStream.Boundaries.Source sourceValve2(redeclare package Medium = Medium, p0_par=200000) annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  ThermofluidStream.Boundaries.Sink sinkValve2(redeclare package Medium = Medium, p0_par=100000) annotation (Placement(transformation(extent={{50,30},{70,50}})));
  ThermofluidStream.Processes.FlowResistance flowResValve2(
    redeclare package Medium = Medium,
    m_flow_0=10,
    r(displayUnit="mm") = 0.02,
    l=3,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss) annotation (Placement(transformation(extent={{20,30},{40,50}})));
  ThermofluidStream.FlowControl.PCV pCValve2(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=10,
    pressureFromInput=true,
    pressure_set_par(displayUnit="Pa")) annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  ThermofluidStream.Boundaries.Source sourceValve1(redeclare package Medium = Medium, p0_par=200000) annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  ThermofluidStream.Boundaries.Sink sinkValve1(redeclare package Medium = Medium, p0_par=100000) annotation (Placement(transformation(extent={{50,70},{70,90}})));
  ThermofluidStream.Processes.FlowResistance flowResValve1(
    redeclare package Medium = Medium,
    m_flow_0=10,
    r(displayUnit="mm") = 0.02,
    l=3,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss) annotation (Placement(transformation(extent={{20,70},{40,90}})));
  ThermofluidStream.FlowControl.PCV pCValve1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=10,
    mode=ThermofluidStream.FlowControl.Internal.Types.PressureControlValveMode.outlet_pressure,
    pressureFromInput=true,
    pressure_set_par(displayUnit="bar")) annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Modelica.Blocks.Sources.Ramp rampValve1(
    height=0.5e5,
    duration=0.6,
    offset=1.5e5,
    startTime=0.1) annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Modelica.Blocks.Sources.Ramp rampValve2(
    height=-0.2e5,
    duration=0.6,
    offset=0.2e5,
    startTime=0.1) annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
equation

  connect(volumeFlex1Valve4.outlet, pCValve4.inlet) annotation (Line(
      points={{-20,-40},{-10,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(volumeFlex2Valve4.inlet, flowResValve4.outlet) annotation (Line(
      points={{50,-40},{40,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResValve4.inlet, pCValve4.outlet) annotation (Line(
      points={{20,-40},{10,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(volumeFlex1Valve3.outlet, pCValve3.inlet) annotation (Line(
      points={{-20,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(volumeFlex2Valve3.inlet, flowResValve3.outlet) annotation (Line(
      points={{50,0},{40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResValve3.inlet, pCValve3.outlet) annotation (Line(
      points={{20,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceValve2.outlet, pCValve2.inlet) annotation (Line(
      points={{-20,40},{-10,40}},
      color={28,108,200},
      thickness=0.5));
  connect(pCValve2.outlet, flowResValve2.inlet) annotation (Line(
      points={{10,40},{20,40}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResValve2.outlet, sinkValve2.inlet) annotation (Line(
      points={{40,40},{50,40}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceValve1.outlet, pCValve1.inlet) annotation (Line(
      points={{-20,80},{-10,80}},
      color={28,108,200},
      thickness=0.5));
  connect(pCValve1.outlet, flowResValve1.inlet) annotation (Line(
      points={{10,80},{20,80}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResValve1.outlet, sinkValve1.inlet) annotation (Line(
      points={{40,80},{50,80}},
      color={28,108,200},
      thickness=0.5));
  connect(rampValve2.y, pCValve2.pressure_set_var) annotation (Line(points={{-59,40},{-50,40},{-50,20},{0,20},{0,28}}, color={0,0,127}));
  connect(rampValve1.y, pCValve1.pressure_set_var) annotation (Line(points={{-59,80},{-50,80},{-50,60},{0,60},{0,68}}, color={0,0,127}));
  connect(sourceValve5.outlet, pCValve5.inlet) annotation (Line(
      points={{-20,-80},{-10,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(pCValve5.outlet, flowResValve5.inlet) annotation (Line(
      points={{10,-80},{20,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResValve5.outlet, sinkValve5.inlet) annotation (Line(
      points={{40,-80},{50,-80}},
      color={28,108,200},
      thickness=0.5));
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
</html>"),
    __Dymola_Commands(file="D:/Dymola_local/plot_scripts/PlotSetupTestPCV.mos" "PlotSetupTestPCV", file="D:/Dymola_local/plot_scripts/PlotSetupTestPCV.mos" "dsada"));
end PCV;
