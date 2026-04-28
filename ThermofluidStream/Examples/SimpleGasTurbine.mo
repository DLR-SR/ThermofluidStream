within ThermofluidStream.Examples;
model SimpleGasTurbine "Simple version of a Gas Turbine"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.DryAirNasa
    constrainedby Media.myMedia.Interfaces.PartialMedium "Medium Model"
    annotation (Documentation(
        info="<html>
<p>Medium used for this Example. Should be a gas.</p>
</html>"));

  Processes.Compressor compressor(
    redeclare package Medium=Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    initOmega=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    omega_0=100,
    redeclare function dp_tau_compressor =
        Processes.Internal.TurboComponent.dp_tau_const_isentrop (
      omega_ref=100,
      eta=0.8))
    annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));
  Processes.Turbine turbine(
    redeclare package Medium=Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function dp_tau_turbine =
        Processes.Internal.TurboComponent.dp_tau_const_isentrop (
      omega_ref=1000,
      m_flow_ref=1.2,
      eta=0.8))
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Boundaries.Volume volume(redeclare package Medium=Medium,
    useHeatport=true,
    p_start=100000,
    T_start(displayUnit="K") = 600,
    V_par(displayUnit="l") = 0.01)
    annotation (Placement(transformation(extent={{-20,0},{0,-20}})));
  Boundaries.Sink sink(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{90,-20},{110,0}})));
  Boundaries.Source source(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-140,-20},{-120,0}})));
  inner DropOfCommons dropOfCommons(assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{-130,50},{-110,70}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(
    J=1,
    phi(fixed=true, start=0))
    annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
  Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque
    linearSpeedDependentTorque(
    tau_nominal=-1,
    TorqueDirection=false,
    w_nominal=100)
    annotation (Placement(transformation(extent={{-130,-70},{-110,-50}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,18})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm1(
    redeclare package Medium = Medium,
    digits=5,
    outputPressure=false,
    outputMassFlowRate=true,
    pressureUnit="bar")
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Sensors.MultiSensor_Tp multiSensor_Tp(
    redeclare package Medium = Medium,
    digits=3,
    pressureUnit="bar") annotation (Placement(transformation(extent={{16,-4},{36,16}})));
  Sensors.MultiSensor_Tp multiSensor_Tp1(
    redeclare package Medium = Medium,
    digits=3,
    pressureUnit="bar") annotation (Placement(transformation(extent={{76,-4},{96,16}})));
  Sensors.MultiSensor_Tp multiSensor_Tp2(
    redeclare package Medium = Medium,
    digits=3,
    pressureUnit="bar") annotation (Placement(transformation(extent={{-104,0},{
            -84,20}})));
  Modelica.Blocks.Continuous.LimPID PI(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2000,
    Ti=20,
    yMax=5e5,
    yMin=0) annotation (Placement(transformation(extent={{114,46},{102,58}})));
  Modelica.Blocks.Sources.RealExpression setpoint(y=1000)
    annotation (Placement(transformation(extent={{138,46},{124,58}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=90,
        origin={-10,40})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
    annotation (Placement(transformation(extent={{58,-70},{78,-50}})));
  Modelica.Blocks.Nonlinear.Limiter q_limits(uMax=5e5, uMin=0)
    annotation (Placement(transformation(extent={{18,46},{6,58}})));
  ThermofluidStream.Utilities.Icons.DLRLogo dLRLogo annotation (Placement(transformation(extent={{102,-78},{138,-42}})));
equation
  connect(sink.inlet, turbine.outlet) annotation (Line(
      points={{90,-10},{60,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.inlet, source.outlet) annotation (Line(
      points={{-90,-10},{-120,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(inertia.flange_b, turbine.flange)
    annotation (Line(points={{0,-60},{50,-60},{50,-20}}, color={0,0,0}));
  connect(inertia.flange_a, compressor.flange)
    annotation (Line(points={{-20,-60},{-80,-60},{-80,-20}}, color={0,0,0}));
  connect(prescribedHeatFlow.port, volume.heatPort)
    annotation (Line(points={{-10,8},{-10,-2}}, color={191,0,0}));
  connect(linearSpeedDependentTorque.flange, compressor.flange)
    annotation (Line(points={{-110,-60},{-80,-60},{-80,-20}},
                                                           color={0,0,0}));
  connect(multiSensor_Tp2.inlet, source.outlet) annotation (Line(
      points={{-104,10},{-110,10},{-110,-10},{-120,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(speedSensor.flange, turbine.flange)
    annotation (Line(points={{58,-60},{50,-60},{50,-20}}, color={0,0,0}));
  connect(prescribedHeatFlow.Q_flow, product1.y)
    annotation (Line(points={{-10,28},{-10,33.4}}, color={0,0,127}));
  connect(speedSensor.w, PI.u_m)
    annotation (Line(points={{79,-60},{94,-60},{94,-36},{108,-36},{108,44.8}},
                                                             color={0,0,127}));
  connect(PI.u_s, setpoint.y)
    annotation (Line(points={{115.2,52},{123.3,52}}, color={0,0,127}));
  connect(compressor.outlet, multiSensor_Tpm1.inlet) annotation (Line(
      points={{-70,-10},{-60,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(volume.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{-20,-10},{-40,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(volume.outlet, turbine.inlet) annotation (Line(
      points={{0,-10},{40,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tp.inlet, turbine.inlet) annotation (Line(
      points={{16,6},{10,6},{10,-10},{40,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.m_flow_out, product1.u1) annotation (Line(points={{-41.8,-6},{-30,-6},{-30,60},{-13.6,60},{-13.6,47.2}},
                                                              color={0,0,127}));
  connect(q_limits.y, product1.u2) annotation (Line(points={{5.4,52},{-6.4,52},
          {-6.4,47.2}}, color={0,0,127}));
  connect(PI.y, q_limits.u)
    annotation (Line(points={{101.4,52},{19.2,52}}, color={0,0,127}));
  connect(multiSensor_Tp1.inlet, turbine.outlet) annotation (Line(
      points={{76,6},{70,6},{70,-10},{60,-10}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    experiment(StopTime=100, Tolerance=1e-6, Interval=0.1),
    Diagram(coordinateSystem(extent={{-140,-80},{140,80}}),
      graphics={
        Rectangle(
          extent={{-64,76},{36,-26}},
          lineColor={28,108,200}),
        Text(
          extent={{-60,76},{16,60}},
          textColor={28,108,200},
          textString="combustion chamber")}),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>A very basic model of a regulated gas turbine. GASTASTIC!</p>
<p>The combustion chamber is approximated with a prescribed heatflow into a volume. The prescribed heatflow is proportional to the massflow, so the steady-state q is the input to the combustion chamber. </p>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end SimpleGasTurbine;
