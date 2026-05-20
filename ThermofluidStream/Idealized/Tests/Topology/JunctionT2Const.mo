within ThermofluidStream.Idealized.Tests.Topology;
model JunctionT2Const "Example - JunctionT2 with constant mass flow rate sources"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{180,80},{200,100}})));

  ThermofluidStream.Boundaries.Source sourceA(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-200,60},{-180,80}})));
  ThermofluidStream.Boundaries.Sink
                    sink(redeclare package Medium = Medium,
    p0_par=100000,
    L=1e4)                                                 annotation(Placement(transformation(extent={{-110,20},{-90,40}})));
  ThermofluidStream.Processes.FlowResistance flowResistanceB(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k2=1e5) "Linear-quadratic",
    l=1,
    r=1) annotation(Placement(transformation(extent={{-170,20},{-150,40}})));
  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = Medium,
    p0_par=200000,
    T0_par=313.15) annotation(Placement(transformation(extent={{-200,20},{-180,40}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateA(
    redeclare package Medium = Medium,

    m_flow_fixed=1) annotation(Placement(transformation(extent={{-170,60},{-150,80}})));
  ThermofluidStream.Idealized.Topology.JunctionT2 junction(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-140,20},{-120,40}})));
  ThermofluidStream.Boundaries.Source sourceB1(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-50,20},{-30,40}})));
  ThermofluidStream.Boundaries.Sink
                    sink1(
    redeclare package Medium = Medium,
    p0_par=100000,
    L=1e4)                                                 annotation(Placement(transformation(extent={{40,20},{60,40}})));
  ThermofluidStream.Processes.FlowResistance
                       flowResistanceA(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k2=1e5) "Linear-quadratic",
    l=1,
    r=1)                                                                                       annotation(Placement(transformation(extent={{-20,60},{0,80}})));
  ThermofluidStream.Boundaries.Source sourceA1(
    redeclare package Medium = Medium,
    p0_par=200000,
    T0_par=313.15) annotation(Placement(transformation(extent={{-50,60},{-30,80}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateB(
    redeclare package Medium = Medium,

    m_flow_fixed=1) annotation(Placement(transformation(extent={{-20,20},{0,40}})));
  ThermofluidStream.Idealized.Topology.JunctionT2 junction1(free=ThermofluidStream.Idealized.Topology.Types.FreeJunctionInlet.B, redeclare package Medium = Medium) annotation(Placement(transformation(extent={{10,20},{30,40}})));
  ThermofluidStream.Boundaries.Source sourceA2(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-200,-40},{-180,-20}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink2(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-110,-80},{-90,-60}})));
  ThermofluidStream.Boundaries.Source sourceB2(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=313.15) annotation(Placement(transformation(extent={{-200,-80},{-180,-60}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateA2(
    redeclare package Medium = Medium,

    m_flow_fixed=1) annotation(Placement(transformation(extent={{-170,-40},{-150,-20}})));
  ThermofluidStream.Idealized.Topology.JunctionT2 junction2(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-140,-80},{-120,-60}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateB2(
    redeclare package Medium = Medium,

    m_flow_fixed=1) annotation(Placement(transformation(extent={{-170,-80},{-150,-60}})));
  ThermofluidStream.Boundaries.Source sourceA3(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-70,-40},{-50,-20}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink3(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{20,-80},{40,-60}})));
  ThermofluidStream.Boundaries.Source sourceB3(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=313.15) annotation(Placement(transformation(extent={{-70,-80},{-50,-60}})));
  ThermofluidStream.Idealized.Topology.JunctionT2 junction3(free=ThermofluidStream.Idealized.Topology.Types.FreeJunctionInlet.B, redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-10,-80},{10,-60}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateB1(
    redeclare package Medium = Medium,

    m_flow_fixed=1) annotation(Placement(transformation(extent={{-40,-80},{-20,-60}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateA1(
    redeclare package Medium = Medium,

    m_flow_fixed=1) annotation(Placement(transformation(extent={{-40,-40},{-20,-20}})));
  ThermofluidStream.Boundaries.Source sourceA4(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{50,-40},{70,-20}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink4(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{170,-80},{190,-60}})));
  ThermofluidStream.Boundaries.Source sourceB4(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=313.15) annotation(Placement(transformation(extent={{50,-80},{70,-60}})));
  ThermofluidStream.Idealized.Topology.JunctionT2 junction4(free=ThermofluidStream.Idealized.Topology.Types.FreeJunctionInlet.B, redeclare package Medium = Medium) annotation(Placement(transformation(extent={{110,-80},{130,-60}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateB3(
    redeclare package Medium = Medium,

    m_flow_fixed=1) annotation(Placement(transformation(extent={{80,-80},{100,-60}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateA4(
    redeclare package Medium = Medium,

    m_flow_fixed=1.5) annotation(Placement(transformation(extent={{140,-80},{160,-60}})));

equation
  connect(sourceB.outlet, flowResistanceB.inlet) annotation(Line(
      points={{-180,30},{-170,30}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA.outlet, massFlowRateA.inlet) annotation(Line(
      points={{-180,70},{-170,70}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceB.outlet, junction.inletB) annotation(Line(
      points={{-150,30},{-140,30}},
      color={28,108,200},
      thickness=0.5));
  connect(junction.outlet, sink.inlet) annotation(Line(
      points={{-120,30},{-110,30}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateA.outlet, junction.inletA) annotation(Line(
      points={{-150,70},{-130,70},{-130,40}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA1.outlet, flowResistanceA.inlet) annotation(Line(
      points={{-30,70},{-20,70}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB1.outlet, massFlowRateB.inlet) annotation(Line(
      points={{-30,30},{-20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(junction1.outlet, sink1.inlet) annotation(Line(
      points={{30,30},{40,30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceA.outlet, junction1.inletA) annotation(Line(
      points={{0,70},{20,70},{20,40}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateB.outlet, junction1.inletB) annotation(Line(
      points={{0,30},{10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA2.outlet, massFlowRateA2.inlet) annotation(Line(
      points={{-180,-30},{-170,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(junction2.outlet, sink2.inlet) annotation(Line(
      points={{-120,-70},{-110,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateA2.outlet, junction2.inletA) annotation(Line(
      points={{-150,-30},{-130,-30},{-130,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB2.outlet, massFlowRateB2.inlet) annotation(Line(
      points={{-180,-70},{-170,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateB2.outlet, junction2.inletB) annotation(Line(
      points={{-150,-70},{-140,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB3.outlet, massFlowRateB1.inlet) annotation(Line(
      points={{-50,-70},{-40,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateB1.outlet, junction3.inletB) annotation(Line(
      points={{-20,-70},{-10,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA3.outlet, massFlowRateA1.inlet) annotation(Line(
      points={{-50,-30},{-40,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateA1.outlet, junction3.inletA) annotation(Line(
      points={{-20,-30},{0,-30},{0,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(junction3.outlet, sink3.inlet) annotation(Line(
      points={{10,-70},{20,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB4.outlet, massFlowRateB3.inlet) annotation(Line(
      points={{70,-70},{80,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateB3.outlet, junction4.inletB) annotation(Line(
      points={{100,-70},{110,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(junction4.outlet, massFlowRateA4.inlet) annotation(Line(
      points={{130,-70},{140,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateA4.outlet, sink4.inlet) annotation(Line(
      points={{160,-70},{170,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA4.outlet, junction4.inletA) annotation(Line(
      points={{70,-30},{120,-30},{120,-60}},
      color={28,108,200},
      thickness=0.5));

  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(
        extent={{-200,-100},{200,100}})),
    Documentation(
      info="<html>
  <p>
    <a href=\"modelica://ThermofluidStream.Idealized.Topology.JunctionT2\">JunctionT2</a> test model for differentiable mass flow rates.  
  </p>

  <p>
    The junction icon indicates whether the pressure balance is satisfied. Temporary violation may be accepted.
  </p>
</html>",
      revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end JunctionT2Const;
