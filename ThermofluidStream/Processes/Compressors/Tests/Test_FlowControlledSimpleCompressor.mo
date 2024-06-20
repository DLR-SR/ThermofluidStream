within ThermofluidStream.Processes.Compressors.Tests;
model Test_FlowControlledSimpleCompressor
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.CO2
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Source. Make sure it is the same as the one
the inlet the source is connected to.
</p>
</html>"));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15)                           annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium, pressureFromInput=true)
                                         annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  SimpleCompressors.FlowControlledSimpleCompressor flowControlledSimpleCompressor(redeclare package Medium = Medium,
    eta_is=0.8,
    setpointFromInput=true,
    displayEfficiency=true)                                                                                                          annotation (Placement(transformation(extent={{-10,10},
            {10,-10}})));
  Sensors.SingleSensorSelect singleSensorSelect(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1,
    outputValue=true) annotation (Placement(transformation(extent={{-52,-16},{-32,4}})));
  Sensors.SingleSensorSelect singleSensorSelect1(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK,
    outputValue=true) annotation (Placement(transformation(extent={{-52,-28},{-32,-8}})));
  Sensors.SingleSensorSelect singleSensorSelect2(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa,
    outputValue=true) annotation (Placement(transformation(extent={{-52,-40},{-32,-20}})));
  Sensors.SingleSensorSelect singleSensorSelect3(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation (Placement(transformation(extent={{-52,-52},{-32,-32}})));
  Utilities.CompressorIsentropicEfficiency compressorIsentropicEfficiency(eta_is=0.8)
    annotation (Placement(transformation(extent={{-10,-42},{10,-22}})));
  Sensors.SingleSensorSelect singleSensorSelect4(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa,
    outputValue=true) annotation (Placement(transformation(extent={{36,-36},{16,-16}})));
  Modelica.Blocks.Sources.Ramp outletPressure(
    height=10e5,
    duration=1,
    offset=1e5) annotation (Placement(transformation(extent={{120,-10},{100,10}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=1,
    f=3,
    offset=2) annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
equation
  connect(source.outlet, flowControlledSimpleCompressor.inlet) annotation (Line(
      points={{-80,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.value_out, compressorIsentropicEfficiency.kappa)
    annotation (Line(points={{-33.8,-6},{-20,-6},{-20,-26},{-12,-26}}, color={0,0,127}));
  connect(singleSensorSelect1.value_out, compressorIsentropicEfficiency.cp)
    annotation (Line(points={{-33.8,-18},{-22,-18},{-22,-30},{-12,-30}}, color={0,0,127}));
  connect(singleSensorSelect2.value_out, compressorIsentropicEfficiency.p1)
    annotation (Line(points={{-33.8,-30},{-24,-30},{-24,-34},{-12,-34}}, color={0,0,127}));
  connect(singleSensorSelect3.value_out, compressorIsentropicEfficiency.T1)
    annotation (Line(points={{-33.8,-42},{-18,-42},{-18,-38},{-12,-38}}, color={0,0,127}));
  connect(singleSensorSelect.inlet, source.outlet)
    annotation (Line(
      points={{-52,-6},{-60,-6},{-60,0},{-80,0}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.inlet, source.outlet)
    annotation (Line(
      points={{-52,-18},{-60,-18},{-60,0},{-80,0}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect2.inlet, source.outlet)
    annotation (Line(
      points={{-52,-30},{-60,-30},{-60,0},{-80,0}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect3.inlet, source.outlet)
    annotation (Line(
      points={{-52,-42},{-60,-42},{-60,0},{-80,0}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect4.value_out, compressorIsentropicEfficiency.p2)
    annotation (Line(points={{17.8,-26},{12,-26}}, color={0,0,127}));
  connect(singleSensorSelect4.inlet, flowControlledSimpleCompressor.outlet)
    annotation (Line(
      points={{36,-26},{40,-26},{40,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, flowControlledSimpleCompressor.outlet)
    annotation (Line(
      points={{60,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(outletPressure.y, sink.p0_var) annotation (Line(points={{99,0},{72,0}}, color={0,0,127}));
  connect(sine.y, flowControlledSimpleCompressor.m_flow_var)
    annotation (Line(points={{-19,30},{0,30},{0,8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Test_FlowControlledSimpleCompressor;
