within ThermofluidStream.HeatExchangers.Tests;
model Evaporator

  replaceable package MediumAir = Media.myMedia.Air.MoistAir
    constrainedby Media.myMedia.Interfaces.PartialMedium      annotation(choicesAllMatching = true);

  replaceable package MediumRefrigerant = Media.myMedia.R134a.R134a_ph
    constrainedby Media.myMedia.Interfaces.PartialMedium      annotation(choicesAllMatching = true);

  extends Modelica.Icons.Example;

  ThermofluidStream.Boundaries.Source sourceA(redeclare package Medium =
        MediumAir,
    T0_par=303.15,
    p0_par=200000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-6})));

  ThermofluidStream.Boundaries.Sink sinkA(
    redeclare package Medium = MediumAir, p0_par=150000)
                   annotation (Placement(transformation(extent={{-74,-16},{-94,4}})));

  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm(redeclare package Medium =
               MediumAir,
    temperatureUnit="degC",
    pressureUnit="bar")                                         annotation (
      Placement(transformation(
        extent={{11,10},{-11,-10}},
        rotation=0,
        origin={47,-16})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package Medium =
               MediumAir,
    digits=3,
    temperatureUnit="degC")   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-24,-16})));

  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    T0_par=283.15,
    p0_par=500000,
    h0_par=300e3)
               annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,60})));

  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 400000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={62,60})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package Medium =
               MediumRefrigerant,
    digits=3,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{24,10},{44,30}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package Medium =
               MediumRefrigerant,
    digits=3,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{132,-64},{152,-44}})));
  DiscretizedCounterFlowHEX evaporator(
    redeclare package MediumA = MediumAir,
    redeclare package MediumB = MediumRefrigerant,
    redeclare model ConductionElementA = Internal.ConductionElementHEX (U_nom=4000),
    redeclare model ConductionElementB = Internal.ConductionElementHEX_twoPhase (
        U_liq_nom=1000,
        U_vap_nom=1400,
        U_tp_nom=3000),
    initializeMassFlow=true,
    nCells=20,
    A=10,
    k_wall=250) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={2,2})));
  Processes.FlowResistance flowResistanceA(
    redeclare package Medium = MediumAir,
    m_flow_0=1,
    r=0.05,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{88,-16},{68,4}})));

  Processes.FlowResistance flowResistanceB(
    redeclare package Medium = MediumRefrigerant,
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
        MediumRefrigerant, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{24,44},{44,24}})));
  Sensors.SingleSensorSelect singleSensorSelect1(redeclare package Medium =
        MediumRefrigerant, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-20,44},{-40,24}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality(redeclare package Medium =
        MediumRefrigerant,                                                                      quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-20,-8},{-40,12}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality1(redeclare package Medium =
        MediumRefrigerant,                                                                       quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{24,-8},{44,12}})));
  FlowControl.MCV mCV(
    redeclare package Medium = MediumAir,
    m_flow_0=0,
    massFlow_set_par=1) annotation (Placement(transformation(extent={{-44,-16},{-64,4}})));
  FlowControl.MCV mCV1(
    redeclare package Medium = MediumRefrigerant,
    m_flow_0=1,
    massFlow_set_par=0.2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-60,30})));
equation
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
  connect(multiSensor_Tpm.outlet, evaporator.inletA)
    annotation (Line(
      points={{36,-6},{18,-6},{18,-6},{12,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outletA, multiSensor_Tpm1.inlet)
    annotation (Line(
      points={{-8.2,-6},{-8.2,-6},{-6,-6},{-14,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outletB, multiSensor_Tpm2.inlet) annotation (Line(
      points={{12.2,10},{24,10}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, evaporator.inletB) annotation (Line(
      points={{-20,10},{-8,10}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.inlet, evaporator.outletB)
    annotation (Line(
      points={{24,34},{20,34},{20,10},{12.2,10}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.inlet, evaporator.inletB)
    annotation (Line(
      points={{-20,34},{-16,34},{-16,10},{-8,10}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality.inlet, evaporator.inletB)
    annotation (Line(
      points={{-20,2},{-12,2},{-12,10},{-8,10}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality1.inlet, evaporator.outletB)
    annotation (Line(
      points={{24,2},{14,2},{14,10},{12.2,10}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA.inlet, mCV.outlet) annotation (Line(
      points={{-74,-6},{-64,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{-44,-6},{-34,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB.outlet, mCV1.inlet) annotation (Line(
      points={{-60,50},{-60,40}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV1.outlet, multiSensor_Tpm3.inlet) annotation (Line(
      points={{-60,20},{-60,10},{-40,10}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-160,-100},{160,100}})),
    experiment(
      StopTime=10,
   Tolerance=1e-6,
   Interval=0.01,
      __Dymola_Algorithm="Dassl"),
        Documentation(info="<html>
        <p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end Evaporator;
