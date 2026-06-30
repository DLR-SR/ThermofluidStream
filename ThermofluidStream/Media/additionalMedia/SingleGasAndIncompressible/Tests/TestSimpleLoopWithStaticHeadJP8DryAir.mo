within ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.Tests;
model TestSimpleLoopWithStaticHeadJP8DryAir "Test of a cooling loop with static head using JP8DryAir"
  extends Modelica.Icons.Example;

  replaceable package TertiaryMedium = ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.JP8DryAir
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  //     TertiaryMedium.BaseProperties terMedium;

  ThermofluidStream.Processes.FlowResistance flowResistance1(
    redeclare package Medium = TertiaryMedium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=1e4),
    pressureDropUnit=ThermofluidStream.Types.PressureUnit.kPa)
    annotation (Placement(transformation(extent={{0,50},{-20,70}})));

  ThermofluidStream.Processes.Pump pump(
    redeclare package Medium = TertiaryMedium,
    omega_from_input=true,
    redeclare function dp_tau_pump = ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal (
          useLegacyReynolds=false)) annotation (Placement(transformation(extent={{70,-30},{90,-10}})));

  ThermofluidStream.Processes.ConductionElement conductionElement(
    redeclare package Medium = TertiaryMedium,
    displayVolume=false,
    displayConduction=false) annotation (Placement(transformation(extent={{0,-10},{20,-30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heating_element
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Modelica.Blocks.Sources.RealExpression heat(y=40000)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  ThermofluidStream.Boundaries.Reservoir reservoir(redeclare package Medium = TertiaryMedium)
    annotation (Placement(transformation(extent={{-120,-30},{-100,-10}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(
    redeclare package Medium = TertiaryMedium,
    outputTemperature=false,
    outputMassFlowRate=false,
    temperatureUnit="degC") annotation (Placement(transformation(extent={{-40,60},{-60,80}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=600, uMin=50)
    annotation (Placement(transformation(extent={{14,-96},{26,-84}})));
  Modelica.Blocks.Continuous.PI PI2(
    k=-5,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=300) annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  Modelica.Blocks.Math.Feedback feedback2 annotation (Placement(transformation(extent={{-60,-80},{-40,-100}})));
  Modelica.Blocks.Sources.RealExpression refFlow_setPoint2(y=15)
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  ThermofluidStream.Sensors.DifferenceSensor_Tp differenceSensor_Tp(
    redeclare package MediumA = TertiaryMedium,
    redeclare package MediumB = TertiaryMedium,
    outputTemperature=true) annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  inner ThermofluidStream.Boundaries.AccelerationBoundary acceleration(
    setFromInputs=false,
    ax=9*sin(0.1*time),
    ay=0) annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  ThermofluidStream.Processes.StaticHead staticHead(
    redeclare package Medium = TertiaryMedium,
    fromPosition={0,0,0},
    toPosition={3,0,2})
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={130,30})));
  ThermofluidStream.Processes.StaticHead staticHead1(
    redeclare package Medium = TertiaryMedium,
    fromPosition={3,0,2},
    toPosition={1,0,1}) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-140,40})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(
    redeclare package Medium = TertiaryMedium,
    outputTemperature=false,
    outputMassFlowRate=false,
    temperatureUnit="degC") annotation (Placement(transformation(extent={{100,-20},{120,-40}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(
    redeclare package Medium = TertiaryMedium,
    outputTemperature=false,
    outputMassFlowRate=false,
    temperatureUnit="degC") annotation (Placement(transformation(extent={{60,60},{40,80}})));
  ThermofluidStream.Processes.StaticHead staticHead2(
    redeclare package Medium = TertiaryMedium,
    fromPosition={1,0,1},
    toPosition={0,0,0},
    displayPositions=false) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-80,-20})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm5(
    redeclare package Medium = TertiaryMedium,
    outputTemperature=false,
    outputMassFlowRate=false,
    temperatureUnit="degC") annotation (Placement(transformation(extent={{-60,-20},{-40,-40}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm4(
    redeclare package Medium = TertiaryMedium,
    outputTemperature=false,
    outputMassFlowRate=false,
    temperatureUnit="degC") annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-150,10})));
equation

  connect(heating_element.port, conductionElement.heatPort)
    annotation (Line(points={{-40,10},{10,10},{10,-10}}, color={191,0,0}));
  connect(heat.y, heating_element.Q_flow) annotation (Line(points={{-79,10},{-60,10}}, color={0,0,127}));
  connect(flowResistance1.outlet, multiSensor_Tpm3.inlet)
    annotation (Line(
      points={{-20,60},{-40,60}},
      color={28,108,200},
      thickness=0.5));
  connect(limiter2.u, PI2.y) annotation (Line(points={{12.8,-90},{1,-90}}, color={0,0,127}));
  connect(limiter2.y, pump.omega_input) annotation (Line(points={{26.6,-90},{80,-90},{80,-32}}, color={0,0,127}));
  connect(feedback2.y, PI2.u) annotation (Line(points={{-41,-90},{-22,-90}}, color={0,0,127}));
  connect(feedback2.u1, refFlow_setPoint2.y) annotation (Line(points={{-58,-90},{-79,-90}}, color={0,0,127}));
  connect(multiSensor_Tpm3.outlet, staticHead1.inlet)
    annotation (Line(
      points={{-60,60},{-140,60},{-140,50}},
      color={28,108,200},
      thickness=0.5));
  connect(staticHead.outlet, multiSensor_Tpm2.inlet)
    annotation (Line(
      points={{130,40},{130,60},{60,60}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm2.outlet, flowResistance1.inlet)
    annotation (Line(
      points={{40,60},{0,60}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.outlet, multiSensor_Tpm1.inlet)
    annotation (Line(
      points={{90,-20},{100,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.outlet, staticHead.inlet)
    annotation (Line(
      points={{120,-20},{130,-20},{130,20}},
      color={28,108,200},
      thickness=0.5));
  connect(reservoir.outlet, staticHead2.inlet)
    annotation (Line(
      points={{-100,-20},{-90,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement.outlet, pump.inlet)
    annotation (Line(
      points={{20,-20},{70,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(staticHead2.outlet, multiSensor_Tpm5.inlet)
    annotation (Line(
      points={{-70,-20},{-60,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm5.outlet, conductionElement.inlet)
    annotation (Line(
      points={{-40,-20},{0,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement.outlet, differenceSensor_Tp.inletA)
    annotation (Line(
      points={{20,-20},{30,-20},{30,-46},{40,-46}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm5.outlet, differenceSensor_Tp.inletB)
    annotation (Line(
      points={{-40,-20},{-8,-20},{-8,-54},{40,-54}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensor_Tp.T_out, feedback2.u2)
    annotation (Line(points={{61,-46},{68,-46},{68,-66},{-50,-66},{-50,-82}}, color={0,0,127}));
  connect(staticHead1.outlet, multiSensor_Tpm4.inlet)
    annotation (Line(
      points={{-140,30},{-140,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm4.outlet, reservoir.inlet)
    annotation (Line(
      points={{-140,0},{-140,-20},{-120,-20}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-120},{160,120}})),
    experiment(StopTime=30, __Dymola_Algorithm="Dassl"),
    Documentation(revisions="<html>
  <ul>
    <li>
      06/2026, by Corentin Lepais (corentin.lepais@dlr.de):<br>
      Improve documentation and graphic layer. Change heat in-flow from 40W to 40000W to make sure the loop reaches the setpoint. 
    </li>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Introduced new version of <code>dp_tau_const_isentrop</code> pump function.
    </li>
    <li>
      <p><img src=\"modelica://ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
        Simulation and Thermal Analysis,
        Vehicle Systems,
        SAAB Aerosystems, 2024
     </p>
    </li>
  </ul>
</html>", info="<html>
  <p>
    <code>TestSimpleLoopWithStaticHeadJP8DryAir</code> is a Modelica test model for a simple cooling loop using
    <a href=\"modelica://ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.JP8DryAir\">JP8DryAir</a>,
    a mixture of JP8 jet fuel and dry air, as the working fluid.
  </p>
  <p>
    This model extends
    <a href=\"modelica://ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.Tests.TestSimpleLoopJP8DryAir\">TestSimpleLoopJP8DryAir</a>
    by adding static head components to simulate pressure changes due to acceleration.
    The acceleration profile is sinusoidal along the x axis with a period of 60s and an amplitude of 9 m/s².
  </p>
</html>"));
end TestSimpleLoopWithStaticHeadJP8DryAir;
