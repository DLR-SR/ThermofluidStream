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
        origin={-92,8})));

  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = MediumRefrigerant,
    pressureFromInput=false,
    p0_par(displayUnit="bar") = 400000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,-4})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package
      Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{24,8},{44,28}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package
      Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-40,8},{-20,28}})));
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
  Sensors.SingleSensorSelect singleSensorSelect(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{24,24},{44,44}})));
  Sensors.SingleSensorSelect singleSensorSelect1(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-20,24},{-40,44}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-20,36},{-40,56}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality1(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{24,36},{44,56}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm1(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-22,-4},{-42,-24}})));
  Sensors.SingleSensorSelect singleSensorSelect2(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{-22,-36},{-42,-16}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality2(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{-22,-48},{-42,-28}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm4(
    redeclare package Medium = MediumRefrigerant,
    digits=3,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{44,-4},{24,-24}})));
  Sensors.SingleSensorSelect singleSensorSelect3(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg)
    annotation (Placement(transformation(extent={{44,-36},{24,-16}})));
  Sensors.TwoPhaseSensorSelect sensorVaporQuality3(
    redeclare package Medium = MediumRefrigerant,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation (Placement(transformation(extent={{44,-48},{24,-28}})));
  FlowControl.MCV mCV(
    redeclare package Medium = MediumRefrigerant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0.2,
    massFlow_set_par=0.2) annotation (Placement(transformation(extent={{-76,-2},{-56,18}})));
equation
  connect(pCV.inlet, multiSensor_Tpm2.outlet)
    annotation (Line(
      points={{68,10},{68,16},{50,16},{50,8},{44,8}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality1.inlet, multiSensor_Tpm2.inlet)
    annotation (Line(
      points={{24,46},{20,46},{20,8},{24,8}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.inlet, multiSensor_Tpm2.inlet)
    annotation (Line(
      points={{24,34},{20,34},{20,8},{24,8}},
      color={28,108,200},
      thickness=0.5));
  connect(pCV.outlet, multiSensor_Tpm4.inlet)
    annotation (Line(
      points={{68,-10},{68,-14},{52,-14},{52,-4},{44,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm4.outlet, evaporator.inletB) annotation (Line(
      points={{24,-4},{18,-4},{18,-4},{10,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality3.inlet, multiSensor_Tpm4.inlet)
    annotation (Line(
      points={{44,-38},{52,-38},{52,-4},{44,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect3.inlet, multiSensor_Tpm4.inlet)
    annotation (Line(
      points={{44,-26},{52,-26},{52,-4},{44,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.inlet, evaporator.outletB) annotation (Line(
      points={{-22,-4},{-16,-4},{-16,-4},{-10,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect2.inlet, evaporator.outletB)
    annotation (Line(
      points={{-22,-26},{-18,-26},{-18,-4},{-10,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality2.inlet, evaporator.outletB)
    annotation (Line(
      points={{-22,-38},{-18,-38},{-18,-4},{-10,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.outlet, sinkB.inlet)
    annotation (Line(
      points={{-42,-4},{-50,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB.outlet, mCV.inlet) annotation (Line(
      points={{-82,8},{-76,8}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.outlet, multiSensor_Tpm3.inlet) annotation (Line(
      points={{-56,8},{-40,8}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, evaporator.inletA) annotation (Line(
      points={{-20,8},{-16,8},{-16,8},{-10,8}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outletA, multiSensor_Tpm2.inlet) annotation (Line(
      points={{10,8},{18,8},{18,8},{24,8}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect1.inlet, evaporator.inletA)
    annotation (Line(
      points={{-20,34},{-16,34},{-16,8},{-10,8}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorVaporQuality.inlet, evaporator.inletA)
    annotation (Line(
      points={{-20,46},{-16,46},{-16,8},{-10,8}},
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
