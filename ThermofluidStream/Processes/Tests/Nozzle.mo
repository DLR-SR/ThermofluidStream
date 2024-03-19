within ThermofluidStream.Processes.Tests;
model Nozzle
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.MoistAir
    constrainedby Media.myMedia.Interfaces.PartialMedium "Medium Model"
    annotation (choicesAllMatching=true,Documentation(info="<html>
<p>
Medium model for the test. Can be anything.
</p>
</html>"));


  ThermofluidStream.Processes.Nozzle nozzle(
    redeclare package Medium = Medium,
    A_in=0.00015,
    A_out=0.01) annotation (Placement(transformation(extent={{10,10},{30,30}})));
  FlowResistance flowResistance(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.01,
    l=10,
    redeclare function pLoss = Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
  Boundaries.Source source(redeclare package Medium = Medium, p0_par=110000)
    annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
  Boundaries.Sink sink(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{70,10},{90,30}})));
  ThermofluidStream.Processes.Nozzle nozzle1(
    redeclare package Medium = Medium,
    A_in=0.01,
    A_out=0.00015) annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.01,
    l=10,
    redeclare function pLoss =
      Internal.FlowResistance.laminarTurbulentPressureLoss (
        material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
  Boundaries.Source source1(redeclare package Medium = Medium, p0_par=110000)
    annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
  Boundaries.Sink sink1(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{70,-30},{90,-10}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow(
    redeclare package Medium = Medium,
    A_par=0.00015)
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow1(
    redeclare package Medium = Medium,
    A_par=0.01)
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow(
    redeclare package Medium = Medium,
    A_par=0.01)
    annotation (Placement(transformation(extent={{40,10},{60,30}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow1(
    redeclare package Medium = Medium,
    A_par=0.00015)
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons annotation (
    Placement(visible = true, transformation(origin = {0, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(nozzle.inlet, flowResistance.outlet) annotation (Line(
      points={{10,20},{-10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(nozzle1.inlet, flowResistance1.outlet) annotation (Line(
      points={{10,-20},{-10,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.inlet, dynamicPressureInflow.outlet)
    annotation (Line(
      points={{-30,20},{-40,20}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureInflow.inlet, source.outlet) annotation (Line(
      points={{-60,20},{-70,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.inlet, dynamicPressureInflow1.outlet)
    annotation (Line(
      points={{-30,-20},{-40,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureInflow1.inlet, source1.outlet)
    annotation (Line(
      points={{-60,-20},{-70,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(nozzle.outlet, dynamicPressureOutflow.inlet) annotation (Line(
      points={{30,20},{40,20}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureOutflow.outlet, sink.inlet) annotation (Line(
      points={{60,20},{70,20}},
      color={28,108,200},
      thickness=0.5));
  connect(nozzle1.outlet, dynamicPressureOutflow1.inlet)
    annotation (Line(
      points={{30,-20},{40,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureOutflow1.outlet, sink1.inlet) annotation (Line(
      points={{60,-20},{70,-20}},
      color={28,108,200},
      thickness=0.5));
  annotation (experiment(StopTime=10, Tolerance=1e-6, Interval=0.01),
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Test for the nozzle, that can be used to transfer between kinetic enegy and enthalpy of the fluid.</p>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end Nozzle;
