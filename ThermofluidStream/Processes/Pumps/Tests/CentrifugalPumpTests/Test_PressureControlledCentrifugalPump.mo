within ThermofluidStream.Processes.Pumps.Tests.CentrifugalPumpTests;
model Test_PressureControlledCentrifugalPump
  extends ThermofluidStream.Processes.Pumps.Tests.BaseClasses.PartialTest_CentrifugalPump;
  Modelica.Blocks.Sources.Sine dp_sine(
    amplitude=4e4,
    f=5e-4,
    offset=5e4,
    startTime=1e3) annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Sources.Sine p_out_sine(
    amplitude=0.4e5,
    f=5e-4,
    offset=1.5e5,
    startTime=1e3) annotation (Placement(transformation(extent={{-120,30},{-100,50}})));
  Modelica.Blocks.Sources.Sine dp_sine1(
    amplitude=4e4,
    f=5e-4,
    offset=5e4,
    startTime=1e3) annotation (Placement(transformation(extent={{-100,-150},{-80,-130}})));
  Modelica.Blocks.Sources.Sine p_out_sine1(
    amplitude=0.4e5,
    f=5e-4,
    offset=1.5e5,
    startTime=1e3) annotation (Placement(transformation(extent={{-120,-170},{-100,-150}})));
  CentrifugalPumps.BasedOnMeasurements.PressureControlledCentrifugalPumpMeasurements pressureControlledCentrifugalPumpMeasurements(
    redeclare package Medium = Medium_liquid,
    redeclare CentrifugalPumps.BasedOnMeasurements.MeasurementData.Wilo.CronolineIL80slash220dash4slash4 data,
    displaySetpoint=true,
    displayInertance=false,
    setpoint=ThermofluidStream.Processes.Pumps.Internal.Types.PumpSetpointModePressure.p_out,
    setpointFromInput=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-30,90})));
  CentrifugalPumps.BasedOnCoefficients.PressureControlledCentrifugalPumpCoefficients
    pressureControlledCentrifugalPumpCoefficients(
    redeclare package Medium = Medium_liquid,
    redeclare CentrifugalPumps.BasedOnCoefficients.CoefficientsData.Wilo.CronolineIL80slash220dash4slash4 coefficients,
    displaySetpoint=true,
    displayInertance=false,
    setpoint=ThermofluidStream.Processes.Pumps.Internal.Types.PumpSetpointModePressure.p_out,
    setpointFromInput=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-30,-100})));

equation
  connect(multiSensor_Tpm3.inlet, pressureControlledCentrifugalPumpMeasurements.outlet)
    annotation (Line(
      points={{-48,90},{-40,90}},
      color={28,108,200},
      thickness=0.5));
  connect(pressureControlledCentrifugalPumpMeasurements.inlet, multiSensor_Tpm2.outlet)
    annotation (Line(
      points={{-20,90},{-10,90}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm13.inlet, pressureControlledCentrifugalPumpCoefficients.outlet)
    annotation (Line(
      points={{-46,-100},{-40,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(pressureControlledCentrifugalPumpCoefficients.inlet, multiSensor_Tpm12.outlet)
    annotation (Line(
      points={{-20,-100},{-10,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_sine1.y, pressureControlledCentrifugalPumpCoefficients.p_out_var)
    annotation (Line(points={{-99,-160},{-30,-160},{-30,-108}}, color={0,0,127}));
  connect(p_out_sine.y, pressureControlledCentrifugalPumpMeasurements.p_out_var)
    annotation (Line(points={{-99,40},{-30,40},{-30,82}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Test_PressureControlledCentrifugalPump;
