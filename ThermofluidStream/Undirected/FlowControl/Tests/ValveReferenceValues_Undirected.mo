within ThermofluidStream.Undirected.FlowControl.Tests;
model ValveReferenceValues_Undirected
  "Test for Reference Values in Basic and Specific Valve in undirected flow"
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
  Boundaries.BoundaryRear             boundaryRear(
    redeclare package Medium = medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300)
    annotation (Placement(transformation(extent={{-116,170},{-96,190}})));
  ThermofluidStream.Undirected.FlowControl.BasicControlValve reference(
    redeclare package Medium = medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    dp_ref=200000,
    redeclare function valveCharacteristics =
        ThermofluidStream.FlowControl.Internal.ControlValve.linearCharacteristics,
    flowCoefficient=ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypesBasic.m_flow_set,
    Kvs=5,
    Cvs_UK=0.1,
    m_flow_ref_set=1)
    annotation (Placement(transformation(extent={{-10,170},{10,190}})));

  Boundaries.BoundaryFore           boundaryFore(
                                          redeclare package Medium = medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{96,170},{116,190}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1,
    duration=10,
    offset=0,
    startTime=5)
    annotation (Placement(transformation(extent={{180,-8},{160,12}})));
  Boundaries.BoundaryRear             boundaryRear2(
    redeclare package Medium = medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300)
    annotation (Placement(transformation(extent={{-116,110},{-96,130}})));
  ThermofluidStream.Undirected.FlowControl.BasicControlValve dp_ref(
    redeclare package Medium = medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    invertInput=false,
    dp_ref=200000,
    rho_ref(displayUnit="kg/m3"),
    Kvs=5,
    redeclare function valveCharacteristics =
        ThermofluidStream.FlowControl.Internal.ControlValve.parabolicCharacteristics,
    Cvs_UK=0.1,
    m_flow_ref_set=0.1,
    assertionLevel=AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-10,110},{10,130}})));

  Boundaries.BoundaryFore           boundaryFore2(
                                          redeclare package Medium = medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{96,110},{116,130}})));
  Boundaries.BoundaryRear             boundaryRear3(
    redeclare package Medium = medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300)
    annotation (Placement(transformation(extent={{-116,50},{-96,70}})));
  ThermofluidStream.Undirected.FlowControl.BasicControlValve rho_ref(
    redeclare package Medium = medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    rho_ref=10000,
    Kvs=5,
    redeclare function valveCharacteristics =
        ThermofluidStream.FlowControl.Internal.ControlValve.equalPercentageCharacteristics,
    assertionLevel=AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));

  Boundaries.BoundaryFore           boundaryFore3(
                                          redeclare package Medium = medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{96,50},{116,70}})));
  Modelica.Blocks.Sources.Constant const2(k=1.1e5)
    annotation (Placement(transformation(extent={{-184,-4},{-164,16}})));
  Boundaries.BoundaryRear boundaryRear4(
    redeclare package Medium = medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300)
    annotation (Placement(transformation(extent={{-116,-50},{-96,-30}})));
  ThermofluidStream.Undirected.FlowControl.SpecificValveType
                                                  reference1(
    redeclare package Medium = medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    Kvs=5) annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Boundaries.BoundaryFore boundaryFore4(redeclare package Medium = medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{96,-50},{116,-30}})));
  Boundaries.BoundaryRear boundaryRear5(
    redeclare package Medium = medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300)
    annotation (Placement(transformation(extent={{-116,-110},{-96,-90}})));
  ThermofluidStream.Undirected.FlowControl.SpecificValveType
                                                  dp_ref1(
    redeclare package Medium = medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    invertInput=false,
    dp_ref=200000,
    rho_ref(displayUnit="kg/m3"),
    Kvs=5,
    m_flow_ref_set=0.1,
    assertionLevel=AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Boundaries.BoundaryFore boundaryFore5(redeclare package Medium = medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{96,-110},{116,-90}})));
  Boundaries.BoundaryRear boundaryRear1(
    redeclare package Medium = medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300)
    annotation (Placement(transformation(extent={{-116,-170},{-96,-150}})));
  ThermofluidStream.Undirected.FlowControl.SpecificValveType
                                                  rho_ref1(
    redeclare package Medium = medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    rho_ref=10000,
    Kvs=5,
    assertionLevel=AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-10,-170},{10,-150}})));
  Boundaries.BoundaryFore boundaryFore1(redeclare package Medium = medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{96,-170},{116,-150}})));
equation
  connect(boundaryRear3.p0_var, const2.y) annotation (Line(points={{-108,66},{-158,
          66},{-158,6},{-163,6}}, color={0,0,127}));
  connect(ramp.y, dp_ref.u_in) annotation (Line(points={{159,2},{124,2},{124,
          148},{0,148},{0,128}}, color={0,0,127}));
  connect(ramp.y, rho_ref.u_in) annotation (Line(points={{159,2},{124,2},{124,
          88},{0,88},{0,68}}, color={0,0,127}));
  connect(boundaryRear.p0_var, const2.y) annotation (Line(points={{-108,186},{-158,
          186},{-158,6},{-163,6}}, color={0,0,127}));
  connect(const2.y, boundaryRear2.p0_var) annotation (Line(points={{-163,6},{-158,
          6},{-158,126},{-108,126}}, color={0,0,127}));
  connect(reference.u_in, ramp.y) annotation (Line(points={{0,188},{0,208},{150,
          208},{150,2},{159,2}}, color={0,0,127}));
  connect(boundaryRear1.p0_var, const2.y) annotation (Line(points={{-108,-154},
          {-158,-154},{-158,6},{-163,6}}, color={0,0,127}));
  connect(ramp.y, dp_ref1.u_in) annotation (Line(points={{159,2},{124,2},{124,
          -72},{0,-72},{0,-92}}, color={0,0,127}));
  connect(ramp.y, rho_ref1.u_in) annotation (Line(points={{159,2},{124,2},{124,
          -132},{0,-132},{0,-152}}, color={0,0,127}));
  connect(boundaryRear4.p0_var, const2.y) annotation (Line(points={{-108,-34},{
          -158,-34},{-158,6},{-163,6}}, color={0,0,127}));
  connect(const2.y, boundaryRear5.p0_var) annotation (Line(points={{-163,6},{-158,
          6},{-158,-94},{-108,-94}}, color={0,0,127}));
  connect(reference1.u_in, ramp.y)
    annotation (Line(points={{0,-32},{0,2},{159,2}}, color={0,0,127}));
  connect(boundaryRear.fore, reference.rear) annotation (Line(
      points={{-96,180},{-10,180}},
      color={28,108,200},
      thickness=0.5));
  connect(reference.fore, boundaryFore.rear) annotation (Line(
      points={{10,180},{96,180}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_ref.rear, boundaryRear2.fore) annotation (Line(
      points={{-10,120},{-96,120}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_ref.fore, boundaryFore2.rear) annotation (Line(
      points={{10,120},{96,120}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryRear3.fore, rho_ref.rear) annotation (Line(
      points={{-96,60},{-10,60}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_ref.fore, boundaryFore3.rear) annotation (Line(
      points={{10,60},{96,60}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryRear4.fore, reference1.rear) annotation (Line(
      points={{-96,-40},{-10,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(reference1.fore, boundaryFore4.rear) annotation (Line(
      points={{10,-40},{96,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryRear5.fore, dp_ref1.rear) annotation (Line(
      points={{-96,-100},{-10,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_ref1.fore, boundaryFore5.rear) annotation (Line(
      points={{10,-100},{96,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryRear1.fore, rho_ref1.rear) annotation (Line(
      points={{-96,-160},{-10,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_ref1.fore, boundaryFore1.rear) annotation (Line(
      points={{10,-160},{96,-160}},
      color={28,108,200},
      thickness=0.5));
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
end ValveReferenceValues_Undirected;
