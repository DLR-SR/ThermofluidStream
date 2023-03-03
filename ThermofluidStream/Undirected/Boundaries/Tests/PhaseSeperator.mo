within ThermofluidStream.Undirected.Boundaries.Tests;
model PhaseSeperator
  extends Modelica.Icons.Example;

  package Medium = Media.myMedia.Water.StandardWater;

  BoundaryRear boundaryRear(
    redeclare package Medium = Medium,
    setEnthalpy=true,
    enthalpyFromInput=true,
    p0_par=120000,
    h0_par=2000) annotation (Placement(transformation(extent={{-120,10},{-100,30}})));
  ThermofluidStream.Undirected.Boundaries.PhaseSeparator receiver(
    redeclare package Medium = Medium,
    p_start=110000,
    V_par(displayUnit="l") = 0.01,
    pipe_low=0.05,
    pipe_high=0.15,
    init_method=ThermofluidStream.Boundaries.Internal.InitializationMethodsPhaseSeperator.l)
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  BoundaryFore boundaryFore1(
    redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{130,-30},{150,-10}})));

  ThermofluidStream.Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation (Placement(transformation(extent={{-84,-52},{-64,-32}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect1(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation (Placement(transformation(extent={{56,-52},{76,-32}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect2(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation (Placement(transformation(extent={{44,32},{64,52}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect3(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation (Placement(transformation(extent={{116,-52},{136,-32}})));
  Modelica.Blocks.Sources.TimeTable timeTable(
    table=[0.0,1500e3; 24.9,1500e3; 25.1,3500e3; 49.9,3500e3; 50.1,1500e3; 74.9,1500e3; 75.1,410e3; 99.9,410e3; 100.1,1500e3; 124.9,1500e3; 1e10,
        1500e3],
    offset=0,
    startTime=0) annotation (Placement(transformation(extent={{-154,-10},{-134,10}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="cm") = 0.05,
    l=1,
    computeL=false,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss(
      k=5000))
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="cm") = 0.05,
    l=1,
    computeL=false,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss(
      k=5000))
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="cm") = 0.05,
    l=1,
    computeL=false,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss(
      k=5000))
    annotation (Placement(transformation(extent={{60,10},{80,30}})));
  Processes.FlowResistance flowResistance3(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="cm") = 0.05,
    l=1,
    computeL=false,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss(
      k=5000))
    annotation (Placement(transformation(extent={{72,-30},{92,-10}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect4(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation (Placement(transformation(extent={{-24,-52},{-4,-32}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect5(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation (Placement(transformation(extent={{-16,34},{4,54}})));
  ThermofluidStream.Sensors.SingleSensorSelect singleSensorSelect(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar) annotation (Placement(transformation(extent={{-16,42},{4,62}})));
  ThermofluidStream.Sensors.SingleSensorSelect singleSensorSelect1(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar) annotation (Placement(transformation(extent={{44,40},{64,60}})));
  ThermofluidStream.Sensors.SingleSensorSelect singleSensorSelect2(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar) annotation (Placement(transformation(extent={{-24,-60},{-4,-40}})));
  ThermofluidStream.Sensors.SingleSensorSelect singleSensorSelect3(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar) annotation (Placement(transformation(extent={{56,-60},{76,-40}})));
  ThermofluidStream.Sensors.SingleSensorSelect singleSensorSelect4(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar) annotation (Placement(transformation(extent={{116,-60},{136,-40}})));
  ThermofluidStream.Sensors.SingleSensorSelect singleSensorSelect5(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar) annotation (Placement(transformation(extent={{-84,-60},{-64,-40}})));
  BoundaryRear boundaryRear1(
    redeclare package Medium = Medium,
    setEnthalpy=true,
    enthalpyFromInput=true,
    p0_par=120000,
    h0_par=2000) annotation (Placement(transformation(extent={{-130,-30},{-110,-10}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect6(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation (Placement(transformation(extent={{-76,32},{-56,52}})));
  ThermofluidStream.Sensors.SingleSensorSelect singleSensorSelect6(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar) annotation (Placement(transformation(extent={{-76,40},{-56,60}})));
  BoundaryFore boundaryFore(
    redeclare package Medium = Medium,
    p0_par=100000)
    annotation (Placement(transformation(extent={{120,10},{140,30}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect7(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation (Placement(transformation(extent={{104,32},{124,52}})));
  ThermofluidStream.Sensors.SingleSensorSelect singleSensorSelect7(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar) annotation (Placement(transformation(extent={{104,40},{124,60}})));
  inner DropOfCommons dropOfCommons annotation (Placement(transformation(extent={{-130,-68},{-110,-48}})));
  Sensors.UnidirectionalSensorAdapter unidirectionalSensorAdapter(
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-90,18},{-70,26}})));
  Sensors.UnidirectionalSensorAdapter unidirectionalSensorAdapter1(
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-30,18},{-10,26}})));
  Sensors.UnidirectionalSensorAdapter unidirectionalSensorAdapter2(
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{30,18},{50,26}})));
  Sensors.UnidirectionalSensorAdapter unidirectionalSensorAdapter3(
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{90,18},{110,26}})));
  ThermofluidStream.Undirected.Boundaries.PhaseSeparator accumulator(
    redeclare package Medium = Medium,
    p_start=110000,
    V_par(displayUnit="l") = 0.01,
    pipe_low=0.05,
    pipe_high=0.15)
    annotation (Placement(transformation(extent={{20,-30},{0,-10}})));
  Topology.ConnectForeFore connectForeFore(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  Topology.ConnectRearRear connectRearRear(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Sensors.UnidirectionalSensorAdapter unidirectionalSensorAdapter4(
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-40,-18},{-20,-26}})));
  Sensors.UnidirectionalSensorAdapter unidirectionalSensorAdapter5(
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{40,-18},{60,-26}})));
  Sensors.UnidirectionalSensorAdapter unidirectionalSensorAdapter6(
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{100,-18},{120,-26}})));
  Sensors.UnidirectionalSensorAdapter unidirectionalSensorAdapter7(
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-100,-18},{-80,-26}})));
equation
  connect(boundaryRear.h0_var, timeTable.y) annotation (Line(points={{-112,20},{-124,20},{-124,0},{-133,0}}, color={0,0,127}));
  connect(boundaryRear1.h0_var, timeTable.y) annotation (Line(points={{-122,-20},{-128,-20},{-128,0},{-133,0}}, color={0,0,127}));
  connect(boundaryRear.fore, unidirectionalSensorAdapter.rear)
    annotation (Line(
      points={{-100,20},{-90,20}},
      color={28,108,200},
      thickness=0.5));
  connect(unidirectionalSensorAdapter.fore, flowResistance1.rear)
    annotation (Line(
      points={{-70,20},{-60,20},{-60,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.fore, unidirectionalSensorAdapter1.rear)
    annotation (Line(
      points={{-40,20},{-30,20}},
      color={28,108,200},
      thickness=0.5));
  connect(unidirectionalSensorAdapter1.fore,receiver. rear)
    annotation (Line(
      points={{-10,20},{0,20}},
      color={28,108,200},
      thickness=0.5));
  connect(receiver.fore, unidirectionalSensorAdapter2.rear)
    annotation (Line(
      points={{20,20},{30,20}},
      color={28,108,200},
      thickness=0.5));
  connect(unidirectionalSensorAdapter2.fore, flowResistance.rear)
    annotation (Line(
      points={{50,20},{60,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.fore, unidirectionalSensorAdapter3.rear)
    annotation (Line(
      points={{80,20},{90,20}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryFore.rear, unidirectionalSensorAdapter3.fore)
    annotation (Line(
      points={{120,20},{110,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.fore, unidirectionalSensorAdapter4.rear)
    annotation (Line(
      points={{-50,-20},{-40,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(connectRearRear.rear_a, unidirectionalSensorAdapter4.fore)
    annotation (Line(
      points={{-13,-20},{-20,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(accumulator.fore, connectRearRear.rear_b) annotation (Line(
      points={{0,-20},{-7,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(accumulator.rear, connectForeFore.fore_a) annotation (Line(
      points={{20,-20},{27,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(connectForeFore.fore_b, unidirectionalSensorAdapter5.rear)
    annotation (Line(
      points={{33,-20},{40,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(unidirectionalSensorAdapter5.fore, flowResistance3.rear)
    annotation (Line(
      points={{60,-20},{72,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.fore, unidirectionalSensorAdapter6.rear)
    annotation (Line(
      points={{92,-20},{100,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(unidirectionalSensorAdapter6.fore, boundaryFore1.rear)
    annotation (Line(
      points={{120,-20},{130,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(unidirectionalSensorAdapter7.fore, flowResistance2.rear)
    annotation (Line(
      points={{-80,-20},{-70,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryRear1.fore, unidirectionalSensorAdapter7.rear)
    annotation (Line(
      points={{-110,-20},{-100,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect.inlet, unidirectionalSensorAdapter7.outlet)
    annotation (Line(
      points={{-84,-42},{-90,-42},{-90,-24}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect5.inlet, unidirectionalSensorAdapter7.outlet)
    annotation (Line(
      points={{-84,-50},{-90,-50},{-90,-24}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect4.inlet, unidirectionalSensorAdapter4.outlet)
    annotation (Line(
      points={{-24,-42},{-30,-42},{-30,-24}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect2.inlet, unidirectionalSensorAdapter4.outlet)
    annotation (Line(
      points={{-24,-50},{-30,-50},{-30,-24}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect1.inlet, unidirectionalSensorAdapter5.outlet)
    annotation (Line(
      points={{56,-42},{50,-42},{50,-24}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect3.inlet, unidirectionalSensorAdapter5.outlet)
    annotation (Line(
      points={{56,-50},{50,-50},{50,-24}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect3.inlet, unidirectionalSensorAdapter6.outlet)
    annotation (Line(
      points={{116,-42},{110,-42},{110,-24}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect4.inlet, unidirectionalSensorAdapter6.outlet)
    annotation (Line(
      points={{116,-50},{110,-50},{110,-24}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect6.inlet, unidirectionalSensorAdapter.outlet)
    annotation (Line(
      points={{-76,42},{-80,42},{-80,24}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect6.inlet, unidirectionalSensorAdapter.outlet)
    annotation (Line(
      points={{-76,50},{-80,50},{-80,24}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect5.inlet, unidirectionalSensorAdapter1.outlet)
    annotation (Line(
      points={{-16,44},{-20,44},{-20,24}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.inlet, unidirectionalSensorAdapter1.outlet)
    annotation (Line(
      points={{-16,52},{-20,52},{-20,24}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect2.inlet, unidirectionalSensorAdapter2.outlet)
    annotation (Line(
      points={{44,42},{40,42},{40,24}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.inlet, unidirectionalSensorAdapter2.outlet)
    annotation (Line(
      points={{44,50},{40,50},{40,24}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect7.inlet, unidirectionalSensorAdapter3.outlet)
    annotation (Line(
      points={{104,42},{100,42},{100,24}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect7.inlet, unidirectionalSensorAdapter3.outlet)
    annotation (Line(
      points={{104,50},{100,50},{100,24}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
                                                                 Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{160,100}})),
    experiment(StopTime=125, Tolerance=1e-6, Interval=0.125, __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end PhaseSeperator;
