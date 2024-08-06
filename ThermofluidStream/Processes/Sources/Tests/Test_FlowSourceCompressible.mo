within ThermofluidStream.Processes.Sources.Tests;
model Test_FlowSourceCompressible
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.CO2
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
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
    T0_par=293.15)                           annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium, pressureFromInput=true)
                                         annotation (Placement(transformation(extent={{60,10},{80,30}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation (Placement(transformation(extent={{-202,68},
            {-182,88}})));
  Sources.AllMediaBasedOnEntropy.FlowSource flowSource(
    redeclare package Medium = Medium,
    compressor=true,
    eta_is=eta,
    setpoint=ThermofluidStream.Processes.Internal.Types.SetpointModeFlow.m_flow,
    setpointFromInput=true,
    displayEfficiency=true) annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Sensors.SingleSensorSelect singleSensorSelect(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1,
    outputValue=true) annotation (Placement(transformation(extent={{-52,66},{-32,86}})));
  Sensors.SingleSensorSelect singleSensorSelect1(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK,
    outputValue=true) annotation (Placement(transformation(extent={{-52,54},{-32,74}})));
  Sensors.SingleSensorSelect singleSensorSelect2(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa,
    outputValue=true) annotation (Placement(transformation(extent={{-52,42},{-32,62}})));
  Sensors.SingleSensorSelect singleSensorSelect3(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation (Placement(transformation(extent={{-52,30},{-32,50}})));
  Utilities.CompressorIsentropicEfficiencyConstCp compressorIsentropicEfficiency(eta_is=eta)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Sensors.SingleSensorSelect singleSensorSelect4(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa,
    outputValue=true) annotation (Placement(transformation(extent={{36,46},{16,66}})));
  Modelica.Blocks.Sources.Ramp outletPressure(
    height=99e5,
    duration=1,
    offset=1e5) annotation (Placement(transformation(extent={{120,-10},{100,10}})));
  Modelica.Blocks.Sources.Sine massFlowRate(
    amplitude=1,
    f=3,
    offset=2) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Boundaries.Source                   source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15)                           annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Boundaries.Sink                   sink1(redeclare package Medium = Medium, pressureFromInput=true)
                                         annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
  Sources.IdealGasConstantKappa.FlowSourceIdealGas flowControlledSimpleCompressor1(
    redeclare package Medium = Medium,
    eta_is=eta,
    setpoint=ThermofluidStream.Processes.Internal.Types.SetpointModeFlow.m_flow,
    setpointFromInput=true,
    displayEfficiency=true) annotation (Placement(transformation(extent={{-10,-10},{10,-30}})));
  Sensors.SingleSensorSelect singleSensorSelect5(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa,
    outputValue=true) annotation (Placement(transformation(extent={{38,-54},{18,-34}})));
  Sensors.SensorState sensorState(displayInstanceName=false, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Utilities.CompressorIsentropicEfficiencyConstKappa compressorIsentropicEfficiencyConstKappa(redeclare package Medium =
        Medium, eta_is=eta) annotation (Placement(transformation(extent={{-8,-60},{12,-40}})));
equation
  connect(source.outlet, flowSource.inlet)
    annotation (Line(
      points={{-80,20},{-10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.value_out, compressorIsentropicEfficiency.kappa)
    annotation (Line(points={{-33.8,76},{-20,76},{-20,56},{-12,56}},   color={0,0,127}));
  connect(singleSensorSelect1.value_out, compressorIsentropicEfficiency.cp)
    annotation (Line(points={{-33.8,64},{-22,64},{-22,52},{-12,52}},     color={0,0,127}));
  connect(singleSensorSelect2.value_out, compressorIsentropicEfficiency.p1)
    annotation (Line(points={{-33.8,52},{-24,52},{-24,48},{-12,48}},     color={0,0,127}));
  connect(singleSensorSelect3.value_out, compressorIsentropicEfficiency.T1)
    annotation (Line(points={{-33.8,40},{-18,40},{-18,44},{-12,44}},     color={0,0,127}));
  connect(singleSensorSelect.inlet, source.outlet)
    annotation (Line(
      points={{-52,76},{-66,76},{-66,20},{-80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.inlet, source.outlet)
    annotation (Line(
      points={{-52,64},{-66,64},{-66,20},{-80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect2.inlet, source.outlet)
    annotation (Line(
      points={{-52,52},{-66,52},{-66,20},{-80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect3.inlet, source.outlet)
    annotation (Line(
      points={{-52,40},{-66,40},{-66,20},{-80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect4.value_out, compressorIsentropicEfficiency.p2)
    annotation (Line(points={{17.8,56},{12,56}},   color={0,0,127}));
  connect(singleSensorSelect4.inlet, flowSource.outlet)
    annotation (Line(
      points={{36,56},{40,56},{40,20},{10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, flowSource.outlet)
    annotation (Line(
      points={{60,20},{10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(outletPressure.y, sink.p0_var) annotation (Line(points={{99,0},{86,0},{86,20},{72,20}},
                                                                                  color={0,0,127}));
  connect(massFlowRate.y, flowSource.m_flow_var) annotation (Line(points={{-39,0},{0,0},{0,12}}, color={0,0,127}));
  connect(source1.outlet, flowControlledSimpleCompressor1.inlet)
    annotation (Line(
      points={{-80,-20},{-10,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, flowControlledSimpleCompressor1.outlet)
    annotation (Line(
      points={{60,-20},{10,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(outletPressure.y, sink1.p0_var) annotation (Line(points={{99,0},{86,0},{86,-20},{72,-20}}, color={0,0,127}));
  connect(flowControlledSimpleCompressor1.m_flow_var, massFlowRate.y)
    annotation (Line(points={{0,-12},{0,0},{-39,0}}, color={0,0,127}));
  connect(sensorState.state_out, compressorIsentropicEfficiencyConstKappa.inletState)
    annotation (Line(points={{-22,-50},{-10,-50}}, color={162,29,33}));
  connect(sensorState.inlet, source1.outlet) annotation (Line(
      points={{-40,-50},{-50,-50},{-50,-20},{-80,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect5.inlet, flowControlledSimpleCompressor1.outlet)
    annotation (Line(
      points={{38,-44},{50,-44},{50,-20},{10,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect5.value_out, compressorIsentropicEfficiencyConstKappa.p2)
    annotation (Line(points={{19.8,-44},{14,-44}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
The test model shows how arbitrary mass flow rates <code>m_flow > 0</code> can be set without creating nonlinear equation systems.
</p>
<p>
See <a href=\"modelica://ThermofluidStream.Processes.Sources.Tests.Test_PressureSourceCompressible\">Test_PressureSourceCompressible</a> for more information about the behavior concerning media models. 
</p>


</html>"));
end Test_FlowSourceCompressible;
