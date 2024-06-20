within ThermofluidStream.Processes.Compressors.Tests;
model Test_PressureControlledSimpleCompressor
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.Ar constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium                            "Medium"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Source. Make sure it is the same as the one
the inlet the source is connected to.
</p>
</html>"));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{80,10},{100,30}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  SimpleCompressors.PressureControlledSimpleCompressor pressureControlledSimpleCompressor(redeclare package Medium = Medium,
    eta_is=0.8,
    setpoint=ThermofluidStream.Processes.Compressors.Internal.Types.CompressorSetpointModePressure.pr,
    setpointFromInput=true,
    dp_par=100000,
    displayEfficiency=true)                                                               annotation (Placement(transformation(extent={{-10,30},
            {10,10}})));
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss,
    l=10,
    r=1e-2) annotation (Placement(transformation(extent={{50,10},{70,30}})));
  Utilities.CompressorIsentropicEfficiency compressorIsentropicEfficiency(eta_is=0.8)
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Sensors.SingleSensorSelect singleSensorSelect(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1,
    outputValue=true) annotation (Placement(transformation(extent={{-52,4},{-32,24}})));
  Sensors.SingleSensorSelect singleSensorSelect1(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK,
    outputValue=true) annotation (Placement(transformation(extent={{-52,-8},{-32,12}})));
  Sensors.SingleSensorSelect singleSensorSelect2(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa,
    outputValue=true) annotation (Placement(transformation(extent={{-52,-20},{-32,0}})));
  Sensors.SingleSensorSelect singleSensorSelect3(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation (Placement(transformation(extent={{-52,-32},{-32,-12}})));
  Sensors.SingleSensorSelect singleSensorSelect4(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa,
    outputValue=true) annotation (Placement(transformation(extent={{36,-14},{16,6}})));
  Modelica.Blocks.Sources.Ramp pressureDifference(
    height=10,
    duration=1,
    offset=1) annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
equation
  connect(source.outlet, pressureControlledSimpleCompressor.inlet)
    annotation (Line(
      points={{-80,20},{-10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(pressureControlledSimpleCompressor.outlet, flowResistance.inlet) annotation (Line(
      points={{10,20},{50,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, sink.inlet)
    annotation (Line(
      points={{70,20},{80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.inlet, source.outlet)
    annotation (Line(
      points={{-52,14},{-60,14},{-60,20},{-80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.inlet, source.outlet)
    annotation (Line(
      points={{-52,2},{-60,2},{-60,20},{-80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.value_out, compressorIsentropicEfficiency.kappa)
    annotation (Line(points={{-33.8,14},{-20,14},{-20,-4},{-12,-4}}, color={0,0,127}));
  connect(singleSensorSelect1.value_out, compressorIsentropicEfficiency.cp)
    annotation (Line(points={{-33.8,2},{-22,2},{-22,-8},{-12,-8}}, color={0,0,127}));
  connect(singleSensorSelect2.inlet, source.outlet)
    annotation (Line(
      points={{-52,-10},{-60,-10},{-60,20},{-80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect2.value_out, compressorIsentropicEfficiency.p1)
    annotation (Line(points={{-33.8,-10},{-24,-10},{-24,-12},{-12,-12}},
                                                                       color={0,0,127}));
  connect(singleSensorSelect3.inlet, source.outlet)
    annotation (Line(
      points={{-52,-22},{-60,-22},{-60,20},{-80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect3.value_out, compressorIsentropicEfficiency.T1)
    annotation (Line(points={{-33.8,-22},{-20,-22},{-20,-16},{-12,-16}}, color={0,0,127}));
  connect(singleSensorSelect4.value_out, compressorIsentropicEfficiency.p2)
    annotation (Line(points={{17.8,-4},{12,-4}}, color={0,0,127}));
  connect(singleSensorSelect4.inlet, pressureControlledSimpleCompressor.outlet)
    annotation (Line(
      points={{36,-4},{40,-4},{40,20},{10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(pressureDifference.y, pressureControlledSimpleCompressor.pr_var)
    annotation (Line(points={{-19,50},{0,50},{0,28}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Test_PressureControlledSimpleCompressor;
