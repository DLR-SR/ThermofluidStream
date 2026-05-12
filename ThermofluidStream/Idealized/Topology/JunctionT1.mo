within ThermofluidStream.Idealized.Topology;
model JunctionT1 "Junction T1, inlet A or B is free - Underdetermined (1 equation)"

  extends BaseClasses.Junction(displayParameters=true, displayInstanceName=false);
  ThermofluidStream.Interfaces.Inlet inletA(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=-90, origin={0,100})));
  ThermofluidStream.Interfaces.Inlet inletB(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=90, origin={0,-100})));
equation

  stateA = inletA.state;
  stateB = inletB.state;
  rA = inletA.r;
  rB = inletB.r;
  m_flowA = inletA.m_flow;
  m_flowB = inletB.m_flow;

  annotation (defaultComponentName = "junction",
  Icon(graphics={
       Text(visible=displayInstanceName,
          extent={{-150,90},{150,60}},
          textString="%name",
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
        Text(visible = free == ThermoFluidStream.Idealized.Topology.Types.FreeJunctionInlet.A,
          extent={{0,80},{100,40}},
          textColor={0,0,0},
          textString="free"),
        Text(visible = free == ThermoFluidStream.Idealized.Topology.Types.FreeJunctionInlet.B,
          extent={{0,-40},{100,-80}},
          textColor={0,0,0},
          textString="free"),
        Ellipse(visible = free == ThermoFluidStream.Idealized.Topology.Types.FreeJunctionInlet.A,
          extent={{-48,78},{-12,42}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(visible = free == ThermoFluidStream.Idealized.Topology.Types.FreeJunctionInlet.A,
          extent={{-46,62},{-14,58}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(visible = free == ThermoFluidStream.Idealized.Topology.Types.FreeJunctionInlet.B,
          extent={{-48,-42},{-12,-78}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(visible = free == ThermoFluidStream.Idealized.Topology.Types.FreeJunctionInlet.B,
          extent={{-46,-58},{-14,-62}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    Model of an ideal junction that should be used when the mass flow rate is specified at one or both inlets. 
  </p>
  <p>
    The model is locally underdetermined (one equation missing) and therefore must be connected to an overdetermined component 
    (e.g., <a href=\"modelica://ThermoFluidStream.Idealized.Sources.MassFlowRate\">MassFlowRate</a>) 
    to ensure that the overall system is not underdetermined.
  </p>
</html>"));
end JunctionT1;
