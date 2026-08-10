within ThermofluidStream.Idealized.Tests;
model Icons
  extends Modelica.Icons.Example;
  ThermofluidStream.Idealized.Processes.Adiabatic adiabatic(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=10000,
    IconType=ThermofluidStream.Idealized.Types.dpIconType.Compression,
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
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=100) "Fixed pressure loss coefficient",
    l=10,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.1,
    redeclare package Medium = Medium,
    computeL=false)
    annotation (Placement(transformation(extent={{50,80},{70,100}})));
  Modelica.Blocks.Sources.Step step(
    height=0.2,
    offset=-0.1,
    startTime=1)
    annotation (Placement(transformation(extent={{-140,50},{-120,70}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas polytropic(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=10000,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
  ThermofluidStream.Boundaries.Sink sink1(redeclare package Medium = Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{80,20},{100,40}})));
  ThermofluidStream.Processes.FlowResistance flowResistance1(
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=100) "Fixed pressure loss coefficient",
    l=10,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.1,
    redeclare package Medium = Medium,
    computeL=false)
    annotation (Placement(transformation(extent={{50,20},{70,40}})));
  Modelica.Blocks.Sources.Step step1(
    height=0.2,
    offset=-0.1,
    startTime=1)
    annotation (Placement(transformation(extent={{-140,-10},{-120,10}})));
  ThermofluidStream.Idealized.Processes.Isobaric  isobaric(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-120,-40},{-100,-20}})));
  Modelica.Blocks.Sources.Step step2(
    height=20,
    offset=-10,
    startTime=1)
    annotation (Placement(transformation(extent={{-140,-70},{-120,-50}})));
  ThermofluidStream.Idealized.Boundaries.MassFlowRate massFlowRate(m_flow_fixed
      =0.1, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink2(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
  ThermofluidStream.Idealized.Processes.MassFractionModifier composition(
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Composition.OutletMassFractions,
    Xi_out_fixed=Medium.X_default[1:Medium.nXi],
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,-162},{-40,-142}})));
  ThermofluidStream.Boundaries.Sink sink4(redeclare package Medium = Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{80,-162},{100,-142}})));
  ThermofluidStream.Processes.FlowResistance flowResistance3(
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=100) "Fixed pressure loss coefficient",
    l=10,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.1,
    redeclare package Medium = Medium,
    computeL=false)
    annotation (Placement(transformation(extent={{-20,-162},{0,-142}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    p0_par=110000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-100,-162},{-80,-142}})));
  ThermofluidStream.Idealized.Processes.PseudoSource pseudoSource(redeclare
      package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,-202},{-40,-182}})));
  ThermofluidStream.Boundaries.Sink sink5(redeclare package Medium = Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{80,-202},{100,-182}})));
  ThermofluidStream.Processes.FlowResistance flowResistance4(
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=100) "Fixed pressure loss coefficient",
    l=10,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.1,
    redeclare package Medium = Medium,
    computeL=false)
    annotation (Placement(transformation(extent={{-20,-202},{0,-182}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    p0_par=110000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-100,-202},{-80,-182}})));
  ThermofluidStream.Idealized.Processes.Isochoric isochoric(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    IconType=ThermofluidStream.Idealized.Types.dTIconType.Heating)
    annotation (Placement(transformation(extent={{-60,-242},{-40,-222}})));
  ThermofluidStream.Boundaries.Sink sink6(redeclare package Medium = Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{80,-242},{100,-222}})));
  ThermofluidStream.Processes.FlowResistance flowResistance5(
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=100) "Fixed pressure loss coefficient",
    l=10,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.1,
    redeclare package Medium = Medium,
    computeL=false)
    annotation (Placement(transformation(extent={{50,-242},{70,-222}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    p0_par=110000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-100,-242},{-80,-222}})));
  Modelica.Blocks.Sources.Step step3(
    height=20,
    offset=-10,
    startTime=1)
    annotation (Placement(transformation(extent={{-140,-272},{-120,-252}})));
  ThermofluidStream.Idealized.Processes.FlowWork flowWork(boundary=
        ThermofluidStream.Idealized.Types.FlowWorkBoundary.Inlet, redeclare
      package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,-302},{-40,-282}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    p0_par=110000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-100,-302},{-80,-282}})));
  ThermofluidStream.Idealized.Processes.FlowWork flowWork1(redeclare package
      Medium = Medium, boundary=ThermofluidStream.Idealized.Types.FlowWorkBoundary.Outlet)
    annotation (Placement(transformation(extent={{-20,-302},{0,-282}})));
  ThermofluidStream.Boundaries.Sink sink7(redeclare package Medium = Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{80,-302},{100,-282}})));
  ThermofluidStream.Processes.FlowResistance flowResistance6(
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=100) "Fixed pressure loss coefficient",
    l=10,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.1,
    redeclare package Medium = Medium,
    computeL=false)
    annotation (Placement(transformation(extent={{20,-302},{40,-282}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas polytropic1(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=10000,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  ThermofluidStream.Idealized.Processes.Isobaric  isobaric1(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas polytropic2(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=10000,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    iconType=ThermofluidStream.Idealized.Types.dpIconType.Expansion,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{10,20},{30,40}})));
  ThermofluidStream.Idealized.Processes.Isobaric  isobaric2(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    iconType=ThermofluidStream.Idealized.Types.dTIconType.Cooling)
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  ThermofluidStream.Idealized.Processes.Adiabatic adiabatic1(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=10000,
    IconType=ThermofluidStream.Idealized.Types.dpIconType.Expansion,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas polytropic3(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=10000,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    iconType=ThermofluidStream.Idealized.Types.dpIconType.Expansion,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  ThermofluidStream.Idealized.Processes.Isobaric  isobaric3(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    iconType=ThermofluidStream.Idealized.Types.dTIconType.Cooling)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  ThermofluidStream.Idealized.Processes.Isochoric isochoric1(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    IconType=ThermofluidStream.Idealized.Types.dTIconType.Cooling)
    annotation (Placement(transformation(extent={{-20,-242},{0,-222}})));
equation
  connect(adiabatic.inlet, source.outlet) annotation (Line(
      points={{-60,90},{-80,90}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, flowResistance.outlet) annotation (Line(
      points={{80,90},{70,90}},
      color={28,108,200},
      thickness=0.5));
  connect(step.y, adiabatic.outletSpec_prescribed)
    annotation (Line(points={{-119,60},{-40,60},{-40,78}},color={0,0,127}));
  connect(polytropic.inlet, source1.outlet) annotation (Line(
      points={{-90,30},{-100,30}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, flowResistance1.outlet) annotation (Line(
      points={{80,30},{70,30}},
      color={28,108,200},
      thickness=0.5));
  connect(step1.y, polytropic.outletSpec_prescribed)
    annotation (Line(points={{-119,0},{-70,0},{-70,18}},color={0,0,127}));
  connect(isobaric.inlet, source2.outlet) annotation (Line(
      points={{-90,-30},{-100,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(step2.y, isobaric.outletSpec_prescribed)
    annotation (Line(points={{-119,-60},{-70,-60},{-70,-42}},color={0,0,127}));
  connect(massFlowRate.outlet, sink2.inlet) annotation (Line(
      points={{70,-30},{80,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.outlet, sink4.inlet) annotation (Line(
      points={{0,-152},{80,-152}},
      color={28,108,200},
      thickness=0.5));
  connect(composition.outlet, flowResistance3.inlet) annotation (Line(
      points={{-40,-152},{-20,-152}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet, composition.inlet) annotation (Line(
      points={{-80,-152},{-60,-152}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.outlet, sink5.inlet) annotation (Line(
      points={{0,-192},{80,-192}},
      color={28,108,200},
      thickness=0.5));
  connect(pseudoSource.outlet, flowResistance4.inlet) annotation (Line(
      points={{-40,-192},{-20,-192}},
      color={28,108,200},
      thickness=0.5));
  connect(source5.outlet, pseudoSource.inlet) annotation (Line(
      points={{-80,-192},{-60,-192}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance5.outlet, sink6.inlet) annotation (Line(
      points={{70,-232},{80,-232}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, isochoric.inlet) annotation (Line(
      points={{-80,-232},{-60,-232}},
      color={28,108,200},
      thickness=0.5));
  connect(step3.y, isochoric.outletSpec_prescribed) annotation (Line(points={{-119,-262},{-40,-262},{-40,-244}},
                                            color={0,0,127}));
  connect(source7.outlet, flowWork.inlet) annotation (Line(
      points={{-80,-292},{-60,-292}},
      color={28,108,200},
      thickness=0.5));
  connect(flowWork.outlet, flowWork1.inlet) annotation (Line(
      points={{-40,-292},{-20,-292}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance6.outlet, sink7.inlet) annotation (Line(
      points={{40,-292},{80,-292}},
      color={28,108,200},
      thickness=0.5));
  connect(flowWork1.outlet, flowResistance6.inlet) annotation (Line(
      points={{0,-292},{20,-292}},
      color={28,108,200},
      thickness=0.5));
  connect(polytropic1.outletSpec_prescribed, step1.y)
    annotation (Line(points={{0,18},{0,0},{-119,0}}, color={0,0,127}));
  connect(step2.y, isobaric1.outletSpec_prescribed)
    annotation (Line(points={{-119,-60},{0,-60},{0,-42}}, color={0,0,127}));
  connect(polytropic1.outlet, polytropic2.inlet) annotation (Line(
      points={{0,30},{10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(polytropic2.outlet, flowResistance1.inlet) annotation (Line(
      points={{30,30},{50,30}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric1.outlet, isobaric2.inlet) annotation (Line(
      points={{0,-30},{20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric2.outlet, massFlowRate.inlet) annotation (Line(
      points={{40,-30},{50,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(polytropic2.outletSpec_prescribed, step1.y)
    annotation (Line(points={{30,18},{30,0},{-119,0}}, color={0,0,127}));
  connect(isobaric2.outletSpec_prescribed, step2.y)
    annotation (Line(points={{40,-42},{40,-60},{-119,-60}}, color={0,0,127}));
  connect(adiabatic.outlet, adiabatic1.inlet) annotation (Line(
      points={{-40,90},{-20,90}},
      color={28,108,200},
      thickness=0.5));
  connect(adiabatic1.outlet, flowResistance.inlet) annotation (Line(
      points={{0,90},{50,90}},
      color={28,108,200},
      thickness=0.5));
  connect(adiabatic1.outletSpec_prescribed, step.y)
    annotation (Line(points={{0,78},{0,60},{-119,60}}, color={0,0,127}));
  connect(polytropic.outlet, polytropic3.inlet) annotation (Line(
      points={{-70,30},{-60,30}},
      color={28,108,200},
      thickness=0.5));
  connect(polytropic3.outlet, polytropic1.inlet) annotation (Line(
      points={{-40,30},{-20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(polytropic3.outletSpec_prescribed, step1.y)
    annotation (Line(points={{-40,18},{-40,0},{-119,0}}, color={0,0,127}));
  connect(isobaric.outlet, isobaric3.inlet) annotation (Line(
      points={{-70,-30},{-60,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric3.outlet, isobaric1.inlet) annotation (Line(
      points={{-40,-30},{-20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric3.outletSpec_prescribed, step2.y) annotation (Line(points={{
          -40,-42},{-40,-60},{-119,-60}}, color={0,0,127}));
  connect(isochoric.outlet, isochoric1.inlet) annotation (Line(
      points={{-40,-232},{-20,-232}},
      color={28,108,200},
      thickness=0.5));
  connect(isochoric1.outlet, flowResistance5.inlet) annotation (Line(
      points={{0,-232},{50,-232}},
      color={28,108,200},
      thickness=0.5));
  connect(isochoric1.outletSpec_prescribed, step3.y)
    annotation (Line(points={{0,-244},{0,-262},{-119,-262}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-300},{100,
            120}})),
    experiment(StopTime=2, __Dymola_Algorithm="Dassl"));
end Icons;
