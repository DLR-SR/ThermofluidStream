within ThermofluidStream.Undirected.Topology;
model ConnectForeFore "Undirected connector with fore and fore"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
                                                                "Medium of the connection"
    annotation (Documentation(info="<html>
<p>This is the replaceable package that determines the medium of the Connector. Make sure it fits the medium in all models connected to the ports of the Connector.</p>
</html>"));
  parameter Utilities.Units.Inertance L = dropOfCommons.L "Inertance"
    annotation(Dialog(tab="Advanced"));

  Interfaces.Fore fore_a(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={-30,0}),
        iconTransformation(extent={{-20,-20},{20,20}}, origin={-30,0})));
  Interfaces.Fore fore_b(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={30,0}),
        iconTransformation(extent={{-20,-20},{20,20}}, origin={30,0})));

protected
  outer DropOfCommons dropOfCommons;

equation
  fore_b.state_forwards = fore_a.state_rearwards;
  fore_a.state_forwards = fore_b.state_rearwards;
  fore_a.m_flow + fore_b.m_flow = 0;
  L*der(fore_a.m_flow) = fore_a.r - fore_b.r;

  annotation (Icon(
      graphics={
        Line( points={{-20,0},{20,0}},
          color={28,108,200},
          thickness=0.5)},
      coordinateSystem(preserveAspectRatio=false)),
     Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This connector can be used to connect two undirected rear ports. </p>
<p>Basically the connector switches the names of output and input of the two ports.</p>
</html>"));
end ConnectForeFore;
