within ThermofluidStream.Undirected.Topology;
model ConnectForeOutlet
  "Uni/Bidirectional connector with rear and outlet"

  replaceable package Medium = myMedia.Interfaces.PartialMedium "Medium of the connection"
    annotation (Documentation(info="<html>
<p>This is the replaceable package that determines the medium of the Connector. Make shure it fits the medium in all models connected to the ports of the Connector.</p>
</html>"));
  parameter Utilities.Units.Inertance L = dropOfCommons.L "Inertance"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean useDefaultStateAsRear = false "Use Default Medium states as state_rearwards";

  Interfaces.Fore fore(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={-40,0}),
        iconTransformation(extent={{-20,-20},{20,20}}, origin={-30,0})));
  ThermofluidStream.Interfaces.Outlet outlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={40,0}),
        iconTransformation(extent={{-20,-20},{20,20}}, origin={30,0})));
  ConnectRearOutlet connectRearOutlet(redeclare package Medium=Medium, final L=L/2, final useDefaultStateAsRear = useDefaultStateAsRear)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  ConnectForeFore connectForeFore(redeclare package Medium=Medium, final L=L/2)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  ThermofluidStream.Interfaces.StateInput state_rear(redeclare package Medium=Medium) if not useDefaultStateAsRear
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,40})));

protected
  outer DropOfCommons dropOfCommons;

equation

  connect(connectRearOutlet.rear, connectForeFore.fore_b) annotation (Line(
      points={{7,0},{-7,0}},
      color={28,108,200},
      thickness=0.5));
  connect(connectRearOutlet.outlet, outlet) annotation (Line(
      points={{13,0},{40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(connectForeFore.fore_a, fore) annotation (Line(
      points={{-13,0},{-40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(connectRearOutlet.state_rear, state_rear) annotation (Line(points={{10,4},{
          10,12},{0,12},{0,40}},      color={162,29,33}));
  annotation (Icon(
      graphics={
        Line( points={{-20,0},{20,0}},
          color={28,108,200},
          thickness=0.5), Line(
          points={{0,0},{0,60}},
          color={162,29,33},
          arrow={Arrow.Filled,Arrow.None},
          arrowSize = 20)},
      coordinateSystem(preserveAspectRatio=false)),
     Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This connector can be used to connect a unidirectional inlet to a bidirectional rear port. </p>
<p>The state from the rearward direction of the fore port is handed to the outlet, the total pressure as well as the massflow of outlet and port are set equal. </p>
<p>Note that when the flow is reversed, the resulting inertial pressure can be different on both sides of this connector. </p>
<p>Since the unidirectional side of this connector is an oulet, there is no information about the rear state from this side. This information must be given by the StateInlet.</p>
</html>"));
end ConnectForeOutlet;
