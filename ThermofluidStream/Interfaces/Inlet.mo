within ThermofluidStream.Interfaces;
connector Inlet "Inlet port for a fluid"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium model defining the ThermodynamicState of the Inlet.</p>
</html>"));

  SI.Pressure r "Inertial pressure";
  flow SI.MassFlowRate m_flow "Mass flow rate";

  input Medium.ThermodynamicState state "Thermodynamic state assuming steady mass flow pressure";

  input Medium.ThermodynamicState state "thermodynamic state assuming steady mass flow pressure";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-60,12},{-8,-14}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Polygon(
          points={{100,0},{-100,100},{-100,0},{-100,-100},{100,0}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineColor={28,108,200},
          lineThickness=0.5),
        Polygon(
          points={{-100,60},{-100,-60},{20,0},{-100,60}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-100,60},{-100,-60}},
          color={255,255,254},
          thickness=0.1),
        Line(
          points={{-100,100},{100,0},{-100,-100}},
          color={28,108,200},
          thickness=0.5)}),
    Diagram(coordinateSystem(preserveAspectRatio=true), graphics={
        Polygon(
          points={{100,0},{0,50},{0,-50},{100,0}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,100},{100,0},{-100,-100}},
          color={28,108,200},
          lineThickness=0.5),
        Polygon(
          points={{-68,48},{28,0},{-68,-48},{-68,48}},
          thickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=linePattern.None)}),
                            Diagram(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{100,0},{0,50},{0,-50},{100,0}},
          pattern=LinePattern.None,
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,50},{100,0},{0,-50}},
          color={28,108,200},
          lineThickness=0.5),
        Polygon(
          points={{20,20},{60,0},{20,-20},{20,20}},
          thickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}),
    Documentation(info="<html>
<p>Directed flow connector for fluids.</p>
<p>The mass-flow is supposed to be positive, hence the fluid is supposed to enter the component through an inlet, therefore the state information of this connector is an input.</p>
</html>"));
end Inlet;
