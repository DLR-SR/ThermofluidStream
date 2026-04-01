within ThermofluidStream.FlowControl.Tests;
model ThreeWayValve "Test for the three way valve"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.SimpleAir
    constrainedby Media.myMedia.Interfaces.PartialMedium "Medium package"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Test.
</p>
</html>"));

  inner DropOfCommons dropOfCommons(assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  Boundaries.Source source(redeclare package Medium=Medium,
    pressureFromInput=true, T0_par(displayUnit="K") = 300,
    p0_par=200000)
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Boundaries.Sink sink(redeclare package Medium=Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{80,30},{100,50}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-42,30},{-22,50}})));
  Boundaries.Sink sink1(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{50,50},{70,70}})));
  ThermofluidStream.FlowControl.ThreeWayValve
                                       threeWayValve(
    redeclare package Medium = Medium,
    redeclare function valveCharacteristics = ThermofluidStream.FlowControl.Internal.ControlValve.linearCharacteristics,
    flowCoefficient=ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypesBasic.m_flow_set,
    invertInput=true)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.Blocks.Sources.Sine  sine(
    amplitude=0.5e5,
    f=0.5,
    offset=2e5,
    startTime=1)
    annotation (Placement(transformation(extent={{-96,-38},{-76,-18}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=1e5,                    period=1,
    offset=1.5e5,
    startTime=1)
    annotation (Placement(transformation(extent={{-134,10},{-114,30}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=0.001, initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(transformation(extent={{-96,14},{-84,26}})));
  Sensors.SingleFlowSensor singleFlowSensor(
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_gps,
    outputValue=true) annotation (Placement(transformation(extent={{50,50},{70,30}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=3) annotation (Placement(transformation(extent={{50,-30},{30,-10}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.2,
    Ti=0.001,
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90)));
equation
  connect(flowResistance.outlet, threeWayValve.inlet) annotation (Line(
      points={{-22,40},{-10,40}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, flowResistance1.outlet) annotation (Line(
      points={{50,60},{40,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{-50,40},{-42,40}},
      color={28,108,200},
      thickness=0.5));
  connect(threeWayValve.outletB, flowResistance1.inlet) annotation (Line(
      points={{0,50},{0,60},{20,60}},
      color={28,108,200},
      thickness=0.5));
  connect(threeWayValve.outletA, flowResistance2.inlet) annotation (Line(
      points={{10,40},{20,40}},
      color={28,108,200},
      thickness=0.5));
  connect(pulse.y, firstOrder.u) annotation (Line(points={{-113,20},{-97.2,20}}, color={0,0,127}));
  connect(flowResistance2.outlet, singleFlowSensor.inlet) annotation (Line(
      points={{40,40},{50,40}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, singleFlowSensor.outlet) annotation (Line(
      points={{80,40},{70,40}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor.value_out, PID.u_m) annotation (Line(points={{68,34},{74,34},{74,0},{12,0}}, color={0,0,127}));
  connect(realExpression.y, PID.u_s) annotation (Line(points={{29,-20},{0,-20},{0,-12}}, color={0,0,127}));
  connect(PID.y, threeWayValve.u) annotation (Line(points={{0,11},{0,28}}, color={0,0,127}));
  connect(pulse.y, source.p0_var) annotation (Line(points={{-113,20},{-104,20},{-104,46},{-62,46}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-120,-100},{100,100}})),
    experiment(StopTime=10, Tolerance=1e-6, Interval=0.01, __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>Test for the switches.</p>
<p>Owner: Michael Mei&szlig;ner</p>
</html>"));
end ThreeWayValve;
