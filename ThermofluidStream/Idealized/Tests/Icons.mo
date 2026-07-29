within ThermofluidStream.Idealized.Tests;
model Icons
  extends Modelica.Icons.Example;
  ThermofluidStream.Idealized.Processes.Adiabatic adiabatic(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=10000,
    IconType=ThermofluidStream.Idealized.Types.dpIconType.Expansion,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa
    constrainedby Media.myMedia.Interfaces.PartialMedium annotation (
      choicesAllMatching=true);
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=100) "Fixed pressure loss coefficient",
    l=10,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.1,
    redeclare package Medium = Medium,
    computeL=false)
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  Modelica.Blocks.Sources.Step step(
    height=0.2,
    offset=-0.1,
    startTime=1)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas polytropic(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=10000,
    IconType=ThermofluidStream.Idealized.Types.dpIconType.Compression,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  ThermofluidStream.Boundaries.Sink sink1(redeclare package Medium = Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  ThermofluidStream.Processes.FlowResistance flowResistance1(
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=100) "Fixed pressure loss coefficient",
    l=10,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.1,
    redeclare package Medium = Medium,
    computeL=false)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Sources.Step step1(
    height=0.2,
    offset=-0.1,
    startTime=1)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  ThermofluidStream.Idealized.Processes.Isobaric  isobaric(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    IconType=ThermofluidStream.Idealized.Types.dTIconType.Cooling)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.Step step2(
    height=20,
    offset=-10,
    startTime=1)
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  ThermofluidStream.Idealized.Boundaries.MassFlowRate massFlowRate(m_flow_fixed
      =0.1, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink2(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic isenthalpic(dpLoss_fixed=
        10000, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=120000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  ThermofluidStream.Boundaries.Sink sink3(redeclare package Medium = Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
  ThermofluidStream.Processes.FlowResistance flowResistance2(
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=100) "Fixed pressure loss coefficient",
    l=10,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.1,
    redeclare package Medium = Medium,
    computeL=false)
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  ThermofluidStream.Idealized.Processes.MassFractionModifier composition(
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Composition.OutletMassFractions,
    Xi_out_fixed=Medium.X_default[1:Medium.nXi],
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,-140},{-40,-120}})));
  ThermofluidStream.Boundaries.Sink sink4(redeclare package Medium = Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{20,-140},{40,-120}})));
  ThermofluidStream.Processes.FlowResistance flowResistance3(
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=100) "Fixed pressure loss coefficient",
    l=10,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.1,
    redeclare package Medium = Medium,
    computeL=false)
    annotation (Placement(transformation(extent={{-20,-140},{0,-120}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    p0_par=110000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-100,-140},{-80,-120}})));
  ThermofluidStream.Idealized.Processes.PseudoSource pseudoSource(redeclare
      package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,-180},{-40,-160}})));
  ThermofluidStream.Boundaries.Sink sink5(redeclare package Medium = Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{20,-180},{40,-160}})));
  ThermofluidStream.Processes.FlowResistance flowResistance4(
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=100) "Fixed pressure loss coefficient",
    l=10,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.1,
    redeclare package Medium = Medium,
    computeL=false)
    annotation (Placement(transformation(extent={{-20,-180},{0,-160}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    p0_par=110000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-100,-180},{-80,-160}})));
  ThermofluidStream.Idealized.Processes.Isochoric isochoric(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    IconType=ThermofluidStream.Idealized.Types.dTIconType.Heating)
    annotation (Placement(transformation(extent={{-60,-220},{-40,-200}})));
  ThermofluidStream.Boundaries.Sink sink6(redeclare package Medium = Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{20,-220},{40,-200}})));
  ThermofluidStream.Processes.FlowResistance flowResistance5(
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=100) "Fixed pressure loss coefficient",
    l=10,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.1,
    redeclare package Medium = Medium,
    computeL=false)
    annotation (Placement(transformation(extent={{-20,-220},{0,-200}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    p0_par=110000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-100,-220},{-80,-200}})));
  Modelica.Blocks.Sources.Step step3(
    height=20,
    offset=-10,
    startTime=1)
    annotation (Placement(transformation(extent={{-80,-250},{-60,-230}})));
  ThermofluidStream.Idealized.Processes.FlowWork flowWork(boundary=
        ThermofluidStream.Idealized.Types.FlowWorkBoundary.Inlet, redeclare
      package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,-280},{-40,-260}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    p0_par=110000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-100,-280},{-80,-260}})));
  ThermofluidStream.Idealized.Processes.FlowWork flowWork1(redeclare package
      Medium = Medium, boundary=ThermofluidStream.Idealized.Types.FlowWorkBoundary.Outlet)
    annotation (Placement(transformation(extent={{-20,-280},{0,-260}})));
  ThermofluidStream.Boundaries.Sink sink7(redeclare package Medium = Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{60,-280},{80,-260}})));
  ThermofluidStream.Processes.FlowResistance flowResistance6(
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=100) "Fixed pressure loss coefficient",
    l=10,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.1,
    redeclare package Medium = Medium,
    computeL=false)
    annotation (Placement(transformation(extent={{20,-280},{40,-260}})));
equation
  connect(adiabatic.inlet, source.outlet) annotation (Line(
      points={{-60,90},{-80,90}},
      color={28,108,200},
      thickness=0.5));
  connect(adiabatic.outlet, flowResistance.inlet) annotation (Line(
      points={{-40,90},{-20,90}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, flowResistance.outlet) annotation (Line(
      points={{20,90},{0,90}},
      color={28,108,200},
      thickness=0.5));
  connect(step.y, adiabatic.outletSpec_prescribed)
    annotation (Line(points={{-59,60},{-40,60},{-40,78}}, color={0,0,127}));
  connect(polytropic.inlet, source1.outlet) annotation (Line(
      points={{-60,30},{-80,30}},
      color={28,108,200},
      thickness=0.5));
  connect(polytropic.outlet, flowResistance1.inlet) annotation (Line(
      points={{-40,30},{-20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, flowResistance1.outlet) annotation (Line(
      points={{20,30},{0,30}},
      color={28,108,200},
      thickness=0.5));
  connect(step1.y, polytropic.outletSpec_prescribed)
    annotation (Line(points={{-59,0},{-40,0},{-40,18}}, color={0,0,127}));
  connect(isobaric.inlet, source2.outlet) annotation (Line(
      points={{-60,-30},{-80,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(step2.y, isobaric.outletSpec_prescribed)
    annotation (Line(points={{-59,-60},{-40,-60},{-40,-42}}, color={0,0,127}));
  connect(isobaric.outlet, massFlowRate.inlet) annotation (Line(
      points={{-40,-30},{-20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate.outlet, sink2.inlet) annotation (Line(
      points={{0,-30},{20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, isenthalpic.inlet) annotation (Line(
      points={{-80,-90},{-60,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(isenthalpic.outlet, flowResistance2.inlet) annotation (Line(
      points={{-40,-90},{-20,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, sink3.inlet) annotation (Line(
      points={{0,-90},{20,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.outlet, sink4.inlet) annotation (Line(
      points={{0,-130},{20,-130}},
      color={28,108,200},
      thickness=0.5));
  connect(composition.outlet, flowResistance3.inlet) annotation (Line(
      points={{-40,-130},{-20,-130}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet, composition.inlet) annotation (Line(
      points={{-80,-130},{-60,-130}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.outlet, sink5.inlet) annotation (Line(
      points={{0,-170},{20,-170}},
      color={28,108,200},
      thickness=0.5));
  connect(pseudoSource.outlet, flowResistance4.inlet) annotation (Line(
      points={{-40,-170},{-20,-170}},
      color={28,108,200},
      thickness=0.5));
  connect(source5.outlet, pseudoSource.inlet) annotation (Line(
      points={{-80,-170},{-60,-170}},
      color={28,108,200},
      thickness=0.5));
  connect(isochoric.outlet, flowResistance5.inlet) annotation (Line(
      points={{-40,-210},{-20,-210}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance5.outlet, sink6.inlet) annotation (Line(
      points={{0,-210},{20,-210}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, isochoric.inlet) annotation (Line(
      points={{-80,-210},{-60,-210}},
      color={28,108,200},
      thickness=0.5));
  connect(step3.y, isochoric.outletSpec_prescribed) annotation (Line(points={{
          -59,-240},{-40,-240},{-40,-222}}, color={0,0,127}));
  connect(source7.outlet, flowWork.inlet) annotation (Line(
      points={{-80,-270},{-60,-270}},
      color={28,108,200},
      thickness=0.5));
  connect(flowWork.outlet, flowWork1.inlet) annotation (Line(
      points={{-40,-270},{-20,-270}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance6.outlet, sink7.inlet) annotation (Line(
      points={{40,-270},{60,-270}},
      color={28,108,200},
      thickness=0.5));
  connect(flowWork1.outlet, flowResistance6.inlet) annotation (Line(
      points={{0,-270},{20,-270}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -300},{100,120}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-300},{100,
            120}})),
    experiment(StopTime=2, __Dymola_Algorithm="Dassl"));
end Icons;
