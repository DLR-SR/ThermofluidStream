within ThermofluidStream.Undirected.Topology;
model ConnectForeOutlet "Connects fore port to outlet"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus(displayInstanceName=false);

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (Documentation(info="<html>
<p>This is the replaceable package that determines the medium of the Connector. Make sure it fits the medium in all models connected to the ports of the Connector.</p>
</html>"));
  parameter Utilities.Units.Inertance L = dropOfCommons.L "Inertance"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean useDefaultStateAsRear = false "=true, if default medium state is used for rear.state_rearwards";

  Interfaces.Fore fore(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),iconTransformation(extent={{-60,-20},{-20,20}})));
  ThermofluidStream.Interfaces.Outlet outlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),iconTransformation(extent={{20,-20},{60,20}})));
  ConnectRearOutlet connectRearOutlet(
    displayInstanceName=true,
    redeclare package Medium=Medium,
    final L=L/2,
    final useDefaultStateAsRear = useDefaultStateAsRear)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  ConnectForeFore connectForeFore(
    displayInstanceName=true,
    redeclare package Medium=Medium,
    final L=L/2)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  ThermofluidStream.Interfaces.StateInput state_rear(redeclare package Medium=Medium) if not useDefaultStateAsRear
    annotation (Placement(transformation(extent={{20,-20},{-20,20}},rotation=270,origin={0,-40})));

equation

  connect(connectRearOutlet.rear, connectForeFore.fore_b) annotation (Line(
      points={{37,0},{-37,0}},
      color={28,108,200},
      thickness=0.5));
  connect(connectRearOutlet.outlet, outlet) annotation (Line(
      points={{43,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(connectForeFore.fore_a, fore) annotation (Line(
      points={{-43,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(connectRearOutlet.state_rear, state_rear) annotation (Line(points={{40,-4},{40,-12},{0,-12},{0,-40}},
                                 color={162,29,33}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true),
      graphics={
        Text(visible=displayInstanceName,
          extent={{-150,65},{150,25}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Line(
          points={{-30,0},{30,0}},
          color={28,108,200},
          thickness=0.5),
        Line(visible = not useDefaultStateAsRear,
          points={{0,0},{0,-60}},
          color={162,29,33})}),
     Diagram(
        coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>This connector can be used to connect a unidirectional inlet to a undirected rear port. </p>
<p>The state from the rearward direction of the fore port is handed to the outlet, the total pressure as well as the massflow of outlet and port are set equal. </p>
<p>Note that when the flow is reversed, the resulting inertial pressure can be different on both sides of this connector. </p>
<p>Since the unidirectional side of this connector is an oulet, there is no information about the rear state from this side. This information must be given by the StateInlet.</p>
</html>"));
end ConnectForeOutlet;
