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
    annotation (Placement(transformation(extent={{-18,-10},{2,10}})));
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
    p0_par=110000) annotation (Placement(transformation(extent={{102,-10},{122,10}})));
  inner DropOfCommons dropOfCommons(m_flow_reg=0.01)
    annotation (Placement(transformation(extent={{-130,22},{-110,42}})));
  Modelica.Blocks.Sources.Step step(
    height=-80000,
    offset=140000,
    startTime=5)
    annotation (Placement(transformation(extent={{138,0},{126,12}})));
  MultiSensor_Tpm multiSensor_Tpm(redeclare package Medium = Medium,
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=false)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  SingleSensorSelect singleSensorSelect(redeclare package Medium = Medium,
      quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  UnidirectionalSensorAdapter unidirectionalSensorAdapter(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{38,-10},{58,10}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect sensor_vaporQuality1(
    redeclare package Medium = Medium, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{68,28},{88,8}})));
  SingleFlowSensor singleFlowSensor(redeclare package Medium = Medium, quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  TwoPhaseSensorSelect sensor_vaporQuality2(
    redeclare package Medium2Phase = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg,
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{68,-10},{88,10}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.01,
    l=100,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-18,50},{2,70}})));
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
    p0_par=110000) annotation (Placement(transformation(extent={{98,50},{118,70}})));
  Modelica.Blocks.Sources.Step step1(
    height=-80000,
    offset=140000,
    startTime=5)
    annotation (Placement(transformation(extent={{138,60},{126,72}})));
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
    value_0=1) annotation (Placement(transformation(extent={{10,50},{30,70}})));
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
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{68,50},{88,70}})));
  UnidirectionalSensorAdapter unidirectionalSensorAdapter1(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{38,70},{58,50}})));
  ThermofluidStream.Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect(
    redeclare package MediumA = Medium,
    redeclare package MediumB = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa,
    outputValue=true,
    filter_output=true) annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={48,34})));
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
    p0_par=100000) annotation (Placement(transformation(extent={{120,-40},{140,-20}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium2,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.01,
    l=100,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  SingleSensorX singleSensorX(redeclare package Medium = Medium2) annotation (Placement(transformation(extent={{-80,-40},
            {-60,-20}})));
  SingleSensorX singleSensorX1(
    redeclare package Medium = Medium2,
    digits=2,
    outputValue=true,
    filter_output=true,
    row=2) annotation (Placement(transformation(extent={{-54,-40},{-34,-20}})));
  SensorState sensorState(redeclare package Medium = Medium2) annotation (Placement(transformation(extent={{56,-40},{76,
            -20}})));
  SingleSensorSelect sensor(redeclare package Medium = Medium2, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_kJpkg)
    annotation (Placement(transformation(extent={{26,-40},{46,-20}})));
  SingleSensorSelect sensor1(redeclare package Medium = Medium2, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_kJpkgK)
    annotation (Placement(transformation(extent={{90,-40},{110,-20}})));
  SingleFlowSensor flowSensor(redeclare package Medium = Medium2, quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_kW)
    annotation (Placement(transformation(extent={{-104,-40},{-84,-20}})));
  SingleFlowSensor flowSensor1(redeclare package Medium = Medium2, quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.S_flow_kWpK)
    annotation (Placement(transformation(extent={{-28,-40},{-8,-20}})));
  SingleFlowSensor flowSensor2(redeclare package Medium = Medium, quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_MW)
    annotation (Placement(transformation(extent={{-44,50},{-24,70}})));
  SingleFlowSensor flowSensor3(redeclare package Medium = Medium, quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.S_flow_MWpK)
    annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
equation
  connect(step.y, boundary_fore.p0_var)
    annotation (Line(points={{125.4,6},{114,6}},   color={0,0,127}));
  connect(singleSensorSelect.rear, flowResistance.fore) annotation (Line(
      points={{10,0},{2,0}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.fore, unidirectionalSensorAdapter.rear)
    annotation (Line(
      points={{30,0},{38,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sensor_vaporQuality1.inlet, unidirectionalSensorAdapter.outlet)
    annotation (Line(
      points={{68,18},{48,18},{48,10}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.fore, singleFlowSensor.rear) annotation (Line(
      points={{-80,0},{-70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(unidirectionalSensorAdapter.fore, sensor_vaporQuality2.rear)
    annotation (Line(
      points={{58,0},{68,0}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore.rear, sensor_vaporQuality2.fore)
    annotation (Line(
      points={{102,0},{88,0}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear.fore, multiSensor_Tpm.rear) annotation (Line(
      points={{-110,-8.88178e-16},{-106,-8.88178e-16},{-106,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(step1.y, boundary_fore1.p0_var) annotation (Line(points={{125.4,66},{110,66}},  color={0,0,127}));
  connect(singleSensorSelect1.rear, flowResistance1.fore)
    annotation (Line(
      points={{10,60},{2,60}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.fore, singleFlowSensor1.rear)
    annotation (Line(
      points={{-80,60},{-70,60}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore1.rear, sensor_vaporQuality4.fore)
    annotation (Line(
      points={{98,60},{88,60}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear1.fore, multiSensor_Tpm1.rear)
    annotation (Line(
      points={{-110,60},{-100,60}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.fore, unidirectionalSensorAdapter1.rear)
    annotation (Line(
      points={{30,60},{38,60}},
      color={28,108,200},
      thickness=0.5));
  connect(unidirectionalSensorAdapter1.fore, sensor_vaporQuality4.rear)
    annotation (Line(
      points={{58,60},{68,60}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceTwoPhaseSensorSensorSelect.inletA, unidirectionalSensorAdapter.outlet)
    annotation (Line(
      points={{48,24},{48,10}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceTwoPhaseSensorSensorSelect.inletB, unidirectionalSensorAdapter1.outlet)
    annotation (Line(
      points={{48,44},{48,50}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorX1.rear, singleSensorX.fore) annotation (Line(
      points={{-54,-30},{-60,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.fore, sensor.rear)
    annotation (Line(
      points={{20,-30},{26,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(sensor.fore, sensorState.rear)
    annotation (Line(
      points={{46,-30},{56,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorState.fore, sensor1.rear)
    annotation (Line(
      points={{76,-30},{90,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(sensor1.fore, boundary_fore2.rear)
    annotation (Line(
      points={{110,-30},{120,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear2.fore, flowSensor.rear)
    annotation (Line(
      points={{-110,-30},{-104,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowSensor.fore, singleSensorX.rear)
    annotation (Line(
      points={{-84,-30},{-80,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.rear, flowSensor1.fore)
    annotation (Line(
      points={{0,-30},{-8,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowSensor1.rear, singleSensorX1.fore)
    annotation (Line(
      points={{-28,-30},{-34,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.rear, flowSensor2.fore)
    annotation (Line(
      points={{-18,60},{-24,60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowSensor2.rear, singleFlowSensor1.fore)
    annotation (Line(
      points={{-44,60},{-50,60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.rear, flowSensor3.fore)
    annotation (Line(
      points={{-18,0},{-24,0}},
      color={28,108,200},
      thickness=0.5));
  connect(flowSensor3.rear, singleFlowSensor.fore)
    annotation (Line(
      points={{-44,0},{-50,0}},
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
