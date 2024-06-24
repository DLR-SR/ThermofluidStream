within ThermofluidStream.Processes.Pumps.Tests.SimplePumpTests;
model Test_FlowSourceIncompressibleFluid
  extends ThermofluidStream.Processes.Pumps.Tests.BaseClasses.PartialTest_SimplePump;
  Modelica.Blocks.Sources.Sine m_flow_sine(
    amplitude=0.9,
    f=5e-4,
    offset=1,
    startTime=1e3) annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.Sine V_flow_sine(
    amplitude=0.9e-3,
    f=5e-4,
    offset=1e-3,
    startTime=1e3) annotation (Placement(transformation(extent={{-120,-30},{-100,-10}})));
  Sources.IncompressibleFluid.FlowSourceIncompressibleFluid flowControlledSimplePump(
    redeclare package Medium = Medium_liquid,
    displaySetpoint=true,
    displayEfficiency=false,
    displayInertance=false,
    setpoint=ThermofluidStream.Processes.Internal.Types.PumpSetpointModeFlow.V_flow,
    setpointFromInput=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-30,20})));
equation
  connect(flowControlledSimplePump.V_flow_var, V_flow_sine.y)
    annotation (Line(points={{-30,12},{-30,-20},{-99,-20}}, color={0,0,127}));
  connect(multiSensor_Tpm3.inlet, flowControlledSimplePump.outlet)
    annotation (Line(
      points={{-50,20},{-40,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowControlledSimplePump.inlet, multiSensor_Tpm2.outlet)
    annotation (Line(
      points={{-20,20},{-10,20}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Test_FlowSourceIncompressibleFluid;
