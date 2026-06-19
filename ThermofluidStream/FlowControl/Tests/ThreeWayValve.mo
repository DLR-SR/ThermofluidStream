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
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Boundaries.Source source(redeclare package Medium=Medium,
    pressureFromInput=true, T0_par(displayUnit="K") = 300,
    p0_par=200000)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Boundaries.Sink sinkControlled(redeclare package Medium = Medium, p0_par=100000) annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.01,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-42,-10},{-22,10}})));
  Boundaries.Sink sinkUncontrolled(redeclare package Medium = Medium, p0_par=100000) annotation (Placement(transformation(extent={{50,10},{70,30}})));
  ThermofluidStream.FlowControl.ThreeWayValve
                                       threeWayValve(
    redeclare package Medium = Medium,
    redeclare function valveCharacteristics = ThermofluidStream.FlowControl.Internal.ControlValve.linearCharacteristics,
    flowCoefficient=ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypesBasic.m_flow_set,
    invertInput=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Processes.FlowResistance flowResistanceUncontrolled(
    redeclare package Medium = Medium,
    r=0.01,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (material=ThermofluidStream.Processes.Internal.Material.steel)) annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Processes.FlowResistance flowResistanceControlled(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.01,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (material=ThermofluidStream.Processes.Internal.Material.steel)) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=1e5,                    period=1,
    offset=1.5e5,
    startTime=1)
    annotation (Placement(transformation(extent={{-112,0},{-100,12}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=0.001, initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(transformation(extent={{-86,0},{-74,12}})));
  Sensors.SingleFlowSensor mFlowSensor(
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_gps,
    outputValue=true) annotation (Placement(transformation(extent={{50,10},{70,-10}})));
  Modelica.Blocks.Sources.RealExpression mFlowSet(y=3) annotation (Placement(transformation(extent={{50,-70},{30,-50}})));
  Modelica.Blocks.Continuous.LimPID massFlowControl(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.2,
    Ti=0.001,
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={0,-40})));
equation
  connect(flowResistance.outlet, threeWayValve.inlet) annotation (Line(
      points={{-22,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkUncontrolled.inlet, flowResistanceUncontrolled.outlet) annotation (Line(
      points={{50,20},{40,20}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{-50,0},{-42,0}},
      color={28,108,200},
      thickness=0.5));
  connect(threeWayValve.outletB, flowResistanceUncontrolled.inlet) annotation (Line(
      points={{0,10},{0,20},{20,20}},
      color={28,108,200},
      thickness=0.5));
  connect(threeWayValve.outletA, flowResistanceControlled.inlet) annotation (Line(
      points={{10,0},{20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pulse.y, firstOrder.u) annotation (Line(points={{-99.4,6},{-87.2,6}},  color={0,0,127}));
  connect(flowResistanceControlled.outlet, mFlowSensor.inlet) annotation (Line(
      points={{40,0},{50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkControlled.inlet, mFlowSensor.outlet) annotation (Line(
      points={{80,0},{70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(mFlowSensor.value_out, massFlowControl.u_m) annotation (Line(points={{71,-6},{74,-6},{74,-40},{9.6,-40}}, color={0,0,127}));
  connect(mFlowSet.y, massFlowControl.u_s) annotation (Line(points={{29,-60},{0,-60},{0,-49.6}}, color={0,0,127}));
  connect(firstOrder.y, source.p0_var) annotation (Line(points={{-73.4,6},{-62,6}}, color={0,0,127}));
  connect(massFlowControl.y, threeWayValve.u) annotation (Line(points={{0,-31.2},{0,-12}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-120,-100},{100,100}})),
    experiment(StopTime=10, Tolerance=1e-6, Interval=0.01, __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>Test for the switches.</p>
<p>Owner: Michael Mei&szlig;ner</p>
</html>"));
end ThreeWayValve;
