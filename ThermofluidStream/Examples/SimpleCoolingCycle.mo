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
    A=10) annotation (Placement(transformation(extent={{60,4},{80,24}})));
  Boundaries.VolumeFlex flexVolume(
    redeclare package Medium = Medium_liquid,
    V_ref=0.02,
    p_start=100000,
    T_start=278.15)
    annotation (Placement(transformation(extent={{20,10},{0,30}})));
  ThermofluidStream.Processes.Pump pump(
    redeclare package Medium = Medium_liquid,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function dp_tau_pump = ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal)
    annotation (Placement(transformation(extent={{-40,10},{-60,30}})));
  ThermofluidStream.Processes.ThermalConvectionPipe thermalConvectionPipe(
    redeclare package Medium = Medium_liquid,
    r=0.005,
    l=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,50})));
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium_liquid,
    r=0.05,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e5))
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(
    redeclare package Medium = Medium_liquid,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{50,20},{30,40}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(
    redeclare package Medium = Medium_liquid,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-10,20},{-30,40}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(
    redeclare package Medium = Medium_liquid,
    digits=2,
    outputMassFlowRate=true,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-70,20},{-90,0}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm4(
    redeclare package Medium = Medium_liquid,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-30,90})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium_air,
    T0_par=283.15,
    p0_par=101300)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-2,-10})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm5(
    redeclare package Medium = Medium_air,
    temperatureUnit="degC")
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={42,-2})));
  ThermofluidStream.Boundaries.Sink sink(
    redeclare package Medium = Medium_air,
    p0_par=101300) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={156,8})));
  Modelica.Mechanics.Rotational.Sources.Speed speed
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-18})));
  Modelica.Mechanics.Rotational.Sources.Speed speed1
    annotation (Placement(transformation(extent={{40,-90},{60,-70}})));

  ThermofluidStream.Processes.Fan fan(
    redeclare package Medium = Medium_air,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function dp_tau_fan =
        Processes.Internal.TurboComponent.dp_tau_const_isentrop (
      omega_ref=100))
    annotation (Placement(transformation(extent={{120,-2},{140,18}})));
  Modelica.Blocks.Sources.RealExpression pump_speed(y=80 + 273.15)
    annotation (Placement(transformation(extent={{-160,-30},{-180,-10}})));
  Modelica.Blocks.Sources.RealExpression fan_speed(y=400)
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=500, T(start=373.15, fixed=true))
    annotation (Placement(transformation(extent={{-140,50},{-120,70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-170,40},{-150,60}})));
  Modelica.Blocks.Sources.RealExpression heat_load(y=10000)
    annotation (Placement(transformation(extent={{-200,80},{-180,100}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{140,80},{160,100}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm6(
    redeclare package Medium = Medium_liquid, temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={100,30})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm7(
    redeclare package Medium = Medium_air,
    temperatureUnit="degC")
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={100,-2})));
  Modelica.Blocks.Sources.RealExpression actual_heatPortTemp(
    y=thermalConvectionPipe.heatPort.T)
    annotation (Placement(transformation(extent={{-200,-90},{-180,-70}})));
  Modelica.Blocks.Interaction.Show.RealValue realValue(
    use_numberPort=false,
    number=thermalConvectionPipe.heatPort.T - 273.15)
    annotation (Placement(transformation(extent={{-180,20},{-200,0}})));
  ThermofluidStream.Utilities.showRealValue showRealValue
    annotation (Placement(transformation(extent={{-140,-26},{-120,-6}})));
  ThermofluidStream.Utilities.showRealValue showRealValue1(
    use_numberPort=false,
    description="eff",
    number=heatExchange_CounterFlowNTU.effectiveness)
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    table=[0,5000; 2000,5000;
        2000.01,10000; 4000,10000; 4000.01,25000; 6000,25000; 6000.01,5000; 10000,
        5000])
    annotation (Placement(transformation(extent={{-200,40},{-180,60}})));
  Modelica.Blocks.Math.Gain gain(k=-3)
    annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=30,
    Ti=2,
    yMax=-5,
    yMin=-5000)
    annotation (Placement(transformation(extent={{-180,-60},{-160,-40}})));
  Modelica.Blocks.Math.Gain gain1(k=-0.001)
    annotation (Placement(transformation(extent={{-140,-60},{-120,-40}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-110,-40},{-90,-60}})));
  Modelica.Blocks.Continuous.PI PI(
    k=3000,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  ThermofluidStream.Utilities.showRealValue showRealValue2
    annotation (Placement(transformation(extent={{-120,-40},{-140,-20}})));
  ThermofluidStream.Utilities.Icons.DLRLogo dLRLogo annotation (Placement(transformation(extent={{120,-100},{160,-60}})));
equation
  connect(multiSensor_Tpm1.inlet, heatExchange_CounterFlowNTU.outletB)
    annotation (Line(
      points={{50,20},{59,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.outlet, flexVolume.inlet) annotation (Line(
      points={{30,20},{20,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flexVolume.outlet, multiSensor_Tpm2.inlet) annotation (Line(
      points={{0,20},{-10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm2.outlet, pump.inlet) annotation (Line(
      points={{-30,20},{-40,20}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.outlet, multiSensor_Tpm3.inlet) annotation (Line(
      points={{-60,20},{-70,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, thermalConvectionPipe.inlet) annotation (
      Line(
      points={{-90,20},{-100,20},{-100,40}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConvectionPipe.outlet, multiSensor_Tpm4.inlet) annotation (
      Line(
      points={{-100,60},{-100,80},{-40,80}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.inlet, multiSensor_Tpm4.outlet) annotation (Line(
      points={{60,80},{-20,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, multiSensor_Tpm5.inlet) annotation (Line(
      points={{8,-10},{20,-10},{20,8},{32,8}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm5.outlet, heatExchange_CounterFlowNTU.inletA)
    annotation (Line(
      points={{52,8},{58.8,8}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, fan.outlet) annotation (Line(
      points={{146,8},{140,8}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConvectionPipe.heatPort, heatCapacitor.port)
    annotation (Line(points={{-110,50},{-130,50}},color={191,0,0}));
  connect(heatCapacitor.port, prescribedHeatFlow.port)
    annotation (Line(points={{-130,50},{-150,50}}, color={191,0,0}));
  connect(heatExchange_CounterFlowNTU.inletB, multiSensor_Tpm6.outlet)
    annotation (Line(
      points={{81.2,20},{90,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm6.inlet, flowResistance.outlet) annotation (Line(
      points={{110,20},{120,20},{120,80},{80,80}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchange_CounterFlowNTU.outletA, multiSensor_Tpm7.inlet)
    annotation (Line(
      points={{81,8},{90,8}},
      color={28,108,200},
      thickness=0.5));
  connect(fan.inlet, multiSensor_Tpm7.outlet) annotation (Line(
      points={{120,8},{110,8}},
      color={28,108,200},
      thickness=0.5));
  connect(fan.flange, speed1.flange)
    annotation (Line(points={{130,-2},{130,-40},{80,-40},{80,-80},{60,-80}},
                                                             color={0,0,0}));
  connect(pump.flange, speed.flange)
    annotation (Line(points={{-50,10},{-50,-8}},             color={0,0,0}));
  connect(speed1.w_ref, gain.y) annotation (Line(points={{38,-80},{21,-80}},
                     color={0,0,127}));
  connect(PID.y, showRealValue.numberPort) annotation (Line(points={{-159,-50},{-150,-50},{-150,-16},{-141.5,-16}},
                                               color={0,0,127}));
  connect(PID.u_s, pump_speed.y)
    annotation (Line(points={{-182,-50},{-190,-50},{-190,-20},{-181,-20}},
                                                     color={0,0,127}));
  connect(actual_heatPortTemp.y, PID.u_m) annotation (Line(points={{-179,-80},{-170,-80},{-170,-62}},
                                 color={0,0,127}));
  connect(PID.y, gain1.u)
    annotation (Line(points={{-159,-50},{-142,-50}}, color={0,0,127}));
  connect(gain1.y, feedback.u1)
    annotation (Line(points={{-119,-50},{-108,-50}}, color={0,0,127}));
  connect(multiSensor_Tpm3.m_flow_out, feedback.u2) annotation (Line(points={{-90,16},{-100,16},{-100,-42}},
                                  color={0,0,127}));
  connect(PI.y, speed.w_ref)
    annotation (Line(points={{-59,-50},{-50,-50},{-50,-30}},
                                                   color={0,0,127}));
  connect(feedback.y, PI.u)
    annotation (Line(points={{-91,-50},{-82,-50}},   color={0,0,127}));
  connect(PID.y, gain.u) annotation (Line(points={{-159,-50},{-150,-50},{-150,-80},{-2,-80}},
                          color={0,0,127}));
  connect(showRealValue2.numberPort, feedback.u1) annotation (Line(points={{-118.5,-30},{-112,-30},{-112,-50},{-108,-50}},
                                                         color={0,0,127}));
  connect(prescribedHeatFlow.Q_flow, combiTimeTable.y[1])
    annotation (Line(points={{-154,20},{-167,20}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=10000,
      Tolerance=1e-6,
      Interval=10,
      __Dymola_Algorithm="Dassl"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    Diagram(
      coordinateSystem(preserveAspectRatio=false, extent={{-200,-120},{180,100}})),
    Documentation(info="<html>
<p>This cooling cycle is regulated to hit a temperature target. The load is a prescribed heatflow and comes from a table.</p>
<p><br>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end SimpleCoolingCycle;
