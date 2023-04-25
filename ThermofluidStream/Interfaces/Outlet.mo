within ThermofluidStream.Interfaces;
connector Outlet "Outlet port for a fluid"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium model defining the ThermodynamicState of the Outlet.</p>
</html>"));

  SI.Pressure r "Inertial pressure";
  flow SI.MassFlowRate m_flow "Mass flow rate";

  output Medium.ThermodynamicState state "Thermodynamic state assuming steady mass flow pressure";

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Polygon(
          points={{100,0},{-100,100},{-40,0},{-100,-100},{100,0}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={28,108,200},
          lineThickness=0.5)}),
    Diagram(coordinateSystem(preserveAspectRatio=true), graphics={
        Polygon(
          points={{0,0},{-100,50},{-80,0},{-100,-50},{0,0}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={28,108,200},
          lineThickness=0.5)}),
    Documentation(info="<html>
<p>Directed flow connector for fluids.</p>
<p>The mass flow is supposed to be negative, hence the fluid is supposed to leave the component through an outlet, therefore the state information of this connector is an output.</p>
</html>"));
end Outlet;
