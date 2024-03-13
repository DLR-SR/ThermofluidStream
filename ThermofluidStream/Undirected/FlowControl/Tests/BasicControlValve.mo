within ThermofluidStream.Undirected.FlowControl.Tests;
model BasicControlValve "Test for undirected BasicControlValve"
  extends Modelica.Icons.Example;

  replaceable package Medium =
      ThermofluidStream.Media.myMedia.Water.ConstantPropertyLiquidWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium package"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Test.
</p>
</html>"));

  inner ThermofluidStream.DropOfCommons dropOfCommons(assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-170,94},{-150,114}})));
  Boundaries.BoundaryRear boundary_rear(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300) annotation (Placement(transformation(extent={{-116,50},{-96,70}})));
  FlowControl.BasicControlValve valveLinear(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    flowCoefficient=ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypesBasic.Kvs,
    Kvs=5,
    redeclare function valveCharacteristics =
        ThermofluidStream.FlowControl.Internal.ControlValve.linearCharacteristics)
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));

  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e3))
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Boundaries.BoundaryFore boundary_fore1(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{96,50},{116,70}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1,
    duration=10,
    offset=0,
    startTime=5)
    annotation (Placement(transformation(extent={{174,10},{154,30}})));
  Boundaries.BoundaryRear boundary_rear2(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300) annotation (Placement(transformation(extent={{-116,-10},{-96,10}})));
  FlowControl.BasicControlValve valveParabolic(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    invertInput=false,
    flowCoefficient=ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypesBasic.Kvs,
    Kvs=5,
    redeclare function valveCharacteristics =
        ThermofluidStream.FlowControl.Internal.ControlValve.parabolicCharacteristics,
    m_flow_ref_set=0.1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Boundaries.BoundaryFore boundary_fore2(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{96,-10},{116,10}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm4(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm5(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Boundaries.BoundaryRear boundary_rear1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300) annotation (Placement(transformation(extent={{-116,-70},{-96,-50}})));
  FlowControl.BasicControlValve valveEqualPercentage(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    flowCoefficient=ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypesBasic.Kvs,
    Kvs=5,
    redeclare function valveCharacteristics =
        ThermofluidStream.FlowControl.Internal.ControlValve.equalPercentageCharacteristics)
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));

  Boundaries.BoundaryFore boundary_fore(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{96,-70},{116,-50}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm7(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm8(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=2e4,
    period=2,
    offset=0.9e5)
    annotation (Placement(transformation(extent={{-172,-4},{-152,16}})));
  Processes.FlowResistance flowResistance6(
    redeclare package Medium = Medium,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e3))
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e3))
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e3))
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Processes.FlowResistance flowResistance3(
    redeclare package Medium = Medium,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e3))
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Processes.FlowResistance flowResistance4(
    redeclare package Medium = Medium,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e3))
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
equation
  connect(boundary_rear1.p0_var, pulse.y) annotation (Line(points={{-108,-54},{-140,-54},{-140,6},{-151,6}}, color={0,0,127}));
  connect(ramp.y, valveParabolic.u_in)
    annotation (Line(points={{153,20},{0,20},{0,8}}, color={0,0,127}));
  connect(ramp.y, valveEqualPercentage.u_in) annotation (Line(points={{153,20},
          {120,20},{120,-40},{0,-40},{0,-52}}, color={0,0,127}));
  connect(boundary_rear.p0_var, pulse.y) annotation (Line(points={{-108,66},{-140,66},{-140,6},{-151,6}}, color={0,0,127}));
  connect(pulse.y, boundary_rear2.p0_var) annotation (Line(points={{-151,6},{-108,6}}, color={0,0,127}));
  connect(valveLinear.u_in, ramp.y) annotation (Line(points={{0,68},{0,90},{120,
          90},{120,20},{153,20}}, color={0,0,127}));
  connect(flowResistance.rear, boundary_rear.fore) annotation (Line(
      points={{-80,60},{-96,60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.fore, multiSensor_Tpm2.rear) annotation (Line(
      points={{-60,60},{-40,60}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm2.fore, valveLinear.rear) annotation (Line(
      points={{-20,60},{-10,60}},
      color={28,108,200},
      thickness=0.5));
  connect(valveLinear.fore, multiSensor_Tpm3.rear)
    annotation (Line(
      points={{10,60},{20,60}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.fore, flowResistance6.rear) annotation (Line(
      points={{40,60},{60,60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance6.fore, boundary_fore1.rear) annotation (Line(
      points={{80,60},{96,60}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore2.rear, flowResistance1.fore) annotation (Line(
      points={{96,0},{80,0}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.rear, multiSensor_Tpm5.fore) annotation (Line(
      points={{60,0},{40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm5.rear, valveParabolic.fore) annotation (Line(
      points={{20,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(valveParabolic.rear, multiSensor_Tpm4.fore) annotation (Line(
      points={{-10,0},{-20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm4.rear, flowResistance2.fore) annotation (Line(
      points={{-40,0},{-60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.rear, boundary_rear2.fore) annotation (Line(
      points={{-80,0},{-96,0}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear1.fore, flowResistance3.rear) annotation (Line(
      points={{-96,-60},{-80,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.fore, multiSensor_Tpm7.rear)
    annotation (Line(
      points={{-60,-60},{-40,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm7.fore, valveEqualPercentage.rear)
    annotation (Line(
      points={{-20,-60},{-10,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(valveEqualPercentage.fore, multiSensor_Tpm8.rear)
    annotation (Line(
      points={{10,-60},{20,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm8.fore, flowResistance4.rear) annotation (Line(
      points={{40,-60},{60,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.fore, boundary_fore.rear) annotation (Line(
      points={{80,-60},{96,-60}},
      color={28,108,200},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(extent={{-180,-100},{180,120}})),
    experiment(
      StopTime=20,
   Tolerance=1e-6,
   Interval=0.02,
      __Dymola_Algorithm="Dassl"),
    Icon(coordinateSystem),
    Documentation(info="<html>
        <p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end BasicControlValve;
