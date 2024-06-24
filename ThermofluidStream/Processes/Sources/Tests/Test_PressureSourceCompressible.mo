within ThermofluidStream.Processes.Sources.Tests;
model Test_PressureSourceCompressible
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.CO2
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
    T0_par=293.15) annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{80,10},{100,30}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation (Placement(transformation(extent={{-100,80},
            {-80,100}})));
  Sources.AllMediaBasedOnEntropy.PressureSource pressureSource(
    redeclare package Medium = Medium,
    eta_is=eta,
    setpoint=ThermofluidStream.Processes.Internal.Types.SetpointModePressure.pr,
    setpointFromInput=true,
    dp_par=100000,
    displayEfficiency=true) annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss,
    l=10,
    r=1e-2) annotation (Placement(transformation(extent={{50,10},{70,30}})));
  Utilities.CompressorIsentropicEfficiencyConstCp compressorIsentropicEfficiency(eta_is=eta)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Sensors.SingleSensorSelect singleSensorSelect(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1,
    outputValue=true) annotation (Placement(transformation(extent={{-52,54},{-32,74}})));
  Sensors.SingleSensorSelect singleSensorSelect1(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK,
    outputValue=true) annotation (Placement(transformation(extent={{-52,42},{-32,62}})));
  Sensors.SingleSensorSelect singleSensorSelect2(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa,
    outputValue=true) annotation (Placement(transformation(extent={{-52,30},{-32,50}})));
  Sensors.SingleSensorSelect singleSensorSelect3(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation (Placement(transformation(extent={{-52,18},{-32,38}})));
  Sensors.SingleSensorSelect singleSensorSelect4(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa,
    outputValue=true) annotation (Placement(transformation(extent={{36,46},{16,66}})));
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
  Sources.IdealGasConstantKappa.PressureSourceIdealGas pressureSourceIdealGas(
    redeclare package Medium = Medium,
    eta_is=eta,
    setpoint=ThermofluidStream.Processes.Internal.Types.SetpointModePressure.pr,
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
      points={{-80,20},{-10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(pressureSource.outlet, flowResistance.inlet)
    annotation (Line(
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
      points={{-52,64},{-66,64},{-66,20},{-80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.inlet, source.outlet)
    annotation (Line(
      points={{-52,52},{-66,52},{-66,20},{-80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.value_out, compressorIsentropicEfficiency.kappa)
    annotation (Line(points={{-33.8,64},{-22,64},{-22,56},{-12,56}}, color={0,0,127}));
  connect(singleSensorSelect1.value_out, compressorIsentropicEfficiency.cp)
    annotation (Line(points={{-33.8,52},{-12,52}},                 color={0,0,127}));
  connect(singleSensorSelect2.inlet, source.outlet)
    annotation (Line(
      points={{-52,40},{-66,40},{-66,20},{-80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect2.value_out, compressorIsentropicEfficiency.p1)
    annotation (Line(points={{-33.8,40},{-22,40},{-22,48},{-12,48}},   color={0,0,127}));
  connect(singleSensorSelect3.inlet, source.outlet)
    annotation (Line(
      points={{-52,28},{-66,28},{-66,20},{-80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect3.value_out, compressorIsentropicEfficiency.T1)
    annotation (Line(points={{-33.8,28},{-20,28},{-20,44},{-12,44}},     color={0,0,127}));
  connect(singleSensorSelect4.value_out, compressorIsentropicEfficiency.p2)
    annotation (Line(points={{17.8,56},{12,56}}, color={0,0,127}));
  connect(singleSensorSelect4.inlet, pressureSource.outlet)
    annotation (Line(
      points={{36,56},{40,56},{40,20},{10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(pressureRatio.y, pressureSource.pr_var) annotation (Line(points={{-19,0},{0,0},{0,12}}, color={0,0,127}));
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
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false),
        graphics={Text(
          extent={{-100,140},{100,120}},
          textColor={28,108,200},
          textString="Compare approach using entropy vs approach 
assuming ideal gas with constant kappa for
different media, e.g. Argon and CO2")}),
    Documentation(info="<html>
<p>
Compares:
</p>
<ul>
<li><a href=\"modelica://ThermofluidStream.Processes.Sources.AllMediaBasedOnEntropy.PressureSource\">BasedOnEntropy</a> suitable for \"all\" media, especially non ideal gas/fluid</li>
<li><a href=\"modelica://ThermofluidStream.Processes.Sources.IdealGasConstantKappa.PressureSourceIdealGas\">IdealGasConstantKappa</a> assuming ideal gas with constant kappa</li>
</ul>

<p>
For a few media model, e.g. <a href=\"modelica://ThermofluidStream.Media.myMedia.IdealGases.SingleGases.Ar\">Argon</a> both approaches yield the same results,
for most media models, e.g. <a href=\"modelica://ThermofluidStream.Media.myMedia.IdealGases.SingleGases.CO2\">CO2</a> the results will be different, 
and the user may consider whether <a href=\"modelica://ThermofluidStream.Processes.Sources.IdealGasConstantKappa.PressureSourceIdealGas\">IdealGasConstantKappa</a> is sufficient. 
</p>

<p>
<a href=\"modelica://ThermofluidStream.Processes.Sources.AllMediaBasedOnEntropy.PressureSource\">BasedOnEntropy</a> is more general and should therefor be prefered to <a href=\"modelica://ThermofluidStream.Processes.Sources.IdealGasConstantKappa.PressureSourceIdealGas\">IdealGasConstantKappa</a>.
However there might be Media models where using the entropy function might cause problems and then <a href=\"modelica://ThermofluidStream.Processes.Sources.IdealGasConstantKappa.PressureSourceIdealGas\">IdealGasConstantKappa</a> <strong>might</strong> be faster/more robust. 
</p>

</html>"));
end Test_PressureSourceCompressible;
