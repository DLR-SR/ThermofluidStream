within ThermofluidStream.Undirected.Topology;
model ConnectInletFore
  "Uni/Bidirectional connector with input and fore"

  replaceable package Medium = myMedia.Interfaces.PartialMedium "Medium of the connection"
    annotation (Documentation(info="<html>
<p>This is the replaceable package that determines the medium of the Connector. Make shure it fits the medium in all models connected to inlet and port of the Connector.</p>
</html>"));
  parameter Utilities.Units.Inertance L = dropOfCommons.L "Inertance"
    annotation(Dialog(tab="Advanced"));

  ThermofluidStream.Interfaces.Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={-30,0}),
        iconTransformation(extent={{-20,-20},{20,20}}, origin={-30,0})));
  Interfaces.Fore fore(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={30,0}),
        iconTransformation(extent={{-20,-20},{20,20}}, origin={30,0})));

protected
  outer DropOfCommons dropOfCommons;

  SI.Pressure r_fore, r_inlet;

equation
  fore.state_forwards = inlet.state;

  fore.m_flow + inlet.m_flow = 0;
  r_inlet + Medium.pressure(inlet.state) = r_fore + Internal.regStep(inlet.m_flow, Medium.pressure(inlet.state), Medium.pressure(fore.state_rearwards), dropOfCommons.m_flow_reg);

  L/2*der(inlet.m_flow) = inlet.r - r_inlet;
  L/2*der(fore.m_flow) = fore.r - r_fore;

  annotation (Icon(
      graphics={
        Line( points={{-20,0},{20,0}},
          color={28,108,200},
          thickness=0.5)},
      coordinateSystem(preserveAspectRatio=false)),
     Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This connector can be used to connect a unidirectional outlet to a bidirectional rear port. </p>
<p>The state from the inlet is given to the forward direction of the fore port, the total pressure as well as the massflow of inlet and port are set equal. </p>
<p>Note that when the flow is reversed, the resulting inertial pressure can be different on both sides of this connector. </p>
</html>"));
end ConnectInletFore;
