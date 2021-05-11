within ThermofluidStream.Examples;
model WaterHammer "Pump water by using dynamic pressures"
  extends Modelica.Icons.Example;

  replaceable package Medium =
      ThermofluidStream.myMedia.Water.ConstantPropertyLiquidWater
    constrainedby ThermofluidStream.myMedia.Interfaces.PartialMedium
    annotation(choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(stopOnFailedAssert=false)
    annotation (Placement(transformation(extent={{-170,94},{-150,114}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300)
    annotation (Placement(transformation(extent={{-140,-10},{-120,10}})));
  FlowControl.BasicControlValve              valveLinear(
    redeclare package Medium = Medium,
    flowCoefficient=ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypesBasic.Kvs,
    Kvs=10,
    redeclare function valveCharacteristics =
        FlowControl.Internal.ControlValve.parabolicCharacteristics)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}})));

  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.025,
    l=25,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=1e3))
    annotation (Placement(transformation(extent={{-102,-10},{-82,10}})));
  ThermofluidStream.Boundaries.Sink sink1(redeclare package Medium = Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{26,0},{46,20}})));

  Modelica.Blocks.Sources.Constant const2(k=1.5e5)
    annotation (Placement(transformation(extent={{-170,-10},{-150,10}})));
  Topology.SplitterT2 splitterT2_1(redeclare package Medium =
               Medium)    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  ThermofluidStream.FlowControl.CheckValve checkValve(redeclare package Medium = Medium, initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state)
                                                                                         annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,30})));
  Sensors.MultiSensor_Tpm                   multiSensor_Tpm1(redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,70})));
  Boundaries.Reservoir reservoir(redeclare package Medium =
               Medium,
    A_surf=0.00025,
    p_env_par=100000,
    height_0=0.1)
    annotation (Placement(transformation(extent={{-16,80},{4,100}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=-0.9,
    width=40,
    period=1,
    offset=1,
    startTime=5) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={92,-40})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    T=0.05,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1)
    annotation (Placement(transformation(extent={{60,-50},{40,-30}})));
  ThermofluidStream.Utilities.Icons.DLRLogo dLRLogo annotation (Placement(transformation(extent={{118,-98},{174,-42}})));
equation
  connect(multiSensor_Tpm3.inlet, valveLinear.outlet) annotation (Line(
      points={{26,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, multiSensor_Tpm2.inlet) annotation (Line(
      points={{-82,0},{-70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source.p0_var, const2.y) annotation (Line(points={{-132,0},{-132,0},{-149,0}},
                                                color={0,0,127}));
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{-120,0},{-102,0}},
      color={28,108,200},
      thickness=0.5));
  connect(valveLinear.inlet, splitterT2_1.outletB) annotation (Line(
      points={{-10,0},{-20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT2_1.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{-40,0},{-50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT2_1.outletA, checkValve.inlet) annotation (Line(
      points={{-30,10},{-30,20}},
      color={28,108,200},
      thickness=0.5));
  connect(checkValve.outlet, multiSensor_Tpm1.inlet) annotation (Line(
      points={{-30,40},{-30,60}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, sink1.inlet) annotation (Line(
      points={{46,0},{60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(reservoir.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{-16,90},{-30,90},{-30,80}},
      color={28,108,200},
      thickness=0.5));
  connect(pulse.y, firstOrder.u)
    annotation (Line(points={{81,-40},{62,-40}}, color={0,0,127}));
  connect(firstOrder.y, valveLinear.u_in)
    annotation (Line(points={{39,-40},{0,-40},{0,-8}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-180,-100},{180,120}})),
    experiment(
      StopTime=25,
      Interval=0.01,
      __Dymola_Algorithm="Dassl"),
    Icon(coordinateSystem),
    Documentation(info="<html>
<p>This water hammer pumps water up by using the dynamic pressure when closing a valve. </p>
<p><br>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end WaterHammer;
