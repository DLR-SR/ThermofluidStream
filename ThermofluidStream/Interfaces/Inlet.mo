within ThermofluidStream.Interfaces;
connector Inlet "Inlet port for a fluid"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium model defining the ThermodynamicState of the Inlet.</p>
</html>"));


  SI.Pressure r "inertial pressure";
  flow SI.MassFlowRate m_flow "mass flow rate";

  input Medium.ThermodynamicState state "thermodynamic state assuming steady mass flow pressure";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{100,0},{-100,100},{-100,50},{0,0},{-100,-50},{-100,-100},{100,0}},
          lineColor={28,108,200},
          pattern=LinePattern.None,
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,100},{100,0},{-100,-100}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-100,50},{0,0},{-100,-50}},
          color={170,213,255},
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{100,0},{0,50},{0,20},{40,0},{0,-20},{0,-50},{100,0}},
          lineColor={28,108,200},
          pattern=LinePattern.None,
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,50},{100,0},{0,-50}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,20},{40,0},{0,-20}},
          color={170,213,255},
          thickness=0.5)}),
    Documentation(info="<html>
<p>Directed flow connector for fluids.</p>
<p>The mass-flow is supposed to be positiv, hence the fluid is supposed to enter the component through an inlet, therefore the state information of this connector is an input.</p>
</html>"));
end Inlet;
