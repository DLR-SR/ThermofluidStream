within ThermofluidStream.HeatExchangers.Tests;
model ElementTwoPhase
  extends Modelica.Icons.Example;

  replaceable package MediumRefrigerant = Media.myMedia.R134a.R134a_ph
    constrainedby Media.myMedia.Interfaces.PartialMedium      annotation(choicesAllMatching = true);

  Internal.ConductionElementHEX_twoPhase conductionElementHEX_twoPhase(
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0.5,
    redeclare package twoPhaseMedium = MediumRefrigerant,
    V(displayUnit="l") = 0.0005,
    A=10,
    U_liq_nom=700,
    U_vap_nom=500,
    U_tp_nom=1000) annotation (Placement(transformation(extent={{-28,-16},{4,16}})));
  Boundaries.Sink sink(redeclare package Medium =
        MediumRefrigerant,
    pressureFromInput=true,
    p0_par=390000)
    annotation (Placement(transformation(extent={{78,-10},{98,10}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm(redeclare package Medium =
        MediumRefrigerant, temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-58,0},{-38,20}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package Medium =
        MediumRefrigerant, outputMassFlowRate=true,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{46,0},{66,20}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=35e5, uMin=20e5)
    annotation (Placement(transformation(extent={{112,-6},{100,6}})));
  Modelica.Blocks.Continuous.PI PI1(
    k=-10000,
    T=0.01,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=30e5)
    annotation (Placement(transformation(extent={{84,32},{104,52}})));
  Modelica.Blocks.Math.Feedback feedback1
    annotation (Placement(transformation(extent={{52,32},{72,52}})));
  Modelica.Blocks.Sources.RealExpression airFlow_setPoint1(y=0.5)
    annotation (Placement(transformation(extent={{22,32},{42,52}})));
  Modelica.Blocks.Sources.Ramp ramp_enthalpy(
    height=140e3,
    duration=30,
    offset=300e3,
    startTime=20)
    annotation (Placement(transformation(extent={{-126,-12},{-106,8}})));
  Modelica.Blocks.Sources.Constant const(k=458610)
    annotation (Placement(transformation(extent={{-148,46},{-128,66}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = MediumRefrigerant,
    r=0.05,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (                       k=2e4))
    annotation (Placement(transformation(extent={{18,-10},{38,10}})));
  Modelica.Blocks.Sources.Ramp ramp_temperature(
    height=20,
    duration=30,
    offset=-10 + 273.15,
    startTime=20)
    annotation (Placement(transformation(extent={{-92,44},{-72,64}})));
  Boundaries.Source source(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    enthalpyFromInput=true,
    p0_par=3000000)
    annotation (Placement(transformation(extent={{-92,-10},{-72,10}})));
equation
  connect(conductionElementHEX_twoPhase.inlet, multiSensor_Tpm.outlet)
    annotation (Line(
      points={{-28,0},{-38,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{78,0},{66,0}},
      color={28,108,200},
      thickness=0.5));
  connect(PI1.y,limiter1. u) annotation (Line(points={{105,42},{118,42},{118,0},
          {113.2,0}},        color={0,0,127}));
  connect(PI1.u, feedback1.y)
    annotation (Line(points={{82,42},{71,42}}, color={0,0,127}));
  connect(airFlow_setPoint1.y, feedback1.u1)
    annotation (Line(points={{43,42},{54,42}}, color={0,0,127}));
  connect(multiSensor_Tpm1.m_flow_out, feedback1.u2)
    annotation (Line(points={{66,4},{66,22},{62,22},{62,34}},
                                               color={0,0,127}));
  connect(conductionElementHEX_twoPhase.outlet, flowResistance.inlet)
    annotation (Line(
      points={{4,0},{18,0}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.inlet, flowResistance.outlet) annotation (Line(
      points={{46,0},{38,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.p0_var, limiter1.y)
    annotation (Line(points={{90,0},{99.4,0}}, color={0,0,127}));
  connect(multiSensor_Tpm.inlet, source.outlet) annotation (Line(
      points={{-58,0},{-72,0}},
      color={28,108,200},
      thickness=0.5));
  connect(ramp_enthalpy.y, source.h0_var) annotation (Line(points={{-105,-2},{-94,-2},{-94,0},{-84,0}},
                                      color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=60, tolerance=1e-6, Interval=0.06, __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
      <p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p> </html>"));
end ElementTwoPhase;
