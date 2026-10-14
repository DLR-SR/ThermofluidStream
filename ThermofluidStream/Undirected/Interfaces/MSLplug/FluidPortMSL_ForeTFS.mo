within ThermofluidStream.Undirected.Interfaces.MSLplug;
model FluidPortMSL_ForeTFS

  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium model"    annotation (choicesAllMatching=true, Documentation(info =              "<html>
    <p><span style=\"font-family: Courier New;\">Medium package used in both sides of the connector.</span></p>
    </html>"));
protected
  outer ThermofluidStream.DropOfCommons dropOfCommons;
  Modelica.Units.SI.Pressure r;
public
  parameter ThermofluidStream.Utilities.Units.Inertance L=dropOfCommons.L "Inertance of pressure"
    annotation (Dialog(tab="Advanced"));

  Modelica.Fluid.Interfaces.FluidPort_b portMSL(redeclare package Medium = Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"   annotation (Placement(transformation(extent={{-20,-20},{-60,20}}),iconTransformation(extent={{-30,-10},
            {-50,10}})));

  Fore fore annotation (Placement(transformation(extent={{20,-20},{60,20}}), iconTransformation(extent={{20,-20},{60,20}})));
equation

  // Mass balance
  rearTFS.m_flow + portMSL.m_flow = 0;

  // Pressure
  der(rearTFS.m_flow)*L = rearTFS.r - r;
  Medium.pressure(rearTFS.state_rearwards) + r = portMSL.p;
  Medium.pressure(rearTFS.state_forwards) + r = portMSL.p;

  // Enthalpy
  portMSL.h_outflow   = Medium.specificEnthalpy(rearTFS.state_rearwards);
  rearTFS.state_rearwards = Medium.setState_phX(portMSL.p,inStream(portMSL.h_outflow),inStream(portMSL.Xi_outflow));

//  port_a.Xi_outflow = inStream(port_b.Xi_outflow);
//  port_b.Xi_outflow = inStream(port_a.Xi_outflow);
//  port_a.C_outflow = inStream(port_b.C_outflow);
//  port_b.C_outflow = inStream(port_a.C_outflow);

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-40,-40},{40,40}}), graphics={
        Rectangle(
          extent={{-40,20},{40,-20}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-36,32},{36,12}},
          textColor={28,108,200},
          textString="MSL <=> TFS"),
        Polygon(
          points={{8,-12.5},{28,-20.5},{8,-28.5},{8,-12.5}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=showDesignFlowDirection),
        Polygon(
          points={{8,-14},{20,-20},{8,-27},{8,-14}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=allowFlowReversal),
        Line(
          points={{20,-20.5},{-24,-20.5}},
          color={0,128,255},
          visible=showDesignFlowDirection),
        Line(
          points={{28,2},{-30,2}},
          color={0,128,255},
          visible=showDesignFlowDirection),
        Line(
          points={{28,-2},{-30,-2}},
          color={0,128,255},
          visible=showDesignFlowDirection)}),                   Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-40,-40},
            {40,40}})));
end FluidPortMSL_ForeTFS;
