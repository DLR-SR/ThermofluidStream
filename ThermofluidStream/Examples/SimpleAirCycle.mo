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

  ThermofluidStream.Utilities.Icons.DLRLogo dLRLogo annotation (Placement(transformation(extent={{-18,102},{18,138}})));
  ThermofluidStream.Boundaries.Source bleedInlet(
    redeclare package Medium = Medium,
    T0_par=473.15,
    p0_par=220000,
    Xi0_par={0}) annotation (Placement(transformation(extent={{-4,-130},{-24,-110}})));
  ThermofluidStream.Boundaries.Sink packDischarge(redeclare package Medium = Medium, p0_par=80000) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-130,100})));
  ThermofluidStream.Boundaries.Source ramInlet(
    redeclare package Medium = Medium,
    T0_par=238.65,
    p0_par=37600,
    Xi0_par={0}) annotation (Placement(transformation(extent={{-160,40},{-140,60}})));
  ThermofluidStream.Boundaries.DynamicPressureInflow dynamicPressure(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    assumeConstantDensity=false,
    velocityFromInput=false,
    v_in_par=155,
    A_par=r^2*Modelica.Constants.pi,
    displayOutletArea=false) annotation (Placement(transformation(extent={{-120,40},{-100,60}})));
  ThermofluidStream.Boundaries.Sink ramOutlet(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    p0_par=37600) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-150,-120})));
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
        origin={-54,6})));
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
        origin={-54,66})));
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
        origin={-60,34})));
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
        origin={-60,-22})));
  ThermofluidStream.Processes.Fan fan(redeclare package Medium = Medium, redeclare function dp_tau_fan =
        ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_const_isentrop (
        omega_ref=500,
        skew=1,
        m_flow_ref=0.21,
        eta=0.7)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-66,-82})));
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
        origin={-66,-54})));
  ThermofluidStream.Processes.FlowResistance outflowLoss(
    redeclare package Medium = Medium,
    r=r,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (zeta=1),
    computeL=false,
    L_value=0) annotation (Placement(transformation(extent={{-110,-110},{-130,-130}})));
  ThermofluidStream.Boundaries.Source bleedInlet1(
    redeclare package Medium = Medium,
    T0_par=473.15,
    p0_par=220000,
    Xi0_par={0}) annotation (Placement(transformation(extent={{4,-130},{24,-110}})));
  ThermofluidStream.Boundaries.Sink packDischarge1(redeclare package Medium = Medium, p0_par=80000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={130,100})));
  ThermofluidStream.Boundaries.Source ramInlet1(
    redeclare package Medium = Medium,
    T0_par=238.65,
    p0_par=37600,
    Xi0_par={0}) annotation (Placement(transformation(extent={{160,40},{140,60}})));
  ThermofluidStream.Boundaries.DynamicPressureInflow dynamicPressure1(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    assumeConstantDensity=false,
    velocityFromInput=false,
    v_in_par=155,
    A_par=r^2*Modelica.Constants.pi,
    displayOutletArea=false) annotation (Placement(transformation(extent={{126,40},{106,60}})));
  ThermofluidStream.Boundaries.Sink ramOutlet1(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    p0_par=37600) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={150,-120})));
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
        origin={52,60})));
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
        origin={58,0})));
  ThermofluidStream.Processes.Fan fan1(redeclare package Medium = Medium, redeclare function dp_tau_fan =
        ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_const_isentrop (
        omega_ref=1000,
        skew=1,
        eta=0.7)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={64,-72})));
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
        origin={64,-42})));
  ThermofluidStream.Processes.FlowResistance outflowLoss1(
    redeclare package Medium = Medium,
    r=r,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss (zeta=1),
    computeL=false,
    L_value=0) annotation (Placement(transformation(extent={{112,-110},{132,-130}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm packDischargeSensor(
    redeclare package Medium = Medium,
    digits=2,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-80,100},{-100,120}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm packDischargeSensor1(
    redeclare package Medium = Medium,
    digits=2,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{82,100},{102,120}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm ramOutSensor(
    redeclare package Medium = Medium,
    digits=2,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-80,-120},{-100,-100}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm ramOutSensor1(
    redeclare package Medium = Medium,
    digits=2,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{80,-120},{100,-100}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm ramInletSensor(
    redeclare package Medium = Medium,
    digits=2,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm ramInletSensor1(
    redeclare package Medium = Medium,
    digits=2,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{92,50},{72,70}})));
  ThermofluidStream.Utilities.showRealValue CoolingPower_kW(
    description="Cooling Power [kW]",
    use_numberPort=false,
    number=-turbine.m_flow*1.005*(packDischarge.inlet.state.T - bleedInlet.outlet.state.T),
    significantDigits=3) annotation (Placement(transformation(extent={{-160,-40},{-100,-20}})));
  ThermofluidStream.Utilities.showRealValue CoolingPower_kW1(
    description="Cooling Power [kW]",
    use_numberPort=false,
    number=-turbine1.m_flow*1.005*(packDischarge1.inlet.state.T - bleedInlet1.outlet.state.T),
    significantDigits=3) annotation (Placement(transformation(extent={{100,-40},{160,-20}})));
  Sensors.SingleSensorSelect sensorMainHXRam(
    redeclare package Medium = Medium,
    digits=3,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)
    annotation (Placement(transformation(extent={{-72,-6},{-92,14}})));
  Sensors.SingleSensorSelect sensorHXRam1(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)
    annotation (Placement(transformation(extent={{74,-26},{94,-6}})));
  Sensors.SingleSensorSelect sensorPrimaryHXRam(
    redeclare package Medium = Medium,
    digits=3,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)
    annotation (Placement(transformation(extent={{-72,-48},{-92,-28}})));
  Sensors.SingleSensorSelect sensorMainHX(
    redeclare package Medium = Medium,
    digits=3,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)
    annotation (Placement(transformation(extent={{-46,40},{-26,60}})));
  Sensors.SingleSensorSelect sensorPrimaryHX(
    redeclare package Medium = Medium,
    digits=3,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)
    annotation (Placement(transformation(extent={{-48,-18},{-28,2}})));
  Sensors.SingleSensorSelect sensorMainHX1(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)
    annotation (Placement(transformation(extent={{46,20},{26,40}})));
equation
  connect(ramInlet.outlet, dynamicPressure.inlet)
    annotation (Line(
      points={{-140,50},{-120,50}},
      color={28,108,200},
      thickness=0.5));
  connect(pipe.outlet, fan.inlet)
    annotation (Line(
      points={{-66,-64},{-66,-72}},
      color={28,108,200},
      thickness=0.5));
  connect(bleedInlet.outlet, primaryHex.inletA)
    annotation (Line(
      points={{-24,-120},{-54,-120},{-54,-32}},
      color={28,108,200},
      thickness=0.5));
  connect(primaryHex.outletA, compressor.inlet)
    annotation (Line(
      points={{-54,-12},{-54,-4}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.outlet, mainHex.inletA)
    annotation (Line(
      points={{-54,16},{-54,24}},
      color={28,108,200},
      thickness=0.5));
  connect(mainHex.outletA, turbine.inlet)
    annotation (Line(
      points={{-54,44},{-54,56}},
      color={28,108,200},
      thickness=0.5));
  connect(mainHex.outletB, primaryHex.inletB)
    annotation (Line(
      points={{-66,24},{-66,-12}},
      color={28,108,200},
      thickness=0.5));
  connect(primaryHex.outletB, pipe.inlet)
    annotation (Line(
      points={{-66,-32},{-66,-44}},
      color={28,108,200},
      thickness=0.5));
  connect(fan.flange, compressor.flange) annotation (Line(points={{-56,-82},{-26,-82},{-26,6},{-44,6}}, color={0,0,0}));
  connect(turbine.flange, compressor.flange)
    annotation (Line(points={{-44,66},{-26,66},{-26,6},{-44,6}}, color={0,0,0}));
  connect(bleedInlet1.outlet, hex.inletB)
    annotation (Line(
      points={{24,-120},{52,-120},{52,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(hex.outletB, turbine1.inlet)
    annotation (Line(
      points={{52,10},{52,50}},
      color={28,108,200},
      thickness=0.5));
  connect(ramInlet1.outlet, dynamicPressure1.inlet)
    annotation (Line(
      points={{140,50},{126,50}},
      color={28,108,200},
      thickness=0.5));
  connect(hex.outletA, pipe1.inlet)
    annotation (Line(
      points={{64,-10},{64,-32}},
      color={28,108,200},
      thickness=0.5));
  connect(pipe1.outlet, fan1.inlet)
    annotation (Line(
      points={{64,-52},{64,-62}},
      color={28,108,200},
      thickness=0.5));
  connect(outflowLoss1.outlet, ramOutlet1.inlet)
    annotation (Line(
      points={{132,-120},{140,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine1.flange, fan1.flange) annotation (Line(points={{42,60},{22,60},{22,-72},{54,-72}}, color={0,0,0}));
  connect(ramOutlet.inlet, outflowLoss.outlet)
    annotation (Line(
      points={{-140,-120},{-130,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(packDischarge.inlet, packDischargeSensor.outlet)
    annotation (Line(
      points={{-120,100},{-100,100}},
      color={28,108,200},
      thickness=0.5));
  connect(packDischargeSensor.inlet, turbine.outlet)
    annotation (Line(
      points={{-80,100},{-54,100},{-54,76}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine1.outlet, packDischargeSensor1.inlet)
    annotation (Line(
      points={{52,70},{52,100},{82,100}},
      color={28,108,200},
      thickness=0.5));
  connect(packDischargeSensor1.outlet, packDischarge1.inlet)
    annotation (Line(
      points={{102,100},{120,100}},
      color={28,108,200},
      thickness=0.5));
  connect(fan.outlet, ramOutSensor.inlet)
    annotation (Line(
      points={{-66,-92},{-66,-120},{-80,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(ramOutSensor.outlet, outflowLoss.inlet)
    annotation (Line(
      points={{-100,-120},{-110,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(fan1.outlet, ramOutSensor1.inlet)
    annotation (Line(
      points={{64,-82},{64,-120},{80,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(ramOutSensor1.outlet, outflowLoss1.inlet)
    annotation (Line(
      points={{100,-120},{112,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressure.outlet, ramInletSensor.inlet)
    annotation (Line(
      points={{-100,50},{-90,50}},
      color={28,108,200},
      thickness=0.5));
  connect(ramInletSensor.outlet, mainHex.inletB)
    annotation (Line(
      points={{-70,50},{-66,50},{-66,44}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressure1.outlet, ramInletSensor1.inlet)
    annotation (Line(
      points={{106,50},{92,50}},
      color={28,108,200},
      thickness=0.5));
  connect(ramInletSensor1.outlet, hex.inletA)
    annotation (Line(
      points={{72,50},{64,50},{64,10}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorMainHXRam.inlet, mainHex.outletB)
    annotation (Line(
      points={{-72,4},{-66,4},{-66,24}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorHXRam1.inlet, hex.outletA)
    annotation (Line(
      points={{74,-16},{64,-16},{64,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(primaryHex.outletB, sensorPrimaryHXRam.inlet)
    annotation (Line(
      points={{-66,-32},{-66,-38},{-72,-38}},
      color={28,108,200},
      thickness=0.5));
  connect(primaryHex.outletA, sensorPrimaryHX.inlet)
    annotation (Line(
      points={{-54,-12},{-54,-8},{-48,-8}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorMainHX.inlet, mainHex.outletA)
    annotation (Line(
      points={{-46,50},{-54,50},{-54,44}},
      color={28,108,200},
      thickness=0.5));
  connect(hex.outletB, sensorMainHX1.inlet)
    annotation (Line(
      points={{52,10},{52,30},{46,30}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    experiment(
      StopTime=100,
      Tolerance=1e-6,
      Interval=0.1),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-140},{160,140}}), graphics={
        Text(
          extent={{-158,0},{-96,-20}},
          textColor={28,108,200},
          textString="three wheel bootstrap"),
        Rectangle(
          extent={{18,80},{98,-96}},
          lineColor={28,108,200},
          fillColor={239,248,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{102,0},{158,-20}},
          textColor={28,108,200},
          textString="simple cycle"),
        Rectangle(
          extent={{-94,80},{-20,-96}},
          lineColor={28,108,200},
          fillColor={239,248,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
Simple implementation of a <strong>bootstrap air cycle</strong> used in aircraft environmental control systems (ECS).
</p>
<p>
Two configurations are implemented: a <strong>three-wheel bootstrap cycle</strong> on the left and a <strong>simple cycle</strong> on the right.
</p>

<p>
<strong>Boundary Conditions:</strong>
</p>
<ul>
<li><strong>Ram Air Inlet</strong> (T = -34.5 °C, p = 0.376 bar): Static ambient conditions at <strong>25,000 ft</strong> in <strong>ISA0</strong> atmosphere.</li>
<li><strong>Bleed Air Inlet</strong> (T = 200 °C, p = 2.2 bar): Typical engine bleed air conditions. In conventional ECS packs, bleed air is the source of fresh air for the cabin.</li>
<li><strong>Pack Discharge</strong> (p = 0.8 bar): Typical cabin pressure in cruise.</li>
<li><strong>Dynamic Pressure Inflow</strong> (v = 155 m/s): Aircraft true airspeed in cruise. This component accounts for dynamic effects due to the aircraft's speed.</li>
</ul>
<p>
Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Meißner</a>
</p>
</html>", revisions=""));
end SimpleAirCycle;
