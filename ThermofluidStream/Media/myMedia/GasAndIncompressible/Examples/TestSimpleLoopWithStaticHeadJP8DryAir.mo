within ThermofluidStream.Media.myMedia.GasAndIncompressible.Examples;
model TestSimpleLoopWithStaticHeadJP8DryAir

    replaceable package SecondaryMedium =
      ThermofluidStream.Media.XRGMedia.CO2_ph constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    annotation(choicesAllMatching=true);

  replaceable package RefrigerantMedium =
    ThermofluidStream.Media.XRGMedia.CO2_ph  constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    annotation(choicesAllMatching=true);

  replaceable package TertiaryMedium =
    ThermofluidStream.Media.myMedia.GasAndIncompressible.JP8DryAir     constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    annotation(choicesAllMatching=true);
//     TertiaryMedium.BaseProperties terMedium;

  ThermofluidStream.Processes.FlowResistance flowResistance1(
    redeclare package Medium = TertiaryMedium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss
        (k=1e4))
    annotation (Placement(transformation(extent={{26,-4},{6,16}})));
  ThermofluidStream.Processes.Pump pump(redeclare package Medium =
        TertiaryMedium,
    omega_from_input=true,
    redeclare function dp_tau_pump =
        ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal)
    annotation (Placement(transformation(extent={{92,-82},{112,-62}})));
  ThermofluidStream.Processes.ConductionElement conductionElement(redeclare
      package Medium = TertiaryMedium)
    annotation (Placement(transformation(extent={{42,-82},{62,-62}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heating_element
    annotation (Placement(transformation(extent={{32,-56},{52,-36}})));
  Modelica.Blocks.Sources.RealExpression heat(y=40)
    annotation (Placement(transformation(extent={{-8,-58},{12,-38}})));
  ThermofluidStream.Boundaries.Reservoir reservoir(redeclare package Medium =
        TertiaryMedium)
    annotation (Placement(transformation(extent={{-114,-94},{-94,-74}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(
    redeclare package Medium = TertiaryMedium,
    outputTemperature=true,
    outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-6,6},{-52,-18}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{-174,-50},{-154,-30}})));
  Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=600, uMin=50)
    annotation (Placement(transformation(extent={{38,-150},{50,-138}})));
  Modelica.Blocks.Continuous.PI PI2(
    k=-5,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=300)
    annotation (Placement(transformation(extent={{4,-154},{24,-134}})));
  Modelica.Blocks.Math.Feedback feedback2
    annotation (Placement(transformation(extent={{-32,-134},{-12,-154}})));
  Modelica.Blocks.Sources.RealExpression refFlow_setPoint2(y=15)
    annotation (Placement(transformation(extent={{-66,-154},{-46,-134}})));
  ThermofluidStream.Sensors.DifferenceSensor_Tp differenceSensor_Tp(
  redeclare package MediumA = TertiaryMedium,
  redeclare package MediumB = TertiaryMedium,
      outputTemperature=true)
    annotation (Placement(transformation(extent={{66,-96},{86,-116}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-4,-126},{-14,-116}})));
  inner ThermofluidStream.Boundaries.AccelerationBoundary acceleration(
    setFromInputs=false,
    setFromExpressions=true,
    ax=9*sin(0.1*time),
    ay=0) annotation (Placement(transformation(extent={{-178,-22},{-158,-2}})));
  ThermofluidStream.Processes.StaticHead staticHead(
    redeclare package Medium = TertiaryMedium,
    fromPosition={0,0,0},
    toPosition={3,0,2}) annotation (Placement(transformation(
        extent={{-13,-16},{13,16}},
        rotation=90,
        origin={178,-29})));
  ThermofluidStream.Processes.StaticHead staticHead1(
    redeclare package Medium = TertiaryMedium,
    fromPosition={3,0,2},
    toPosition={1,0,1}) annotation (Placement(transformation(
        extent={{13,-16},{-13,16}},
        rotation=90,
        origin={-126,-15})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(
    redeclare package Medium = TertiaryMedium,
    outputTemperature=true,
    outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{118,-72},{164,-96}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm4(
    redeclare package Medium = TertiaryMedium,
    outputTemperature=true,
    outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-23,12},{23,-12}},
        rotation=-90,
        origin={-137,-62})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(
    redeclare package Medium = TertiaryMedium,
    outputTemperature=true,
    outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{118,6},{72,-18}})));
  ThermofluidStream.Processes.StaticHead staticHead2(
    redeclare package Medium = TertiaryMedium,
    fromPosition={1,0,1},
    toPosition={0,0,0},
    displayPositions=false) annotation (Placement(transformation(
        extent={{13,16},{-13,-16}},
        rotation=180,
        origin={-66,-85})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm5(
    redeclare package Medium = TertiaryMedium,
    outputTemperature=true,
    outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-42,-86},{4,-110}})));
equation

  connect(heating_element.port,conductionElement. heatPort) annotation (Line(
        points={{52,-46},{52,-62.2}},                                color={191,
          0,0}));
  connect(heat.y,heating_element. Q_flow) annotation (Line(points={{13,-48},{
          13,-46},{32,-46}}, color={0,0,127}));
  connect(flowResistance1.outlet,multiSensor_Tpm3. inlet) annotation (Line(
      points={{6,6},{8.88178e-16,6},{8.88178e-16,6},{-6,6}},
      color={28,108,200},
      thickness=0.5));
  connect(limiter2.u,PI2. y)
    annotation (Line(points={{36.8,-144},{25,-144}},   color={0,0,127}));
  connect(limiter2.y, pump.omega_input) annotation (Line(points={{50.6,-144},
          {102,-144},{102,-82}},                 color={0,0,127}));
  connect(feedback2.y, PI2.u)
    annotation (Line(points={{-13,-144},{2,-144}}, color={0,0,127}));
  connect(feedback2.u1, refFlow_setPoint2.y)
    annotation (Line(points={{-30,-144},{-45,-144}}, color={0,0,127}));
  connect(differenceSensor_Tp.inletA, conductionElement.inlet) annotation (Line(
      points={{66,-114},{32,-114},{32,-72},{42,-72}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensor_Tp.inletB, conductionElement.outlet) annotation (
      Line(
      points={{66,-98},{66,-88},{72,-88},{72,-72},{62,-72}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensor_Tp.T_out, gain.u) annotation (Line(points={{86,-110},
          {92,-110},{92,-120},{-3,-120},{-3,-121}},
                                         color={0,0,127}));
  connect(feedback2.u2, gain.y) annotation (Line(points={{-22,-136},{-22,-121},
          {-14.5,-121}}, color={0,0,127}));
  connect(multiSensor_Tpm3.outlet, staticHead1.inlet) annotation (Line(
      points={{-52,6},{-126,6},{-126,-2}},
      color={28,108,200},
      thickness=0.5));
  connect(staticHead.outlet, multiSensor_Tpm2.inlet) annotation (Line(
      points={{178,-16},{178,6},{118,6}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm2.outlet, flowResistance1.inlet) annotation (Line(
      points={{72,6},{26,6}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.outlet, multiSensor_Tpm1.inlet) annotation (Line(
      points={{112,-72},{118,-72}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.outlet, staticHead.inlet) annotation (Line(
      points={{164,-72},{164,-52},{178,-52},{178,-42}},
      color={28,108,200},
      thickness=0.5));
  connect(staticHead1.outlet, multiSensor_Tpm4.inlet) annotation (Line(
      points={{-126,-28},{-126,-34},{-125,-34},{-125,-39}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm4.outlet, reservoir.inlet) annotation (Line(
      points={{-125,-85},{-119.5,-85},{-119.5,-84},{-114,-84}},
      color={28,108,200},
      thickness=0.5));
  connect(reservoir.outlet, staticHead2.inlet) annotation (Line(
      points={{-94,-84},{-85.5,-84},{-85.5,-85},{-79,-85}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement.outlet, pump.inlet) annotation (Line(
      points={{62,-72},{92,-72}},
      color={28,108,200},
      thickness=0.5));
  connect(staticHead2.outlet, multiSensor_Tpm5.inlet) annotation (Line(
      points={{-53,-85},{-46.5,-85},{-46.5,-86},{-42,-86}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm5.outlet, conductionElement.inlet) annotation (Line(
      points={{4,-86},{8,-85},{8,-72},{42,-72}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-180},{260,100}}),
        graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-82,-178},{192,98}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-18,74},{170,-46},{-18,-158},{-18,74}})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-180},{260,
            100}})),
    experiment(StopTime=30, __Dymola_Algorithm="Dassl"));
end TestSimpleLoopWithStaticHeadJP8DryAir;
