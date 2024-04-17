within ThermofluidStream.Undirected.Interfaces;
connector Fore "Undirected connector outputting the forward state"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in Fore. Make sure it is the same as the other part of the connection.</p>
</html>"));

  SI.Pressure r "Inertial pressure";
  flow SI.MassFlowRate m_flow "Mass flow rate";

  input Medium.ThermodynamicState state_rearwards "Thermodynamic state in rearwards direction";
  output Medium.ThermodynamicState state_forwards "Thermodynamic state in forwards direction";
  annotation (Icon(coordinateSystem(preserveAspectRatio=true,initialScale=0.2), graphics={Ellipse(
          extent={{-80.0,80.0},{80.0,-80.0}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Ellipse(
          extent={{-40.0,40.0},{40.0,-40.0}},
          lineColor={170,213,255},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid)}),
                            Diagram(coordinateSystem(preserveAspectRatio=true,initialScale=0.2), graphics={
                                                                          Ellipse(
          extent={{-40.0,40.0},{40.0,-40.0}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Ellipse(
          extent={{-20.0,20.0},{20.0,-20.0}},
          lineColor={170,213,255},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
          Text(
          extent={{-80.0,100.0},{120.0,50.0}},
          textColor={28,108,200},
          textString="%name")}),
    Documentation(info="<html>
<p>One of the two undirected connectors. The state information flows in both directions, forward and backward. </p>
<p>At positive massflow, Fore is a output. </p>
</html>"));

end Fore;
