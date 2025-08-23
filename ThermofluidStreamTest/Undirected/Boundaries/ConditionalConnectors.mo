within ThermofluidStreamTest.Undirected.Boundaries;
model ConditionalConnectors
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Incompressible.Examples.Glycol47
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium annotation(choicesAllMatching = true);

  inner ThermofluidStream.DropOfCommons dropOfCommons annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  ThermofluidStream.Boundaries.Source sourceA(
    redeclare package Medium = Medium,
    T0_par=333.15)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-30,50})));
  ThermofluidStream.FlowControl.MCV mCV annotation (Placement(transformation(extent={{20,40},{40,60}})));
equation
  connect(sourceA.outlet, mCV.inlet) annotation (Line(
      points={{-20,50},{20,50}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end ConditionalConnectors;
