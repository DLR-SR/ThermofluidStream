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
    redeclare function pLoss =
        .ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-40,-8},{-20,12}})));
  Boundaries.BoundaryRear boundary_rear(
    redeclare package Medium = Medium,
    T0_par=373.15,
    p0_par=100000) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-120,2})));
  Boundaries.BoundaryFore boundary_fore(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par=303.15,
    p0_par=110000) annotation (Placement(transformation(extent={{84,-8},{104,12}})));
  inner DropOfCommons dropOfCommons(m_flow_reg=0.01)
    annotation (Placement(transformation(extent={{-130,22},{-110,42}})));
  Modelica.Blocks.Sources.Step step(
    height=-80000,
    offset=140000,
    startTime=5)
    annotation (Placement(transformation(extent={{120,-4},{108,8}})));
  MultiSensor_Tpm multiSensor_Tpm(redeclare package Medium = Medium,
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=false)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  SingleSensorSelect singleSensorSelect(redeclare package Medium = Medium,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar)
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  UnidirectionalSensorAdapter unidirectionalSensorAdapter(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{20,0},{40,8}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect sensor_vaporQuality1(redeclare package Medium = Medium, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{50,12},{70,32}})));
  SingleFlowSensor singleFlowSensor(redeclare package Medium = Medium, quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps)
    annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
  TwoPhaseSensorSelect sensor_vaporQuality2(
    redeclare package Medium2Phase = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg,
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{50,0},{70,20}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.01,
    l=100,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-40,52},{-20,72}})));
  Boundaries.BoundaryRear boundary_rear1(
    redeclare package Medium = Medium,
    T0_par=373.15,
    p0_par=100000) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-120,62})));
  Boundaries.BoundaryFore boundary_fore1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par=303.15,
    p0_par=110000) annotation (Placement(transformation(extent={{84,52},{104,72}})));
  Modelica.Blocks.Sources.Step step1(
    height=-80000,
    offset=140000,
    startTime=5)
    annotation (Placement(transformation(extent={{120,56},{108,68}})));
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
    filter_output=true)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  SingleFlowSensor singleFlowSensor1(
    redeclare package Medium = Medium,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps,
    filter_output=true) annotation (Placement(transformation(extent={{-70,60},{-50,80}})));
  TwoPhaseSensorSelect sensor_vaporQuality4(
    redeclare package Medium2Phase = Medium,
    outputValue=true,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg,
    filter_output=true,
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{50,60},{70,80}})));
  UnidirectionalSensorAdapter unidirectionalSensorAdapter1(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{20,64},{40,56}})));
  ThermofluidStream.Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect(
    redeclare package MediumA = Medium,
    redeclare package MediumB = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa,
    outputValue=true,
    filter_output=true) annotation (Placement(transformation(extent={{50,52},{70,32}})));
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
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-38,-40},{-18,-20}})));
  SingleSensorX singleSensorX(redeclare package Medium = Medium2) annotation (Placement(transformation(extent={{-100,-32},{-80,-12}})));
  SingleSensorX singleSensorX1(
    redeclare package Medium = Medium2,
    digits=2,
    outputValue=true,
    filter_output=true,
    row=2) annotation (Placement(transformation(extent={{-70,-32},{-50,-12}})));
  SensorState sensorState(redeclare package Medium = Medium2) annotation (Placement(transformation(extent={{20,-32},{40,-12}})));
equation
  connect(step.y, boundary_fore.p0_var)
    annotation (Line(points={{107.4,2},{102,2},{102,8},{96,8}},
                                                   color={0,0,127}));
  connect(singleSensorSelect.rear, flowResistance.fore) annotation (Line(
      points={{-10,2},{-20,2}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.fore, unidirectionalSensorAdapter.rear)
    annotation (Line(
      points={{10,2},{20,2}},
      color={28,108,200},
      thickness=0.5));
  connect(sensor_vaporQuality1.inlet, unidirectionalSensorAdapter.outlet)
    annotation (Line(
      points={{50,22},{30,22},{30,6}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.fore, singleFlowSensor.rear) annotation (Line(
      points={{-80,2},{-70,2}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.rear, singleFlowSensor.fore) annotation (Line(
      points={{-40,2},{-50,2}},
      color={28,108,200},
      thickness=0.5));
  connect(unidirectionalSensorAdapter.fore, sensor_vaporQuality2.rear)
    annotation (Line(
      points={{40,2},{50,2}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore.rear, sensor_vaporQuality2.fore)
    annotation (Line(
      points={{84,2},{70,2}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear.fore, multiSensor_Tpm.rear) annotation (Line(
      points={{-110,2},{-100,2}},
      color={28,108,200},
      thickness=0.5));
  connect(step1.y, boundary_fore1.p0_var) annotation (Line(points={{107.4,62},{102,62},{102,68},{96,68}},
                                                                                          color={0,0,127}));
  connect(singleSensorSelect1.rear, flowResistance1.fore)
    annotation (Line(
      points={{-10,62},{-20,62}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.fore, singleFlowSensor1.rear)
    annotation (Line(
      points={{-80,62},{-70,62}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.rear, singleFlowSensor1.fore)
    annotation (Line(
      points={{-40,62},{-50,62}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore1.rear, sensor_vaporQuality4.fore)
    annotation (Line(
      points={{84,62},{70,62}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear1.fore, multiSensor_Tpm1.rear)
    annotation (Line(
      points={{-110,62},{-100,62}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.fore, unidirectionalSensorAdapter1.rear)
    annotation (Line(
      points={{10,62},{20,62}},
      color={28,108,200},
      thickness=0.5));
  connect(unidirectionalSensorAdapter1.fore, sensor_vaporQuality4.rear)
    annotation (Line(
      points={{40,62},{50,62}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceTwoPhaseSensorSensorSelect.inletA, unidirectionalSensorAdapter.outlet)
    annotation (Line(
      points={{50.4,38},{30,38},{30,6}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceTwoPhaseSensorSensorSelect.inletB, unidirectionalSensorAdapter1.outlet)
    annotation (Line(
      points={{50.4,46},{30,46},{30,58}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorX.rear, boundary_rear2.fore) annotation (Line(
      points={{-100,-30},{-110,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.rear, singleSensorX1.fore) annotation (Line(
      points={{-38,-30},{-50,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorX1.rear, singleSensorX.fore) annotation (Line(
      points={{-70,-30},{-80,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.fore, sensorState.rear) annotation (Line(
      points={{-18,-30},{20,-30}},
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
