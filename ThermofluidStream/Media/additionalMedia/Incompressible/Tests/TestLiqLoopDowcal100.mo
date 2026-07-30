within ThermofluidStream.Media.additionalMedia.Incompressible.Tests;
model TestLiqLoopDowcal100 "Test of medium Dowcal100 for a liquid loop"
  extends Modelica.Icons.Example;
  replaceable package SecondaryMedium = ThermofluidStream.Media.XRGMedia.CO2_ph constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium annotation (choicesAllMatching=true);

  replaceable package TertiaryMedium = ThermofluidStream.Media.additionalMedia.Incompressible.Dowcal100 constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium annotation (choicesAllMatching=true);

  ThermofluidStream.HeatExchangers.DiscretizedCounterFlowHEX evaporator(
    redeclare package MediumA = TertiaryMedium,
    redeclare package MediumB = SecondaryMedium,
    redeclare model ConductionElementA = ThermofluidStream.HeatExchangers.Internal.ConductionElementHEX,
    redeclare model ConductionElementB = ThermofluidStream.HeatExchangers.Internal.ConductionElementHEX_twoPhase,
    initializeMassFlow=false,
    nCells=10,
    A=15,
    V_Hex(displayUnit="m3"),
    k_wall=50) annotation (Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-44,78})));

  ThermofluidStream.Processes.FlowResistance flowResistance1(
    redeclare package Medium = TertiaryMedium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=1e4),
    pressureDropUnit=ThermofluidStream.Types.PressureUnit.kPa,
    pressureDropSignificantDigits=2) annotation (Placement(transformation(extent={{60,56},{40,76}})));

  ThermofluidStream.Processes.Pump pump(
    redeclare package Medium = TertiaryMedium,
    omega_from_input=true,
    redeclare function dp_tau_pump = ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal (
          useLegacyReynolds=false)) annotation (Placement(transformation(extent={{40,-20},{60,0}})));

  ThermofluidStream.Processes.ConductionElement conductionElement(
    redeclare package Medium = TertiaryMedium,
    displayVolume=false,
    displayConduction=false) annotation (Placement(transformation(extent={{-44,0},{-24,-20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heating_element
    annotation (Placement(transformation(extent={{-64,10},{-44,30}})));
  Modelica.Blocks.Sources.RealExpression heat(y=40000)
    annotation (Placement(transformation(extent={{-104,10},{-84,30}})));
  ThermofluidStream.Boundaries.Reservoir reservoir(redeclare package Medium = TertiaryMedium)
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = SecondaryMedium,
    temperatureFromInput=true,
    p0_par(displayUnit="Pa") = (SecondaryMedium.saturationPressure(263.15)))
    annotation (Placement(transformation(extent={{-180,80},{-160,100}})));
  ThermofluidStream.Boundaries.Sink sink1(redeclare package Medium = SecondaryMedium, pressureFromInput=true)
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
  ThermofluidStream.Processes.FlowResistance flowResistance2(
    redeclare package Medium = SecondaryMedium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=1e4),
    pressureDropUnit=ThermofluidStream.Types.PressureUnit.bar,
    pressureDropSignificantDigits=3) annotation (Placement(transformation(extent={{-140,80},{-120,100}})));

  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(
    redeclare package Medium = SecondaryMedium,
    pressureUnit="bar",
    outputTemperature=false,
    outputMassFlowRate=false,
    temperatureUnit="degC") annotation (Placement(transformation(extent={{0,90},{20,110}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=10e5, uMin=100)
    annotation (Placement(transformation(extent={{100,80},{80,100}})));
  Modelica.Blocks.Continuous.PI PI1(
    k=200000,
    T=10,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5) annotation (Placement(transformation(extent={{140,80},{120,100}})));
  Modelica.Blocks.Math.Feedback feedback1 annotation (Placement(transformation(extent={{170,80},{150,100}})));
  Modelica.Blocks.Sources.RealExpression refFlow_setPoint1(y=30)
    annotation (Placement(transformation(extent={{200,80},{180,100}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons annotation (Placement(transformation(extent={{100,0},{120,20}})));
  Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=600, uMin=50)
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
  Modelica.Blocks.Continuous.PI PI2(
    k=-50,
    T=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=300) annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Modelica.Blocks.Math.Feedback feedback2 annotation (Placement(transformation(extent={{-80,-60},{-60,-80}})));
  Modelica.Blocks.Sources.RealExpression refFlow_setPoint2(y=15)
    annotation (Placement(transformation(extent={{-120,-80},{-100,-60}})));
  Modelica.Blocks.Sources.RealExpression inlet_temp(y=283.15)
    annotation (Placement(transformation(extent={{-210,80},{-190,100}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm4(
    redeclare package Medium = SecondaryMedium,
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=false,
    outputMassFlowRate=false) annotation (Placement(transformation(extent={{-100,90},{-80,110}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm2(
    redeclare package Medium = TertiaryMedium,
    pressureUnit="bar",
    outputTemperature=false,
    outputMassFlowRate=false,
    temperatureUnit="degC") annotation (Placement(transformation(extent={{16,66},{-4,46}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm1(
    redeclare package Medium = TertiaryMedium,
    pressureUnit="bar",
    outputTemperature=true,
    outputMassFlowRate=false,
    temperatureUnit="degC") annotation (Placement(transformation(extent={{-80,66},{-100,46}})));
  Sensors.DifferenceSensor_Tp differenceSensor_Tp(
    redeclare package MediumA = TertiaryMedium,
    redeclare package MediumB = TertiaryMedium,
    outputTemperature=true)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,-30})));
equation
  connect(pump.outlet, flowResistance1.inlet)
    annotation (Line(
      points={{60,-10},{76,-10},{76,66},{60,66}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement.outlet, pump.inlet)
    annotation (Line(
      points={{-24,-10},{40,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(heating_element.port, conductionElement.heatPort)
    annotation (Line(points={{-44,20},{-34,20},{-34,0}}, color={191,0,0}));
  connect(heat.y, heating_element.Q_flow) annotation (Line(points={{-83,20},{-64,20}}, color={0,0,127}));
  connect(reservoir.outlet, conductionElement.inlet)
    annotation (Line(
      points={{-80,-10},{-44,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowResistance2.inlet)
    annotation (Line(
      points={{-160,90},{-140,90}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, multiSensor_Tpm3.outlet)
    annotation (Line(
      points={{40,90},{20,90}},
      color={28,108,200},
      thickness=0.5));
  connect(limiter1.y, sink1.p0_var) annotation (Line(points={{79,90},{52,90}}, color={0,0,127}));
  connect(limiter1.u, PI1.y) annotation (Line(points={{102,90},{119,90}}, color={0,0,127}));
  connect(PI1.u, feedback1.y) annotation (Line(points={{142,90},{151,90}}, color={0,0,127}));
  connect(feedback1.u1, refFlow_setPoint1.y) annotation (Line(points={{168,90},{179,90}}, color={0,0,127}));
  connect(evaporator.outletB, multiSensor_Tpm3.inlet)
    annotation (Line(
      points={{-24,90},{0,90}},
      color={28,108,200},
      thickness=0.5));
  connect(limiter2.u, PI2.y) annotation (Line(points={{-2,-70},{-19,-70}}, color={0,0,127}));
  connect(limiter2.y, pump.omega_input) annotation (Line(points={{21,-70},{50,-70},{50,-22}}, color={0,0,127}));
  connect(feedback2.y, PI2.u) annotation (Line(points={{-61,-70},{-42,-70}}, color={0,0,127}));
  connect(feedback2.u1, refFlow_setPoint2.y) annotation (Line(points={{-78,-70},{-99,-70}}, color={0,0,127}));
  connect(flowResistance2.outlet, multiSensor_Tpm4.inlet)
    annotation (Line(
      points={{-120,90},{-100,90}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm4.outlet, evaporator.inletB)
    annotation (Line(
      points={{-80,90},{-64,90}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm2.outlet, evaporator.inletA)
    annotation (Line(
      points={{-4,66},{-24,66}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm2.inlet, flowResistance1.outlet)
    annotation (Line(
      points={{16,66},{40,66}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outletA, multiSensor_Tpm1.inlet)
    annotation (Line(
      points={{-64,66},{-80,66}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.outlet, reservoir.inlet) annotation (Line(
      points={{-100,66},{-120,66},{-120,-10},{-100,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.T_out, feedback1.u2)
    annotation (Line(points={{-101,50},{-110,50},{-110,40},{160,40},{160,82}}, color={0,0,127}));
  connect(inlet_temp.y, source1.T0_var) annotation (Line(points={{-189,90},{-172,90}}, color={0,0,127}));
  connect(differenceSensor_Tp.inletB, reservoir.outlet)
    annotation (Line(
      points={{0,-34},{-60,-34},{-60,-10},{-80,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensor_Tp.inletA, conductionElement.outlet)
    annotation (Line(
      points={{0,-26},{-14,-26},{-14,-10},{-24,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensor_Tp.T_out, feedback2.u2)
    annotation (Line(points={{21,-26},{32,-26},{32,-50},{-70,-50},{-70,-62}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-220,-100},{220,120}})),
    Documentation(info="<html>
  <p>
    <code>TestLiqLoopDowcal100</code> is a Modelica test model for <a href=\"modelica://ThermofluidStream.Media.additionalMedia.Incompressible.Dowcal100\">Dowcal 100</a>, an incompressible heat transfer fluid.
    It simulates a liquid loop system with a primary Dowcal 100 circuit and a secondary CO2 circuit.
  </p>
  <p>
    The primary loop includes a reservoir, centrifugal pump, flow resistances, and heating element.
    A 40 kW heating element adds thermal energy to the Dowcal 100 fluid. The pump maintained a temperature difference of 15°C across the conduction element.
  </p>
  <p>
    The secondary loop uses a counter-flow heat exchanger (evaporator) for cooling with CO2 as cooling medium.
    A PI controller regulates CO2 sink pressure to maintain an evaporator outlet temperature of 30°C in the liquid loop.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Introduced new version of <code>dp_tau_const_isentrop</code> pump function.
    </li>
    <li>
      06/2026, by Corentin Lepais (corentin.lepais@dlr.de):<br>
      Improve documentation, graphic layer and controller performances.
    </li>
  </ul>
</html>"),
    experiment(StopTime=30, __Dymola_Algorithm="Dassl"));
end TestLiqLoopDowcal100;
