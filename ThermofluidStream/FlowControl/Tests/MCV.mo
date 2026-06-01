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
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    T0_par(displayUnit="K") = 300,
    p0_par=200000) annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{50,20},{70,40}})));
  ThermofluidStream.FlowControl.MCV mCV(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.mass_flow,
    setpointFromInput=true,
    massFlow_set_par=0.1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    r=0.1,
    l=10,
    L_value=0.01,
    computeL=false,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300,
    p0_par=200000) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  ThermofluidStream.Boundaries.Sink sink1(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  ThermofluidStream.FlowControl.MCV mCV1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.volume_flow,
    massFlow_set_par=0.1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  ThermofluidStream.Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    r=0.1,
    l=10,
    L_value=0.01,
    computeL=false,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.Pulse pulse1(
    amplitude=2e5,
    period=2.5,
    offset=0.5e5,
    startTime=0)
    annotation (Placement(transformation(extent={{-80,-4},{-60,16}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300,
    p0_par=200000) annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  ThermofluidStream.Boundaries.Sink sink2(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  ThermofluidStream.FlowControl.MCV mCV2(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.volume_flow,
    massFlow_set_par=0.1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  ThermofluidStream.Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    r=0.1,
    l=10,
    L_value=0.01,
    computeL=false,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=2e5,
    rising=0.5,
    width=0.75,
    falling=0.5,
    period=2.5,
    offset=0.5e5,
    startTime=0)
    annotation (Placement(transformation(extent={{-80,-34},{-60,-14}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300,
    p0_par=200000) annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  ThermofluidStream.Boundaries.Sink sink3(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
  ThermofluidStream.FlowControl.MCV mCV3(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.mass_flow,
    massFlow_set_par=0.1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  ThermofluidStream.Processes.FlowResistance flowResistance3(
    redeclare package Medium = Medium,
    r=0.1,
    l=10,
    L_value=0.01,
    computeL=false,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Modelica.Blocks.Sources.Pulse pulse3(
    amplitude=2e5,
    period=2.5,
    offset=0.5e5,
    startTime=0)
    annotation (Placement(transformation(extent={{-80,-64},{-60,-44}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300,
    p0_par=200000) annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  ThermofluidStream.Boundaries.Sink sink4(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{50,-100},{70,-80}})));
  ThermofluidStream.FlowControl.MCV mCV4(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.mass_flow,
    massFlow_set_par=0.1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));
  ThermofluidStream.Processes.FlowResistance flowResistance4(
    redeclare package Medium = Medium,
    r=0.1,
    l=10,
    L_value=0.01,
    computeL=false,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid1(
    amplitude=2e5,
    rising=0.5,
    width=1.5,
    falling=0.5,
    period=2.5,
    offset=0.5e5,
    startTime=0)
    annotation (Placement(transformation(extent={{-78,-94},{-58,-74}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    T0_par(displayUnit="K") = 300,
    p0_par=200000) annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  ThermofluidStream.Boundaries.Sink sink5(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{50,60},{70,80}})));
  ThermofluidStream.FlowControl.MCV mCV5(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.volume_flow,
    setpointFromInput=true,
    massFlow_set_par=0.1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  ThermofluidStream.Processes.FlowResistance flowResistance5(
    redeclare package Medium = Medium,
    r=0.1,
    l=10,
    L_value=0.01,
    computeL=false,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Modelica.Blocks.Sources.Pulse pulse5(
    amplitude=0.2,
    period=2.5,
    offset=0.1,
    startTime=0)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid2(
    amplitude=5,
    rising=0.5,
    width=0.75,
    falling=0.5,
    period=2.5,
    offset=1,
    startTime=0)
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  Boundaries.Source source6(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    T0_par(displayUnit="K") = 300,
    p0_par=100000) annotation (Placement(transformation(extent={{-38,130},{-18,
            150}})));
  Boundaries.Sink sink6(redeclare package Medium = Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{52,130},{72,150}})));
  ThermofluidStream.FlowControl.MCV mCV6(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.mass_flow,
    massFlow_set_par=1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{-8,130},
            {12,150}})));

equation
  connect(mCV.inlet, source.outlet) annotation (Line(
      points={{-10,30},{-20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, flowResistance.outlet) annotation (Line(
      points={{50,30},{40,30}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.outlet, flowResistance.inlet) annotation (Line(
      points={{10,30},{20,30}},
      color={28,108,200},
      thickness=0.5));

  connect(mCV1.inlet, source1.outlet) annotation (Line(
      points={{-10,0},{-20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, flowResistance1.outlet) annotation (Line(
      points={{50,0},{40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV1.outlet, flowResistance1.inlet) annotation (Line(
      points={{10,0},{20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pulse1.y, source1.p0_var) annotation (Line(points={{-59,6},{-32,6}}, color={0,0,127}));
  connect(mCV2.inlet, source2.outlet) annotation (Line(
      points={{-10,-30},{-20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(sink2.inlet, flowResistance2.outlet) annotation (Line(
      points={{50,-30},{40,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV2.outlet, flowResistance2.inlet) annotation (Line(
      points={{10,-30},{20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(trapezoid.y, source2.p0_var) annotation (Line(points={{-59,-24},{-32,-24}}, color={0,0,127}));
  connect(mCV3.inlet, source3.outlet) annotation (Line(
      points={{-10,-60},{-20,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(sink3.inlet, flowResistance3.outlet) annotation (Line(
      points={{50,-60},{40,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV3.outlet, flowResistance3.inlet) annotation (Line(
      points={{10,-60},{20,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(pulse3.y, source3.p0_var) annotation (Line(points={{-59,-54},{-32,-54}}, color={0,0,127}));
  connect(mCV4.inlet, source4.outlet) annotation (Line(
      points={{-10,-90},{-20,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(sink4.inlet, flowResistance4.outlet) annotation (Line(
      points={{50,-90},{40,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV4.outlet, flowResistance4.inlet) annotation (Line(
      points={{10,-90},{20,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(trapezoid1.y, source4.p0_var) annotation (Line(points={{-57,-84},{-32,-84}}, color={0,0,127}));
  connect(mCV5.inlet, source5.outlet) annotation (Line(
      points={{-10,70},{-20,70}},
      color={28,108,200},
      thickness=0.5));
  connect(sink5.inlet, flowResistance5.outlet) annotation (Line(
      points={{50,70},{40,70}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV5.outlet, flowResistance5.inlet) annotation (Line(
      points={{10,70},{20,70}},
      color={28,108,200},
      thickness=0.5));
  connect(pulse5.y, mCV.setpoint_var) annotation (Line(points={{-59,50},{0,50},{0,38}}, color={0,0,127}));
  connect(trapezoid2.y, mCV5.setpoint_var) annotation (Line(points={{-59,90},{0,90},{0,78}}, color={0,0,127}));
  connect(mCV6.inlet,source6. outlet) annotation (Line(
      points={{-8,140},{-18,140}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV6.outlet, sink6.inlet) annotation (Line(
      points={{12,140},{52,140}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-120},{120,120}})),
    experiment(
      StopTime=10,
      __Dymola_NumberOfIntervals=1500,
      __Dymola_Algorithm="Dassl"),
        Documentation(info="<html>
<p>Test for the MCV.</p>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end MCV;
