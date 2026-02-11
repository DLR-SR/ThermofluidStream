within ThermofluidStream.FlowControl.Tests;
model MCV "Test for MCV"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium package"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Test.
</p>
</html>"));

  inner ThermofluidStream.DropOfCommons dropOfCommons(assertionLevel=AssertionLevel.warning)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  ThermofluidStream.Boundaries.Source sourceValve1(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    T0_par(displayUnit="K") = 300,
    p0_par=200000) annotation (Placement(transformation(extent={{-40,120},{-20,140}})));
  ThermofluidStream.Boundaries.Sink sinkValve1(redeclare package Medium = Medium, p0_par=100000) annotation (Placement(transformation(extent={{50,120},{70,140}})));
  ThermofluidStream.FlowControl.MCV mCValve1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.mass_flow,
    setpointFromInput=true,
    massFlow_set_par=0.1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{-10,120},{10,140}})));
  ThermofluidStream.Processes.FlowResistance flowResValve1(
    redeclare package Medium = Medium,
    r=0.1,
    l=10,
    L_value=0.01,
    computeL=false,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss) annotation (Placement(transformation(extent={{20,120},{40,140}})));
  ThermofluidStream.Boundaries.Source sourceValve2(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300,
    p0_par=200000) annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  ThermofluidStream.Boundaries.Sink sinkValve2(redeclare package Medium = Medium, p0_par=100000) annotation (Placement(transformation(extent={{50,70},{70,90}})));
  ThermofluidStream.FlowControl.MCV vCValve2(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.volume_flow,
    massFlow_set_par=0.1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  ThermofluidStream.Processes.FlowResistance flowResValve2(
    redeclare package Medium = Medium,
    r=0.1,
    l=10,
    L_value=0.01,
    computeL=false,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss) annotation (Placement(transformation(extent={{20,70},{40,90}})));
  Modelica.Blocks.Sources.Pulse pulseValve2(
    amplitude=2e5,
    period=2.5,
    offset=0.5e5,
    startTime=0) annotation (Placement(transformation(extent={{-80,76},{-60,96}})));
  ThermofluidStream.Boundaries.Source sourceValve3(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300,
    p0_par=200000) annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  ThermofluidStream.Boundaries.Sink sinkValve3(redeclare package Medium = Medium, p0_par=100000) annotation (Placement(transformation(extent={{50,30},{70,50}})));
  ThermofluidStream.FlowControl.MCV vCValve3(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.volume_flow,
    massFlow_set_par=0.1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  ThermofluidStream.Processes.FlowResistance flowResValve3(
    redeclare package Medium = Medium,
    r=0.1,
    l=10,
    L_value=0.01,
    computeL=false,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss) annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.Blocks.Sources.Trapezoid trapezoidValve3(
    amplitude=2e5,
    rising=0.5,
    width=0.75,
    falling=0.5,
    period=2.5,
    offset=0.5e5,
    startTime=0) annotation (Placement(transformation(extent={{-80,36},{-60,56}})));
  ThermofluidStream.Boundaries.Source sourceValve4(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300,
    p0_par=200000) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  ThermofluidStream.Boundaries.Sink sinkValve4(redeclare package Medium = Medium, p0_par=100000) annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  ThermofluidStream.FlowControl.MCV mCValve4(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.mass_flow,
    massFlow_set_par=0.1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  ThermofluidStream.Processes.FlowResistance flowResValve4(
    redeclare package Medium = Medium,
    r=0.1,
    l=10,
    L_value=0.01,
    computeL=false,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.Pulse pulseValve4(
    amplitude=2e5,
    period=2.5,
    offset=0.5e5,
    startTime=0) annotation (Placement(transformation(extent={{-80,-4},{-60,16}})));
  ThermofluidStream.Boundaries.Source sourceValve5(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300,
    p0_par=200000) annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  ThermofluidStream.Boundaries.Sink sinkValve5(redeclare package Medium = Medium, p0_par=100000) annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
  ThermofluidStream.FlowControl.MCV mCValve5(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.mass_flow,
    massFlow_set_par=0.1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  ThermofluidStream.Processes.FlowResistance flowResValve5(
    redeclare package Medium = Medium,
    r=0.1,
    l=10,
    L_value=0.01,
    computeL=false,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss) annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  Modelica.Blocks.Sources.Trapezoid trapezoidValve5(
    amplitude=2e5,
    rising=0.5,
    width=1.5,
    falling=0.5,
    period=2.5,
    offset=0.5e5,
    startTime=0) annotation (Placement(transformation(extent={{-80,-44},{-60,-24}})));
  ThermofluidStream.Boundaries.Source sourceValve6(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    T0_par(displayUnit="K") = 300,
    p0_par=200000) annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  ThermofluidStream.Boundaries.Sink sinkValve6(redeclare package Medium = Medium, p0_par=100000) annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
  ThermofluidStream.FlowControl.MCV vCValve6(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.volume_flow,
    setpointFromInput=true,
    massFlow_set_par=0.1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  ThermofluidStream.Processes.FlowResistance flowResValve6(
    redeclare package Medium = Medium,
    r=0.1,
    l=10,
    L_value=0.01,
    computeL=false,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss) annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
  Modelica.Blocks.Sources.Pulse pulseValve1(
    amplitude=0.2,
    period=2.5,
    offset=0.1,
    startTime=0) annotation (Placement(transformation(extent={{-80,120},{-60,140}})));
  Modelica.Blocks.Sources.Trapezoid trapezoidValve6(
    amplitude=5,
    rising=0.5,
    width=0.75,
    falling=0.5,
    period=2.5,
    offset=1,
    startTime=0) annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Boundaries.Source sourceValve7(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    T0_par(displayUnit="K") = 300,
    p0_par=100000) annotation (Placement(transformation(extent={{-40,-140},{-20,-120}})));
  Boundaries.Sink sinkValve7(redeclare package Medium = Medium, p0_par=100000) annotation (Placement(transformation(extent={{50,-140},{70,-120}})));
  ThermofluidStream.FlowControl.MCV mCValve7(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.mass_flow,
    massFlow_set_par=1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{-10,-140},{10,-120}})));

  Processes.FlowResistance flowResValve7(
    redeclare package Medium = Medium,
    r=0.1,
    l=10,
    L_value=0.01,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss) annotation (Placement(transformation(extent={{20,-140},{40,-120}})));
equation
  connect(mCValve1.inlet, sourceValve1.outlet) annotation (Line(
      points={{-10,130},{-20,130}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkValve1.inlet, flowResValve1.outlet) annotation (Line(
      points={{50,130},{40,130}},
      color={28,108,200},
      thickness=0.5));
  connect(mCValve1.outlet, flowResValve1.inlet) annotation (Line(
      points={{10,130},{20,130}},
      color={28,108,200},
      thickness=0.5));

  connect(vCValve2.inlet, sourceValve2.outlet) annotation (Line(
      points={{-10,80},{-20,80}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkValve2.inlet, flowResValve2.outlet) annotation (Line(
      points={{50,80},{40,80}},
      color={28,108,200},
      thickness=0.5));
  connect(vCValve2.outlet, flowResValve2.inlet) annotation (Line(
      points={{10,80},{20,80}},
      color={28,108,200},
      thickness=0.5));
  connect(pulseValve2.y, sourceValve2.p0_var) annotation (Line(points={{-59,86},{-32,86}}, color={0,0,127}));
  connect(vCValve3.inlet, sourceValve3.outlet) annotation (Line(
      points={{-10,40},{-20,40}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkValve3.inlet, flowResValve3.outlet) annotation (Line(
      points={{50,40},{40,40}},
      color={28,108,200},
      thickness=0.5));
  connect(vCValve3.outlet, flowResValve3.inlet) annotation (Line(
      points={{10,40},{20,40}},
      color={28,108,200},
      thickness=0.5));
  connect(trapezoidValve3.y, sourceValve3.p0_var) annotation (Line(points={{-59,46},{-32,46}}, color={0,0,127}));
  connect(mCValve4.inlet, sourceValve4.outlet) annotation (Line(
      points={{-10,0},{-20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkValve4.inlet, flowResValve4.outlet) annotation (Line(
      points={{50,0},{40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(mCValve4.outlet, flowResValve4.inlet) annotation (Line(
      points={{10,0},{20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pulseValve4.y, sourceValve4.p0_var) annotation (Line(points={{-59,6},{-32,6}}, color={0,0,127}));
  connect(mCValve5.inlet, sourceValve5.outlet) annotation (Line(
      points={{-10,-40},{-20,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkValve5.inlet, flowResValve5.outlet) annotation (Line(
      points={{50,-40},{40,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(mCValve5.outlet, flowResValve5.inlet) annotation (Line(
      points={{10,-40},{20,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(trapezoidValve5.y, sourceValve5.p0_var) annotation (Line(points={{-59,-34},{-32,-34}}, color={0,0,127}));
  connect(vCValve6.inlet, sourceValve6.outlet) annotation (Line(
      points={{-10,-80},{-20,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkValve6.inlet, flowResValve6.outlet) annotation (Line(
      points={{50,-80},{40,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(vCValve6.outlet, flowResValve6.inlet) annotation (Line(
      points={{10,-80},{20,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(pulseValve1.y, mCValve1.setpoint_var) annotation (Line(points={{-59,130},{-46,130},{-46,110},{0,110},{0,118}}, color={0,0,127}));
  connect(trapezoidValve6.y, vCValve6.setpoint_var) annotation (Line(points={{-59,-80},{-46,-80},{-46,-100},{0,-100},{0,-92}}, color={0,0,127}));
  connect(mCValve7.inlet, sourceValve7.outlet) annotation (Line(
      points={{-10,-130},{-20,-130}},
      color={28,108,200},
      thickness=0.5));
  connect(mCValve7.outlet, flowResValve7.inlet) annotation (Line(
      points={{10,-130},{20,-130}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkValve7.inlet, flowResValve7.outlet) annotation (Line(
      points={{50,-130},{40,-130}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-160},{120,160}})),
    experiment(
      StopTime=10,
      __Dymola_NumberOfIntervals=1500,
      __Dymola_Algorithm="Dassl"),
        Documentation(info="<html>
<p>Test for the MCV.</p>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end MCV;
