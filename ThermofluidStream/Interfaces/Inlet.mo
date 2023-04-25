within ThermofluidStream.Interfaces;
connector Inlet "Inlet port for a fluid"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium model defining the ThermodynamicState of the Inlet.</p>
</html>"));

  SI.Pressure r "Inertial pressure";
  flow SI.MassFlowRate m_flow "Mass flow rate";

  input Medium.ThermodynamicState state "Thermodynamic state assuming steady mass flow pressure";

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Polygon(
          points={{-100,100},{-40,0},{-100,-100},{100,0},{-100,100}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5,
          lineColor={28,108,200})}),
    Diagram(coordinateSystem(preserveAspectRatio=true), graphics={
        Polygon(
          points={{100,0},{0,50},{20,0},{0,-50},{100,0}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5,
          lineColor={28,108,200})}),
    Documentation(info="<html>
<p>Directed flow connector for fluids.</p>
<p>The mass flow is supposed to be positive, hence the fluid is supposed to enter the component through an inlet, therefore the state information of this connector is an input.</p>
</html>"));
end Inlet;
