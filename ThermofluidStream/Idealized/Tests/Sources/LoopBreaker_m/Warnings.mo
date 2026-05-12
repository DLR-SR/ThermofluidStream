within ThermofluidStream.Idealized.Tests.Sources.LoopBreaker_m;
model Warnings "Example - Loop breaker"
  extends Modelica.Icons.Example;
  ThermofluidStream.Idealized.LoopBreaker_m loopBreaker(
    redeclare package Medium = Medium,
    m_flow_in_par=1,
    tol_p=tol_p,
    tol_h=tol_h,
    tol_m_flow=tol_m_flow,
    tol_Xi=tol_Xi,
    p_out_fixed=100000,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.Temperature,
    T_out_fixed=293.15) annotation (Placement(transformation(extent={{80,20},{100,40}})));

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{120,120},{140,140}})));

  ThermofluidStream.Idealized.Processes.Isenthalpic isenthalpic(redeclare package Medium = Medium, outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaric(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.SpecificEnthalpyDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15,
    setEnthalpy=false) annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateSource1(
    redeclare package Medium = Medium,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    m_flow_fixed=0) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  ThermofluidStream.Idealized.Topology.JunctionT2 junction(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{50,40},{70,20}})));
  Modelica.Blocks.Sources.LogFrequencySweep logSweep(
    wMin=0.1,
    wMax=10,
    startTime=0.1,
    duration=1) annotation (Placement(transformation(extent={{-140,-40},{-120,-20}})));
  Modelica.Blocks.Math.Gain gain(k=-tol_p) annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
  Modelica.Blocks.Math.Gain gain1(k=tol_h) annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Math.Gain gain2(k=tol_Xi) annotation (Placement(transformation(extent={{-100,-130},{-80,-110}})));
  parameter SI.PressureDifference tol_p(displayUnit="Pa") = 1 "Absolute tolerance for pressure p_in, p_out";
  parameter SI.SpecificEnthalpy tol_h=500 "Absolute tolerance for specific enthalpy h_in, h_out";
  parameter SI.MassFlowRate tol_m_flow=1e-3 "Absolute tolerance for mass flow rate m_flow_in, m_flow_out";
  ThermofluidStream.Idealized.Processes.MassFractionModifier composition(redeclare package Medium = Medium, outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Blocks.Math.Gain gain3(k=tol_m_flow) annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.LogFrequencySweep logSweep1(
    wMin=0.1,
    wMax=10,
    startTime=0.2,
    duration=1) annotation (Placement(transformation(extent={{-140,-70},{-120,-50}})));
  Modelica.Blocks.Sources.LogFrequencySweep logSweep2(
    wMin=0.1,
    wMax=10,
    startTime=0.3,
    duration=1) annotation (Placement(transformation(extent={{-140,-100},{-120,-80}})));
  Modelica.Blocks.Sources.LogFrequencySweep logSweep3(
    wMin=0.1,
    wMax=10,
    startTime=0.4,
    duration=1) annotation (Placement(transformation(extent={{-140,-130},{-120,-110}})));
  parameter SI.MassFlowRate tol_Xi=1e-5 "Absolute tolerance for mass fractions Xi_in, Xi_out";
equation
  connect(source.outlet, massFlowRateSource1.inlet) annotation (Line(
      points={{-100,0},{-70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateSource1.outlet, junction.inletA) annotation (Line(
      points={{-50,0},{60,0},{60,20}},
      color={28,108,200},
      thickness=0.5));
  connect(junction.outlet, loopBreaker.inlet) annotation (Line(
      points={{70,30},{80,30}},
      color={28,108,200},
      thickness=0.5));
  connect(isenthalpic.outlet, isobaric.inlet) annotation (Line(
      points={{-20,30},{-10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(gain.y, isenthalpic.outletSpec_prescribed) annotation (Line(points={{-79,-60},{-20,-60},{-20,18}}, color={0,0,127}));
  connect(isobaric.outlet, composition.inlet) annotation (Line(
      points={{10,30},{20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(composition.outlet, junction.inletB) annotation (Line(
      points={{40,30},{50,30}},
      color={28,108,200},
      thickness=0.5));
  connect(logSweep.y, gain3.u) annotation (Line(points={{-119,-30},{-102,-30}}, color={0,0,127}));
  connect(logSweep1.y, gain.u) annotation (Line(points={{-119,-60},{-102,-60}}, color={0,0,127}));
  connect(logSweep2.y, gain1.u) annotation (Line(points={{-119,-90},{-102,-90}}, color={0,0,127}));
  connect(logSweep3.y, gain2.u) annotation (Line(points={{-119,-120},{-102,-120}}, color={0,0,127}));
  connect(gain3.y, massFlowRateSource1.m_flow_prescribed) annotation (Line(points={{-79,-30},{-60,-30},{-60,-8}}, color={0,0,127}));
  connect(gain1.y, isobaric.outletSpec_prescribed) annotation (Line(points={{-79,-90},{10,-90},{10,18}}, color={0,0,127}));
  connect(gain2.y, composition.outletSpec_prescribed[1]) annotation (Line(points={{-79,-120},{40,-120},{40,18}}, color={0,0,127}));
  connect(loopBreaker.outlet, isenthalpic.inlet) annotation (Line(
      points={{100,30},{112,30},{112,72},{-52,72},{-52,30},{-40,30}},
      color={28,108,200},
      thickness=0.5));
  annotation (experiment(StopTime=2), Diagram(coordinateSystem(preserveAspectRatio=false,
        grid={2,2},
        extent={{-140,-140},{140,140}})),
    Documentation(info="<html>
  <p>
    Tests warnings.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Warnings;
