within ThermofluidStream.Examples;
model SimpleAirCycle "Basic bootstrap cooling cycle"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium (ram and bleed air)" annotation (
      choicesAllMatching=true);
  parameter SI.Radius r=0.07 "Ram air duct radius";

  inner ThermofluidStream.DropOfCommons dropOfCommons(
    assertionLevel=AssertionLevel.warning,
    displayInstanceNames=true,
    displayParameters=true) annotation (Placement(transformation(extent={{-10,60},{10,80}})));

  ThermofluidStream.Utilities.Icons.DLRLogo dLRLogo annotation (Placement(transformation(extent={{-18,114},
            {18,150}})));
  ThermofluidStream.Boundaries.Source bleedInlet(
    redeclare package Medium = Medium,
    T0_par=473.15,
    p0_par=220000,
    Xi0_par={0}) annotation (Placement(transformation(extent={{-4,-168},{-24,-148}})));
  ThermofluidStream.Boundaries.Sink bleedOutlet(redeclare package Medium = Medium, p0_par=80000) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-130,112})));
  ThermofluidStream.Boundaries.Source ramInlet(
    redeclare package Medium = Medium,
    T0_par=238.65,
    p0_par=37600,
    Xi0_par={0}) annotation (Placement(transformation(extent={{-160,50},{-140,70}})));
  ThermofluidStream.Boundaries.DynamicPressureInflow dynamicPressure(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    assumeConstantDensity=false,
    velocityFromInput=false,
    v_in_par=155,
    A_par=r^2*Modelica.Constants.pi,
    displayOutletArea=false) annotation (Placement(transformation(extent={{-120,50},
            {-100,70}})));
  ThermofluidStream.Boundaries.Sink ramOutlet(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    p0_par=37600) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-150,-158})));
  ThermofluidStream.Processes.Compressor compressor(
    redeclare package Medium = Medium,
    omega_from_input=false,
    initPhi=false,
    redeclare function dp_tau_compressor = ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_const_isentrop (
        omega_ref=2500,
        skew=1,
        m_flow_ref=1,
        eta=0.9))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-54,0})));
  ThermofluidStream.Processes.Turbine turbine(
    redeclare package Medium = Medium,
    L=5e2,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    omega_from_input=false,
    initOmega=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    omega_0=0,
    initPhi=true,
    phi_0=0,
    redeclare function dp_tau_turbine = ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_const_isentrop (
        omega_ref=Modelica.Constants.inf,
        m_flow_ref=0.36,
        skew=-0.2,
        k=2,
        eta=0.93))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-54,80})));
  ThermofluidStream.HeatExchangers.CounterFlowNTU mainHex(
    redeclare package MediumA = Medium,
    redeclare package MediumB = Medium,
    A=3,
    k_NTU=200,
    L=1,
    TC=10,
    displaykNTU=false) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-60,36})));
  ThermofluidStream.HeatExchangers.CounterFlowNTU primaryHex(
    redeclare package MediumA = Medium,
    redeclare package MediumB = Medium,
    A=2,
    k_NTU=200,
    L=1,
    TC=10,
    displaykNTU=false) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-60,-42})));
  ThermofluidStream.Processes.Fan fan(redeclare package Medium = Medium, redeclare function dp_tau_fan =
        ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_const_isentrop (
        omega_ref=500,
        skew=1,
        m_flow_ref=0.21,
        eta=0.7)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-66,-122})));
  ThermofluidStream.Processes.FlowResistance pipe(
    redeclare package Medium = Medium,
    r=r,
    l=5,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLossHaaland
      "Laminar-turbulent (Haaland1983)",
    pressureDropUnit=ThermofluidStream.Types.PressureUnit.kPa,
    pressureDropSignificantDigits=2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-66,-90})));
  ThermofluidStream.Processes.FlowResistance outflowLoss(
    redeclare package Medium = Medium,
    r=r,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (zeta=1),
    computeL=false,
    L_value=0) annotation (Placement(transformation(extent={{-110,-148},{-130,-168}})));
  ThermofluidStream.Boundaries.Source bleedInlet1(
    redeclare package Medium = Medium,
    T0_par=473.15,
    p0_par=220000,
    Xi0_par={0}) annotation (Placement(transformation(extent={{4,-168},{24,-148}})));
  ThermofluidStream.Boundaries.Sink bleedOutlet1(redeclare package Medium = Medium, p0_par=80000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={130,112})));
  ThermofluidStream.Boundaries.Source ramInlet1(
    redeclare package Medium = Medium,
    T0_par=238.65,
    p0_par=37600,
    Xi0_par={0}) annotation (Placement(transformation(extent={{160,50},{140,70}})));
  ThermofluidStream.Boundaries.DynamicPressureInflow dynamicPressure1(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    assumeConstantDensity=false,
    velocityFromInput=false,
    v_in_par=155,
    A_par=r^2*Modelica.Constants.pi,
    displayOutletArea=false) annotation (Placement(transformation(extent={{126,50},
            {106,70}})));
  ThermofluidStream.Boundaries.Sink ramOutlet1(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    p0_par=37600) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={150,-158})));
  ThermofluidStream.Processes.Turbine turbine1(
    redeclare package Medium = Medium,
    L=5e2,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    omega_from_input=false,
    initOmega=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    omega_0=0,
    initPhi=true,
    phi_0=0,
    redeclare function dp_tau_turbine = ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_const_isentrop (
        omega_ref=Modelica.Constants.inf,
        m_flow_ref=0.3658,
        skew=-0.2,
        k=2,
        eta=0.93))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={52,80})));
  ThermofluidStream.HeatExchangers.CounterFlowNTU hex(
    redeclare package MediumA = Medium,
    redeclare package MediumB = Medium,
    A=5,
    k_NTU=200,
    L=1,
    TC=10,
    displaykNTU=false)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={58,-4})));
  ThermofluidStream.Processes.Fan fan1(redeclare package Medium = Medium, redeclare function dp_tau_fan =
        ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_const_isentrop (
        omega_ref=1000,
        skew=1,
        eta=0.7)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={64,-100})));
  ThermofluidStream.Processes.FlowResistance pipe1(
    redeclare package Medium = Medium,
    r=r,
    l=5,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLossHaaland
      "Laminar-turbulent (Haaland1983)",
    pressureDropUnit=ThermofluidStream.Types.PressureUnit.kPa,
    pressureDropSignificantDigits=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={64,-58})));
  ThermofluidStream.Processes.FlowResistance outflowLoss1(
    redeclare package Medium = Medium,
    r=r,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (zeta=1),
    computeL=false,
    L_value=0) annotation (Placement(transformation(extent={{112,-148},{132,-168}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm packDischargeSensor(
    redeclare package Medium = Medium,
    digits=2,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-80,112},{
            -100,132}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm packDischargeSensor1(
    redeclare package Medium = Medium,
    digits=2,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{82,112},{102,
            132}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm ramOutSensor(
    redeclare package Medium = Medium,
    digits=2,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-80,-158},
            {-100,-138}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm ramOutSensor1(
    redeclare package Medium = Medium,
    digits=2,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{80,-158},{
            100,-138}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm ramInletSensor(
    redeclare package Medium = Medium,
    digits=2,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-90,60},{-70,
            80}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm ramInletSensor1(
    redeclare package Medium = Medium,
    digits=2,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{92,60},{72,
            80}})));
  ThermofluidStream.Utilities.showRealValue CoolingPower_kW(
    description="Cooling Power [kW]",
    use_numberPort=false,
    number=turbine.m_flow*1.005*(bleedInlet.outlet.state.T - bleedOutlet.inlet.state.T),
    significantDigits=3) annotation (Placement(transformation(extent={{-178,0},{
            -118,20}})));
  ThermofluidStream.Utilities.showRealValue CoolingPower_kW1(
    description="Cooling Power [kW]",
    use_numberPort=false,
    number=turbine1.m_flow*1.005*(bleedInlet1.outlet.state.T - bleedOutlet1.inlet.state.T),
    significantDigits=3) annotation (Placement(transformation(extent={{120,0},{180,
            20}})));
  Sensors.SingleSensorSelect sensorMainHXRam(
    redeclare package Medium = Medium,
    digits=3,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)
    annotation (Placement(transformation(extent={{-72,-6},{-92,14}})));
  Sensors.SingleSensorSelect sensorHXRam1(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)
    annotation (Placement(transformation(extent={{74,-38},{94,-18}})));
  Sensors.SingleSensorSelect sensorPrimaryHXRam(
    redeclare package Medium = Medium,
    digits=3,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)
    annotation (Placement(transformation(extent={{-72,-76},{-92,-56}})));
  Sensors.SingleSensorSelect sensorMainHX(
    redeclare package Medium = Medium,
    digits=3,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)
    annotation (Placement(transformation(extent={{-46,48},{-26,68}})));
  Sensors.SingleSensorSelect sensorPrimaryHX(
    redeclare package Medium = Medium,
    digits=3,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)
    annotation (Placement(transformation(extent={{-48,-32},{-28,-12}})));
  Sensors.SingleSensorSelect sensorMainHX1(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)
    annotation (Placement(transformation(extent={{46,20},{26,40}})));
  Sensors.SingleSensorSelect sensorCompressor(
    redeclare package Medium = Medium,
    digits=3,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)
    annotation (Placement(transformation(extent={{-48,10},{-28,30}})));
  ThermofluidStream.Utilities.showRealValue fanPr(
    description="Fan Pressure Ratio",
    use_numberPort=false,
    number=fan.p_out/fan.p_in,
    significantDigits=3) annotation (Placement(transformation(extent={{-178,-60},
            {-118,-40}})));
  ThermofluidStream.Utilities.showRealValue fan1Pr(
    description="Fan1 Pressure Ratio",
    use_numberPort=false,
    number=fan1.p_out/fan1.p_in,
    significantDigits=3) annotation (Placement(transformation(extent={{120,-40},
            {180,-20}})));
  ThermofluidStream.Utilities.showRealValue cmpPr(
    description="Compressor Pressure Ratio",
    use_numberPort=false,
    number=compressor.p_out/compressor.p_in,
    significantDigits=3) annotation (Placement(transformation(extent={{-178,-18},
            {-118,2}})));
  ThermofluidStream.Utilities.showRealValue turbinePr(
    description="Turbine Pressure Ratio",
    use_numberPort=false,
    number=turbine.p_in/turbine.p_out,
    significantDigits=3) annotation (Placement(transformation(extent={{-178,-38},
            {-118,-18}})));
  ThermofluidStream.Utilities.showRealValue turbine1Pr(
    description="Turbine1 Pressure Ratio",
    use_numberPort=false,
    number=turbine1.p_in/turbine1.p_out,
    significantDigits=3) annotation (Placement(transformation(extent={{120,-20},
            {180,0}})));
  ThermofluidStream.Utilities.showRealValue hexEffectiveness(
    description="HX Effectiveness",
    use_numberPort=false,
    number=hex.effectiveness,
    significantDigits=3) annotation (Placement(transformation(extent={{120,-60},
            {180,-40}})));
  ThermofluidStream.Utilities.showRealValue mainHexEffectiveness(
    description="Main HX Effectiveness",
    use_numberPort=false,
    number=mainHex.effectiveness,
    significantDigits=3) annotation (Placement(transformation(extent={{-178,-78},
            {-118,-58}})));
  ThermofluidStream.Utilities.showRealValue primaryHexEffectiveness(
    description="Primary HX Effectiveness",
    use_numberPort=false,
    number=primaryHex.effectiveness,
    significantDigits=3) annotation (Placement(transformation(extent={{-178,-98},
            {-118,-78}})));
equation
  connect(ramInlet.outlet, dynamicPressure.inlet)
    annotation (Line(
      points={{-140,60},{-120,60}},
      color={28,108,200},
      thickness=0.5));
  connect(pipe.outlet, fan.inlet)
    annotation (Line(
      points={{-66,-100},{-66,-112}},
      color={28,108,200},
      thickness=0.5));
  connect(bleedInlet.outlet, primaryHex.inletA)
    annotation (Line(
      points={{-24,-158},{-54,-158},{-54,-52}},
      color={28,108,200},
      thickness=0.5));
  connect(primaryHex.outletA, compressor.inlet)
    annotation (Line(
      points={{-54,-32},{-54,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.outlet, mainHex.inletA)
    annotation (Line(
      points={{-54,10},{-54,26}},
      color={28,108,200},
      thickness=0.5));
  connect(mainHex.outletA, turbine.inlet)
    annotation (Line(
      points={{-54,46},{-54,70}},
      color={28,108,200},
      thickness=0.5));
  connect(mainHex.outletB, primaryHex.inletB)
    annotation (Line(
      points={{-66,26},{-66,-32}},
      color={28,108,200},
      thickness=0.5));
  connect(primaryHex.outletB, pipe.inlet)
    annotation (Line(
      points={{-66,-52},{-66,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(fan.flange, compressor.flange) annotation (Line(points={{-56,-122},{-26,
          -122},{-26,0},{-44,0}},                                                                       color={0,0,0}));
  connect(turbine.flange, compressor.flange)
    annotation (Line(points={{-44,80},{-26,80},{-26,0},{-44,0}}, color={0,0,0}));
  connect(bleedInlet1.outlet, hex.inletB)
    annotation (Line(
      points={{24,-158},{52,-158},{52,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(hex.outletB, turbine1.inlet)
    annotation (Line(
      points={{52,6},{52,70}},
      color={28,108,200},
      thickness=0.5));
  connect(ramInlet1.outlet, dynamicPressure1.inlet)
    annotation (Line(
      points={{140,60},{126,60}},
      color={28,108,200},
      thickness=0.5));
  connect(hex.outletA, pipe1.inlet)
    annotation (Line(
      points={{64,-14},{64,-48}},
      color={28,108,200},
      thickness=0.5));
  connect(pipe1.outlet, fan1.inlet)
    annotation (Line(
      points={{64,-68},{64,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(outflowLoss1.outlet, ramOutlet1.inlet)
    annotation (Line(
      points={{132,-158},{140,-158}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine1.flange, fan1.flange) annotation (Line(points={{42,80},{22,80},
          {22,-100},{54,-100}},                                                                      color={0,0,0}));
  connect(ramOutlet.inlet, outflowLoss.outlet)
    annotation (Line(
      points={{-140,-158},{-130,-158}},
      color={28,108,200},
      thickness=0.5));
  connect(bleedOutlet.inlet, packDischargeSensor.outlet)
    annotation (Line(
      points={{-120,112},{-100,112}},
      color={28,108,200},
      thickness=0.5));
  connect(packDischargeSensor.inlet, turbine.outlet)
    annotation (Line(
      points={{-80,112},{-54,112},{-54,90}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine1.outlet, packDischargeSensor1.inlet)
    annotation (Line(
      points={{52,90},{52,112},{82,112}},
      color={28,108,200},
      thickness=0.5));
  connect(packDischargeSensor1.outlet, bleedOutlet1.inlet)
    annotation (Line(
      points={{102,112},{120,112}},
      color={28,108,200},
      thickness=0.5));
  connect(fan.outlet, ramOutSensor.inlet)
    annotation (Line(
      points={{-66,-132},{-66,-158},{-80,-158}},
      color={28,108,200},
      thickness=0.5));
  connect(ramOutSensor.outlet, outflowLoss.inlet)
    annotation (Line(
      points={{-100,-158},{-110,-158}},
      color={28,108,200},
      thickness=0.5));
  connect(fan1.outlet, ramOutSensor1.inlet)
    annotation (Line(
      points={{64,-110},{64,-158},{80,-158}},
      color={28,108,200},
      thickness=0.5));
  connect(ramOutSensor1.outlet, outflowLoss1.inlet)
    annotation (Line(
      points={{100,-158},{112,-158}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressure.outlet, ramInletSensor.inlet)
    annotation (Line(
      points={{-100,60},{-90,60}},
      color={28,108,200},
      thickness=0.5));
  connect(ramInletSensor.outlet, mainHex.inletB)
    annotation (Line(
      points={{-70,60},{-66,60},{-66,46}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressure1.outlet, ramInletSensor1.inlet)
    annotation (Line(
      points={{106,60},{92,60}},
      color={28,108,200},
      thickness=0.5));
  connect(ramInletSensor1.outlet, hex.inletA)
    annotation (Line(
      points={{72,60},{64,60},{64,6}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorMainHXRam.inlet, mainHex.outletB)
    annotation (Line(
      points={{-72,4},{-66,4},{-66,26}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorHXRam1.inlet, hex.outletA)
    annotation (Line(
      points={{74,-28},{64,-28},{64,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(primaryHex.outletB, sensorPrimaryHXRam.inlet)
    annotation (Line(
      points={{-66,-52},{-66,-66},{-72,-66}},
      color={28,108,200},
      thickness=0.5));
  connect(primaryHex.outletA, sensorPrimaryHX.inlet)
    annotation (Line(
      points={{-54,-32},{-54,-22},{-48,-22}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorMainHX.inlet, mainHex.outletA)
    annotation (Line(
      points={{-46,58},{-54,58},{-54,46}},
      color={28,108,200},
      thickness=0.5));
  connect(hex.outletB, sensorMainHX1.inlet)
    annotation (Line(
      points={{52,6},{52,30},{46,30}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorCompressor.inlet, compressor.outlet)
    annotation (Line(
      points={{-48,20},{-54,20},{-54,10}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    experiment(
      StopTime=100,
      Tolerance=1e-6,
      Interval=0.1),
    Icon(coordinateSystem),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-180},{200,
            180}}),                                                                      graphics={
        Text(
          extent={{-158,174},{-42,124}},
          textColor={0,0,0},
          textString="Three wheel bootstrap"),
        Rectangle(
          extent={{18,100},{96,-134}},
          lineColor={28,108,200},
          fillColor={239,248,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{64,162},{134,136}},
          textColor={0,0,0},
          textString="Simple cycle"),
        Rectangle(
          extent={{-94,100},{-20,-134}},
          lineColor={28,108,200},
          fillColor={239,248,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{102,24},{196,-96}},
          fillColor={244,244,244},
          fillPattern=FillPattern.Solid,
          lineColor={182,182,182},
          pattern=LinePattern.None),
        Rectangle(
          extent={{-194,24},{-100,-96}},
          fillColor={244,244,244},
          fillPattern=FillPattern.Solid,
          lineColor={182,182,182},
          pattern=LinePattern.None)}),
    Documentation(info="<html>
<p>Simple implementation of a <strong>bootstrap air cycle</strong> used in aircraft environmental control systems (ECS). </p>
<p>In this example, all bypasses, such as temperature control valves, and dehumidification components are not considered. Consequently, the two bleed sinks do not correspond to real ECS pack outlets.</p>
<p>Two configurations are implemented: a <strong>three-wheel bootstrap cycle</strong> on the left and a <strong>simple cycle</strong> on the right. </p>
<p><strong>Boundary Conditions:</strong> </p>
<ul>
<li><strong>Ram Air Inlet</strong> (T = -34.5 &deg;C, p = 0.376 bar): Static ambient conditions at <strong>25000 ft</strong> in <strong>ISA0</strong> atmosphere.</li>
<li><strong>Bleed Air Inlet</strong> (T = 200 &deg;C, p = 2.2 bar): Typical engine bleed air conditions. In conventional ECS packs, bleed air is the source of fresh air for the cabin.</li>
<li><strong>Bleed Air Outlet</strong> (p = 0.8 bar): Typical cabin pressure at cruise.</li>
<li><strong>Dynamic Pressure Inflow</strong> (v = 155 m/s): Aircraft true airspeed at cruise. This component accounts for dynamic effects due to the aircraft&apos;s speed.</li>
</ul>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a> </p>
</html>", revisions=""));
end SimpleAirCycle;
