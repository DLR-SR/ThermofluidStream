within ThermofluidStream.FlowControl.Tests;
model ValveReferenceValues
  "Test for Reference Values in Basic and Specific Valve"
  extends Modelica.Icons.Example;

  replaceable package medium = ThermofluidStream.Media.myMedia.Water.ConstantPropertyLiquidWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium package"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Test.
</p>
</html>"));

  inner ThermofluidStream.DropOfCommons dropOfCommons(assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-12,10},{8,30}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300)
    annotation (Placement(transformation(extent={{-116,170},{-96,190}})));
  FlowControl.BasicControlValve reference(
    redeclare package Medium = medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function valveCharacteristics =
        ThermofluidStream.FlowControl.Internal.ControlValve.linearCharacteristics,
    Kvs=5) annotation (Placement(transformation(extent={{-10,170},{10,190}})));

  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium = medium,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e3))
    annotation (Placement(transformation(extent={{-80,170},{-60,190}})));
  ThermofluidStream.Boundaries.Sink sink1(redeclare package Medium = medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{96,170},{116,190}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package
      Medium = medium)
    annotation (Placement(transformation(extent={{-40,180},{-20,200}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package
      Medium = medium)
    annotation (Placement(transformation(extent={{26,180},{46,200}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1,
    duration=10,
    offset=0,
    startTime=5)
    annotation (Placement(transformation(extent={{180,-8},{160,12}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300)
    annotation (Placement(transformation(extent={{-116,110},{-96,130}})));
  FlowControl.BasicControlValve dp_ref(
    redeclare package Medium = medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    invertInput=false,
    dp_ref=200000,
    rho_ref(displayUnit="kg/m3"),
    Kvs=5,
    redeclare function valveCharacteristics =
        Internal.ControlValve.parabolicCharacteristics,
    m_flow_ref_set=0.1,
    assertionLevel=AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-10,110},{10,130}})));

  ThermofluidStream.Boundaries.Sink sink2(redeclare package Medium = medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{96,110},{116,130}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm4(redeclare package
      Medium = medium)
    annotation (Placement(transformation(extent={{-40,120},{-20,140}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm5(redeclare package
      Medium = medium)
    annotation (Placement(transformation(extent={{26,120},{46,140}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300)
    annotation (Placement(transformation(extent={{-116,50},{-96,70}})));
  FlowControl.BasicControlValve rho_ref(
    redeclare package Medium = medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    rho_ref=10000,
    Kvs=5,
    redeclare function valveCharacteristics =
        Internal.ControlValve.equalPercentageCharacteristics,
    assertionLevel=AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));

  ThermofluidStream.Boundaries.Sink sink3(redeclare package Medium = medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{96,50},{116,70}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm7(redeclare package
      Medium = medium)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm8(redeclare package
      Medium = medium)
    annotation (Placement(transformation(extent={{26,60},{46,80}})));
  Modelica.Blocks.Sources.Constant const2(k=1.1e5)
    annotation (Placement(transformation(extent={{-184,-4},{-164,16}})));
  Processes.FlowResistance flowResistance6(
    redeclare package Medium = medium,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e3))
    annotation (Placement(transformation(extent={{66,170},{86,190}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = medium,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e3))
    annotation (Placement(transformation(extent={{68,110},{88,130}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = medium,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e3))
    annotation (Placement(transformation(extent={{-80,110},{-60,130}})));
  Processes.FlowResistance flowResistance3(
    redeclare package Medium = medium,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e3))
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Processes.FlowResistance flowResistance4(
    redeclare package Medium = medium,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e3))
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Boundaries.Source                   source3(
    redeclare package Medium = medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300)
    annotation (Placement(transformation(extent={{-116,-50},{-96,-30}})));
  ThermofluidStream.FlowControl.SpecificValveType reference1(
    redeclare package Medium = medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    Kvs=5) annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Processes.FlowResistance                   flowResistance5(
    redeclare package Medium = medium,
    r=0.05,
    l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=1e3))
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Boundaries.Sink                   sink4(redeclare package Medium = medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{96,-50},{116,-30}})));
  Sensors.MultiSensor_Tpm                   multiSensor_Tpm1(redeclare package
      Medium = medium)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Sensors.MultiSensor_Tpm                   multiSensor_Tpm6(redeclare package
      Medium = medium)
    annotation (Placement(transformation(extent={{26,-40},{46,-20}})));
  Boundaries.Source                   source4(
    redeclare package Medium = medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300)
    annotation (Placement(transformation(extent={{-116,-110},{-96,-90}})));
  ThermofluidStream.FlowControl.SpecificValveType dp_ref1(
    redeclare package Medium = medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    invertInput=false,
    dp_ref=200000,
    rho_ref(displayUnit="kg/m3"),
    Kvs=5,
    m_flow_ref_set=0.1,
    assertionLevel=AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Boundaries.Sink                   sink5(redeclare package Medium = medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{96,-110},{116,-90}})));
  Sensors.MultiSensor_Tpm                   multiSensor_Tpm9(redeclare package
      Medium = medium)
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  Sensors.MultiSensor_Tpm                   multiSensor_Tpm10(redeclare package
      Medium = medium)
    annotation (Placement(transformation(extent={{26,-100},{46,-80}})));
  Boundaries.Source                   source5(
    redeclare package Medium = medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300)
    annotation (Placement(transformation(extent={{-116,-170},{-96,-150}})));
  ThermofluidStream.FlowControl.SpecificValveType rho_ref1(
    redeclare package Medium = medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    rho_ref=10000,
    Kvs=5,
    assertionLevel=AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-10,-170},{10,-150}})));
  Boundaries.Sink                   sink6(redeclare package Medium = medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{96,-170},{116,-150}})));
  Sensors.MultiSensor_Tpm                   multiSensor_Tpm11(redeclare package
      Medium = medium)
    annotation (Placement(transformation(extent={{-40,-160},{-20,-140}})));
  Sensors.MultiSensor_Tpm                   multiSensor_Tpm12(redeclare package
      Medium = medium)
    annotation (Placement(transformation(extent={{26,-160},{46,-140}})));
  Processes.FlowResistance flowResistance7(
    redeclare package Medium = medium,
    r=0.05,
    l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=1e3))
    annotation (Placement(transformation(extent={{66,-50},{86,-30}})));
  Processes.FlowResistance flowResistance8(
    redeclare package Medium = medium,
    r=0.05,
    l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=1e3))
    annotation (Placement(transformation(extent={{68,-110},{88,-90}})));
  Processes.FlowResistance flowResistance9(
    redeclare package Medium = medium,
    r=0.05,
    l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=1e3))
    annotation (Placement(transformation(extent={{-80,-110},{-60,-90}})));
  Processes.FlowResistance flowResistance10(
    redeclare package Medium = medium,
    r=0.05,
    l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=1e3))
    annotation (Placement(transformation(extent={{-80,-170},{-60,-150}})));
  Processes.FlowResistance flowResistance11(
    redeclare package Medium = medium,
    r=0.05,
    l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=1e3))
    annotation (Placement(transformation(extent={{60,-170},{80,-150}})));
equation
  connect(reference.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{-10,180},{-20,180}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.inlet, reference.outlet) annotation (Line(
      points={{26,180},{10,180}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, multiSensor_Tpm2.inlet) annotation (Line(
      points={{-60,180},{-40,180}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_ref.inlet, multiSensor_Tpm4.outlet) annotation (Line(
      points={{-10,120},{-20,120}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm5.inlet, dp_ref.outlet) annotation (Line(
      points={{26,120},{10,120}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_ref.inlet, multiSensor_Tpm7.outlet) annotation (Line(
      points={{-10,60},{-20,60}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm8.inlet, rho_ref.outlet) annotation (Line(
      points={{26,60},{10,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.p0_var, const2.y) annotation (Line(points={{-108,66},{-158,66},
          {-158,6},{-163,6}},   color={0,0,127}));
  connect(ramp.y, dp_ref.u_in) annotation (Line(points={{159,2},{124,2},{124,
          148},{0,148},{0,128}}, color={0,0,127}));
  connect(ramp.y, rho_ref.u_in) annotation (Line(points={{159,2},{124,2},{124,
          88},{0,88},{0,68}}, color={0,0,127}));
  connect(source.p0_var, const2.y) annotation (Line(points={{-108,186},{-158,
          186},{-158,6},{-163,6}},              color={0,0,127}));
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{-96,180},{-80,180}},
      color={28,108,200},
      thickness=0.5));
  connect(const2.y, source1.p0_var) annotation (Line(points={{-163,6},{-158,6},
          {-158,126},{-108,126}},
                               color={0,0,127}));
  connect(multiSensor_Tpm3.outlet, flowResistance6.inlet) annotation (Line(
      points={{46,180},{66,180}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, flowResistance6.outlet) annotation (Line(
      points={{96,180},{86,180}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm5.outlet, flowResistance1.inlet) annotation (Line(
      points={{46,120},{68,120}},
      color={28,108,200},
      thickness=0.5));
  connect(sink2.inlet, flowResistance1.outlet) annotation (Line(
      points={{96,120},{88,120}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowResistance2.inlet) annotation (Line(
      points={{-96,120},{-80,120}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm4.inlet, flowResistance2.outlet) annotation (Line(
      points={{-40,120},{-60,120}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, flowResistance3.inlet) annotation (Line(
      points={{-96,60},{-80,60}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm7.inlet, flowResistance3.outlet) annotation (Line(
      points={{-40,60},{-60,60}},
      color={28,108,200},
      thickness=0.5));
  connect(sink3.inlet, flowResistance4.outlet) annotation (Line(
      points={{96,60},{80,60}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm8.outlet, flowResistance4.inlet) annotation (Line(
      points={{46,60},{60,60}},
      color={28,108,200},
      thickness=0.5));
  connect(reference.u_in, ramp.y) annotation (Line(points={{0,188},{0,208},{150,
          208},{150,2},{159,2}}, color={0,0,127}));
  connect(reference1.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{-10,-40},{-20,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm6.inlet, reference1.outlet) annotation (Line(
      points={{26,-40},{10,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance5.outlet, multiSensor_Tpm1.inlet) annotation (Line(
      points={{-60,-40},{-40,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_ref1.inlet, multiSensor_Tpm9.outlet) annotation (Line(
      points={{-10,-100},{-20,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm10.inlet, dp_ref1.outlet) annotation (Line(
      points={{26,-100},{10,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_ref1.inlet, multiSensor_Tpm11.outlet) annotation (Line(
      points={{-10,-160},{-20,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm12.inlet, rho_ref1.outlet) annotation (Line(
      points={{26,-160},{10,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(source5.p0_var, const2.y) annotation (Line(points={{-108,-154},{-158,
          -154},{-158,6},{-163,6}},
                                color={0,0,127}));
  connect(ramp.y, dp_ref1.u_in) annotation (Line(points={{159,2},{124,2},{124,
          -72},{0,-72},{0,-92}}, color={0,0,127}));
  connect(ramp.y, rho_ref1.u_in) annotation (Line(points={{159,2},{124,2},{124,
          -132},{0,-132},{0,-152}}, color={0,0,127}));
  connect(source3.p0_var, const2.y) annotation (Line(points={{-108,-34},{-158,
          -34},{-158,6},{-163,6}}, color={0,0,127}));
  connect(source3.outlet, flowResistance5.inlet) annotation (Line(
      points={{-96,-40},{-80,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(const2.y,source4. p0_var) annotation (Line(points={{-163,6},{-158,6},
          {-158,-94},{-108,-94}},
                               color={0,0,127}));
  connect(multiSensor_Tpm6.outlet,flowResistance7. inlet) annotation (Line(
      points={{46,-40},{66,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(sink4.inlet,flowResistance7. outlet) annotation (Line(
      points={{96,-40},{86,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm10.outlet, flowResistance8.inlet) annotation (Line(
      points={{46,-100},{68,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(sink5.inlet,flowResistance8. outlet) annotation (Line(
      points={{96,-100},{88,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet,flowResistance9. inlet) annotation (Line(
      points={{-96,-100},{-80,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm9.inlet,flowResistance9. outlet) annotation (Line(
      points={{-40,-100},{-60,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(source5.outlet, flowResistance10.inlet) annotation (Line(
      points={{-96,-160},{-80,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm11.inlet, flowResistance10.outlet) annotation (Line(
      points={{-40,-160},{-60,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(sink6.inlet, flowResistance11.outlet) annotation (Line(
      points={{96,-160},{80,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm12.outlet, flowResistance11.inlet) annotation (Line(
      points={{46,-160},{60,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(reference1.u_in, ramp.y)
    annotation (Line(points={{0,-32},{0,2},{159,2}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-180,-200},{180,220}}, grid={2,
            2})),
    experiment(
      StopTime=20,
      Interval=0.02,
   Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>
This test model verifies the safeguards for the reference values
<code>dp_ref</code> and <code>rho_ref</code> in
<code>BasicControlValve</code> and <code>SpecificValveType</code>.
</p>
<p>
When a valve is parameterized using <code>Kvs</code>,
<code>Cvs_US</code>, or <code>Cvs_UK</code>, the reference values must
remain at their defaults:
</p>
<ul>
<li><code>dp_ref = 1 bar</code></li>
<li><code>rho_ref = 1000 kg/m3</code></li>
</ul>
<p>
The model contains correctly parameterized reference valves as well as
valves with modified reference values. The latter use
<code>assertionLevel = AssertionLevel.warning</code>, allowing the
simulation to continue while demonstrating the corresponding assertion
messages.
</p>
<p>
The test verifies that modifying <code>dp_ref</code> or
<code>rho_ref</code> for standardized flow coefficients is detected,
while valves using the default reference values do not trigger these
assertions.
</p>
</html>"));
end ValveReferenceValues;
