within ThermofluidStream.HeatExchangers.Tests;
model Recuperator
  extends Modelica.Icons.Example;

  replaceable package MediumRefrigerant = Media.myMedia.R134a.R134a_ph
    constrainedby Media.myMedia.Interfaces.PartialMedium
      annotation(choicesAllMatching = true);


  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = MediumRefrigerant,
    setEnthalpy=true,
    temperatureFromInput=false,
    pressureFromInput=false,
    T0_par=283.15,
    p0_par=500000,
    h0_par=300e3)
               annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-92,10})));

  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 400000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,-6})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package
      Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{24,10},{44,30}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package
      Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{132,-64},{152,-44}})));
  DiscretizedCounterFlowHEX evaporator(
    redeclare package MediumA = MediumRefrigerant,
    redeclare package MediumB = MediumRefrigerant,
    redeclare model ConductionElementA = Internal.ConductionElementHEX_twoPhase,
    redeclare model ConductionElementB = Internal.ConductionElementHEX_twoPhase,
    initializeMassFlow=false,
    nCells=20,
    A=10,
    k_wall=250) annotation (Placement(transformation(extent={{10,12},{-10,-8}})));

  FlowControl.PCV pCV(
    redeclare package Medium = MediumRefrigerant,
    m_flow_0=0.3,
    pressure_set_par=50000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={68,0})));
  Sensors.SingleSensorSelect singleSensorSelect(redeclare package Medium =
        MediumRefrigerant, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{24,44},{44,24}})));
  Sensors.SingleSensorSelect singleSensorSelect1(redeclare package Medium =
        MediumRefrigerant, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-20,44},{-40,24}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality(redeclare package Medium =
        MediumRefrigerant,                                                                      quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-20,32},{-40,52}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality1(redeclare package Medium =
        MediumRefrigerant,                                                                       quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{24,32},{44,52}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm1(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-22,-6},{-42,-26}})));
  Sensors.SingleSensorSelect singleSensorSelect2(redeclare package Medium =
        MediumRefrigerant,                                                                     quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-22,-18},{-42,-38}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality2(redeclare package Medium =
        MediumRefrigerant,                                                                       quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-22,-46},{-42,-26}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm4(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{44,-6},{24,-26}})));
  Sensors.SingleSensorSelect singleSensorSelect3(redeclare package Medium =
        MediumRefrigerant,                                                                     quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{44,-28},{24,-48}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality3(redeclare package Medium =
        MediumRefrigerant,                                                                       quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{44,-40},{24,-20}})));
  FlowControl.MCV mCV(
    redeclare package Medium = MediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0.2,
    massFlow_set_par=0.2) annotation (Placement(transformation(extent={{-76,0},{-56,20}})));
equation
  connect(pCV.inlet, multiSensor_Tpm2.outlet)
    annotation (Line(
      points={{68,10},{68,16},{50,16},{50,10},{44,10}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality1.inlet, multiSensor_Tpm2.inlet)
    annotation (Line(
      points={{24,42},{20,42},{20,10},{24,10}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.inlet, multiSensor_Tpm2.inlet)
    annotation (Line(
      points={{24,34},{20,34},{20,10},{24,10}},
      color={28,108,200},
      thickness=0.5));
  connect(pCV.outlet, multiSensor_Tpm4.inlet)
    annotation (Line(
      points={{68,-10},{68,-14},{52,-14},{52,-6},{44,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm4.outlet, evaporator.inletB) annotation (Line(
      points={{24,-6},{10,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality3.inlet, multiSensor_Tpm4.inlet)
    annotation (Line(
      points={{44,-30},{52,-30},{52,-6},{44,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect3.inlet, multiSensor_Tpm4.inlet)
    annotation (Line(
      points={{44,-38},{52,-38},{52,-6},{44,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.inlet, evaporator.outletB) annotation (Line(
      points={{-22,-6},{-10.2,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect2.inlet, evaporator.outletB)
    annotation (Line(
      points={{-22,-28},{-18,-28},{-18,-6},{-10.2,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality2.inlet, evaporator.outletB)
    annotation (Line(
      points={{-22,-36},{-18,-36},{-18,-6},{-10.2,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.outlet, sinkB.inlet)
    annotation (Line(
      points={{-42,-6},{-46,-6},{-46,-6},{-50,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB.outlet, mCV.inlet) annotation (Line(
      points={{-82,10},{-76,10}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.outlet, multiSensor_Tpm3.inlet) annotation (Line(
      points={{-56,10},{-40,10}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, evaporator.inletA) annotation (Line(
      points={{-20,10},{-10,10}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outletA, multiSensor_Tpm2.inlet) annotation (Line(
      points={{10.2,10},{24,10}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.inlet, evaporator.inletA)
    annotation (Line(
      points={{-20,34},{-16,34},{-16,10},{-10,10}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality.inlet, evaporator.inletA)
    annotation (Line(
      points={{-20,42},{-16,42},{-16,10},{-10,10}},
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
  <p><br>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end Recuperator;
