within ThermofluidStream.Boundaries.Tests;
model PhaseSeperator
  extends Modelica.Icons.Example;

  package Medium = Media.myMedia.Water.StandardWater;

  Boundaries.Source source(redeclare package Medium=Medium,
    setEnthalpy=true,
    enthalpyFromInput=true,
    p0_par=120000,
    h0_par=2000)                                            annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
  .ThermofluidStream.Boundaries.PhaseSeperator receiver(
    redeclare package Medium = Medium,
    p_start=110000,
    V_par(displayUnit="l") = 0.01,
    pipe_low=0.05,
    pipe_high=0.15,
    init_method=ThermofluidStream.Boundaries.Internal.InitializationMethodsPhaseSeperator.l)
                    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  .ThermofluidStream.Boundaries.PhaseSeperator accumulator(
    redeclare package Medium = Medium,
    p_start=110000,
    V_par(displayUnit="l") = 0.01,
    pipe_low=0.85,
    pipe_high=0.95,
    init_method=ThermofluidStream.Boundaries.Internal.InitializationMethodsPhaseSeperator.l)
                    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Boundaries.Sink sink(redeclare package Medium=Medium, p0_par=100000)
                                                        annotation (Placement(transformation(extent={{76,-30},{96,-10}})));

  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation (Placement(transformation(extent={{-56,-38},{-36,-18}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect1(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect2(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect3(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation (Placement(transformation(extent={{64,-52},{84,-32}})));
  Modelica.Blocks.Sources.TimeTable
                               timeTable(
    table=[0.0,1500e3; 24.9,1500e3; 25.1,3500e3; 49.9,3500e3; 50.1,1500e3; 74.9,1500e3; 75.1,410e3; 99.9,410e3; 100.1,1500e3; 124.9,1500e3; 1e10,
        1500e3],
    offset=0,
    startTime=0) annotation (Placement(transformation(extent={{-120,-16},{-100,4}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="cm") = 0.05,
    l=1,
    computeL=false,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.linearQuadraticPressureLoss (                       k=5000))
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="cm") = 0.05,
    l=1,
    computeL=false,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.linearQuadraticPressureLoss (                       k=5000))
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="cm") = 0.05,
    l=1,
    computeL=false,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.linearQuadraticPressureLoss (                       k=5000))
    annotation (Placement(transformation(extent={{30,10},{50,30}})));
  Processes.FlowResistance flowResistance3(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="cm") = 0.05,
    l=1,
    computeL=false,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.linearQuadraticPressureLoss (                       k=5000))
    annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect4(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation (Placement(transformation(extent={{-8,-50},{12,-30}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect5(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation (Placement(transformation(extent={{-8,30},{12,50}})));
  Sensors.SingleSensorSelect singleSensorSelect(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar) annotation (Placement(transformation(extent={{-8,38},{12,58}})));
  Sensors.SingleSensorSelect singleSensorSelect1(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar) annotation (Placement(transformation(extent={{20,38},{40,58}})));
  Sensors.SingleSensorSelect singleSensorSelect2(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar) annotation (Placement(transformation(extent={{-8,-58},{12,-38}})));
  Sensors.SingleSensorSelect singleSensorSelect3(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar) annotation (Placement(transformation(extent={{20,-58},{40,-38}})));
  Sensors.SingleSensorSelect singleSensorSelect4(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar) annotation (Placement(transformation(extent={{64,-60},{84,-40}})));
  Sensors.SingleSensorSelect singleSensorSelect5(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar) annotation (Placement(transformation(extent={{-56,-46},{-36,-26}})));
  Boundaries.Source source1(
    redeclare package Medium = Medium,
    setEnthalpy=true,
    enthalpyFromInput=true,
    p0_par=120000,
    h0_par=2000)                                            annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect6(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation (Placement(transformation(extent={{-56,20},{-36,40}})));
  Sensors.SingleSensorSelect singleSensorSelect6(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar) annotation (Placement(transformation(extent={{-56,28},{-36,48}})));
  Boundaries.Sink sink1(redeclare package Medium = Medium, p0_par=100000)
                                                        annotation (Placement(transformation(extent={{76,10},{96,30}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect7(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation (Placement(transformation(extent={{64,32},{84,52}})));
  Sensors.SingleSensorSelect singleSensorSelect7(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar) annotation (Placement(transformation(extent={{64,40},{84,60}})));
  inner DropOfCommons dropOfCommons(stopOnFailedAssert=false)
                                    annotation (Placement(transformation(extent={{-86,-72},{-66,-52}})));
equation
  connect(source.h0_var, timeTable.y) annotation (Line(points={{-82,14},{-90,14},{-90,-6},{-99,-6}}, color={0,0,127}));
  connect(twoPhaseSensorSelect1.inlet, accumulator.outlet)
    annotation (Line(
      points={{20,-40},{16,-40},{16,-20},{10,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect2.inlet,receiver. outlet)
    annotation (Line(
      points={{20,40},{16,40},{16,20},{10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet,receiver. inlet) annotation (Line(
      points={{-20,20},{-10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(accumulator.inlet, flowResistance2.outlet) annotation (Line(
      points={{-10,-20},{-20,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.inlet, accumulator.outlet) annotation (Line(
      points={{30,-20},{10,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.inlet,receiver. outlet) annotation (Line(
      points={{30,20},{10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect4.inlet, flowResistance2.outlet)
    annotation (Line(
      points={{-8,-40},{-14,-40},{-14,-20},{-20,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect5.inlet,receiver. inlet)
    annotation (Line(
      points={{-8,40},{-14,40},{-14,20},{-10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.inlet,receiver. inlet)
    annotation (Line(
      points={{-8,48},{-14,48},{-14,20},{-10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.inlet,receiver. outlet)
    annotation (Line(
      points={{20,48},{16,48},{16,20},{10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect3.inlet, accumulator.outlet)
    annotation (Line(
      points={{20,-48},{16,-48},{16,-20},{10,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect2.inlet, flowResistance2.outlet)
    annotation (Line(
      points={{-8,-48},{-14,-48},{-14,-20},{-20,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, flowResistance1.inlet) annotation (Line(
      points={{-70,20},{-40,20}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowResistance2.inlet)
    annotation (Line(
      points={{-70,-20},{-56,-20},{-56,-20},{-40,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.h0_var, timeTable.y) annotation (Line(points={{-82,-26},{-90,-26},{-90,-6},{-99,-6}}, color={0,0,127}));
  connect(twoPhaseSensorSelect.inlet, flowResistance2.inlet)
    annotation (Line(
      points={{-56,-28},{-60,-28},{-60,-20},{-40,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect5.inlet, flowResistance2.inlet)
    annotation (Line(
      points={{-56,-36},{-60,-36},{-60,-20},{-40,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect6.inlet, flowResistance1.inlet)
    annotation (Line(
      points={{-56,38},{-60,38},{-60,20},{-40,20}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect6.inlet, flowResistance1.inlet)
    annotation (Line(
      points={{-56,30},{-60,30},{-60,20},{-40,20}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, flowResistance3.outlet) annotation (Line(
      points={{76,-20},{50,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, flowResistance.outlet) annotation (Line(
      points={{76,20},{50,20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect4.inlet, flowResistance3.outlet)
    annotation (Line(
      points={{64,-50},{60,-50},{60,-20},{50,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect3.inlet, flowResistance3.outlet)
    annotation (Line(
      points={{64,-42},{60,-42},{60,-20},{50,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(twoPhaseSensorSelect7.inlet, flowResistance.outlet)
    annotation (Line(
      points={{64,42},{60,42},{60,20},{50,20}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect7.inlet, flowResistance.outlet)
    annotation (Line(
      points={{64,50},{60,50},{60,20},{50,20}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
                                                                 Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{120,100}})),
    experiment(StopTime=125, __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end PhaseSeperator;
