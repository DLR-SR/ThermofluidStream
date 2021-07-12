within ThermofluidStream.HeatExchangers.Tests;
model Evaporator

  replaceable package mediumAir = Media.myMedia.Air.MoistAir
    constrainedby Media.myMedia.Interfaces.PartialMedium      annotation(choicesAllMatching = true);

  replaceable package mediumRefrigerant = Media.myMedia.R134a.R134a_ph
    constrainedby Media.myMedia.Interfaces.PartialMedium      annotation(choicesAllMatching = true);

  extends Modelica.Icons.Example;

  ThermofluidStream.Boundaries.Source sourceA(redeclare package Medium =
        mediumAir,
    T0_par=303.15,
    p0_par=200000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-6})));

  ThermofluidStream.Boundaries.Sink sinkA(
    redeclare package Medium = mediumAir,
    pressureFromInput=true,
    p0_par=100000) annotation (Placement(transformation(extent={{-46,-16},{-66,4}})));

  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm(redeclare package Medium =
               mediumAir,
    temperatureUnit="degC",
    pressureUnit="bar")                                         annotation (
      Placement(transformation(
        extent={{11,10},{-11,-10}},
        rotation=0,
        origin={47,-16})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package Medium =
               mediumAir,
    digits=3,
      outputMassFlowRate=true,
    temperatureUnit="degC")   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-24,-16})));

  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = mediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    pressureFromInput=true,
    T0_par=283.15,
    p0_par=200000,
    h0_par=300e3)
               annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,60})));

  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = mediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 400000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={62,60})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package Medium =
               mediumRefrigerant,
    digits=3,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{24,10},{44,30}})));
  Modelica.Blocks.Sources.RealExpression refFlow_setPoint(y=0.2)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=0,
        origin={26,84})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package Medium =
               mediumRefrigerant,
    digits=3,
    outputMassFlowRate=true,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Blocks.Sources.RealExpression airFlow_setPoint1(y=1)
    annotation (Placement(transformation(extent={{-162,0},{-142,20}})));
  Modelica.Blocks.Continuous.PI PI(
    k=10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=40,
    y_start=4e5)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=0,
        origin={-34,84})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-4,84})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=10e5, uMin=1e5)
    annotation (Placement(transformation(extent={{6,6},{-6,-6}},
        rotation=90,
        origin={-60,72})));
  Modelica.Blocks.Continuous.PI PI1(
    k=-10000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
    annotation (Placement(transformation(extent={{-108,-16},{-88,4}})));
  Modelica.Blocks.Math.Feedback feedback1
    annotation (Placement(transformation(extent={{-136,-16},{-116,4}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{132,-64},{152,-44}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=5e5, uMin=100)
    annotation (Placement(transformation(extent={{-78,-12},{-66,0}})));
  ThermofluidStream.HeatExchangers.DiscretizedHEX evaporator(
    initializeMassFlow=true,
    m_flow_0=0,
    nCells=20,
    redeclare package MediumAir = mediumAir,
    redeclare package MediumRefrigerant = mediumRefrigerant,
    A=10,
    k_wall=250,
    U_nom=4000,
    U_liq_nom=1000,
    U_vap_nom=1400,
    U_tp_nom=3000) annotation (Placement(transformation(extent={{10,12},{-10,-8}})));
  Processes.FlowResistance flowResistanceA(
    redeclare package Medium = mediumAir,
    m_flow_0=1,
    r=0.05,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{88,-16},{68,4}})));

  Processes.FlowResistance flowResistanceB(
    redeclare package Medium = mediumRefrigerant,
    m_flow_0=0.3,
    r=0.05,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={62,32})));
  Sensors.SingleSensorSelect singleSensorSelect(redeclare package Medium =
        mediumRefrigerant, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{24,44},{44,24}})));
  Sensors.SingleSensorSelect singleSensorSelect1(redeclare package Medium =
        mediumRefrigerant, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-20,44},{-40,24}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality(redeclare package Medium =
        mediumRefrigerant,                                                                      quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-20,-8},{-40,12}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality1(redeclare package Medium =
        mediumRefrigerant,                                                                       quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{24,-8},{44,12}})));
equation
  connect(sinkA.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{-46,-6},{-34,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(feedback.y, PI.u)
    annotation (Line(points={{-13,84},{-22,84}},  color={0,0,127}));
  connect(PI1.u, feedback1.y)
    annotation (Line(points={{-110,-6},{-117,-6}}, color={0,0,127}));
  connect(feedback1.u1, airFlow_setPoint1.y)
    annotation (Line(points={{-134,-6},{-140,-6},{-140,10},{-141,10}},
                                                 color={0,0,127}));
  connect(PI1.y, limiter1.u) annotation (Line(points={{-87,-6},{-79.2,-6}},
                             color={0,0,127}));
  connect(sourceA.outlet, flowResistanceA.inlet) annotation (Line(
      points={{100,-6},{88,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.inlet, flowResistanceA.outlet) annotation (Line(
      points={{58,-6},{68,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkB.inlet, flowResistanceB.outlet) annotation (Line(
      points={{62,50},{62,42}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceB.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{62,22},{62,10},{44,10}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB.outlet, multiSensor_Tpm3.inlet) annotation (Line(
      points={{-60,50},{-60,10},{-40,10}},
      color={28,108,200},
      thickness=0.5));
  connect(PI.y, limiter.u)
    annotation (Line(points={{-45,84},{-60,84},{-60,79.2}},
                                                   color={0,0,127}));
  connect(multiSensor_Tpm.outlet, evaporator.inletAir) annotation (Line(
      points={{36,-6},{10,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outletAir, multiSensor_Tpm1.inlet)
    annotation (Line(
      points={{-10.2,-6},{-14,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA.p0_var, limiter1.y)
    annotation (Line(points={{-58,-6},{-65.4,-6}}, color={0,0,127}));
  connect(multiSensor_Tpm1.m_flow_out, feedback1.u2) annotation (Line(points={{-34,-10},
          {-42,-10},{-42,-76},{-126,-76},{-126,-14}},      color={0,0,127}));
  connect(evaporator.outletRef, multiSensor_Tpm2.inlet) annotation (Line(
      points={{10.2,10},{24,10}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, evaporator.inletRef) annotation (Line(
      points={{-20,10},{-10,10}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.m_flow_out, feedback.u2)
    annotation (Line(points={{-20,14},{-4,14},{-4,76}}, color={0,0,127}));
  connect(feedback.u1, refFlow_setPoint.y)
    annotation (Line(points={{4,84},{15,84}}, color={0,0,127}));
  connect(sourceB.p0_var, limiter.y)
    annotation (Line(points={{-60,62},{-60,62},{-60,65.4}}, color={0,0,127}));
  connect(singleSensorSelect.inlet, evaporator.outletRef)
    annotation (Line(
      points={{24,34},{20,34},{20,10},{10.2,10}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.inlet, evaporator.inletRef)
    annotation (Line(
      points={{-20,34},{-16,34},{-16,10},{-10,10}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality.inlet, evaporator.inletRef)
    annotation (Line(
      points={{-20,2},{-12,2},{-12,10},{-10,10}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality1.inlet, evaporator.outletRef)
    annotation (Line(
      points={{24,2},{14,2},{14,10},{10.2,10}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-160,-100},{160,100}})),
    experiment(
      StopTime=10,
   Tolerance=1e-5,
      __Dymola_NumberOfIntervals=1000,
      __Dymola_Algorithm="Dassl"),
        Documentation(info="<html>
        <p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end Evaporator;
