within ThermofluidStream.Idealized.Tests.Topology;
model JunctionT1 "Example - JunctionT1 with different processes"
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconNeglectInertance;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(
    considerInertance=false,                            displayInstanceNames=true, displayParameters=true)annotation(
    Placement(transformation(extent={{180,120},{200,140}})));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-200,70},{-180,90}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-40,48},{-20,68}})));
  Modelica.Blocks.Sources.Ramp massFlowRateRampB(
    height=1,
    duration=1,
    offset=1) annotation(Placement(transformation(extent={{-160,100},{-140,120}})));
  ThermofluidStream.Topology.SplitterT2 splitter1(displayInstanceName=true, redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-170,90},{-150,70}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateA(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-140,30},{-120,50}})));
  Modelica.Blocks.Sources.Ramp massFlowRateRampA(
    height=-3,
    duration=1,
    offset=2) annotation(Placement(transformation(extent={{-160,10},{-140,30}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateB(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-140,90},{-120,70}})));
  .ThermofluidStream.Idealized.Processes.Isobaric isobaric(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.TemperatureDifference,
    dT_fixed=10) annotation(Placement(transformation(extent={{-110,70},{-90,90}})));
  .ThermofluidStream.Idealized.Processes.Isobaric isobaric1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.TemperatureDifference,
    dT_fixed=-20) annotation(Placement(transformation(extent={{-110,30},{-90,50}})));
  ThermofluidStream.Idealized.Topology.JunctionT1 junction(

    displayInstanceName=true,
    redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-80,68},{-60,48}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{0,70},{20,90}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink1(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{180,50},{200,70}})));
  ThermofluidStream.Topology.SplitterT2 splitter2(displayInstanceName=true, redeclare package Medium = Medium) annotation(Placement(transformation(extent={{30,90},{50,70}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateA1(
    redeclare package Medium = Medium,

    m_flow_fixed=2) annotation(Placement(transformation(extent={{60,30},{80,50}})));
  .ThermofluidStream.Idealized.Processes.Isobaric isobaric2(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.TemperatureDifference,
    dT_fixed=25,
    inlet(m_flow(start=1))) annotation(Placement(transformation(extent={{90,70},{110,90}})));
  .ThermofluidStream.Idealized.Processes.Isobaric isobaric3(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.TemperatureDifference,
    dT_fixed=-15) annotation(Placement(transformation(extent={{90,30},{110,50}})));
  ThermofluidStream.Idealized.Topology.JunctionT1 junction1(

    displayInstanceName=true,
    redeclare package Medium = Medium) annotation(Placement(transformation(extent={{120,70},{140,50}})));
  .ThermofluidStream.Idealized.Processes.Isobaric isobaric4(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    dT_fixed=10,
    T_out_fixed=288.15) annotation(Placement(transformation(extent={{150,50},{170,70}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    considerInertance=false,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-200,-50},{-180,-30}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink2(redeclare package Medium = Medium, considerInertance=false) annotation(Placement(transformation(extent={{-30,-70},{-10,-50}})));
  ThermofluidStream.Topology.SplitterT2 splitter3(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    considerInertance=false) annotation(Placement(transformation(extent={{-170,-30},{-150,-50}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateA2(
    redeclare package Medium = Medium,
    considerInertance=false,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    m_flow_fixed=2) annotation(Placement(transformation(extent={{-150,-90},{-130,-70}})));
  .ThermofluidStream.Idealized.Processes.Isobaric isobaric5(
    redeclare package Medium = Medium,
    considerInertance=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.TemperatureDifference,
    dT_fixed=25,
    inlet(m_flow(start=1))) annotation(Placement(transformation(extent={{-130,-50},{-110,-30}})));
  .ThermofluidStream.Idealized.Processes.Isobaric isobaric6(
    redeclare package Medium = Medium,
    considerInertance=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dT_fixed=-15) annotation(Placement(transformation(extent={{-110,-90},{-90,-70}})));
  ThermofluidStream.Idealized.Topology.JunctionT1 junction2(
    considerInertance=false,

    displayInstanceName=true,
    redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-90,-50},{-70,-70}})));
  .ThermofluidStream.Idealized.Processes.Isobaric isobaric7(
    redeclare package Medium = Medium,
    considerInertance=false,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    dT_fixed=10,
    T_out_fixed=298.15) annotation(Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Blocks.Sources.Ramp massFlowRateRampA1(
    height=3,
    duration=1,
    offset=2) annotation(Placement(transformation(extent={{-180,-120},{-160,-100}})));
  Modelica.Blocks.Sources.Ramp temperatureRamp(
    height=-20,
    duration=1,
    offset=0) annotation(Placement(transformation(extent={{-120,-120},{-100,-100}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource(E_flow=0) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-90})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource1(E_flow=0) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={160,30})));
equation
  connect(source.outlet, splitter1.inlet) annotation(Line(
      points={{-180,80},{-170,80}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter1.outletA, massFlowRateA.inlet) annotation(Line(
      points={{-160,70},{-160,40},{-140,40}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateRampA.y, massFlowRateA.m_flow_prescribed) annotation(Line(points={{-139,20},{-130,20},{-130,32}}, color={0,0,127}));
  connect(splitter1.outletB, massFlowRateB.inlet) annotation(Line(
      points={{-150,80},{-140,80}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateRampB.y, massFlowRateB.m_flow_prescribed) annotation(Line(points={{-139,110},{-130,110},{-130,88}}, color={0,0,127}));
  connect(massFlowRateB.outlet, isobaric.inlet) annotation(Line(
      points={{-120,80},{-110,80}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateA.outlet, isobaric1.inlet) annotation(Line(
      points={{-120,40},{-110,40}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric.outlet, junction.inletB) annotation(Line(
      points={{-90,80},{-70,80},{-70,68}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric1.outlet, junction.inletA) annotation(Line(
      points={{-90,40},{-70,40},{-70,48}},
      color={28,108,200},
      thickness=0.5));
  connect(junction.outlet, sink.inlet) annotation(Line(
      points={{-60,58},{-40,58}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, splitter2.inlet) annotation(Line(
      points={{20,80},{30,80}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter2.outletA, massFlowRateA1.inlet) annotation(Line(
      points={{40,70},{40,40},{60,40}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateA1.outlet, isobaric3.inlet) annotation(Line(
      points={{80,40},{90,40}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric2.outlet, junction1.inletB) annotation(Line(
      points={{110,80},{130,80},{130,70}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric3.outlet, junction1.inletA) annotation(Line(
      points={{110,40},{130,40},{130,50}},
      color={28,108,200},
      thickness=0.5));
  connect(junction1.outlet, isobaric4.inlet) annotation(Line(
      points={{140,60},{150,60}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric4.outlet, sink1.inlet) annotation(Line(
      points={{170,60},{180,60}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter2.outletB, isobaric2.inlet) annotation(Line(
      points={{50,80},{90,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, splitter3.inlet) annotation(Line(
      points={{-180,-40},{-170,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter3.outletA, massFlowRateA2.inlet) annotation(Line(
      points={{-160,-50},{-160,-80},{-150,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateA2.outlet, isobaric6.inlet) annotation(Line(
      points={{-130,-80},{-110,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric5.outlet, junction2.inletB) annotation(Line(
      points={{-110,-40},{-80,-40},{-80,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric6.outlet, junction2.inletA) annotation(Line(
      points={{-90,-80},{-80,-80},{-80,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(junction2.outlet, isobaric7.inlet) annotation(Line(
      points={{-70,-60},{-60,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric7.outlet, sink2.inlet) annotation(Line(
      points={{-40,-60},{-30,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter3.outletB, isobaric5.inlet) annotation(Line(
      points={{-150,-40},{-130,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateRampA1.y, massFlowRateA2.m_flow_prescribed) annotation(Line(points={{-159,-110},{-140,-110},{-140,-88}}, color={0,0,127}));
  connect(temperatureRamp.y, isobaric6.outletSpec_prescribed) annotation(Line(points={{-99,-110},{-90,-110},{-90,-92}}, color={0,0,127}));
  connect(energyFlowSource.E_flow_out, isobaric7.Q_flow_in) annotation(Line(points={{-50,-79},{-50,-68}}, color={255,170,85}));
  connect(energyFlowSource1.E_flow_out, isobaric4.Q_flow_in) annotation(Line(points={{160,41},{160,52}}, color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-140},{200,140}}), graphics={
        Polygon(
          points={{0,-60},{40,-60},{40,-40},{20,-40},{20,0},{0,0},{0,-60}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{30,-10},{110,-30}},
          textColor={238,46,47},
          textString="requires considerInertance = false
see User's Guide",
          horizontalAlignment=TextAlignment.Left)}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    Non differentiable mass flow rates require <code>considerInertance = false</code>.
  </p>
</html>"));
end JunctionT1;
