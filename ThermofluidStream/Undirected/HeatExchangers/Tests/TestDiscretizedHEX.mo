within ThermofluidStream.Undirected.HeatExchangers.Tests;
model TestDiscretizedHEX

  extends Modelica.Icons.Example;

  replaceable package mediumAir = Media.myMedia.Air.MoistAir
                                                         constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true, Dialog(group = "Medium definitions"));

  replaceable package mediumRefrigerant = Media.myMedia.R134a.R134a_ph
                                                                 constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true, Dialog(group = "Medium definitions"));

  Boundaries.BoundaryRear boundary_rear(
    redeclare package Medium = mediumAir,
    pressureFromInput=true,
    T0_par=311.15) annotation (Placement(transformation(extent={{-96,14},{-76,34}})));
  Boundaries.BoundaryFore boundary_fore(
    redeclare package Medium = mediumAir,
    pressureFromInput=true,
    T0_par=311.15,
    p0_par=100000) annotation (Placement(transformation(extent={{84,14},{104,34}})));
  Boundaries.BoundaryFore boundary_fore1(
    redeclare package Medium = mediumRefrigerant,
    setEnthalpy=true,
    pressureFromInput=true,
    h0_par=300e3,
    T0_par=278.15,
    p0_par=400000) annotation (Placement(transformation(extent={{-90,-50},{-110,-30}})));
  Boundaries.BoundaryRear boundary_rear1(
    redeclare package Medium = mediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    pressureFromInput=true,
    h0_par=450e3,
    T0_par=268.15) annotation (Placement(transformation(extent={{112,-18},{92,2}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm(redeclare package Medium = mediumAir,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-42,22},{-22,42}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package Medium = mediumAir,
    temperatureUnit="degC",
    pressureUnit="bar",
    outputMassFlowRate=true)
    annotation (Placement(transformation(extent={{18,22},{38,42}})));
  Processes.FlowResistance flowResistanceA(
    redeclare package Medium = mediumAir,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=1,
    r=0.05,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-70,14},{-50,34}})));
  inner DropOfCommons dropOfCommons annotation (Placement(transformation(extent={{74,74},{94,94}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=-0.6,
    duration=10,
    offset=0.3,
    startTime=15) annotation (Placement(transformation(extent={{-40,-58},{-20,-38}})));
  Modelica.Blocks.Sources.Constant const1(k=1e5)    annotation (Placement(transformation(extent={{-120,14},{-100,34}})));
  DiscretizedHEX discretizedHEX(
    redeclare package MediumAir = mediumAir,
    redeclare package MediumRefrigerant = mediumRefrigerant,
    nCells=10,
    V_Hex(displayUnit="m3"),
    k_wall=300)
          annotation (Placement(transformation(extent={{-14,6},{6,26}})));
  Processes.FlowResistance flowResistanceB(
    redeclare package Medium = mediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0.3,
    r=0.05,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-52,-2},{-72,18}})));
  Modelica.Blocks.Continuous.PI PI1(
    k=-10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
    annotation (Placement(transformation(extent={{94,46},{114,66}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=5e5, uMin=100)
    annotation (Placement(transformation(extent={{126,18},{114,30}})));
  Modelica.Blocks.Math.Feedback feedback1
    annotation (Placement(transformation(extent={{38,46},{58,66}})));
  Modelica.Blocks.Sources.RealExpression airFlow_setPoint1(y=1)
    annotation (Placement(transformation(extent={{6,72},{26,92}})));
  Modelica.Blocks.Sources.Ramp ramp2(
    height=-1,
    duration=1,
    offset=1,
    startTime=30) annotation (Placement(transformation(extent={{-22,54},{-2,74}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package Medium =
        mediumRefrigerant,
    temperatureUnit="degC",
    pressureUnit="bar",                                                                  outputMassFlowRate=true)
    annotation (Placement(transformation(extent={{38,10},{18,-10}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package Medium =
        mediumRefrigerant,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-24,10},{-44,-10}})));
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
    startTime=15) annotation (Placement(transformation(extent={{-134,-50},{-114,-30}})));
equation
  connect(discretizedHEX.rearAir, multiSensor_Tpm.fore) annotation (Line(
      points={{-14,24},{-22,24}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX.foreAir, multiSensor_Tpm1.rear) annotation (Line(
      points={{6,24},{18,24}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear.p0_var, const1.y) annotation (Line(points={{-88,30},{-94,30},{-94,24},{-99,24}},
                                                                                       color={0,0,127}));
  connect(boundary_fore1.rear, flowResistanceB.fore) annotation (Line(
      points={{-90,-40},{-84,-40},{-84,8},{-72,8}},
      color={28,108,200},
      thickness=0.5));
  connect(PI1.y,limiter1. u) annotation (Line(points={{115,56},{136,56},{136,24},{127.2,24}},
                             color={0,0,127}));
  connect(boundary_fore.p0_var, limiter1.y) annotation (Line(points={{96,30},{104,30},{104,24},{113.4,24}},
                                                                                          color={0,0,127}));
  connect(multiSensor_Tpm1.m_flow_out, feedback1.u2) annotation (Line(points={{38,28},{48,28},{48,48}}, color={0,0,127}));
  connect(feedback1.y, PI1.u) annotation (Line(points={{57,56},{92,56}}, color={0,0,127}));
  connect(boundary_rear1.fore, multiSensor_Tpm2.rear)
    annotation (Line(
      points={{92,-8},{66,-8},{66,8},{38,8}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX.rearRef, multiSensor_Tpm2.fore) annotation (Line(
      points={{6,8},{18,8}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedHEX.foreRef, multiSensor_Tpm3.rear) annotation (Line(
      points={{-14,8},{-24,8}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.fore, flowResistanceB.rear) annotation (Line(
      points={{-44,8},{-52,8}},
      color={28,108,200},
      thickness=0.5));
  connect(feedback.y,PI. u)
    annotation (Line(points={{17,-48},{38,-48}},  color={0,0,127}));
  connect(PI.y,limiter. u)
    annotation (Line(points={{61,-48},{76.8,-48}}, color={0,0,127}));
  connect(limiter.y, boundary_rear1.p0_var) annotation (Line(points={{90.6,-48},{112,-48},{112,-2},{104,-2}}, color={0,0,127}));
  connect(multiSensor_Tpm2.m_flow_out, feedback.u2) annotation (Line(points={{18,4},{8,4},{8,-40}}, color={0,0,127}));
  connect(multiSensor_Tpm1.fore, boundary_fore.rear) annotation (Line(
      points={{38,24},{84,24}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear.fore, flowResistanceA.rear) annotation (Line(
      points={{-76,24},{-70,24}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.rear, flowResistanceA.fore) annotation (Line(
      points={{-42,24},{-50,24}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore1.p0_var, ramp3.y) annotation (Line(points={{-102,-34},{-108,-34},{-108,-40},{-113,-40}}, color={0,0,127}));
  connect(ramp2.y, feedback1.u1) annotation (Line(points={{-1,64},{24,64},{24,56},{40,56}},              color={0,0,127}));
  connect(feedback.u1, ramp1.y) annotation (Line(points={{0,-48},{-19,-48}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=40, tolerance=1e-6, Interval=0.04, __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
        <p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"),
    __Dymola_experimentSetupOutput_X(
      derivatives=false,
      inputs=false,
      outputs=true,
      auxiliaries=false,
      events=false));
end TestDiscretizedHEX;
