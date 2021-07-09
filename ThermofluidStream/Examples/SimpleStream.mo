within ThermofluidStream.Examples;
model SimpleStream "Steam splitting and joining"
  extends Modelica.Icons.Example;

  replaceable package medium = Media.myMedia.Air.MoistAir
    constrainedby Media.myMedia.Interfaces.PartialMedium      annotation(choicesAllMatching = true);

  Boundaries.Source source(
    redeclare package Medium = medium, Xi0_par={0})
    annotation (Placement(transformation(extent={{-150,-20},{-130,0}})));
  Boundaries.Sink sink(redeclare package Medium = medium,
      p0_par=80000)
    annotation (Placement(transformation(extent={{130,-20},{150,0}})));
  Topology.SplitterT1 splitterT1_1(redeclare package Medium =
        medium)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Topology.JunctionT1 junctionrT1_1(redeclare package Medium =
        medium)
    annotation (Placement(transformation(extent={{60,-20},{40,0}})));
  Processes.ConductionElement       thermalConduction(
    redeclare package Medium = medium,
    L=100) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=4e2, T(start=368.15, fixed=true))
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm(redeclare package Medium =
        medium)
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm1(redeclare package Medium =
        medium)
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm2(redeclare package Medium =
        medium)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm4(redeclare package Medium =
        medium)
    annotation (Placement(transformation(extent={{10,-30},{30,-50}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=1000,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
  Processes.FlowResistance flowResistance3(
    redeclare package Medium = medium,
    r=0.1,
    l=10,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));
  Processes.FlowResistance flowResistance4(
    redeclare package Medium = medium,
    r=0.1,
    l=20,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{100,-20},{120,0}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{-140,20},{-120,40}})));
  ThermofluidStream.Utilities.Icons.DLRLogo dLRLogo annotation (Placement(transformation(extent={{116,-62},{158,-20}})));
equation
  connect(source.outlet, flowResistance3.inlet) annotation (Line(
      points={{-130,-10},{-120,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, junctionrT1_1.inletA) annotation (Line(
      points={{40,10},{50,10},{50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT1_1.outletB, flowResistance2.inlet) annotation (Line(
      points={{-50,-20},{-50,-30},{-30,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT1_1.outletA, thermalConduction.inlet) annotation (Line(
      points={{-50,0},{-50,10},{-40,10}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConduction.heatPort, heatCapacitor.port)
    annotation (Line(points={{-30,19.8},{-30,30}},
                                                 color={191,0,0}));
  connect(thermalConduction.outlet, multiSensor_Tpm.inlet) annotation (Line(
      points={{-20,10},{-10,10}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.outlet, flowResistance1.inlet) annotation (Line(
      points={{10,10},{20,10}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionrT1_1.outlet, multiSensor_Tpm1.inlet) annotation (Line(
      points={{60,-10},{70,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm1.outlet, flowResistance4.inlet) annotation (Line(
      points={{90,-10},{100,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.outlet, multiSensor_Tpm2.inlet) annotation (Line(
      points={{-100,-10},{-90,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm2.outlet, splitterT1_1.inlet) annotation (Line(
      points={{-70,-10},{-60,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.outlet, sink.inlet) annotation (Line(
      points={{120,-10},{130,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, multiSensor_Tpm4.inlet) annotation (Line(
      points={{-10,-30},{10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm4.outlet, junctionrT1_1.inletB) annotation (Line(
      points={{30,-30},{50,-30},{50,-20}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-60},{160,
            60}})),
    experiment(StopTime=100, Tolerance=1e-5),
        Documentation(info="<html>
<p>Very basic example if a stream that gets split and rejoins later. </p>
<p><br>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end SimpleStream;
