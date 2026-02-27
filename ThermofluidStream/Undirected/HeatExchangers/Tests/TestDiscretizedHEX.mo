within ThermofluidStream.Undirected.HeatExchangers.Tests;
model TestDiscretizedHEX

  extends Modelica.Icons.Example;

  replaceable package MediumAir = Media.myMedia.Air.MoistAir
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (
      choicesAllMatching=true,
      Dialog(group = "Medium definitions"));

  replaceable package MediumRefrigerant = Media.myMedia.R134a.R134a_ph
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (
      choicesAllMatching=true,
      Dialog(group = "Medium definitions"));

  Boundaries.BoundaryRear boundary_rear(
    redeclare package Medium = MediumAir,
    pressureFromInput=true,
    T0_par=311.15) annotation (Placement(transformation(extent={{-92,12},{-72,32}})));
  Boundaries.BoundaryFore boundary_fore(
    redeclare package Medium = MediumAir,
    pressureFromInput=true,
    T0_par=311.15,
    p0_par=100000) annotation (Placement(transformation(extent={{82,12},{102,32}})));
  Boundaries.BoundaryFore boundary_fore1(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    pressureFromInput=true,
    h0_par=300e3,
    T0_par=278.15,
    p0_par=400000) annotation (Placement(transformation(extent={{-74,-20},{-94,
            0}})));
  Boundaries.BoundaryRear boundary_rear1(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    pressureFromInput=true,
    h0_par=450e3,
    T0_par=268.15) annotation (Placement(transformation(extent={{112,0},{92,20}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm(redeclare package Medium = MediumAir,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-38,22},{-18,42}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package Medium = MediumAir,
    temperatureUnit="degC",
    pressureUnit="bar",
    outputMassFlowRate=true)
    annotation (Placement(transformation(extent={{18,22},{38,42}})));
  Processes.FlowResistance flowResistanceA(
    redeclare package Medium = MediumAir,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=1,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-62,12},{-42,32}})));
  inner DropOfCommons dropOfCommons annotation (Placement(transformation(extent={{74,74},{94,94}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=-0.6,
    duration=10,
    offset=0.3,
    startTime=15) annotation (Placement(transformation(extent={{-40,-58},{-20,-38}})));
  Modelica.Blocks.Sources.Constant const1(k=1e5) annotation (Placement(transformation(extent={{-120,22},{-100,42}})));
  DiscretizedCounterFlowHEX discretizedHEX(
    redeclare package MediumA = MediumAir,
    redeclare package MediumB = MediumRefrigerant,
    redeclare model ConductionElementA = Internal.ConductionElementHEX,
    redeclare model ConductionElementB = Internal.ConductionElementHEX_twoPhase,
    nCells=10,
    V_Hex(displayUnit="m3"),
    initializeMassFlow=false,
    k_wall=300) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-4,16})));
  Processes.FlowResistance flowResistanceB(
    redeclare package Medium = MediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0.3,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-42,-20},{-62,0}})));
  Modelica.Blocks.Continuous.PI PI1(
    k=-10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
    annotation (Placement(transformation(extent={{94,46},{114,66}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=5e5, uMin=100)
    annotation (Placement(transformation(extent={{126,22},{114,34}})));
  Modelica.Blocks.Math.Feedback feedback1
    annotation (Placement(transformation(extent={{38,46},{58,66}})));
  Modelica.Blocks.Sources.RealExpression airFlow_setPoint1(y=1)
    annotation (Placement(transformation(extent={{6,72},{26,92}})));
  Modelica.Blocks.Sources.Ramp ramp2(
    height=-1,
    duration=1,
    offset=1,
    startTime=30) annotation (Placement(transformation(extent={{-12,46},{8,66}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm2(
    redeclare package Medium = MediumRefrigerant,
    temperatureUnit="degC",
    pressureUnit="bar",
    outputMassFlowRate=true)
    annotation (Placement(transformation(extent={{38,10},{18,-10}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm3(
    redeclare package Medium = MediumRefrigerant,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-18,-10},{-38,-30}})));
  Modelica.Blocks.Continuous.PI PI(
    k=10000,
    T=0.001,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=300,
    y_start=30e5)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,-48})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=0,
        origin={8,-48})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=35e5, uMin=1e5)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=0,
        origin={84,-48})));
  Modelica.Blocks.Sources.Ramp ramp3(
    height=-26e5,
    duration=10,
    offset=30e5,
    startTime=15) annotation (Placement(transformation(extent={{-120,-14},{-100,
            6}})));
equation
  connect(boundary_rear.p0_var, const1.y) annotation (Line(points={{-84,28},{-92,28},{-92,32},{-99,32}},
                                                                                       color={0,0,127}));
  connect(boundary_fore1.rear, flowResistanceB.fore) annotation (Line(
      points={{-74,-10},{-62,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(PI1.y,limiter1. u) annotation (Line(points={{115,56},{136,56},{136,28},{127.2,28}},
                             color={0,0,127}));
  connect(boundary_fore.p0_var, limiter1.y) annotation (Line(points={{94,28},{113.4,28}}, color={0,0,127}));
  connect(multiSensor_Tpm1.m_flow_out, feedback1.u2) annotation (Line(points={{36.2,26},{48,26},{48,48}},
                                                                                                        color={0,0,127}));
  connect(feedback1.y, PI1.u) annotation (Line(points={{57,56},{92,56}}, color={0,0,127}));
  connect(boundary_rear1.fore, multiSensor_Tpm2.rear)
    annotation (Line(
      points={{92,10},{38,10}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.fore, flowResistanceB.rear) annotation (Line(
      points={{-38,-10},{-42,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(feedback.y,PI. u)
    annotation (Line(points={{17,-48},{38,-48}}, color={0,0,127}));
  connect(PI.y,limiter. u)
    annotation (Line(points={{61,-48},{76.8,-48}}, color={0,0,127}));
  connect(limiter.y, boundary_rear1.p0_var) annotation (Line(points={{90.6,-48},{112,-48},{112,16},{104,16}}, color={0,0,127}));
  connect(multiSensor_Tpm2.m_flow_out, feedback.u2) annotation (Line(points={{19.8,6},{8,6},{8,-40}},
                                                                                                    color={0,0,127}));
  connect(multiSensor_Tpm1.fore, boundary_fore.rear) annotation (Line(
      points={{38,22},{82,22}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear.fore, flowResistanceA.rear) annotation (Line(
      points={{-72,22},{-62,22}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.rear, flowResistanceA.fore) annotation (Line(
      points={{-38,22},{-42,22}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore1.p0_var, ramp3.y) annotation (Line(points={{-86,-4},{
          -99,-4}},                                                                                              color={0,0,127}));
  connect(ramp2.y, feedback1.u1) annotation (Line(points={{9,56},{40,56}},                  color={0,0,127}));
  connect(feedback.u1, ramp1.y) annotation (Line(points={{0,-48},{-19,-48}}, color={0,0,127}));
  connect(discretizedHEX.foreB, multiSensor_Tpm3.rear) annotation (Line(
      points={{-14,10},{-16,10},{-16,-10},{-18,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.fore, discretizedHEX.rearA) annotation (Line(
      points={{-18,22},{-14,22}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX.foreA, multiSensor_Tpm1.rear) annotation (Line(
      points={{6,22},{18,22}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm2.fore, discretizedHEX.rearB) annotation (Line(
      points={{18,10},{6,10}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=40, Tolerance=1e-6, Interval=0.04, __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
        <p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end TestDiscretizedHEX;
