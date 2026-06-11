within ThermofluidStream.Idealized.Tests.Topology;
model JunctionT1Const "Example - JunctionT1 with constant mass flow rate sources"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{180,72},{200,92}})));

  ThermofluidStream.Boundaries.Source sourceA(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-190,60},{-170,80}})));
  ThermofluidStream.Boundaries.Sink
                    sink(redeclare package Medium = Medium,
    p0_par=100000,
    L=1e4)                                                 annotation(Placement(transformation(extent={{-110,40},{-90,60}})));
  ThermofluidStream.Processes.FlowResistance flowResistanceB(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k2=1e5) "Linear-quadratic",
    l=1,
    r=1) annotation(Placement(transformation(extent={{-160,20},{-140,40}})));
  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = Medium,
    p0_par=200000,
    T0_par=313.15) annotation(Placement(transformation(extent={{-190,20},{-170,40}})));
  .ThermofluidStream.Idealized.Boundaries.MassFlowRate massFlowRateA(
    redeclare package Medium = Medium,

    m_flow_fixed=1) annotation (Placement(transformation(extent={{-160,60},{-140,80}})));
  ThermofluidStream.Idealized.Topology.JunctionT1 junction(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-140,40},{-120,60}})));
  ThermofluidStream.Boundaries.Source sourceB1(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-50,20},{-30,40}})));
  ThermofluidStream.Boundaries.Sink
                    sink1(
    redeclare package Medium = Medium,
    p0_par=100000,
    L=1e4)                                                 annotation(Placement(transformation(extent={{30,40},{50,60}})));
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
  .ThermofluidStream.Idealized.Boundaries.MassFlowRate massFlowRateB(
    redeclare package Medium = Medium,

    m_flow_fixed=1) annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  ThermofluidStream.Idealized.Topology.JunctionT1 junction1(free=ThermofluidStream.Idealized.Topology.Types.FreeJunctionInlet.B, redeclare package Medium = Medium) annotation(Placement(transformation(extent={{0,40},{20,60}})));
  ThermofluidStream.Boundaries.Source sourceA2(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-190,-40},{-170,-20}})));
  .ThermofluidStream.Idealized.Boundaries.Sink_free sink2(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-110,-60},{-90,-40}})));
  ThermofluidStream.Boundaries.Source sourceB2(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=313.15) annotation(Placement(transformation(extent={{-190,-80},{-170,-60}})));
  .ThermofluidStream.Idealized.Boundaries.MassFlowRate massFlowRateA2(
    redeclare package Medium = Medium,

    m_flow_fixed=1) annotation (Placement(transformation(extent={{-160,-40},{-140,-20}})));
  ThermofluidStream.Idealized.Topology.JunctionT1 junction2(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-140,-60},{-120,-40}})));
  .ThermofluidStream.Idealized.Boundaries.MassFlowRate massFlowRateB2(
    redeclare package Medium = Medium,

    m_flow_fixed=1) annotation (Placement(transformation(extent={{-160,-80},{-140,-60}})));
  ThermofluidStream.Boundaries.Source sourceA3(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-50,-40},{-30,-20}})));
  .ThermofluidStream.Idealized.Boundaries.Sink_free sink3(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{30,-60},{50,-40}})));
  ThermofluidStream.Boundaries.Source sourceB3(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=313.15) annotation(Placement(transformation(extent={{-50,-80},{-30,-60}})));
  ThermofluidStream.Idealized.Topology.JunctionT1 junction3(free=ThermofluidStream.Idealized.Topology.Types.FreeJunctionInlet.B, redeclare package Medium = Medium) annotation(Placement(transformation(extent={{0,-60},{20,-40}})));
  .ThermofluidStream.Idealized.Boundaries.MassFlowRate massFlowRateB1(
    redeclare package Medium = Medium,

    m_flow_fixed=1) annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  .ThermofluidStream.Idealized.Boundaries.MassFlowRate massFlowRateA1(
    redeclare package Medium = Medium,

    m_flow_fixed=1) annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  ThermofluidStream.Boundaries.Source sourceA4(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{70,-40},{90,-20}})));
  .ThermofluidStream.Idealized.Boundaries.Sink_free sink4(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{180,-60},{200,-40}})));
  ThermofluidStream.Boundaries.Source sourceB4(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=313.15) annotation(Placement(transformation(extent={{70,-80},{90,-60}})));
  ThermofluidStream.Idealized.Topology.JunctionT1 junction4(free=ThermofluidStream.Idealized.Topology.Types.FreeJunctionInlet.B, redeclare package Medium = Medium) annotation(Placement(transformation(extent={{120,-60},{140,-40}})));
  .ThermofluidStream.Idealized.Boundaries.MassFlowRate massFlowRateB3(
    redeclare package Medium = Medium,

    m_flow_fixed=1) annotation (Placement(transformation(extent={{100,-80},{120,-60}})));
  .ThermofluidStream.Idealized.Boundaries.MassFlowRate massFlowRateA4(
    redeclare package Medium = Medium,

    m_flow_fixed=1.5) annotation (Placement(transformation(extent={{150,-60},{170,-40}})));

equation
  connect(sourceB.outlet, flowResistanceB.inlet) annotation(Line(
      points={{-170,30},{-160,30}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA.outlet, massFlowRateA.inlet) annotation(Line(
      points={{-170,70},{-160,70}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceB.outlet, junction.inletB) annotation(Line(
      points={{-140,30},{-130,30},{-130,40}},
      color={28,108,200},
      thickness=0.5));
  connect(junction.outlet, sink.inlet) annotation(Line(
      points={{-120,50},{-110,50}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateA.outlet, junction.inletA) annotation(Line(
      points={{-140,70},{-130,70},{-130,60}},
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
      points={{20,50},{30,50}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceA.outlet, junction1.inletA) annotation(Line(
      points={{0,70},{10,70},{10,60}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateB.outlet, junction1.inletB) annotation(Line(
      points={{0,30},{10,30},{10,40}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA2.outlet, massFlowRateA2.inlet) annotation(Line(
      points={{-170,-30},{-160,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(junction2.outlet, sink2.inlet) annotation(Line(
      points={{-120,-50},{-110,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateA2.outlet, junction2.inletA) annotation(Line(
      points={{-140,-30},{-130,-30},{-130,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB2.outlet, massFlowRateB2.inlet) annotation(Line(
      points={{-170,-70},{-160,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateB2.outlet, junction2.inletB) annotation(Line(
      points={{-140,-70},{-130,-70},{-130,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB3.outlet, massFlowRateB1.inlet) annotation(Line(
      points={{-30,-70},{-20,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateB1.outlet, junction3.inletB) annotation(Line(
      points={{0,-70},{10,-70},{10,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA3.outlet, massFlowRateA1.inlet) annotation(Line(
      points={{-30,-30},{-20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateA1.outlet, junction3.inletA) annotation(Line(
      points={{0,-30},{10,-30},{10,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(junction3.outlet, sink3.inlet) annotation(Line(
      points={{20,-50},{30,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB4.outlet, massFlowRateB3.inlet) annotation(Line(
      points={{90,-70},{100,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateB3.outlet, junction4.inletB) annotation(Line(
      points={{120,-70},{130,-70},{130,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(junction4.outlet, massFlowRateA4.inlet) annotation(Line(
      points={{140,-50},{150,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateA4.outlet, sink4.inlet) annotation(Line(
      points={{170,-50},{180,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA4.outlet, junction4.inletA) annotation(Line(
      points={{90,-30},{130,-30},{130,-40}},
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
    <a href=\"modelica://ThermofluidStream.Idealized.Topology.JunctionT1\">JunctionT1</a> test model for differentiable mass flow rates. 
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
end JunctionT1Const;
