within ThermofluidStream.HeatExchangers.Tests;
model CounterFlowNTU_zeroMassFlow

  replaceable package mediumA =
      myMedia.Incompressible.Examples.Glycol47
    constrainedby myMedia.Interfaces.PartialMedium            annotation(choicesAllMatching = true);

  replaceable package mediumB = myMedia.Air.DryAirNasa
    constrainedby myMedia.Interfaces.PartialMedium            annotation(choicesAllMatching = true);

  extends Modelica.Icons.Example;

  ThermofluidStream.Boundaries.Source sourceA(redeclare package Medium =
        mediumA, T0_par=333.15)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-126,-20})));

  ThermofluidStream.Boundaries.Sink sinkA(
    redeclare package Medium = mediumA,
    pressureFromInput=true,
    p0_par=100000) annotation (Placement(transformation(extent={{116,-30},{136,-10}})));

  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm(redeclare package Medium =
               mediumA,
    temperatureUnit="degC",
    pressureUnit="bar")                                         annotation (
      Placement(transformation(
        extent={{-11,10},{11,-10}},
        rotation=0,
        origin={-75,-30})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package Medium =
               mediumA,
    digits=3,
    temperatureUnit="degC")   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={60,-30})));

  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = mediumB,
    temperatureFromInput=false,
    T0_par=293.15,
    p0_par=100000)
               annotation (Placement(transformation(extent={{136,10},{116,30}})));
  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = mediumB,
    pressureFromInput=true,
    p0_par=100000)
    annotation (Placement(transformation(extent={{-116,10},{-136,30}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package Medium =
               mediumB,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-56,20},{-76,40}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package Medium =
               mediumB,                       outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{66,20},{46,40}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{-156,-98},{-136,-78}})));
  HeatExchangers.CounterFlowNTU counterFlowNTU(
    redeclare package MediumA = mediumA,
    redeclare package MediumB = mediumB,
    A=10) annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  Modelica.Blocks.Sources.RealExpression p_out_B(y=if time < 1000 then sourceB.p0_par*0.9 else sourceB.p0_par)
    "if time < 1000 then sourceB.p0 else sourceB.p0*0.999999"
    annotation (Placement(transformation(extent={{-158,10},{-138,30}})));
  Modelica.Blocks.Sources.RealExpression p_out_A(y=if time < 1500 then sourceA.p0_par*0.8 else sourceA.p0_par)
    "glycolSource.p0*0.999999"
    annotation (Placement(transformation(extent={{158,-30},{138,-10}})));
  Processes.FlowResistance flowResistanceB(
    redeclare package Medium = mediumB,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.005,
    l=0.5,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{98,10},{78,30}})));
  Processes.FlowResistance flowResistanceA(
    redeclare package Medium = mediumA,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.005,
    l=0.5,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (                       material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-54,-30},{-34,-10}})));
equation
  connect(sourceA.outlet, multiSensor_Tpm.inlet) annotation (Line(
      points={{-116,-20},{-86,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{116,-20},{70,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkB.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{-116,20},{-76,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, counterFlowNTU.inletB) annotation (Line(
      points={{46,20},{28,20},{28,8},{11.2,8}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.outletB, multiSensor_Tpm2.inlet) annotation (Line(
      points={{-11,8},{-28,8},{-28,20},{-56,20}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.outletA, multiSensor_Tpm1.inlet) annotation (Line(
      points={{11,-4},{28,-4},{28,-20},{50,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA.p0_var, p_out_A.y)
    annotation (Line(points={{128,-20},{137,-20}}, color={0,0,127}));
  connect(sinkB.p0_var, p_out_B.y)
    annotation (Line(points={{-128,20},{-137,20}}, color={0,0,127}));
  connect(multiSensor_Tpm3.inlet, flowResistanceB.outlet) annotation (Line(
      points={{66,20},{78,20}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB.outlet, flowResistanceB.inlet) annotation (Line(
      points={{116,20},{98,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.outlet,flowResistanceA. inlet) annotation (Line(
      points={{-64,-20},{-54,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceA.outlet, counterFlowNTU.inletA) annotation (Line(
      points={{-34,-20},{-28,-20},{-28,-4},{-11.2,-4}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-160,-100},{160,100}})),
    experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=1000,
      __Dymola_Algorithm="Dassl"),
        Documentation(info="<html>
        <p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end CounterFlowNTU_zeroMassFlow;
