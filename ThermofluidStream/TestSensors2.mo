within ThermofluidStream;
model TestSensors2
  extends Modelica.Icons.Example;

    replaceable package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir constrainedby Media.myMedia.Interfaces.PartialMedium
    "Medium model"
     annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Source. Make sure it is the same as the one
the inlet the source is connected to.
</p>
</html>"));


  Boundaries.Source source(
    redeclare package Medium = Medium,
                           T0_par=293.15, p0_par=110000) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Boundaries.Sink sink(redeclare package Medium = Medium,
                       p0_par=100000) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  inner DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,    l=1, r=1e-3,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
                                                       annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Sensors.SingleSensorSelect2 singleSensorSelect2_1(
    redeclare package Medium = Medium,
    digits=4,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.MM_kgpmol)
                                                    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
equation
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{-40,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, sink.inlet) annotation (Line(
      points={{10,0},{40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect2_1.inlet, source.outlet) annotation (Line(
      points={{-20,30},{-34,30},{-34,0},{-40,0}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end TestSensors2;
