within ThermofluidStream.Processes.Pumps.Tests.CentrifugalPumpTests;
model Test_CentrifugalPump
  extends ThermofluidStream.Processes.Pumps.Tests.BaseClasses.PartialTest_CentrifugalPump;
  Modelica.Blocks.Sources.Sine w_sine(
    amplitude=100,
    f=5e-4,
    offset=200,
    startTime=1e3) annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed(exact=false)
                                                    annotation (Placement(transformation(extent={{-78,50},{-58,70}})));
  Modelica.Blocks.Sources.Sine tau_sine(
    amplitude=0.5,
    f=5e-4,
    offset=1,
    startTime=1e3) annotation (Placement(transformation(extent={{-132,20},{-112,40}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=1, w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-70,20},
            {-50,40}})));
  Modelica.Blocks.Sources.Sine w_sine1(
    amplitude=100,
    f=5e-4,
    offset=200,
    startTime=1e3) annotation (Placement(transformation(extent={{-110,-150},{-90,-130}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque1
                                                      annotation (Placement(transformation(extent={{-100,-180},{-80,
            -160}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed1(exact=false)
                                                    annotation (Placement(transformation(extent={{-78,-150},{-58,-130}})));
  Modelica.Blocks.Sources.Sine tau_sine1(
    amplitude=0.5,
    f=5e-4,
    offset=1,
    startTime=1e3) annotation (Placement(transformation(extent={{-132,-180},{-112,-160}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia1(J=1, w(fixed=true, start=0))
                                                                                        annotation (Placement(transformation(extent={{-70,
            -180},{-50,-160}})));
  CentrifugalPumps.BasedOnMeasurements.CentrifugalPumpMeasurements centrifugalPumpMeasurements(redeclare package Medium
      = Medium_liquid, redeclare
      CentrifugalPumps.BasedOnMeasurements.MeasurementData.Wilo.CronolineIL80slash220dash4slash4 data)
    annotation (Placement(transformation(extent={{-20,80},{-40,100}})));
  CentrifugalPumps.BasedOnCoefficients.CentrifugalPumpCoefficients centrifugalPumpCoefficients(redeclare package Medium
      = Medium_liquid, redeclare
      CentrifugalPumps.BasedOnCoefficients.CoefficientsData.Wilo.CronolineIL80slash220dash4slash4 coefficients)
    annotation (Placement(transformation(extent={{-20,-110},{-40,-90}})));
equation
  connect(w_sine.y,speed. w_ref) annotation (Line(points={{-89,60},{-80,60}},   color={0,0,127}));
  connect(tau_sine.y,torque. tau) annotation (Line(points={{-111,30},{-102,30}},   color={0,0,127}));
  connect(torque.flange,inertia. flange_a) annotation (Line(points={{-80,30},{-70,30}},   color={0,0,0}));
  connect(centrifugalPumpMeasurements.flange, speed.flange)
    annotation (Line(points={{-30,80},{-30,60},{-58,60}}, color={0,0,0}));
  connect(w_sine1.y, speed1.w_ref) annotation (Line(points={{-89,-140},{-80,-140}}, color={0,0,127}));
  connect(tau_sine1.y, torque1.tau) annotation (Line(points={{-111,-170},{-102,-170}}, color={0,0,127}));
  connect(torque1.flange, inertia1.flange_a) annotation (Line(points={{-80,-170},{-70,-170}}, color={0,0,0}));
  connect(multiSensor_Tpm3.inlet, centrifugalPumpMeasurements.outlet)
    annotation (Line(
      points={{-48,90},{-40,90}},
      color={28,108,200},
      thickness=0.5));
  connect(centrifugalPumpMeasurements.inlet, multiSensor_Tpm2.outlet)
    annotation (Line(
      points={{-20,90},{-10,90}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm13.inlet, centrifugalPumpCoefficients.outlet)
    annotation (Line(
      points={{-46,-100},{-40,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(centrifugalPumpCoefficients.inlet, multiSensor_Tpm12.outlet)
    annotation (Line(
      points={{-20,-100},{-10,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(speed1.flange, centrifugalPumpCoefficients.flange)
    annotation (Line(points={{-58,-140},{-30,-140},{-30,-110}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Test_CentrifugalPump;
