within ThermofluidStream.Undirected.HeatExchangers.Tests;
model ConductionElementTwoPhase
  extends Modelica.Icons.Example;

  package MediumRefrigerant = Media.myMedia.R134a.R134a_ph;

  Internal.ConductionElementHEX_twoPhase conductionElementHEX_twoPhase(
    redeclare package Medium = MediumRefrigerant,
    V(displayUnit="l") = 0.001,
    init=ThermofluidStream.Undirected.Processes.Internal.InitializationMethodsCondElement.h,
    A=10,
    U_liq_nom=700,
    U_vap_nom=500,
    U_tp_nom=1000) annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
  Boundaries.BoundaryRear boundary_rear(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    enthalpyFromInput=false,
    h0_par=200e3,
    p0_par=500000) annotation (Placement(transformation(extent={{-82,-10},{-62,10}})));
  Boundaries.BoundaryFore boundary_fore(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    pressureFromInput=true,
    h0_par=450e3) annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = MediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm(
    redeclare package Medium = MediumRefrigerant,
    temperatureUnit="degC",
    outputMassFlowRate=true)
    annotation (Placement(transformation(extent={{24,0},{44,20}})));
  Modelica.Blocks.Continuous.PI PI(
    k=-10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=300,
    y_start=5e5)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={84,46})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,46})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=35e5, uMin=1e5)
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=0,
        origin={88,6})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=-0.6,
    duration=5,
    offset=0.3,
    startTime=20) annotation (Placement(transformation(extent={{-4,36},{16,56}})));
  inner DropOfCommons dropOfCommons annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  connect(boundary_rear.fore, flowResistance.rear) annotation (Line(
      points={{-62,0},{-44,0}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.fore, conductionElementHEX_twoPhase.rear)
    annotation (Line(
      points={{-24,0},{-12,0}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElementHEX_twoPhase.fore, multiSensor_Tpm.rear)
    annotation (Line(
      points={{8,0},{24,0}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore.rear, multiSensor_Tpm.fore) annotation (Line(
      points={{60,0},{44,0}},
      color={28,108,200},
      thickness=0.5));
  connect(feedback.y,PI. u)
    annotation (Line(points={{59,46},{72,46}},    color={0,0,127}));
  connect(PI.y,limiter. u)
    annotation (Line(points={{95,46},{100,46},{100,6},{95.2,6}},
                                                   color={0,0,127}));
  connect(boundary_fore.p0_var, limiter.y) annotation (Line(points={{72,6},{81.4,6}}, color={0,0,127}));
  connect(multiSensor_Tpm.m_flow_out, feedback.u2) annotation (Line(points={{42.2,4},{50,4},{50,38}},
                                                                                                    color={0,0,127}));
  connect(ramp1.y, feedback.u1) annotation (Line(points={{17,46},{42,46}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100, Tolerance=1e-6, Interval=0.1, __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
        <p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end ConductionElementTwoPhase;
