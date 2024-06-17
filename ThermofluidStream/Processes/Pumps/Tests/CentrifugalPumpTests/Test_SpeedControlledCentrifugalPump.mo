within ThermofluidStream.Processes.Pumps.Tests.CentrifugalPumpTests;
model Test_SpeedControlledCentrifugalPump
  extends ThermofluidStream.Processes.Pumps.Tests.BaseClasses.PartialTest_CentrifugalPump;
  Modelica.Blocks.Sources.Sine w_sine(
    amplitude=100,
    f=5e-4,
    offset=200,
    startTime=1e3) annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Blocks.Sources.Sine w_sine1(
    amplitude=100,
    f=5e-4,
    offset=200,
    startTime=1e3) annotation (Placement(transformation(extent={{-80,-150},{-60,-130}})));
  CentrifugalPumps.BasedOnMeasurements.SpeedControlledCentrifugalPumpMeasurements speedControlledCentrifugalPumpMeasurements(
    redeclare package Medium = Medium_liquid,
    redeclare CentrifugalPumps.BasedOnMeasurements.MeasurementData.Wilo.CronolineIL80slash220dash4slash4 data,
    displaySetpoint=true,
    displayInertance=false,
    setpointFromInput=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-30,90})));
  CentrifugalPumps.BasedOnCoefficients.SpeedControlledCentrifugalPumpCoefficients
    speedControlledCentrifugalPumpCoefficients(
    redeclare package Medium = Medium_liquid,
    redeclare CentrifugalPumps.BasedOnCoefficients.CoefficientsData.Wilo.CronolineIL80slash220dash4slash4 coefficients,

    displaySetpoint=true,
    displayInertance=false,
    setpointFromInput=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-30,-100})));
equation
  connect(w_sine1.y, speedControlledCentrifugalPumpCoefficients.w_var)
    annotation (Line(points={{-59,-140},{-30,-140},{-30,-108}}, color={0,0,127}));
  connect(multiSensor_Tpm13.inlet, speedControlledCentrifugalPumpCoefficients.outlet)
    annotation (Line(
      points={{-46,-100},{-40,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(speedControlledCentrifugalPumpCoefficients.inlet, multiSensor_Tpm12.outlet)
    annotation (Line(
      points={{-20,-100},{-10,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(w_sine.y, speedControlledCentrifugalPumpMeasurements.w_var)
    annotation (Line(points={{-59,60},{-30,60},{-30,82}}, color={0,0,127}));
  connect(multiSensor_Tpm3.inlet, speedControlledCentrifugalPumpMeasurements.outlet)
    annotation (Line(
      points={{-48,90},{-40,90}},
      color={28,108,200},
      thickness=0.5));
  connect(speedControlledCentrifugalPumpMeasurements.inlet, multiSensor_Tpm2.outlet)
    annotation (Line(
      points={{-20,90},{-10,90}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Test_SpeedControlledCentrifugalPump;
