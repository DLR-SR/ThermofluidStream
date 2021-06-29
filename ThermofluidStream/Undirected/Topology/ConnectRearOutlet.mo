within ThermofluidStream.Undirected.Topology;
model ConnectRearOutlet
  "Directed/undirected connector with rear and outlet"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
                                                                "Medium of the connection"
    annotation (Documentation(info="<html>
<p>This is the replaceable package that determines the medium of the Connector. Make shure it fits the medium in all models connected to outlet and port of the Connector.</p>
</html>"));
  parameter Utilities.Units.Inertance L = dropOfCommons.L "Inertance"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean useDefaultStateAsRear = false "Use Default Medium states as state_rearwards";

  Interfaces.Rear rear(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={-30,0}),
        iconTransformation(extent={{-20,-20},{20,20}}, origin={-30,0})));
  ThermofluidStream.Interfaces.Outlet outlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={30,0}),
        iconTransformation(extent={{-20,-20},{20,20}}, origin={30,0})));
  ThermofluidStream.Interfaces.StateInput state_rear(redeclare package Medium=Medium, state = rear.state_rearwards) if not useDefaultStateAsRear
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,40})));

protected
  outer DropOfCommons dropOfCommons;

  SI.Pressure r_rear, r_outlet;

equation
  outlet.state = rear.state_forwards;

  rear.m_flow + outlet.m_flow = 0;
  r_outlet + Medium.pressure(outlet.state) = r_rear + Internal.regStep(rear.m_flow, Medium.pressure(rear.state_forwards), Medium.pressure(rear.state_rearwards), dropOfCommons.m_flow_reg);

  L/2*der(outlet.m_flow) = outlet.r - r_outlet;
  L/2*der(rear.m_flow) = rear.r - r_rear;

  if useDefaultStateAsRear then
    rear.state_rearwards = Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default);
  end if;

  annotation (Icon(
      graphics={
        Line( points={{-20,0},{20,0}},
          color={28,108,200},
          thickness=0.5),
        Line(points={{2,58},{0,58}}, color={28,108,200}),
        Line(
          points={{0,0},{0,60}},
          color={162,29,33},
          arrow={Arrow.Filled,Arrow.None},
          arrowSize = 20)},
      coordinateSystem(preserveAspectRatio=false)),
     Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This connector can be used to connect a unidirectional inlet to a undirected fore port. </p>
<p>The state from the forward direction of the rear port is handed to the outlet, the total pressure as well as the massflow of outlet and port are set equal. </p>
<p>Note that when the flow is reversed, the resulting inertial pressure can be different on both sides of this connector. </p>
<p>Since the unidirectional side of this connector is an oulet, there is no information about the rear state from this side. This information must be given by the StateInlet.</p>
</html>"));
end ConnectRearOutlet;
