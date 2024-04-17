within ThermofluidStream.Examples;
model SimpleCoolingCycle "Basic cooling cycle with a load"
extends Modelica.Icons.Example;

  replaceable package Medium_liquid = Media.myMedia.Water.ConstantPropertyLiquidWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Liquid model"
    annotation(choicesAllMatching = true);

  replaceable package Medium_air = ThermofluidStream.Media.myMedia.Air.DryAirNasa
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Air model"
    annotation(choicesAllMatching = true);

  ThermofluidStream.HeatExchangers.CounterFlowNTU heatExchange_CounterFlowNTU(
    redeclare package MediumA = Medium_air,
    redeclare package MediumB = Medium_liquid,
    A=10) annotation (Placement(transformation(extent={{80,4},{100,24}})));
  Boundaries.VolumeFlex flexVolume(
    redeclare package Medium = Medium_liquid,
    V_ref=0.02,
    p_start=100000,
    T_start=278.15)
    annotation (Placement(transformation(extent={{40,10},{20,30}})));
  ThermofluidStream.Processes.Pump pump(
    redeclare package Medium = Medium_liquid,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function dp_tau_pump = ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal)
    annotation (Placement(transformation(extent={{-20,10},{-40,30}})));
  ThermofluidStream.Processes.ThermalConvectionPipe thermalConvectionPipe(
    redeclare package Medium = Medium_liquid,
    r=0.005,
    l=1) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-80,50})));
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium_liquid,
    r=0.05,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e5))
    annotation (Placement(transformation(extent={{80,70},{100,90}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(
    redeclare package Medium = Medium_liquid,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{70,20},{50,40}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(
    redeclare package Medium = Medium_liquid,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,20},{-10,40}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(
    redeclare package Medium = Medium_liquid,
    digits=2,
    outputMassFlowRate=true,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-50,20},{-70,0}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm4(
    redeclare package Medium = Medium_liquid,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-10,90})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium_air,
    T0_par=283.15,
    p0_par=101300)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={18,-10})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm5(
    redeclare package Medium = Medium_air,
    temperatureUnit="degC")
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={62,-2})));
  ThermofluidStream.Boundaries.Sink sink(
    redeclare package Medium = Medium_air,
    p0_par=101300) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={176,8})));
  Modelica.Mechanics.Rotational.Sources.Speed speed
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-18})));
  Modelica.Mechanics.Rotational.Sources.Speed speed1
    annotation (Placement(transformation(extent={{60,-90},{80,-70}})));

  ThermofluidStream.Processes.Fan fan(
    redeclare package Medium = Medium_air,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function dp_tau_fan =
        Processes.Internal.TurboComponent.dp_tau_const_isentrop (
      omega_ref=100))
    annotation (Placement(transformation(extent={{140,-2},{160,18}})));
  Modelica.Blocks.Sources.RealExpression pump_speed(y=80 + 273.15)
    annotation (Placement(transformation(extent={{-140,-30},{-160,-10}})));
  Modelica.Blocks.Sources.RealExpression fan_speed(y=400)
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=500, T(start=373.15, fixed=true))
    annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-150,40},{-130,60}})));
  Modelica.Blocks.Sources.RealExpression heat_load(y=10000)
    annotation (Placement(transformation(extent={{-180,80},{-160,100}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{160,80},{180,100}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm6(
    redeclare package Medium = Medium_liquid, temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={120,30})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm7(
    redeclare package Medium = Medium_air,
    temperatureUnit="degC")
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={120,-2})));
  Modelica.Blocks.Sources.RealExpression actual_heatPortTemp(
    y=thermalConvectionPipe.heatPort.T)
    annotation (Placement(transformation(extent={{-180,-90},{-160,-70}})));
  Modelica.Blocks.Interaction.Show.RealValue realValue(
    use_numberPort=false,
    number=thermalConvectionPipe.heatPort.T - 273.15)
    annotation (Placement(transformation(extent={{-160,20},{-180,0}})));
  ThermofluidStream.Utilities.showRealValue showRealValue
    annotation (Placement(transformation(extent={{-120,-26},{-100,-6}})));
  ThermofluidStream.Utilities.showRealValue showRealValue1(
    use_numberPort=false,
    description="eff",
    number=heatExchange_CounterFlowNTU.effectiveness)
    annotation (Placement(transformation(extent={{80,20},{100,40}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    table=[0,5000; 2000,5000;
        2000.01,10000; 4000,10000; 4000.01,25000; 6000,25000; 6000.01,5000; 10000,
        5000])
    annotation (Placement(transformation(extent={{-180,40},{-160,60}})));
  Modelica.Blocks.Math.Gain gain(k=-3)
    annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=30,
    Ti=2,
    yMax=-5,
    yMin=-5000)
    annotation (Placement(transformation(extent={{-160,-60},{-140,-40}})));
  Modelica.Blocks.Math.Gain gain1(k=-0.001)
    annotation (Placement(transformation(extent={{-120,-60},{-100,-40}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-90,-40},{-70,-60}})));
  Modelica.Blocks.Continuous.PI PI(
    k=3000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  ThermofluidStream.Utilities.showRealValue showRealValue2
    annotation (Placement(transformation(extent={{-100,-40},{-120,-20}})));
  ThermofluidStream.Utilities.Icons.DLRLogo dLRLogo annotation (Placement(transformation(extent={{142,-98},{178,-62}})));
equation
  connect(multiSensor_Tpm1.inlet, heatExchange_CounterFlowNTU.outletB)
    annotation (Line(
      points={{70,20},{80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.outlet, flexVolume.inlet) annotation (Line(
      points={{50,20},{40,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flexVolume.outlet, multiSensor_Tpm2.inlet) annotation (Line(
      points={{20,20},{10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm2.outlet, pump.inlet) annotation (Line(
      points={{-10,20},{-20,20}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.outlet, multiSensor_Tpm3.inlet) annotation (Line(
      points={{-40,20},{-50,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, thermalConvectionPipe.inlet) annotation (
      Line(
      points={{-70,20},{-80,20},{-80,40}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConvectionPipe.outlet, multiSensor_Tpm4.inlet) annotation (
      Line(
      points={{-80,60},{-80,80},{-20,80}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.inlet, multiSensor_Tpm4.outlet) annotation (Line(
      points={{80,80},{0,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, multiSensor_Tpm5.inlet) annotation (Line(
      points={{28,-10},{40,-10},{40,8},{52,8}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm5.outlet, heatExchange_CounterFlowNTU.inletA)
    annotation (Line(
      points={{72,8},{80,8}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, fan.outlet) annotation (Line(
      points={{166,8},{160,8}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConvectionPipe.heatPort, heatCapacitor.port)
    annotation (Line(points={{-90,50},{-110,50}}, color={191,0,0}));
  connect(heatCapacitor.port, prescribedHeatFlow.port)
    annotation (Line(points={{-110,50},{-130,50}}, color={191,0,0}));
  connect(heatExchange_CounterFlowNTU.inletB, multiSensor_Tpm6.outlet)
    annotation (Line(
      points={{100,20},{110,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm6.inlet, flowResistance.outlet) annotation (Line(
      points={{130,20},{140,20},{140,80},{100,80}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchange_CounterFlowNTU.outletA, multiSensor_Tpm7.inlet)
    annotation (Line(
      points={{100,8},{110,8}},
      color={28,108,200},
      thickness=0.5));
  connect(fan.inlet, multiSensor_Tpm7.outlet) annotation (Line(
      points={{140,8},{130,8}},
      color={28,108,200},
      thickness=0.5));
  connect(fan.flange, speed1.flange)
    annotation (Line(points={{150,-2},{150,-40},{100,-40},{100,-80},{80,-80}},
                                                             color={0,0,0}));
  connect(pump.flange, speed.flange)
    annotation (Line(points={{-30,10},{-30,-8}},             color={0,0,0}));
  connect(speed1.w_ref, gain.y) annotation (Line(points={{58,-80},{41,-80}},
                     color={0,0,127}));
  connect(PID.y, showRealValue.numberPort) annotation (Line(points={{-139,-50},{-130,-50},{-130,-16},{-121.5,-16}},
                                               color={0,0,127}));
  connect(PID.u_s, pump_speed.y)
    annotation (Line(points={{-162,-50},{-170,-50},{-170,-20},{-161,-20}},
                                                     color={0,0,127}));
  connect(actual_heatPortTemp.y, PID.u_m) annotation (Line(points={{-159,-80},{-150,-80},{-150,-62}},
                                 color={0,0,127}));
  connect(PID.y, gain1.u)
    annotation (Line(points={{-139,-50},{-122,-50}}, color={0,0,127}));
  connect(gain1.y, feedback.u1)
    annotation (Line(points={{-99,-50},{-88,-50}},   color={0,0,127}));
  connect(multiSensor_Tpm3.m_flow_out, feedback.u2) annotation (Line(points={{-68.2,16},{-80,16},{-80,-42}},
                                  color={0,0,127}));
  connect(PI.y, speed.w_ref)
    annotation (Line(points={{-39,-50},{-30,-50},{-30,-30}},
                                                   color={0,0,127}));
  connect(feedback.y, PI.u)
    annotation (Line(points={{-71,-50},{-62,-50}},   color={0,0,127}));
  connect(PID.y, gain.u) annotation (Line(points={{-139,-50},{-130,-50},{-130,-80},{18,-80}},
                          color={0,0,127}));
  connect(showRealValue2.numberPort, feedback.u1) annotation (Line(points={{-98.5,-30},{-92,-30},{-92,-50},{-88,-50}},
                                                         color={0,0,127}));
  connect(prescribedHeatFlow.Q_flow, combiTimeTable.y[1])
    annotation (Line(points={{-150,50},{-159,50}}, color={0,0,127}));

  annotation (
    experiment(
      StopTime=10000,
      Tolerance=1e-6,
      Interval=10,
      __Dymola_Algorithm="Dassl"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    Diagram(
      coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{180,100}})),
    Documentation(info="<html>
<p>This cooling cycle is regulated to hit a temperature target. The load is a prescribed heatflow and comes from a table.</p>
<p><br>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end SimpleCoolingCycle;
