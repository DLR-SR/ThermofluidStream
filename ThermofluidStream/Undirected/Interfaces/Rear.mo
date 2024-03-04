within ThermofluidStream.Undirected.Interfaces;
connector Rear "Undirected connector outputting the rearward state"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in Fore. Make sure it is the same as the other part of the connection.</p>
</html>"));

  SI.Pressure r "inertial pressure";
  flow SI.MassFlowRate m_flow "mass flow rate";

  output Medium.ThermodynamicState state_rearwards "thermodynamic state in rearwards direction";
  input Medium.ThermodynamicState state_forwards "thermodynamic state in forwards direction";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false,initialScale=0.2), graphics={Ellipse(
          extent={{-80.0,80.0},{80.0,-80.0}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid), Ellipse(
          extent={{-40.0,40.0},{40.0,-40.0}},
          lineColor={170,213,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
                            Diagram(coordinateSystem(preserveAspectRatio=false,initialScale=0.2), graphics={
                                                                          Ellipse(
          extent={{-40.0,40.0},{40.0,-40.0}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid), Ellipse(
          extent={{-20.0,20.0},{20.0,-20.0}},
          lineColor={170,213,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
          Text(
          extent={{-120.0,100.0},{80.0,50.0}},
          textColor={28,108,200},
          textString="%name")}),
    Documentation(info="<html>
<p>One of the two undirected connectors. The state information flows in both directions, forward and backward. </p>
<p>At positive massflow, Rear is a input.</p>
</html>"));
end Rear;
