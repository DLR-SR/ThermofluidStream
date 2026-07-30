within ThermofluidStream.Idealized.Topology;
model JunctionT1 "Junction T1, inlet A or B is free - Underdetermined (1 equation)"
  extends BaseClasses.Junction;

  ThermofluidStream.Interfaces.Inlet inletA(redeclare package Medium = Medium) annotation(
    Placement(transformation(extent={{-20,-20},{20,20}}, rotation=-90, origin={0,100})));
  ThermofluidStream.Interfaces.Inlet inletB(redeclare package Medium = Medium) annotation(
    Placement(transformation(extent={{-20,-20},{20,20}}, rotation=90, origin={0,-100})));

equation

  stateA = inletA.state;
  stateB = inletB.state;
  rA = inletA.r;
  rB = inletB.r;
  m_flowA = inletA.m_flow;
  m_flowB = inletB.m_flow;

  annotation(
    defaultComponentName = "junction",
    Icon(
      graphics={
        Text(
          extent={{-150,90},{150,60}},
          textString = if displayInstanceName then "%name" else "",
          textColor=dropOfCommons.instanceNameColor,
          rotation=90,
          origin={-14,0}),
        Line(
          points={{0,-20},{0,-100}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,20},{0,100}},
          color={28,108,200},
          thickness=0.5),
        Text(
          extent={{20,120},{60,80}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{20,-80},{60,-120}},
          textColor={175,175,175},
          textString="B"),
        Text(
          extent={{0,80},{100,40}},
          textColor={0,0,0},
          textString = if free == ThermofluidStream.Idealized.Topology.Types.FreeJunctionInlet.A then "free" else ""),
        Text(
          extent={{0,-40},{100,-80}},
          textColor={0,0,0},
          textString = if free == ThermofluidStream.Idealized.Topology.Types.FreeJunctionInlet.B then "free" else ""),
        Ellipse(
          extent={{-48,78},{-12,42}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern = if free == ThermofluidStream.Idealized.Topology.Types.FreeJunctionInlet.A then FillPattern.Solid else FillPattern.None),
        Rectangle(
          extent={{-46,62},{-14,58}},
          fillColor={28,108,200},
          fillPattern = if free == ThermofluidStream.Idealized.Topology.Types.FreeJunctionInlet.A then FillPattern.Solid else FillPattern.None,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-48,-42},{-12,-78}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern = if free == ThermofluidStream.Idealized.Topology.Types.FreeJunctionInlet.B then FillPattern.Solid else FillPattern.None),
        Rectangle(
          extent={{-46,-58},{-14,-62}},
          fillColor={28,108,200},
          fillPattern = if free == ThermofluidStream.Idealized.Topology.Types.FreeJunctionInlet.B then FillPattern.Solid else FillPattern.None,
          pattern=LinePattern.None)}),
    Documentation(
      info="<html>
  <p>
    Model of an ideal junction that should be used when the mass flow rate is specified at one or both inlets. 
  </p>
  <p>
    The model is locally underdetermined (one equation missing) and therefore must be connected to an overdetermined component 
    (e.g., <a href=\"modelica://ThermofluidStream.Idealized.Boundaries.MassFlowRate\">MassFlowRate</a>) 
    to ensure that the overall system is not underdetermined.
  </p>
</html>",
      revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end JunctionT1;
