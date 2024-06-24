within ThermofluidStream.Processes.Compressors.Tests;
model Test_PressureSource
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.Ar
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Source. Make sure it is the same as the one
the inlet the source is connected to.
</p>
</html>"));
  parameter SI.Efficiency eta = 0.8 "Isentropic efficiency";
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{80,20},{100,40}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation (Placement(transformation(extent={{-188,84},
            {-168,104}})));
  AllMediaBasedOnEntropy.PressureSource pressureSource(
    redeclare package Medium = Medium,
    eta_is=eta,
    setpoint=ThermofluidStream.Processes.Compressors.Internal.Types.CompressorSetpointModePressure.pr,
    setpointFromInput=true,
    dp_par=100000,
    displayEfficiency=true) annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss,
    l=10,
    r=1e-2) annotation (Placement(transformation(extent={{50,20},{70,40}})));
  Utilities.CompressorIsentropicEfficiencyConstCp compressorIsentropicEfficiency(eta_is=eta)
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Sensors.SingleSensorSelect singleSensorSelect(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1,
    outputValue=true) annotation (Placement(transformation(extent={{-52,64},{-32,84}})));
  Sensors.SingleSensorSelect singleSensorSelect1(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK,
    outputValue=true) annotation (Placement(transformation(extent={{-52,52},{-32,72}})));
  Sensors.SingleSensorSelect singleSensorSelect2(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa,
    outputValue=true) annotation (Placement(transformation(extent={{-52,40},{-32,60}})));
  Sensors.SingleSensorSelect singleSensorSelect3(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation (Placement(transformation(extent={{-52,28},{-32,48}})));
  Sensors.SingleSensorSelect singleSensorSelect4(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa,
    outputValue=true) annotation (Placement(transformation(extent={{36,56},{16,76}})));
  Modelica.Blocks.Sources.Ramp pressureRatio(
    height=99,
    duration=0.9,
    offset=1) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Boundaries.Source                   source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Boundaries.Sink                   sink1(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{80,-30},{100,-10}})));
  IdealGasConstantKappa.PressureSourceIdealGas pressureSourceIdealGas(
    redeclare package Medium = Medium,
    eta_is=eta,
    setpoint=ThermofluidStream.Processes.Compressors.Internal.Types.CompressorSetpointModePressure.pr,
    setpointFromInput=true,
    dp_par=100000,
    displayEfficiency=true) annotation (Placement(transformation(extent={{-10,-10},{10,-30}})));
  FlowResistance                             flowResistance1(
    redeclare package Medium = Medium,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss,
    l=10,
    r=1e-2) annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
  Utilities.CompressorIsentropicEfficiencyConstKappa compressorIsentropicEfficiencyConstKappa(redeclare package Medium =
        Medium, eta_is=eta) annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Sensors.SensorState sensorState(displayInstanceName=false, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-52,-60},{-32,-40}})));
  Sensors.SingleSensorSelect singleSensorSelect5(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa,
    outputValue=true) annotation (Placement(transformation(extent={{36,-54},{16,-34}})));
equation
  connect(source.outlet, pressureSource.inlet)
    annotation (Line(
      points={{-80,30},{-10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(pressureSource.outlet, flowResistance.inlet)
    annotation (Line(
      points={{10,30},{50,30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, sink.inlet)
    annotation (Line(
      points={{70,30},{80,30}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.inlet, source.outlet)
    annotation (Line(
      points={{-52,74},{-66,74},{-66,30},{-80,30}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.inlet, source.outlet)
    annotation (Line(
      points={{-52,62},{-66,62},{-66,30},{-80,30}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.value_out, compressorIsentropicEfficiency.kappa)
    annotation (Line(points={{-33.8,74},{-22,74},{-22,66},{-12,66}}, color={0,0,127}));
  connect(singleSensorSelect1.value_out, compressorIsentropicEfficiency.cp)
    annotation (Line(points={{-33.8,62},{-28,62},{-28,60},{-22,60},{-22,62},{-12,62}},
                                                                   color={0,0,127}));
  connect(singleSensorSelect2.inlet, source.outlet)
    annotation (Line(
      points={{-52,50},{-66,50},{-66,30},{-80,30}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect2.value_out, compressorIsentropicEfficiency.p1)
    annotation (Line(points={{-33.8,50},{-22,50},{-22,58},{-12,58}},   color={0,0,127}));
  connect(singleSensorSelect3.inlet, source.outlet)
    annotation (Line(
      points={{-52,38},{-66,38},{-66,30},{-80,30}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect3.value_out, compressorIsentropicEfficiency.T1)
    annotation (Line(points={{-33.8,38},{-20,38},{-20,54},{-12,54}},     color={0,0,127}));
  connect(singleSensorSelect4.value_out, compressorIsentropicEfficiency.p2)
    annotation (Line(points={{17.8,66},{16,66},{16,64},{14,64},{14,66},{12,66}},
                                                 color={0,0,127}));
  connect(singleSensorSelect4.inlet, pressureSource.outlet)
    annotation (Line(
      points={{36,66},{40,66},{40,30},{10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(pressureRatio.y, pressureSource.pr_var) annotation (Line(points={{-19,0},{0,0},{0,22}}, color={0,0,127}));
  connect(source1.outlet, pressureSourceIdealGas.inlet)
    annotation (Line(
      points={{-80,-20},{-10,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(pressureSourceIdealGas.outlet, flowResistance1.inlet)
    annotation (Line(
      points={{10,-20},{50,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, sink1.inlet)
    annotation (Line(
      points={{70,-20},{80,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(pressureSourceIdealGas.pr_var, pressureRatio.y)
    annotation (Line(points={{0,-12},{0,0},{-19,0}}, color={0,0,127}));
  connect(sensorState.state_out, compressorIsentropicEfficiencyConstKappa.inletState)
    annotation (Line(points={{-34,-50},{-12,-50}}, color={162,29,33}));
  connect(sensorState.inlet, source1.outlet) annotation (Line(
      points={{-52,-50},{-66,-50},{-66,-20},{-80,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect5.value_out, compressorIsentropicEfficiencyConstKappa.p3)
    annotation (Line(points={{17.8,-44},{12,-44}}, color={0,0,127}));
  connect(singleSensorSelect5.inlet, pressureSourceIdealGas.outlet)
    annotation (Line(
      points={{36,-44},{40,-44},{40,-20},{10,-20}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Test_PressureSource;
