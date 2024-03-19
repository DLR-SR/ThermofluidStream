within ThermofluidStream.Undirected.Topology;
model ConnectRearRear "Connects two rear ports"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (Documentation(info="<html>
<p>This is the replaceable package that determines the medium of the Connector. Make sure it fits the medium in all models connected to the ports of the Connector.</p>
</html>"));
  parameter Utilities.Units.Inertance L = dropOfCommons.L "Inertance"
    annotation(Dialog(tab="Advanced"));

  Interfaces.Rear rear_a(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={-30,0}),
        iconTransformation(extent={{-20,-20},{20,20}}, origin={-30,0})));
  Interfaces.Rear rear_b(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={30,0}),
        iconTransformation(extent={{-20,-20},{20,20}}, origin={30,0})));

equation
  rear_b.state_rearwards = rear_a.state_forwards;
  rear_a.state_rearwards = rear_b.state_forwards;
  rear_a.m_flow + rear_b.m_flow = 0;
  L*der(rear_a.m_flow) = rear_a.r - rear_b.r;

  annotation (Icon(
      graphics={
        Text(visible=displayInstanceName,
          extent={{-150,65},{150,25}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Line(
          points={{-20,0},{20,0}},
          color={28,108,200},
          thickness=0.5)},
      coordinateSystem(preserveAspectRatio=true)),
     Diagram(
        coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>This connector can be used to connect two undirected fore ports. </p>
<p>Basically the connector switches the names of output and input of the two ports.</p>
</html>"));
end ConnectRearRear;
