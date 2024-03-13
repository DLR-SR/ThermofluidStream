within ThermofluidStream.Undirected.Sensors.Tests;
model TestSensors "Test for the undirected sensors"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Water.StandardWater
    constrainedby Media.myMedia.Interfaces.PartialTwoPhaseMedium
    "Medium model"
    annotation (Documentation(info="<html>
<p>Replaceable package with the medium model. Due to the vaporQuality sensor it must be a TwoPhaseMedium.</p>
</html>"));

  replaceable package Medium2 = Media.myMedia.IdealGases.MixtureGases.CombustionAir
    constrainedby Media.myMedia.Interfaces.PartialMedium
    "Medium model"
    annotation (Documentation(info="<html>
<p>Replaceable package with the medium model. Due to the vaporQuality sensor it must be a TwoPhaseMedium.</p>
</html>"));

  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.01,
    l=100,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Boundaries.BoundaryRear boundary_rear(
    redeclare package Medium = Medium,
    T0_par=373.15,
    p0_par=100000) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-120,0})));
  Boundaries.BoundaryFore boundary_fore(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par=303.15,
    p0_par=110000) annotation (Placement(transformation(extent={{84,-10},{104,10}})));
  inner DropOfCommons dropOfCommons(m_flow_reg=0.01)
    annotation (Placement(transformation(extent={{-130,22},{-110,42}})));
  Modelica.Blocks.Sources.Step step(
    height=-80000,
    offset=140000,
    startTime=5)
    annotation (Placement(transformation(extent={{120,0},{108,12}})));
  MultiSensor_Tpm multiSensor_Tpm(redeclare package Medium = Medium,
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=false)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  SingleSensorSelect singleSensorSelect(redeclare package Medium = Medium,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  UnidirectionalSensorAdapter unidirectionalSensorAdapter(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect sensor_vaporQuality1(
    redeclare package Medium = Medium, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{50,28},{70,8}})));
  SingleFlowSensor singleFlowSensor(redeclare package Medium = Medium, quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  TwoPhaseSensorSelect sensor_vaporQuality2(
    redeclare package Medium2Phase = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg,
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.01,
    l=100,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Boundaries.BoundaryRear boundary_rear1(
    redeclare package Medium = Medium,
    T0_par=373.15,
    p0_par=100000) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-120,60})));
  Boundaries.BoundaryFore boundary_fore1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par=303.15,
    p0_par=110000) annotation (Placement(transformation(extent={{80,50},{100,70}})));
  Modelica.Blocks.Sources.Step step1(
    height=-80000,
    offset=140000,
    startTime=5)
    annotation (Placement(transformation(extent={{120,60},{108,72}})));
  MultiSensor_Tpm multiSensor_Tpm1(
    redeclare package Medium = Medium,
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=true,
    filter_output=true)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  SingleSensorSelect singleSensorSelect1(
    redeclare package Medium = Medium,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar,
    filter_output=true,
    init=ThermofluidStream.Sensors.Internal.Types.InitializationModelSensor.state,
    value_0=1) annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  SingleFlowSensor singleFlowSensor1(
    redeclare package Medium = Medium,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps,
    filter_output=true) annotation (Placement(transformation(extent={{-70,50},{-50,70}})));
  TwoPhaseSensorSelect sensor_vaporQuality4(
    redeclare package Medium2Phase = Medium,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg,
    filter_output=true,
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{50,50},{70,70}})));
  UnidirectionalSensorAdapter unidirectionalSensorAdapter1(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{20,70},{40,50}})));
  ThermofluidStream.Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect(
    redeclare package MediumA = Medium,
    redeclare package MediumB = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa,
    outputValue=true,
    filter_output=true) annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={30,34})));
  Boundaries.BoundaryRear boundary_rear2(
    redeclare package Medium = Medium2,
    T0_par=373.15,
    p0_par=200000,
    Xi0_par={0.2,0.8})
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-120,-30})));
  Boundaries.BoundaryFore boundary_fore2(
    redeclare package Medium = Medium2,
    pressureFromInput=false,
    T0_par=303.15,
    p0_par=100000) annotation (Placement(transformation(extent={{86,-40},{106,-20}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium2,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.01,
    l=100,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  SingleSensorX singleSensorX(redeclare package Medium = Medium2) annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  SingleSensorX singleSensorX1(
    redeclare package Medium = Medium2,
    digits=2,
    outputValue=true,
    filter_output=true,
    row=2) annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  SensorState sensorState(redeclare package Medium = Medium2) annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
equation
  connect(step.y, boundary_fore.p0_var)
    annotation (Line(points={{107.4,6},{96,6}},    color={0,0,127}));
  connect(singleSensorSelect.rear, flowResistance.fore) annotation (Line(
      points={{-10,0},{-20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.fore, unidirectionalSensorAdapter.rear)
    annotation (Line(
      points={{10,0},{20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sensor_vaporQuality1.inlet, unidirectionalSensorAdapter.outlet)
    annotation (Line(
      points={{50,18},{30,18},{30,10}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.fore, singleFlowSensor.rear) annotation (Line(
      points={{-80,0},{-70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.rear, singleFlowSensor.fore) annotation (Line(
      points={{-40,0},{-50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(unidirectionalSensorAdapter.fore, sensor_vaporQuality2.rear)
    annotation (Line(
      points={{40,0},{50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore.rear, sensor_vaporQuality2.fore)
    annotation (Line(
      points={{84,0},{70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear.fore, multiSensor_Tpm.rear) annotation (Line(
      points={{-110,-8.88178e-16},{-106,-8.88178e-16},{-106,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(step1.y, boundary_fore1.p0_var) annotation (Line(points={{107.4,66},{92,66}},   color={0,0,127}));
  connect(singleSensorSelect1.rear, flowResistance1.fore)
    annotation (Line(
      points={{-10,60},{-20,60}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.fore, singleFlowSensor1.rear)
    annotation (Line(
      points={{-80,60},{-70,60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.rear, singleFlowSensor1.fore)
    annotation (Line(
      points={{-40,60},{-50,60}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore1.rear, sensor_vaporQuality4.fore)
    annotation (Line(
      points={{80,60},{70,60}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear1.fore, multiSensor_Tpm1.rear)
    annotation (Line(
      points={{-110,60},{-100,60}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.fore, unidirectionalSensorAdapter1.rear)
    annotation (Line(
      points={{10,60},{20,60}},
      color={28,108,200},
      thickness=0.5));
  connect(unidirectionalSensorAdapter1.fore, sensor_vaporQuality4.rear)
    annotation (Line(
      points={{40,60},{50,60}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceTwoPhaseSensorSensorSelect.inletA, unidirectionalSensorAdapter.outlet)
    annotation (Line(
      points={{30,24},{30,10}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceTwoPhaseSensorSensorSelect.inletB, unidirectionalSensorAdapter1.outlet)
    annotation (Line(
      points={{30,44},{30,50}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorX.rear, boundary_rear2.fore) annotation (Line(
      points={{-100,-30},{-110,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.rear, singleSensorX1.fore) annotation (Line(
      points={{-40,-30},{-50,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorX1.rear, singleSensorX.fore) annotation (Line(
      points={{-70,-30},{-80,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.fore, sensorState.rear) annotation (Line(
      points={{-20,-30},{20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorState.fore, boundary_fore2.rear) annotation (Line(
      points={{40,-30},{86,-30}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-60},{140,80}})),
    experiment(StopTime=10, Tolerance=1e-6, Interval=0.01),
    Documentation(info="<html>
<p>Test&nbsp;for&nbsp;the&nbsp;undirected&nbsp;sensors.</p>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end TestSensors;
