within ThermofluidStream.Interfaces;
connector Outlet "Outlet port for a fluid"


  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium model defining the ThermodynamicState of the Outlet.</p>
</html>"));


  SI.Pressure r "Inertial pressure";
  flow  SI.MassFlowRate m_flow "Mass flow rate";

  output Medium.ThermodynamicState state "Thermodynamic state assuming steady mass flow pressure";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{40,0},{-80,60}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{40,0},{-80,-60}},
          color={28,108,200},
          thickness=0.5),
        Polygon(
          points={{-80,30},{-80,-30},{-20,0},{-80,30}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-20,0},{-80,30}},
          color={170,213,255},
          thickness=0.5),
        Line(
          points={{-20,0},{-80,-30}},
          color={170,213,255},
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Directed flow connector for fluids.</p>
<p>The mass-flow is supposed to be negativ, hence the fluid is suppoed to leave the component through an outlet, therefore the state information of this connector is an output.</p>
</html>"));
end Outlet;
