within ThermofluidStream.Idealized.Tests.Processes;
model Icons
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa
    constrainedby Media.myMedia.Interfaces.PartialMedium annotation (
      choicesAllMatching=true);

  inner DropOfCommons dropOfCommons annotation(
    Placement(transformation(extent={{120,160},{140,180}})));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(
    Placement(transformation(extent={{-70,130},{-50,150}})));
  ThermofluidStream.Boundaries.Sink_m sink(
    redeclare package Medium = Medium,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    m_flow_fixed=1) annotation(
    Placement(transformation(extent={{50,130},{70,150}})));
  ThermofluidStream.Idealized.Processes.Adiabatic adiabatic(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    iconType=ThermofluidStream.Idealized.Types.Icons.PressureChange.Compression,
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-30,130},{-10,150}})));
 ThermofluidStream.Idealized.Processes.Adiabatic adiabatic1(
    iconType=ThermofluidStream.Idealized.Types.Icons.PressureChange.Expansion,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium) annotation(
    Placement(transformation(extent={{10,130},{30,150}})));
  Modelica.Blocks.Sources.CombiTimeTable pressureDifferenceStep(
    table=[0.0,-0.1e5; 0.3,0.0; 0.6,0.1e5],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    offset={0},
    startTime=0) annotation(
    Placement(transformation(extent={{-130,100},{-110,120}})));

  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(
    Placement(transformation(extent={{-90,70},{-70,90}})));
  ThermofluidStream.Boundaries.Sink_m sink1(
    redeclare package Medium = Medium,
    m_flow_fixed=1) annotation(
    Placement(transformation(extent={{70,70},{90,90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas polytropic(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    redeclare package Medium = Medium) annotation(
    Placement(transformation(extent={{-60,70},{-40,90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas polytropic1(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    iconType=ThermofluidStream.Idealized.Types.Icons.PressureChange.Expansion,
    redeclare package Medium = Medium) annotation(
    Placement(transformation(extent={{-30,70},{-10,90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas polytropic2(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    redeclare package Medium = Medium) annotation(
    Placement(transformation(extent={{10,70},{30,90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas polytropic3(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    iconType=ThermofluidStream.Idealized.Types.Icons.PressureChange.Expansion,
    redeclare package Medium = Medium) annotation(
    Placement(transformation(extent={{40,70},{60,90}})));

  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(
    Placement(transformation(extent={{-90,0},{-70,20}})));
  ThermofluidStream.Boundaries.Sink_m sink2(
    redeclare package Medium = Medium,
    m_flow_fixed=1) annotation(
    Placement(transformation(extent={{70,0},{90,20}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaric(
    iconType=ThermofluidStream.Idealized.Types.Icons.HeatTransfer.Heating,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium) annotation(
    Placement(transformation(extent={{-60,0},{-40,20}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaric1(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    iconType=ThermofluidStream.Idealized.Types.Icons.HeatTransfer.Cooling) annotation(
    Placement(transformation(extent={{-30,0},{-10,20}})));
  ThermofluidStream.Idealized.Processes.Isobaric  isobaric2(
    iconType=ThermofluidStream.Idealized.Types.Icons.HeatTransfer.Heating,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle) annotation(
    Placement(transformation(extent={{10,0},{30,20}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaric3(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    iconType=ThermofluidStream.Idealized.Types.Icons.HeatTransfer.Cooling) annotation(
    Placement(transformation(extent={{40,0},{60,20}})));
  Modelica.Blocks.Sources.CombiTimeTable temperatureDifferenceStep(
    table=[0.0,-10; 0.3,0.0; 0.6,10],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    offset={0},
    startTime=0) annotation(
    Placement(transformation(extent={{-130,-30},{-110,-10}})));

  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(
    Placement(transformation(extent={{-90,-60},{-70,-40}})));
  ThermofluidStream.Boundaries.Sink_m sink3(
    redeclare package Medium = Medium,
    m_flow_fixed=1) annotation(
    Placement(transformation(extent={{70,-60},{90,-40}})));
  ThermofluidStream.Idealized.Processes.Isochoric isochoric(
    iconType=ThermofluidStream.Idealized.Types.Icons.HeatTransfer.Heating,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow) annotation(
    Placement(transformation(extent={{-60,-60},{-40,-40}})));
  ThermofluidStream.Idealized.Processes.Isochoric isochoric1(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    iconType=ThermofluidStream.Idealized.Types.Icons.HeatTransfer.Cooling,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow) annotation(
    Placement(transformation(extent={{-30,-60},{-10,-40}})));
  ThermofluidStream.Idealized.Processes.Isochoric isochoric2(
    iconType=ThermofluidStream.Idealized.Types.Icons.HeatTransfer.Heating,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium) annotation(
    Placement(transformation(extent={{10,-60},{30,-40}})));
  ThermofluidStream.Idealized.Processes.Isochoric isochoric3(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    iconType=ThermofluidStream.Idealized.Types.Icons.HeatTransfer.Cooling) annotation(
    Placement(transformation(extent={{40,-60},{60,-40}})));

  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(
    Placement(transformation(extent={{-60,-130},{-40,-110}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic
                                                  isenthalpic(outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed, redeclare package Medium = Medium)
                                                                   annotation(
    Placement(transformation(extent={{-30,-130},{-10,-110}})));
  ThermofluidStream.Boundaries.Sink_m sink4(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                    annotation(
    Placement(transformation(extent={{40,-130},{60,-110}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic
                                                  isenthalpic1(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    enforcePressureDrop=true)                                      annotation(
    Placement(transformation(extent={{10,-130},{30,-110}})));
  Modelica.Blocks.Sources.CombiTimeTable pressureLossStep(
    table=[0.0,0.1e5; 0.1,0.0; 0.2,-0.1e5; 0.5,0.0; 0.6,0.1e5; 0.9,0; 1.0,-0.1e5],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    offset={0},
    startTime=0) annotation (Placement(transformation(extent={{-80,-170},{-60,-150}})));
  Modelica.Blocks.Sources.CombiTimeTable massFlowRateRamp(
    table=[0.0,1; 0.3,1; 0.4,0; 0.7,0; 0.8,1; 1,1],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    offset={0},
    startTime=0) annotation (Placement(transformation(extent={{100,-130},{80,-110}})));
equation
  connect(adiabatic.inlet, source.outlet) annotation (Line(
      points={{-30,140},{-50,140}},
      color={28,108,200},
      thickness=0.5));
  connect(adiabatic.outlet, adiabatic1.inlet) annotation (Line(
      points={{-10,140},{10,140}},
      color={28,108,200},
      thickness=0.5));
  connect(adiabatic1.outlet, sink.inlet) annotation (Line(
      points={{30,140},{50,140}},
      color={28,108,200},
      thickness=0.5));
  connect(polytropic.inlet, source1.outlet) annotation (Line(
      points={{-60,80},{-70,80}},
      color={28,108,200},
      thickness=0.5));
  connect(polytropic2.outlet, polytropic3.inlet) annotation (Line(
      points={{30,80},{40,80}},
      color={28,108,200},
      thickness=0.5));
  connect(polytropic.outlet, polytropic1.inlet) annotation (Line(
      points={{-40,80},{-30,80}},
      color={28,108,200},
      thickness=0.5));
  connect(polytropic1.outlet, polytropic2.inlet) annotation (Line(
      points={{-10,80},{10,80}},
      color={28,108,200},
      thickness=0.5));
  connect(polytropic3.outlet, sink1.inlet) annotation (Line(
      points={{60,80},{70,80}},
      color={28,108,200},
      thickness=0.5));
  connect(adiabatic.outletSpec_prescribed, pressureDifferenceStep.y[1]) annotation (Line(points={{-10,128},{-10,110},{-109,110}}, color={0,0,127}));
  connect(adiabatic1.outletSpec_prescribed, pressureDifferenceStep.y[1]) annotation (Line(points={{30,128},{30,110},{-109,110}}, color={0,0,127}));
  connect(adiabatic.outletSpec_prescribed, polytropic.outletSpec_prescribed) annotation (Line(points={{-10,128},{-10,110},{-100,110},{-100,54},{-40,54},{-40,68}}, color={0,0,127}));
  connect(polytropic1.outletSpec_prescribed, polytropic.outletSpec_prescribed) annotation (Line(points={{-10,68},{-10,54},{-40,54},{-40,68}}, color={0,0,127}));
  connect(polytropic2.outletSpec_prescribed, polytropic.outletSpec_prescribed) annotation (Line(points={{30,68},{30,54},{-40,54},{-40,68}}, color={0,0,127}));
  connect(polytropic3.outletSpec_prescribed, polytropic.outletSpec_prescribed) annotation (Line(points={{60,68},{60,54},{-40,54},{-40,68}}, color={0,0,127}));
  connect(isobaric.inlet, source2.outlet) annotation (Line(
      points={{-60,10},{-70,10}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric2.outlet,isobaric3. inlet) annotation (Line(
      points={{30,10},{40,10}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric.outlet,isobaric1. inlet) annotation (Line(
      points={{-40,10},{-30,10}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric1.outlet,isobaric2. inlet) annotation (Line(
      points={{-10,10},{10,10}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaric3.outlet, sink2.inlet) annotation (Line(
      points={{60,10},{70,10}},
      color={28,108,200},
      thickness=0.5));
  connect(isochoric.outlet, isochoric1.inlet) annotation (Line(
      points={{-40,-50},{-30,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, isochoric.inlet) annotation (Line(
      points={{-70,-50},{-60,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(isochoric2.outlet, isochoric3.inlet) annotation (Line(
      points={{30,-50},{40,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(isochoric1.outlet, isochoric2.inlet) annotation (Line(
      points={{-10,-50},{10,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(isochoric3.outlet, sink3.inlet) annotation (Line(
      points={{60,-50},{70,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(temperatureDifferenceStep.y[1], isobaric.outletSpec_prescribed) annotation (Line(points={{-109,-20},{-40,-20},{-40,-2}},  color={0,0,127}));
  connect(temperatureDifferenceStep.y[1], isobaric1.outletSpec_prescribed) annotation (Line(points={{-109,-20},{-10,-20},{-10,-2}},  color={0,0,127}));
  connect(isobaric2.outletSpec_prescribed, temperatureDifferenceStep.y[1]) annotation (Line(points={{30,-2},{30,-20},{-109,-20}},  color={0,0,127}));
  connect(isobaric2.outletSpec_prescribed, isobaric3.outletSpec_prescribed) annotation (Line(points={{30,-2},{30,-20},{60,-20},{60,-2}},   color={0,0,127}));
  connect(temperatureDifferenceStep.y[1], isochoric.outletSpec_prescribed) annotation (Line(points={{-109,-20},{-100,-20},{-100,-80},{-40,-80},{-40,-62}},    color={0,0,127}));
  connect(temperatureDifferenceStep.y[1], isochoric1.outletSpec_prescribed) annotation (Line(points={{-109,-20},{-100,-20},{-100,-80},{-10,-80},{-10,-62}},    color={0,0,127}));
  connect(temperatureDifferenceStep.y[1], isochoric2.outletSpec_prescribed) annotation (Line(points={{-109,-20},{-100,-20},{-100,-80},{30,-80},{30,-62}},    color={0,0,127}));
  connect(temperatureDifferenceStep.y[1], isochoric3.outletSpec_prescribed) annotation (Line(points={{-109,-20},{-100,-20},{-100,-80},{60,-80},{60,-62}},    color={0,0,127}));

  connect(source4.outlet, isenthalpic.inlet) annotation (Line(
      points={{-40,-120},{-30,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(isenthalpic.outlet, isenthalpic1.inlet) annotation (Line(
      points={{-10,-120},{10,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(isenthalpic1.outlet, sink4.inlet) annotation (Line(
      points={{30,-120},{40,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(pressureLossStep.y[1], isenthalpic.outletSpec_prescribed) annotation (Line(points={{-59,-160},{-10,-160},{-10,-132}}, color={0,0,127}));
  connect(pressureLossStep.y[1], isenthalpic1.outletSpec_prescribed) annotation (Line(points={{-59,-160},{30,-160},{30,-132}}, color={0,0,127}));
  connect(massFlowRateRamp.y[1], sink4.m_flow_prescribed) annotation (Line(points={{79,-120},{52,-120}}, color={0,0,127}));
  annotation(
    experiment(
      StopTime=1.1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(
        extent={{-140,-180},{140,180}})),
    Documentation(
      info="<html>
  <p>
    This example demonstrates the dynamic icon behavior of the models in <a href=\"modelica://ThermofluidStream.Idealized.Processes\">Idealized.Processes</a>.
  </p>
</html>",
      revisions="<html>
  <ul>
    <li>
      2026, by Silvan Keim (silvan.keim@dlr.de) and Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Icons;
