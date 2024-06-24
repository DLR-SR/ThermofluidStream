within ThermofluidStream.Processes.Pumps.Tests.CentrifugalPumpTests;
model Test_FlowControlledCentrifugalPumps
  extends ThermofluidStream.Processes.Pumps.Tests.BaseClasses.PartialTest_CentrifugalPump;
  Modelica.Blocks.Sources.Sine m_flow_sine(
    amplitude=0.9,
    f=5e-4,
    offset=1,
    startTime=1e3) annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Blocks.Sources.Sine V_flow_sine(
    amplitude=0.9e-3,
    f=5e-4,
    offset=1e-3,
    startTime=1e3) annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  Modelica.Blocks.Sources.Sine m_flow_sine1(
    amplitude=0.9,
    f=5e-4,
    offset=1,
    startTime=1e3) annotation (Placement(transformation(extent={{-80,-150},{-60,-130}})));
  Modelica.Blocks.Sources.Sine V_flow_sine1(
    amplitude=0.9e-3,
    f=5e-4,
    offset=1e-3,
    startTime=1e3) annotation (Placement(transformation(extent={{-100,-170},{-80,-150}})));
  CentrifugalPumps.BasedOnMeasurements.FlowControlledCentrifugalPumpMeasurements
    flowControlledCentrifugalPumpMeasurements(
    displayInstanceName=true,
    redeclare package Medium = Medium_liquid,
    redeclare CentrifugalPumps.BasedOnMeasurements.MeasurementData.Wilo.CronolineIL80slash220dash4slash4 data,
    displaySetpoint=true,
    displayInertance=false,
    setpoint=ThermofluidStream.Processes.Internal.Types.PumpSetpointModeFlow.m_flow,
    setpointFromInput=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-30,90})));
  CentrifugalPumps.BasedOnCoefficients.FlowControlledCentrifugalPumpCoefficients
    flowControlledCentrifugalPumpCoefficients(
    displayInstanceName=true,
    redeclare package Medium = Medium_liquid,
    redeclare CentrifugalPumps.BasedOnCoefficients.CoefficientsData.GenericPumpCoefficients coefficients(
      rho_ref=1000,
      w_ref=157.07963267949,
      head_ref=10,
      V_flow_ref(displayUnit="m3/s") = 5e-3,
      c2_head=0.23,
      Vr_peak=0.5,
      c3_power=-0.28),
    displaySetpoint=true,
    displayInertance=false,
    setpoint=ThermofluidStream.Processes.Internal.Types.PumpSetpointModeFlow.m_flow,
    setpointFromInput=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-30,-100})));
equation
  connect(m_flow_sine1.y, flowControlledCentrifugalPumpCoefficients.m_flow_var)
    annotation (Line(points={{-59,-140},{-30,-140},{-30,-108}}, color={0,0,127}));
  connect(m_flow_sine.y, flowControlledCentrifugalPumpMeasurements.m_flow_var)
    annotation (Line(points={{-59,60},{-30,60},{-30,82}}, color={0,0,127}));
  connect(multiSensor_Tpm13.inlet, flowControlledCentrifugalPumpCoefficients.outlet)
    annotation (Line(
      points={{-46,-100},{-40,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(flowControlledCentrifugalPumpCoefficients.inlet, multiSensor_Tpm12.outlet)
    annotation (Line(
      points={{-20,-100},{-10,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.inlet, flowControlledCentrifugalPumpMeasurements.outlet)
    annotation (Line(
      points={{-48,90},{-40,90}},
      color={28,108,200},
      thickness=0.5));
  connect(flowControlledCentrifugalPumpMeasurements.inlet, multiSensor_Tpm2.outlet)
    annotation (Line(
      points={{-20,90},{-10,90}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Test_FlowControlledCentrifugalPumps;
