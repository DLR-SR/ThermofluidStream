within ThermofluidStream.Idealized.Topology;
model JunctionT2 "Junction T2, inlet A or B are free - Underdetermined (1 equation)"

  extends BaseClasses.Junction;
  ThermofluidStream.Interfaces.Inlet inletA(redeclare package Medium = Medium)annotation(
    Placement(transformation(extent={{-20,-20},{20,20}}, rotation=-90, origin={0,100})));
  ThermofluidStream.Interfaces.Inlet inletB(redeclare package Medium = Medium)annotation(
    Placement(transformation(extent={{-120,-20},{-80,20}})));
equation

  stateA = inletA.state;
  stateB = inletB.state;
  rA = inletA.r;
  rB = inletB.r;
  m_flowA = inletA.m_flow;
  m_flowB = inletB.m_flow;

  annotation(defaultComponentName = "junction",
  Icon(graphics={
        Text(visible=displayInstanceName,
          extent={{-150,-100},{150,-60}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Line(
          points={{-100,0},{-20,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,20},{0,100}},
          color={28,108,200},
          thickness=0.5),
        Text(
          extent={{-60,120},{-20,80}},
          textColor={175,175,175},
          textString="A"),
        Text(
          extent={{-120,60},{-80,20}},
          textColor={175,175,175},
          textString="B"),
        Text(visible = free == ThermoFluidStream.Idealized.Topology.Types.FreeJunctionInlet.A,
          extent={{0,80},{80,50}},
          textColor={0,0,0},
          textString="free"),
        Text(visible = free == ThermoFluidStream.Idealized.Topology.Types.FreeJunctionInlet.B,
          extent={{-80,-20},{0,-50}},
          textColor={0,0,0},
          textString="free"),
        Ellipse(visible = free == ThermoFluidStream.Idealized.Topology.Types.FreeJunctionInlet.A,
          extent={{22,118},{58,82}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(visible = free == ThermoFluidStream.Idealized.Topology.Types.FreeJunctionInlet.A,
          extent={{24,102},{56,98}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(visible = free == ThermoFluidStream.Idealized.Topology.Types.FreeJunctionInlet.B,
          extent={{-118,-22},{-82,-58}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(visible = free == ThermoFluidStream.Idealized.Topology.Types.FreeJunctionInlet.B,
          extent={{-116,-38},{-84,-42}},
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
end JunctionT2;
