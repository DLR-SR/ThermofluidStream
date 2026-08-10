within ThermofluidStream.Idealized.Tests;
model Icons
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa
    constrainedby Media.myMedia.Interfaces.PartialMedium annotation (
      choicesAllMatching=true);

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
  ThermofluidStream.Idealized.Processes.Isochoric isochoric(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    IconType=ThermofluidStream.Idealized.Types.Icons.HeatTransfer.Heating) annotation (Placement(transformation(extent={{-60,-120},{-40,-100}})));
  ThermofluidStream.Boundaries.Sink sink6(redeclare package Medium = Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{80,-120},{100,-100}})));
  ThermofluidStream.Processes.FlowResistance flowResistance5(
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (
          zeta=100) "Fixed pressure loss coefficient",
    l=10,
    shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular,
    r=0.1,
    redeclare package Medium = Medium,
    computeL=false)
    annotation (Placement(transformation(extent={{50,-120},{70,-100}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    p0_par=110000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-100,-120},{-80,-100}})));
  Modelica.Blocks.Sources.Step step3(
    height=20,
    offset=-10,
    startTime=1)
    annotation (Placement(transformation(extent={{-140,-150},{-120,-130}})));
  ThermofluidStream.Idealized.Processes.Isobaric  isobaric1(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaric2(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    iconType=ThermofluidStream.Idealized.Types.Icons.HeatTransfer.Cooling) annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaric3(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    iconType=ThermofluidStream.Idealized.Types.Icons.HeatTransfer.Cooling) annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  ThermofluidStream.Idealized.Processes.Isochoric isochoric1(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    IconType=ThermofluidStream.Idealized.Types.Icons.HeatTransfer.Cooling) annotation (Placement(transformation(extent={{-20,-120},{0,-100}})));
equation
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
  connect(flowResistance5.outlet, sink6.inlet) annotation (Line(
      points={{70,-110},{80,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, isochoric.inlet) annotation (Line(
      points={{-80,-110},{-60,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(step3.y, isochoric.outletSpec_prescribed) annotation (Line(points={{-119,-140},{-40,-140},{-40,-122}},
                                            color={0,0,127}));
  connect(step2.y, isobaric1.outletSpec_prescribed)
    annotation (Line(points={{-119,-60},{0,-60},{0,-42}}, color={0,0,127}));
  connect(isobaric1.outlet, isobaric2.inlet) annotation (Line(
      points={{0,-30},{20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric2.outlet, massFlowRate.inlet) annotation (Line(
      points={{40,-30},{50,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric2.outletSpec_prescribed, step2.y)
    annotation (Line(points={{40,-42},{40,-60},{-119,-60}}, color={0,0,127}));
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
      points={{-40,-110},{-20,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(isochoric1.outlet, flowResistance5.inlet) annotation (Line(
      points={{0,-110},{50,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(isochoric1.outletSpec_prescribed, step3.y)
    annotation (Line(points={{0,-122},{0,-140},{-119,-140}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-300},{100,
            120}})),
    experiment(StopTime=2, __Dymola_Algorithm="Dassl"));
end Icons;
