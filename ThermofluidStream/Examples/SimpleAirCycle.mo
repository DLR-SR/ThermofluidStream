within ThermofluidStream.Examples;
model SimpleAirCycle "Basic bootstrap cooling cycle"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium (ram and bleed air)"
    annotation(choicesAllMatching = true);

  parameter SI.Radius r=0.07   "Ram air duct radius";
  inner DropOfCommons dropOfCommons(assertionLevel = AssertionLevel.warning,
    displayInstanceNames=true,
    displayParameters=true)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));

  ThermofluidStream.Utilities.Icons.DLRLogo dLRLogo annotation (Placement(transformation(extent={{-18,102},{18,138}})));
  Boundaries.Source bleedInlet(
    redeclare package Medium = Medium,
    T0_par=473.15,
    p0_par=220000,
    Xi0_par={0}) annotation (Placement(transformation(extent={{-4,-130},{-24,-110}})));
  Boundaries.Sink packDischarge(redeclare package Medium = Medium, p0_par=80000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-54,116})));
  Boundaries.Source ramInlet(
    redeclare package Medium = Medium,
    T0_par=243.15,
    p0_par=25000,
    Xi0_par={0}) annotation (Placement(transformation(extent={{-160,40},{-140,60}})));
  Boundaries.DynamicPressureInflow dynamicPressure(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    assumeConstantDensity=false,
    velocityFromInput=false,
    v_in_par=230,
    A_par=r^2*Modelica.Constants.pi,
    displayOutletArea=false) annotation (Placement(transformation(extent={{-120,40},{-100,60}})));
  Boundaries.Sink ramOutlet(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    p0_par=30000) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-130,-120})));
  Processes.Compressor compressor(
    redeclare package Medium = Medium,
    omega_from_input=false,
    initPhi=false,
    redeclare function dp_tau_compressor =
        Processes.Internal.TurboComponent.dp_tau_const_isentrop (
        omega_ref=2500,
        skew=1,
        m_flow_ref=1,
        eta=0.9))
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-54,0})));
  Processes.Turbine turbine(
    redeclare package Medium = Medium,
    L=5e2,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    omega_from_input=false,
    initOmega=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    omega_0=0,
    initPhi=true,
    phi_0=0,
    redeclare function dp_tau_turbine = Processes.Internal.TurboComponent.dp_tau_const_isentrop (
        omega_ref=Modelica.Constants.inf,
        m_flow_ref=0.36,
        skew=-0.2,
        k=2,
        eta=0.93))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-54,60})));
  HeatExchangers.CounterFlowNTU                   mainHex(
    redeclare package MediumA = Medium,
    redeclare package MediumB = Medium,
    A=2,
    k_NTU=200,
    L=1,
    displaykNTU=false) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-60,30})));
  HeatExchangers.CounterFlowNTU                   primaryHex(
    redeclare package MediumA = Medium,
    redeclare package MediumB = Medium,
    A=3,
    k_NTU=200,
    L=1,
    displaykNTU=false) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-60,-30})));
  Processes.Fan fan(redeclare package Medium = Medium,     redeclare function dp_tau_fan =
        Processes.Internal.TurboComponent.dp_tau_const_isentrop (
        omega_ref=500,
        skew=1,
        m_flow_ref=0.21,
        eta=0.7))
                annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-66,-90})));
  Processes.FlowResistance pipe(
    redeclare package Medium = Medium,
    r=r,
    l=20,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (material=
            ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-66,-60})));
  Processes.FlowResistance outflowLoss(
    redeclare package Medium = Medium,
    r=r,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.zetaPressureLoss (zeta=1),
    computeL=false,
    L_value=0) annotation (Placement(transformation(extent={{-80,-110},{-100,-130}})));
  Boundaries.Source bleedInlet1(
    redeclare package Medium = Medium,
    T0_par=473.15,
    p0_par=220000,
    Xi0_par={0}) annotation (Placement(transformation(extent={{4,-130},{24,-110}})));
  Boundaries.Sink packDischarge1(redeclare package Medium = Medium, p0_par=
        80000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={52,118})));
  Boundaries.Source ramInlet1(
    redeclare package Medium = Medium,
    T0_par=243.15,
    p0_par=25000,
    Xi0_par={0}) annotation (Placement(transformation(extent={{160,40},{140,60}})));
  Boundaries.DynamicPressureInflow dynamicPressure1(
    displayInstanceName=false,
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    assumeConstantDensity=false,
    velocityFromInput=false,
    v_in_par=230,
    A_par=r^2*Modelica.Constants.pi,
    displayOutletArea=false) annotation (Placement(transformation(extent={{120,40},{100,60}})));
  Boundaries.Sink ramOutlet1(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    p0_par=30000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={120,-120})));
  Processes.Turbine turbine1(
    redeclare package Medium = Medium,
    L=5e2,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    omega_from_input=false,
    initOmega=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    omega_0=0,
    initPhi=true,
    phi_0=0,
    redeclare function dp_tau_turbine = Processes.Internal.TurboComponent.dp_tau_const_isentrop (
        omega_ref=Modelica.Constants.inf,
        m_flow_ref=0.3658,
        skew=-0.2,
        k=2,
        eta=0.93))
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={52,60})));
  HeatExchangers.CounterFlowNTU                   hex(
    redeclare package MediumA = Medium,
    redeclare package MediumB = Medium,
    A=5,
    k_NTU=200,
    L=1,
    displaykNTU=false)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={58,0})));
  Processes.Fan fan1(redeclare package Medium = Medium,     redeclare function dp_tau_fan =
        Processes.Internal.TurboComponent.dp_tau_const_isentrop (
        omega_ref=1000,
        skew=1,
        eta=0.7))
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={64,-90})));
  Processes.FlowResistance pipe1(
    redeclare package Medium = Medium,
    r=r,
    l=20,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (material=
            ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={64,-60})));
  Processes.FlowResistance outflowLoss1(
    redeclare package Medium = Medium,
    r=r,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.zetaPressureLoss (zeta=1),
    computeL=false,
    L_value=0) annotation (Placement(transformation(extent={{80,-110},{100,-130}})));
equation
  connect(ramInlet.outlet, dynamicPressure.inlet)
    annotation (Line(
      points={{-140,50},{-120,50}},
      color={28,108,200},
      thickness=0.5));
  connect(pipe.outlet, fan.inlet)
    annotation (Line(
      points={{-66,-70},{-66,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(fan.outlet, outflowLoss.inlet)
    annotation (Line(
      points={{-66,-100},{-66,-120},{-80,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(bleedInlet.outlet, primaryHex.inletA)
    annotation (Line(
      points={{-24,-120},{-54,-120},{-54,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(primaryHex.outletA, compressor.inlet)
    annotation (Line(
      points={{-54,-20},{-54,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.outlet, mainHex.inletA)
    annotation (Line(
      points={{-54,10},{-54,20}},
      color={28,108,200},
      thickness=0.5));
  connect(mainHex.outletA, turbine.inlet)
    annotation (Line(
      points={{-54,40},{-54,44},{-54,44},{-54,50}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressure.outlet, mainHex.inletB)
    annotation (Line(
      points={{-100,50},{-66,50},{-66,40}},
      color={28,108,200},
      thickness=0.5));
  connect(mainHex.outletB, primaryHex.inletB)
    annotation (Line(
      points={{-66,20},{-66,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(primaryHex.outletB, pipe.inlet)
    annotation (Line(
      points={{-66,-40},{-66,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(fan.flange, compressor.flange)
    annotation (Line(points={{-56,-90},{-38,-90},{-38,0},{-44,0},{-44,-6.10623e-16}}, color={0,0,0}));
  connect(turbine.flange, compressor.flange)
    annotation (Line(points={{-44,60},{-38,60},{-38,-6.10623e-16},{-44,-6.10623e-16}}, color={0,0,0}));
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
  connect(turbine1.outlet, packDischarge1.inlet)
    annotation (Line(
      points={{52,70},{52,108}},
      color={28,108,200},
      thickness=0.5));
  connect(ramInlet1.outlet, dynamicPressure1.inlet)
    annotation (Line(
      points={{140,50},{120,50}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressure1.outlet, hex.inletA)
    annotation (Line(
      points={{100,50},{64,50},{64,10}},
      color={28,108,200},
      thickness=0.5));
  connect(hex.outletA, pipe1.inlet)
    annotation (Line(
      points={{64,-10},{64,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(pipe1.outlet, fan1.inlet)
    annotation (Line(
      points={{64,-70},{64,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(fan1.outlet, outflowLoss1.inlet)
    annotation (Line(
      points={{64,-100},{64,-120},{80,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(outflowLoss1.outlet, ramOutlet1.inlet)
    annotation (Line(
      points={{100,-120},{110,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine1.flange, fan1.flange) annotation (Line(points={{42,60},{34,60},{34,-90},{54,-90}}, color={0,0,0}));
  connect(ramOutlet.inlet, outflowLoss.outlet)
    annotation (Line(
      points={{-120,-120},{-100,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(packDischarge.inlet, turbine.outlet) annotation (Line(
      points={{-54,106},{-54,70}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    experiment(
      StopTime=100,
      Tolerance=1e-6,
      Interval=0.1),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    Diagram(
      coordinateSystem(preserveAspectRatio=false, extent={{-160,-140},{160,140}}),
      graphics={
        Text(
          extent={{-90,90},{-30,80}},
          textColor={28,108,200},
          textString="three wheel bootstrap"),
        Rectangle(extent={{30,80},{90,-106}}, lineColor={28,108,200},
          fillColor={239,248,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{30,90},{90,80}},
          textColor={28,108,200},
          textString="simple cycle"),
        Rectangle(extent={{-90,80},{-30,-106}},
                                              lineColor={28,108,200},
          fillColor={239,248,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
Very simple implementation of a bootstrap air cycle used in an aircraft&apos;s
environmental control system (ecs).
</p>
<p>
<br>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a>
</p>
</html>"));
end SimpleAirCycle;
