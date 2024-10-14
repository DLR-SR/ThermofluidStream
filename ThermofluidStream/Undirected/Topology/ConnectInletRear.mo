within ThermofluidStream.Undirected.Topology;
model ConnectInletRear "Connects inlet to rear port"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus(displayInstanceName=false);

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (Documentation(info="<html>
<p>This is the replaceable package that determines the medium of the Connector. Make sure it fits the medium in all models connected to inlet and port of the Connector.</p>
</html>"));
  parameter Utilities.Units.Inertance L = dropOfCommons.L "Inertance"
    annotation(Dialog(tab="Advanced"));

  ThermofluidStream.Interfaces.Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}), iconTransformation(extent={{-50,-20},{-10,20}})));
  Interfaces.Rear rear(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),iconTransformation(extent={{10,-20},{50,20}})));
  ConnectInletFore connectInletFore(
    displayInstanceName=true,
    redeclare package Medium=Medium,
    final L=L/2)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  ConnectRearRear connectRearRear(
    displayInstanceName=true,
    redeclare package Medium=Medium,
    final L=L/2)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));

equation
  connect(connectInletFore.fore, connectRearRear.rear_a) annotation (Line(
      points={{-37,0},{37,0}},
      color={28,108,200},
      thickness=0.5));
  connect(inlet, connectInletFore.inlet) annotation (Line(
      points={{-100,0},{-43,0}},
      color={28,108,200},
      thickness=0.5));
  connect(connectRearRear.rear_b, rear) annotation (Line(
      points={{43,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(
      graphics={
        Text(visible=displayInstanceName,
          extent={{-150,65},{150,25}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Line(
          points={{-30,0},{30,0}},
          color={28,108,200},
          thickness=0.5)},
      coordinateSystem(preserveAspectRatio=true)),
     Diagram(
        coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>This connector can be used to connect a unidirectional outlet to a undirected fore port. </p>
<p>The state from the inlet is given to the backward direction of the rear port, the total pressure as well as the massflow of inlet and port are set equal. </p>
<p>Note that when the flow is reversed, the resulting inertial pressure can be different on both sides of this connector. </p>
</html>"));
end ConnectInletRear;
