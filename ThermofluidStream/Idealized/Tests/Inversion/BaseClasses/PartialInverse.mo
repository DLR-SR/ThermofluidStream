within ThermofluidStream.Idealized.Tests.Inversion.BaseClasses;
model PartialInverse "Base model defining the mixing problem"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));

  ThermofluidStream.Boundaries.Source
                                sourceA(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{40,40},{60,60}})));
  ThermofluidStream.Idealized.Topology.JunctionT2 junction(
    displayInstanceName=true,
    displayParameters=true,
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-10,60},{10,40}})));
  ThermofluidStream.Boundaries.Source
                                sourceB(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=303.15) annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateB(
    redeclare package Medium = Medium,

    m_flow_fixed=1) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  .ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRateA(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  ThermofluidStream.Sensors.SingleSensorSelect singleSensorSelect(
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,10})));
equation
  connect(junction.outlet, sink.inlet)
    annotation (Line(
      points={{10,50},{40,50}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateB.outlet, junction.inletA) annotation (Line(
      points={{-20,10},{0,10},{0,40}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateA.outlet, junction.inletB) annotation (Line(
      points={{-20,50},{-10,50}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceA.outlet, massFlowRateA.inlet) annotation (Line(
      points={{-60,50},{-40,50}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceB.outlet, massFlowRateB.inlet) annotation (Line(
      points={{-60,10},{-40,10}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.inlet, junction.outlet) annotation (Line(
      points={{30,20},{30,50},{10,50}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    This model defines the mixing problem that is used to test the two inversion approaches.
  </p>
</html>"));
end PartialInverse;
