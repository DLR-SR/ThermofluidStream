within ThermofluidStream.Interfaces.MSLplug.ByCode;
model InletTFStoFluidPortMSL_eq

  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium model"    annotation (choicesAllMatching=true, Documentation(info =              "<html>
    <p><span style=\"font-family: Courier New;\">Medium package used in both sides of the connector.</span></p>
</html>"));

  Interfaces.Inlet inletTFS(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-56,-20},{-16,20}}),
      iconTransformation(extent={{-56,-20},{-16,20}})));
  Modelica.Fluid.Interfaces.FluidPort_b portMSL(redeclare package Medium = Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"   annotation (Placement(transformation(extent={{40,-20},
            {0,20}}),                                                                                                                                 iconTransformation(extent={{30,-10},
            {10,10}})));

equation
  portMSL.m_flow = -inletTFS.m_flow;
  portMSL.p = Medium.pressure(inletTFS.state)+inletTFS.r;
  portMSL.h_outflow = Medium.specificEnthalpy(inletTFS.state);

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-40,-40},{40,40}}), graphics={Polygon(
          points={{-30,-20},{-30,20},{0,0},{-30,-20}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{0,20},{40,-20}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-36,-20},{36,-40}},
          textColor={28,108,200},
          textString="TFS => MSL")}),                           Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-40,-40},
            {40,40}})));
end InletTFStoFluidPortMSL_eq;
