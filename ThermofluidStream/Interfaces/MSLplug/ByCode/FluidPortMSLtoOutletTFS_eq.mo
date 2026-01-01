within ThermofluidStream.Interfaces.MSLplug.ByCode;
model FluidPortMSLtoOutletTFS_eq

  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium model"    annotation (choicesAllMatching=true, Documentation(info =              "<html>
    <p><span style=\"font-family: Courier New;\">Medium package used in both sides of the connector.</span></p>
    </html>"));
  parameter ThermofluidStream.Utilities.Units.Inertance L=dropOfCommons.L "Inertance"
    annotation (Dialog(tab="Advanced"));

  Interfaces.Outlet outletTFS(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{8,-20},{48,20}}),  iconTransformation(extent={{8,-20},{48,20}})));
  Modelica.Fluid.Interfaces.FluidPort_b portMSL(redeclare package Medium = Medium) "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-10,-20},{-50,20}}), iconTransformation(extent={{-12,-10},{-32,10}})));

protected
  outer ThermofluidStream.DropOfCommons dropOfCommons;

equation
  outletTFS.m_flow + portMSL.m_flow =0;
//  portMSL.p = Medium.pressure(outletTFS.state)+outletTFS.r;
  L*der(outletTFS.m_flow) = outletTFS.r - 0;
  outletTFS.state=Medium.setState_phX(portMSL.p, inStream(portMSL.h_outflow), inStream(portMSL.Xi_outflow));
  portMSL.h_outflow=Medium.specificEnthalpy(outletTFS.state);

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-40,-40},{40,40}}), graphics={
        Rectangle(
          extent={{-20,20},{20,-20}},
          lineColor={28,108,200},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Line(
          points={{-12,0},{20,0}},
          color={28,108,200},
          thickness=0.5),                                                                            Polygon(
          points={{26,-20},{26,20},{56,0},{26,-20}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,20},{-2,-20}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-36,-20},{36,-40}},
          textColor={28,108,200},
          textString="TFS => MSL")}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-40,-40},
            {40,40}})));
end FluidPortMSLtoOutletTFS_eq;
