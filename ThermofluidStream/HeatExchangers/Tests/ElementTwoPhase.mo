within ThermofluidStream.HeatExchangers.Tests;
model ElementTwoPhase
  extends Modelica.Icons.Example;

  replaceable package MediumRefrigerant = Media.myMedia.R134a.R134a_ph
    constrainedby Media.myMedia.Interfaces.PartialMedium annotation(choicesAllMatching = true);

  Internal.ConductionElementHEX_twoPhase conductionElementHEX_twoPhase(
    m_flow_0=0.5,
    V(displayUnit="l") = 0.0005,
    A=10,
    U_liq_nom=700,
    U_vap_nom=500,
    U_tp_nom=1000,
    m_flow_nom=0.5,
    redeclare package Medium = MediumRefrigerant)
    annotation (Placement(transformation(extent={{-10,90},{10,70}})));
  Boundaries.Sink sink(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par=1900000)
    annotation (Placement(transformation(extent={{50,70},{70,90}})));
  FlowControl.MCV mCV(
    redeclare package Medium = MediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0.1,
    massFlow_set_par=0.1)
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
  Boundaries.Source source(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    enthalpyFromInput=true,
    p0_par=2000000)
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  Internal.ConductionElementHEX_twoPhase conductionElementHEX_twoPhase1(
    m_flow_0=0.5,
    V(displayUnit="l") = 0.0005,
    A=10,
    U_liq_nom=700,
    U_vap_nom=500,
    U_tp_nom=750,
    m_flow_nom=0.5,
    redeclare package Medium = MediumRefrigerant)
    annotation (Placement(transformation(extent={{-10,-20},{10,-40}})));
  Boundaries.Sink sink1(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par=1900000)
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  FlowControl.MCV mCV1(
    redeclare package Medium = MediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0.1,
    massFlow_set_par=0.1)
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Boundaries.Source source1(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    p0_par=2000000,
    h0_par=330e3)
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=50,
    rising=20,
    width=10,
    falling=20,
    period=60,
    offset=300,
    startTime=5)
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Boundaries.Volume volume(
    redeclare package Medium = MediumRefrigerant,
    p_start=3000000,
    use_hstart=true,
    h_start=270e3,
    V(displayUnit="l"),
    A=10,
    V_par=0.0005) annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Boundaries.Sink sink2(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par=1900000)
    annotation (Placement(transformation(extent={{50,40},{70,60}})));
  FlowControl.MCV mCV2(
    redeclare package Medium = MediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0.1,
    massFlow_set_par=0.1)
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Boundaries.Source source2(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    enthalpyFromInput=true,
    p0_par=2000000)
    annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  Boundaries.Volume volume1(
    redeclare package Medium = MediumRefrigerant,
    useHeatport=true,
    U=700,
    p_start=3000000,
    use_hstart=true,
    h_start=270e3,
    V(displayUnit="l"),
    A=10,
    V_par=0.0005) annotation (Placement(transformation(extent={{-10,-70},{10,-90}})));
  Boundaries.Sink sink3(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par=1900000)
    annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
  FlowControl.MCV mCV3(
    redeclare package Medium = MediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0.1,
    massFlow_set_par=0.1)
    annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
  Boundaries.Source source3(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    p0_par=2000000,
    h0_par=330e3)
    annotation (Placement(transformation(extent={{-70,-90},{-50,-70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature1
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  inner DropOfCommons dropOfCommons(assertionLevel=AssertionLevel.warning) annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = MediumRefrigerant,
    r(displayUnit="mm") = 0.01,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = MediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.01,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-38,40},{-18,60}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = MediumRefrigerant,
    r(displayUnit="mm") = 0.01,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Processes.FlowResistance flowResistance3(
    redeclare package Medium = MediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.01,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  Modelica.Blocks.Sources.Trapezoid
                               trapezoid2(
    amplitude=200e3,
    rising=20,
    width=10,
    falling=20,
    period=60,
    offset=270e3,
    startTime=5)
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
equation
  connect(conductionElementHEX_twoPhase.outlet, mCV.inlet)
    annotation (Line(
      points={{10,80},{20,80}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.outlet, sink.inlet) annotation (Line(
      points={{40,80},{50,80}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElementHEX_twoPhase1.outlet, mCV1.inlet)
    annotation (Line(
      points={{10,-30},{20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV1.outlet, sink1.inlet) annotation (Line(
      points={{40,-30},{50,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(prescribedTemperature.port, conductionElementHEX_twoPhase1.heatPort)
    annotation (Line(points={{-20,-10},{0,-10},{0,-20}},   color={191,0,0}));
  connect(trapezoid.y, prescribedTemperature.T) annotation (Line(points={{-79,-10},{-42,-10}}, color={0,0,127}));
  connect(volume.outlet, mCV2.inlet) annotation (Line(
      points={{10,50},{20,50}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV2.outlet, sink2.inlet) annotation (Line(
      points={{40,50},{50,50}},
      color={28,108,200},
      thickness=0.5));
  connect(volume1.outlet, mCV3.inlet) annotation (Line(
      points={{10,-80},{20,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV3.outlet, sink3.inlet) annotation (Line(
      points={{40,-80},{50,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(prescribedTemperature1.port, volume1.heatPort) annotation (Line(points={{-20,-60},{0,-60},{0,-72}}, color={191,0,0}));
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{-50,80},{-40,80}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, conductionElementHEX_twoPhase.inlet)
    annotation (Line(
      points={{-20,80},{-10,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, flowResistance1.inlet) annotation (Line(
      points={{-50,50},{-38,50}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, volume.inlet) annotation (Line(
      points={{-18,50},{-10,50}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowResistance2.inlet) annotation (Line(
      points={{-50,-30},{-40,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, conductionElementHEX_twoPhase1.inlet)
    annotation (Line(
      points={{-20,-30},{-10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, flowResistance3.inlet) annotation (Line(
      points={{-50,-80},{-40,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.outlet, volume1.inlet) annotation (Line(
      points={{-20,-80},{-10,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(trapezoid2.y, source.h0_var) annotation (Line(points={{-79,80},{-62,80}}, color={0,0,127}));
  connect(source2.h0_var, source.h0_var)
    annotation (Line(points={{-62,50},{-70,50},{-70,80},{-62,80}}, color={0,0,127}));
  connect(prescribedTemperature1.T, prescribedTemperature.T)
    annotation (Line(points={{-42,-60},{-68,-60},{-68,-10},{-42,-10}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-120},{120,120}})),
    experiment(StopTime=60, Tolerance=1e-6, Interval=0.06, __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
      <p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p> </html>"));
end ElementTwoPhase;
