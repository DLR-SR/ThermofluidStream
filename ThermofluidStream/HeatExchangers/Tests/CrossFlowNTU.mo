within ThermofluidStream.HeatExchangers.Tests;
model CrossFlowNTU

  replaceable package MediumA =
      Media.myMedia.Incompressible.Examples.Glycol47
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
        origin={-126,0})));

  ThermofluidStream.Boundaries.Sink sinkA(
    redeclare package Medium = MediumA, p0_par=MediumA.p_default - 1e4)
    annotation (Placement(transformation(extent={{116,-10},{136,
            10}})));

  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm(redeclare package
      Medium = MediumA,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (
      Placement(transformation(
        extent={{-11,-10},{11,10}},
        rotation=0,
        origin={-41,10})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package
      Medium = MediumA,
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
        origin={0,94})));

  ThermofluidStream.Boundaries.Sink sinkB(
    redeclare package Medium = MediumB, p0_par=90000)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-84})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package
      Medium = MediumB,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,-24})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(redeclare package
      Medium = MediumB, outputMassFlowRate=false,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,32})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{-156,-98},{-136,-78}})));
  ThermofluidStream.HeatExchangers.CrossFlowNTU crossFlowNTU(
    redeclare package MediumA = MediumA,
    redeclare package MediumB = MediumB,
    A=10) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Processes.FlowResistance flowResistanceA(
    redeclare package Medium = MediumA,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-92,-10},{-72,10}})));
  Processes.FlowResistance flowResistanceB(
    redeclare package Medium = MediumB,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,64})));

  FlowControl.MCV mCV(
    redeclare package Medium = MediumB,
    m_flow_0=0,
    massFlow_set_par=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-54})));
  FlowControl.MCV mCV1(
    redeclare package Medium = MediumA,
    m_flow_0=1,
    massFlow_set_par=0.3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={82,0})));
equation
  connect(multiSensor_Tpm3.outlet, crossFlowNTU.inletB) annotation (Line(
      points={{0,22},{0,10},{1.77636e-15,10}},
      color={28,108,200},
      thickness=0.5));
  connect(crossFlowNTU.outletB, multiSensor_Tpm2.inlet) annotation (Line(
      points={{-1.77636e-15,-10},{-1.77636e-15,-12},{0,-12},{0,-14}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.outlet, crossFlowNTU.inletA) annotation (Line(
      points={{-30,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(crossFlowNTU.outletA, multiSensor_Tpm1.inlet) annotation (Line(
      points={{10,0},{15,0},{15,1.33227e-15},{30,1.33227e-15}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA.outlet, flowResistanceA.inlet) annotation (Line(
      points={{-116,-1.11022e-15},{-104,-1.11022e-15},{-104,0},{-92,0}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.inlet, flowResistanceA.outlet) annotation (Line(
      points={{-52,0},{-72,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB.outlet, flowResistanceB.inlet) annotation (Line(
      points={{-6.66134e-16,84},{0,84},{0,74},{6.66134e-16,74}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm3.inlet, flowResistanceB.outlet) annotation (Line(
      points={{0,42},{0,54},{-6.66134e-16,54}},
      color={28,108,200},
      thickness=0.5));
  connect(sinkB.inlet, mCV.outlet)
    annotation (Line(
      points={{0,-74},{0,-69},{-6.66134e-16,-69},{-6.66134e-16,-64}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.inlet, multiSensor_Tpm2.outlet)
    annotation (Line(
      points={{6.66134e-16,-44},{6.66134e-16,-39},{0,-39},{0,-34}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.outlet, mCV1.inlet)
    annotation (Line(
      points={{50,-1.77636e-15},{61,-1.77636e-15},{61,1.55431e-15},{72,1.55431e-15}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV1.outlet, sinkA.inlet) annotation (Line(
      points={{92,0},{116,0}},
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
end CrossFlowNTU;
