within ThermofluidStream.Processes.Sources.Tests.SimplePumpTests;
model Test_PressureControlledSimplePump
  extends ThermofluidStream.Processes.Sources.Tests.SimplePumpTests.BaseClasses.PartialTest_SimplePump;
  Modelica.Blocks.Sources.Sine dp_sine(
    amplitude=4e4,
    f=5e-4,
    offset=5e4,
    startTime=1e3) annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Modelica.Blocks.Sources.Sine p_out_sine(
    amplitude=0.4e5,
    f=5e-4,
    offset=1.5e5,
    startTime=1e3) annotation (Placement(transformation(extent={{-120,-50},{-100,-30}})));
  IncompressibleFluid.PressureSourceIncompressibleFluid pressureControlledSimplePump(
    redeclare package Medium = Medium_liquid,
    p_out_par=200000,
    displaySetpoint=true,
    displayEfficiency=false,
    displayInertance=false,
    setpoint=ThermofluidStream.Processes.Internal.Types.PumpSetpointModePressure.p_out,
    setpointFromInput=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-30,20})));
equation
  connect(p_out_sine.y, pressureControlledSimplePump.p_out_var)
    annotation (Line(points={{-99,-40},{-30,-40},{-30,12}}, color={0,0,127}));
  connect(multiSensor_Tpm3.inlet, pressureControlledSimplePump.outlet)
    annotation (Line(
      points={{-50,20},{-40,20}},
      color={28,108,200},
      thickness=0.5));
  connect(pressureControlledSimplePump.inlet, multiSensor_Tpm2.outlet)
    annotation (Line(
      points={{-20,20},{-10,20}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Test_PressureControlledSimplePump;
