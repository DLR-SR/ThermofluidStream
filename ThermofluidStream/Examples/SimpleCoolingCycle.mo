within ThermofluidStream.Examples;
model SimpleCoolingCycle "Basic cooling cycle with a load"
extends Modelica.Icons.Example;

  replaceable package medium_liquid =
      ThermofluidStream.Media.myMedia.Water.ConstantPropertyLiquidWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium      annotation(choicesAllMatching = true);

  replaceable package medium_air = ThermofluidStream.Media.myMedia.Air.DryAirNasa
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium      annotation(choicesAllMatching = true);

  ThermofluidStream.HeatExchangers.CounterFlowNTU heatExchange_CounterFlowNTU(
    redeclare package MediumA = medium_air,
    redeclare package MediumB = medium_liquid,
    A=10) annotation (Placement(transformation(extent={{84,-30},{104,-10}})));
  Boundaries.VolumeFlex                   flexVolume(
    redeclare package Medium =
        medium_liquid,
    V_ref=0.02,
    p_start=100000,
    T_start=278.15)
    annotation (Placement(transformation(extent={{24,-24},{4,-4}})));
  ThermofluidStream.Processes.Pump          pump(
    redeclare package Medium =
        medium_liquid,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
                       redeclare function dp_tau_pump =
        ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal)
           annotation (Placement(transformation(extent={{-34,-24},{-54,-4}})));
  ThermofluidStream.Processes.ThermalConvectionPipe
                                                thermalConvectionPipe(
      redeclare package Medium =
        medium_liquid,
    r=0.005,
    l=1)     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-92,20})));
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium = medium_liquid,
    r=0.05,
    l=1,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
         k=1e5))
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package Medium =
               medium_liquid, temperatureUnit="degC")
    annotation (Placement(transformation(extent={{50,-14},{30,6}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package Medium =
               medium_liquid, temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-6,-14},{-26,6}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package Medium =
               medium_liquid,
    digits=2,
    outputMassFlowRate=true,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-60,-14},{-80,-34}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm4(redeclare package Medium =
               medium_liquid, temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-30,70})));
  ThermofluidStream.Boundaries.Source source(redeclare package Medium =
        medium_air,
    T0_par=283.15,
    p0_par=101300)
               annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={8,-46})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm5(redeclare package Medium =
               medium_air, temperatureUnit="degC")
                                              annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={48,-36})));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium =
        medium_air, p0_par=101300)                    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={180,-26})));
  Modelica.Mechanics.Rotational.Sources.Speed speed
    annotation (Placement(transformation(extent={{-68,-70},{-48,-50}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed1
    annotation (Placement(transformation(extent={{98,-70},{118,-50}})));

  ThermofluidStream.Processes.Fan fan(redeclare package Medium = medium_air,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,redeclare function dp_tau_fan =
        Processes.Internal.TurboComponent.dp_tau_const_isentrop (omega_ref=100))
    annotation (Placement(transformation(extent={{140,-36},{160,-16}})));
  Modelica.Blocks.Sources.RealExpression pump_speed(y=80 + 273.15)
    annotation (Placement(transformation(extent={{-258,-70},{-238,-50}})));
  Modelica.Blocks.Sources.RealExpression fan_speed(y=400)
    annotation (Placement(transformation(extent={{-22,-78},{-2,-58}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=500, T(start=373.15, fixed=true))
    annotation (Placement(transformation(extent={{-124,20},{-104,40}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-154,10},{-134,30}})));
  Modelica.Blocks.Sources.RealExpression heat_load(y=10000)
    annotation (Placement(transformation(extent={{-190,70},{-170,90}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{150,76},{170,96}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm6(redeclare package Medium =
               medium_liquid, temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={124,-4})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm7(redeclare package Medium =
               medium_air, temperatureUnit="degC")
                                              annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={124,-36})));
  Modelica.Blocks.Sources.RealExpression actual_heatPortTemp(y=
        thermalConvectionPipe.heatPort.T)
    annotation (Placement(transformation(extent={{-258,-42},{-238,-22}})));
  Modelica.Blocks.Interaction.Show.RealValue realValue(use_numberPort=false,
      number=thermalConvectionPipe.heatPort.T - 273.15)
    annotation (Placement(transformation(extent={{-232,-6},{-252,-26}})));
  ThermofluidStream.Utilities.showRealValue showRealValue
    annotation (Placement(transformation(extent={{-192,-48},{-172,-28}})));
  ThermofluidStream.Utilities.showRealValue showRealValue1(
    use_numberPort=false,
    description="eff",
    number=heatExchange_CounterFlowNTU.effectiveness)
    annotation (Placement(transformation(extent={{84,-14},{104,6}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=[0,5000; 2000,5000;
        2000.01,10000; 4000,10000; 4000.01,25000; 6000,25000; 6000.01,5000; 10000,
        5000])
    annotation (Placement(transformation(extent={{-188,10},{-168,30}})));
  Modelica.Blocks.Math.Gain gain(k=-3)
    annotation (Placement(transformation(extent={{40,-90},{60,-70}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=30,
    Ti=2,
    yMax=-5,
    yMin=-5000)
    annotation (Placement(transformation(extent={{-224,-50},{-204,-70}})));
  Modelica.Blocks.Math.Gain gain1(k=-0.001)
    annotation (Placement(transformation(extent={{-184,-70},{-164,-50}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-144,-50},{-124,-70}})));
  Modelica.Blocks.Continuous.PI PI(k=3000,
                                         T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  ThermofluidStream.Utilities.showRealValue showRealValue2
    annotation (Placement(transformation(extent={{-154,-48},{-174,-28}})));
  ThermofluidStream.Utilities.Icons.DLRLogo dLRLogo annotation (Placement(transformation(extent={{120,-122},{176,-66}})));
equation
  connect(multiSensor_Tpm1.inlet, heatExchange_CounterFlowNTU.outletB)
    annotation (Line(
      points={{50,-14},{83,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.outlet, flexVolume.inlet) annotation (Line(
      points={{30,-14},{24,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(flexVolume.outlet, multiSensor_Tpm2.inlet) annotation (Line(
      points={{4,-14},{-6,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm2.outlet, pump.inlet) annotation (Line(
      points={{-26,-14},{-34,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.outlet, multiSensor_Tpm3.inlet) annotation (Line(
      points={{-54,-14},{-60,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, thermalConvectionPipe.inlet) annotation (
      Line(
      points={{-80,-14},{-92,-14},{-92,10}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConvectionPipe.outlet, multiSensor_Tpm4.inlet) annotation (
      Line(
      points={{-92,30},{-92,60},{-40,60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.inlet, multiSensor_Tpm4.outlet) annotation (Line(
      points={{60,60},{-20,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, multiSensor_Tpm5.inlet) annotation (Line(
      points={{18,-46},{20,-46},{20,-26},{38,-26}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm5.outlet, heatExchange_CounterFlowNTU.inletA)
    annotation (Line(
      points={{58,-26},{64,-26},{64,-26},{82.8,-26}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, fan.outlet) annotation (Line(
      points={{170,-26},{160,-26}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConvectionPipe.heatPort, heatCapacitor.port)
    annotation (Line(points={{-102,20},{-114,20}},color={191,0,0}));
  connect(heatCapacitor.port, prescribedHeatFlow.port)
    annotation (Line(points={{-114,20},{-134,20}}, color={191,0,0}));
  connect(heatExchange_CounterFlowNTU.inletB, multiSensor_Tpm6.outlet)
    annotation (Line(
      points={{105.2,-14},{114,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm6.inlet, flowResistance.outlet) annotation (Line(
      points={{134,-14},{150,-14},{150,60},{80,60}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchange_CounterFlowNTU.outletA, multiSensor_Tpm7.inlet)
    annotation (Line(
      points={{105,-26},{114,-26}},
      color={28,108,200},
      thickness=0.5));
  connect(fan.inlet, multiSensor_Tpm7.outlet) annotation (Line(
      points={{140,-26},{134,-26}},
      color={28,108,200},
      thickness=0.5));
  connect(fan.flange, speed1.flange)
    annotation (Line(points={{150,-36},{150,-60},{118,-60}}, color={0,0,0}));
  connect(pump.flange, speed.flange)
    annotation (Line(points={{-44,-24},{-44,-60},{-48,-60}}, color={0,0,0}));
  connect(speed1.w_ref, gain.y) annotation (Line(points={{96,-60},{80,-60},{80,-80},
          {61,-80}}, color={0,0,127}));
  connect(PID.y, showRealValue.numberPort) annotation (Line(points={{-203,-60},
          {-198,-60},{-198,-38},{-193.5,-38}}, color={0,0,127}));
  connect(PID.u_s, pump_speed.y)
    annotation (Line(points={{-226,-60},{-237,-60}}, color={0,0,127}));
  connect(actual_heatPortTemp.y, PID.u_m) annotation (Line(points={{-237,-32},{
          -214,-32},{-214,-48}}, color={0,0,127}));
  connect(PID.y, gain1.u)
    annotation (Line(points={{-203,-60},{-186,-60}}, color={0,0,127}));
  connect(gain1.y, feedback.u1)
    annotation (Line(points={{-163,-60},{-142,-60}}, color={0,0,127}));
  connect(multiSensor_Tpm3.m_flow_out, feedback.u2) annotation (Line(points={{-80,-18},
          {-134,-18},{-134,-52}},          color={0,0,127}));
  connect(PI.y, speed.w_ref)
    annotation (Line(points={{-89,-60},{-70,-60}}, color={0,0,127}));
  connect(feedback.y, PI.u)
    annotation (Line(points={{-125,-60},{-112,-60}}, color={0,0,127}));
  connect(PID.y, gain.u) annotation (Line(points={{-203,-60},{-198,-60},{-198,
          -80},{38,-80}}, color={0,0,127}));
  connect(showRealValue2.numberPort, feedback.u1) annotation (Line(points={{
          -152.5,-38},{-146,-38},{-146,-60},{-142,-60}}, color={0,0,127}));
  connect(prescribedHeatFlow.Q_flow, combiTimeTable.y[1])
    annotation (Line(points={{-154,20},{-167,20}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-120},{180,100}})),
    experiment(StopTime=10000, __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput(equidistant=false),
        Documentation(info="<html>
<p>This cooling cycle is regulated to hit a temperature target. The load is a prescribed heatflow and comes from a table.</p>
<p><br>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end SimpleCoolingCycle;
