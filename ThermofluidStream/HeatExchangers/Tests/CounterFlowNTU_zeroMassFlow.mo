within ThermofluidStream.HeatExchangers.Tests;
model CounterFlowNTU_zeroMassFlow

  replaceable package MediumA = Media.myMedia.Incompressible.Examples.Glycol47
    constrainedby Media.myMedia.Interfaces.PartialMedium annotation(choicesAllMatching = true);

  replaceable package MediumB = Media.myMedia.Air.DryAirNasa
    constrainedby Media.myMedia.Interfaces.PartialMedium annotation(choicesAllMatching = true);

  extends Modelica.Icons.Example;

  ThermofluidStream.Boundaries.Source sourceA(
    redeclare package Medium = MediumA,
    T0_par=333.15)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-126,-20})));

  ThermofluidStream.Boundaries.Sink sinkA(
    redeclare package Medium = MediumA,
    pressureFromInput=true,
    p0_par=100000) annotation (Placement(transformation(extent={{116,-30},{136,-10}})));

  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm(redeclare package Medium =
               MediumA,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,-10})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package Medium =
               MediumA,
    digits=3,
    temperatureUnit="degC") annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={50,-10})));

  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = MediumB,
    temperatureFromInput=false,
    T0_par=293.15,
    p0_par=100000)
    annotation (Placement(transformation(extent={{136,10},{116,30}})));
  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = MediumB,
    pressureFromInput=true,
    p0_par=100000)
    annotation (Placement(transformation(extent={{-116,10},{-136,30}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package Medium =
               MediumB,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-70,20},{-90,40}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package Medium =
               MediumB, outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{60,20},{40,40}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{-156,-98},{-136,-78}})));
  HeatExchangers.CounterFlowNTU counterFlowNTU(
    redeclare package MediumA = MediumA,
    redeclare package MediumB = MediumB,
    A=10) annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  Modelica.Blocks.Sources.RealExpression p_out_B(y=if time < 1000 then sourceB.p0_par*0.9 else sourceB.p0_par)
    "if time < 1000 then sourceB.p0 else sourceB.p0*0.999999"
    annotation (Placement(transformation(extent={{-158,10},{-138,30}})));
  Modelica.Blocks.Sources.RealExpression p_out_A(y=if time < 1500 then sourceA.p0_par*0.8 else sourceA.p0_par)
    "glycolSource.p0*0.999999"
    annotation (Placement(transformation(extent={{158,-30},{138,-10}})));
  Processes.FlowResistance flowResistanceB(
    redeclare package Medium = MediumB,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.005,
    l=0.5,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{100,10},{80,30}})));
  Processes.FlowResistance flowResistanceA(
    redeclare package Medium = MediumA,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.005,
    l=0.5,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-54,-30},{-34,-10}})));
equation
  connect(sourceA.outlet, multiSensor_Tpm.inlet) annotation (Line(
      points={{-116,-20},{-90,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{116,-20},{88,-20},{88,-20},{60,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkB.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{-116,20},{-90,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, counterFlowNTU.inletB) annotation (Line(
      points={{40,20},{20,20},{20,8},{10,8}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.outletB, multiSensor_Tpm2.inlet) annotation (Line(
      points={{-10,8},{-20,8},{-20,20},{-70,20}},
      color={28,108,200},
      thickness=0.5));
  connect(counterFlowNTU.outletA, multiSensor_Tpm1.inlet) annotation (Line(
      points={{10,-4},{20,-4},{20,-20},{40,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkA.p0_var, p_out_A.y)
    annotation (Line(points={{128,-20},{137,-20}}, color={0,0,127}));
  connect(sinkB.p0_var, p_out_B.y)
    annotation (Line(points={{-128,20},{-137,20}}, color={0,0,127}));
  connect(multiSensor_Tpm3.inlet, flowResistanceB.outlet) annotation (Line(
      points={{60,20},{80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB.outlet, flowResistanceB.inlet) annotation (Line(
      points={{116,20},{100,20}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.outlet,flowResistanceA. inlet) annotation (Line(
      points={{-70,-20},{-54,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistanceA.outlet, counterFlowNTU.inletA) annotation (Line(
      points={{-34,-20},{-20,-20},{-20,-4},{-10,-4}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-160,-100},{160,100}})),
    experiment(
      StopTime=100,
   Tolerance=1e-6,
   Interval=0.1,
      __Dymola_Algorithm="Dassl"),
        Documentation(info="<html>
        <p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end CounterFlowNTU_zeroMassFlow;
