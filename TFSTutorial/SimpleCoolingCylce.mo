within TFSTutorial;
model SimpleCoolingCylce

    extends Modelica.Icons.Example;

  package Coolant =
      ThermofluidStream.Media.myMedia.Incompressible.Examples.Glycol47;
  package Air = ThermofluidStream.Media.myMedia.Air.MoistAir;

  ThermofluidStream.Processes.ConductionElement conductionElement(
    redeclare package Medium = Coolant,
    init=ThermofluidStream.Processes.Internal.InitializationMethodsCondElement.T,
    T_0=283.15,
    A=10)
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));

  ThermofluidStream.HeatExchangers.CrossFlowNTU crossFlowNTU(
    redeclare package MediumA = Coolant,
    redeclare package MediumB = Air,
    A=60)                                                    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={114,20})));
  ThermofluidStream.Processes.Pump pump(
    redeclare package Medium = Coolant,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
                                        omega_from_input=true,
    redeclare function dp_tau_pump =
        ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal)
    annotation (Placement(transformation(extent={{10,-26},{-10,-46}})));
  Modelica.Blocks.Sources.Constant const(k=400)
    annotation (Placement(transformation(extent={{-28,-16},{-8,4}})));
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium = Coolant,
    r(displayUnit="mm") = 0.005,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss
        (k=10000))
    annotation (Placement(transformation(extent={{32,50},{52,70}})));
  ThermofluidStream.Boundaries.VolumeFlex volumeFlex(redeclare package Medium
      = Coolant,
    initialize_energy=true,
    T_start=283.15,
    V_ref=0.001)
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-34,72},{-14,92}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Air,
    temperatureFromInput=true,
    T0_par=298.15)
    annotation (Placement(transformation(extent={{210,10},{190,30}})));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Air)
    annotation (Placement(transformation(extent={{2,10},{-18,30}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=5000,
    Ti=10,
    yMax=500,
    yMin=1,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=100)
    annotation (Placement(transformation(extent={{222,-38},{202,-18}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{24,72},{44,92}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=25 + 273.15)
    annotation (Placement(transformation(extent={{248,-76},{228,-56}})));
  Modelica.Blocks.Sources.Constant
                               const1(k=20 + 273.15)
    annotation (Placement(transformation(extent={{238,34},{218,54}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{188,82},{208,102}})));
  Modelica.Blocks.Sources.Ramp           ramp(
    height=4000,
    duration=10,
    offset=1000,
    startTime=1000)
    annotation (Placement(transformation(extent={{-80,90},{-60,110}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=1000*
        450, T(fixed=true, start=298.15))
    annotation (Placement(transformation(extent={{-10,92},{10,112}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(
    redeclare package Medium = Air,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{154,20},{134,40}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(
    redeclare package Medium = Air,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{36,20},{16,40}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm6(
    redeclare package Medium = Coolant,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-40,-36},{-60,-16}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm7(
    redeclare package Medium = Coolant,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{54,-36},{34,-16}})));
  ThermofluidStream.Processes.Fan fan(
    redeclare package Medium = Air,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    omega_from_input=true,
    redeclare function dp_tau_fan =
        ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_const_isentrop
        (omega_ref=100, eta=0.8))
    annotation (Placement(transformation(extent={{68,10},{48,30}})));
  ThermofluidStream.Processes.FlowResistance flowResistance1(
    redeclare package Medium = Air,
    r=0.05,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{184,10},{164,30}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm11(
    redeclare package Medium = Air,
    temperatureUnit="degC",
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{98,20},{78,40}})));
equation
  connect(const.y, pump.omega_input)
    annotation (Line(points={{-7,-6},{0,-6},{0,-26}},    color={0,0,127}));
  connect(conductionElement.outlet, flowResistance.inlet) annotation (Line(
      points={{10,60},{32,60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, crossFlowNTU.inletA) annotation (Line(
      points={{52,60},{114,60},{114,30}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement.inlet, volumeFlex.outlet) annotation (Line(
      points={{-10,60},{-30,60}},
      color={28,108,200},
      thickness=0.5));
  connect(prescribedHeatFlow.port, conductionElement.heatPort)
    annotation (Line(points={{-14,82},{0,82},{0,69.8}}, color={191,0,0}));
  connect(realExpression.y, PID.u_m)
    annotation (Line(points={{227,-66},{212,-66},{212,-40}}, color={0,0,127}));
  connect(prescribedHeatFlow.Q_flow, ramp.y) annotation (Line(points={{-34,82},
          {-48,82},{-48,100},{-59,100}}, color={0,0,127}));
  connect(const1.y, source.T0_var) annotation (Line(points={{217,44},{210,44},{
          210,20},{202,20}}, color={0,0,127}));
  connect(heatCapacitor.port, conductionElement.heatPort)
    annotation (Line(points={{0,92},{0,69.8}}, color={191,0,0}));
  connect(temperatureSensor.port, heatCapacitor.port)
    annotation (Line(points={{24,82},{0,82},{0,92}}, color={191,0,0}));
  connect(temperatureSensor.T, PID.u_s) annotation (Line(points={{44,82},{246,
          82},{246,-28},{224,-28}}, color={0,0,127}));
  connect(crossFlowNTU.inletB, multiSensor_Tpm1.outlet) annotation (Line(
      points={{124,20},{134,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm6.inlet, pump.outlet) annotation (Line(
      points={{-40,-36},{-10,-36}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.inlet, multiSensor_Tpm7.outlet) annotation (Line(
      points={{10,-36},{34,-36}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm7.inlet, crossFlowNTU.outletA) annotation (Line(
      points={{54,-36},{114,-36},{114,10}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm2.inlet, fan.outlet) annotation (Line(
      points={{36,20},{48,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.inlet, flowResistance1.outlet) annotation (Line(
      points={{154,20},{164,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.inlet, source.outlet) annotation (Line(
      points={{184,20},{190,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm2.outlet, sink.inlet) annotation (Line(
      points={{16,20},{2,20}},
      color={28,108,200},
      thickness=0.5));
  connect(fan.inlet, multiSensor_Tpm11.outlet) annotation (Line(
      points={{68,20},{78,20}},
      color={28,108,200},
      thickness=0.5));
  connect(crossFlowNTU.outletB, multiSensor_Tpm11.inlet) annotation (Line(
      points={{104,20},{98,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm6.outlet, volumeFlex.inlet) annotation (Line(
      points={{-60,-36},{-74,-36},{-74,60},{-50,60}},
      color={28,108,200},
      thickness=0.5));
  connect(PID.y, fan.omega_input)
    annotation (Line(points={{201,-28},{58,-28},{58,10}},color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-240,-100},{260,100}})),
    experiment(
      StopTime=2000,
      __Dymola_NumberOfIntervals=4000,
      __Dymola_Algorithm="Dassl"));
end SimpleCoolingCylce;
