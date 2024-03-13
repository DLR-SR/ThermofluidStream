within ThermofluidStream.HeatExchangers.Tests;
model CrossFlowNTU_zeroMassFlow

  replaceable package MediumA =
      Media.myMedia.Incompressible.Examples.Glycol47
    constrainedby Media.myMedia.Interfaces.PartialMedium annotation(choicesAllMatching = true);

  replaceable package MediumB = Media.myMedia.Air.DryAirNasa
    constrainedby Media.myMedia.Interfaces.PartialMedium annotation(choicesAllMatching = true);

  extends Modelica.Icons.Example;

  ThermofluidStream.Boundaries.Source sourceA(
    redeclare package Medium = MediumA,
    T0_par=333.15,
    p0_par=100000)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-126,0})));

  ThermofluidStream.Boundaries.Sink sinkA(
    redeclare package Medium = MediumA,
    pressureFromInput=true,
    p0_par=100000) annotation (Placement(transformation(extent={{116,-10},{136,
            10}})));

  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(
    redeclare package Medium = MediumA,
    digits=3,
    temperatureUnit="degC") annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={40,10})));

  ThermofluidStream.Boundaries.Source sourceB(
    redeclare package Medium = MediumB,
    temperatureFromInput=false,
    T0_par=293.15,
    p0_par=100000)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,80})));

  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = MediumB,
    pressureFromInput=true,
    p0_par=100000)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-54})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(
    redeclare package Medium = MediumB,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,-24})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(
    redeclare package Medium = MediumB,
    outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,28})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{-156,-98},{-136,-78}})));
  HeatExchangers.CrossFlowNTU crossFlowNTU(
    redeclare package MediumA = MediumA,
    redeclare package MediumB = MediumB,
    A=10) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.RealExpression p_out_B(y=if time < 1000 then sourceB.p0_par*0.9 else sourceB.p0_par)
    "if time < 1000 then sourceB.p0*0.9 else sourceB.p0"
    annotation (Placement(transformation(extent={{-40,-84},{-20,-64}})));
  Modelica.Blocks.Sources.RealExpression p_out_A(y=if time < 1500 then sourceA.p0_par*0.8 else sourceA.p0_par)
    "if time < 1500 then sourceA.p0*0.8 else sourceA.p0"
    annotation (Placement(transformation(extent={{162,-10},{142,10}})));
  Processes.FlowResistance flowResistanceA(
    redeclare package Medium = MediumA,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.005,
    l=0.5,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e5))
    annotation (Placement(transformation(extent={{-102,-10},{-82,10}})));
  Processes.FlowResistance flowResistanceB(
    redeclare package Medium = MediumB,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.005,
    l=0.5,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e5))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,54})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm4(
    redeclare package Medium = MediumA,
    digits=3,
    temperatureUnit="degC") annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-40,10})));
equation
  connect(sinkA.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{116,0},{83,0},{83,-1.77636e-15},{50,-1.77636e-15}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkB.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{4.44089e-16,-44},{0,-44},{0,-34}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.outlet, crossFlowNTU.inletB) annotation (Line(
      points={{0,18},{0,10}},
      color={28,108,200},
      thickness=0.5));
  connect(crossFlowNTU.outletB, multiSensor_Tpm2.inlet) annotation (Line(
      points={{0,-10},{0,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(crossFlowNTU.outletA, multiSensor_Tpm1.inlet) annotation (Line(
      points={{10,0},{15,0},{15,1.33227e-15},{30,1.33227e-15}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_B.y, sinkB.p0_var)
    annotation (Line(points={{-19,-74},{0,-74},{0,-56}}, color={0,0,127}));
  connect(sinkA.p0_var, p_out_A.y)
    annotation (Line(points={{128,0},{141,0}}, color={0,0,127}));
  connect(sourceB.outlet, flowResistanceB.inlet) annotation (Line(
      points={{-6.66134e-16,70},{0,70},{0,64}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.inlet, flowResistanceB.outlet) annotation (Line(
      points={{0,38},{0,44},{-6.66134e-16,44}},
      color={28,108,200},
      thickness=0.5));
  connect(crossFlowNTU.inletA, multiSensor_Tpm4.outlet) annotation (Line(
      points={{-10,0},{-15,0},{-15,-1.77636e-15},{-30,-1.77636e-15}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA.outlet,flowResistanceA. inlet) annotation (Line(
      points={{-116,-1.11022e-15},{-104,-1.11022e-15},{-104,0},{-102,0}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm4.inlet,flowResistanceA. outlet) annotation (Line(
      points={{-50,1.77636e-15},{-50,0},{-82,0}},
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
end CrossFlowNTU_zeroMassFlow;
