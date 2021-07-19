within ThermofluidStream.Undirected.FlowControl;
model MCV "Massflow control valve"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
    <p>Medium package used in the Component. Make sure it is the same as the one both ports are connected to.</p>
</html>"));

  Interfaces.Fore fore(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
        iconTransformation(extent={{80,-20},{120,20}})));
  Interfaces.Rear rear(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_set_var(unit="kg/s") = m_flow_set if massFlowFromInput "Desired mass-flow [kg/s]"
    annotation (Placement(
        transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80}),                           iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80})));

  parameter Utilities.Units.Inertance L = dropOfCommons.L "Inertance of the flow"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean massFlowFromInput = false "Enable desired massFlow input";
  parameter SI.MassFlowRate m_flow_set_par "Mass flow variable to set";
  parameter SI.MassFlowRate m_flow_ref = 0.1 "Reference mass flow";
  parameter SI.Pressure p_ref = 1e5 "Reference pressurre";
  parameter SI.Time TC = 0.1 "Time constant of pressure adaptation"
    annotation(Dialog(tab="Advanced"));

protected
  outer DropOfCommons dropOfCommons;

  SI.MassFlowRate m_flow_set;
  SI.MassFlowRate m_flow = rear.m_flow;

  SI.SpecificEnthalpy h_in_rear = Medium.specificEnthalpy(rear.state_forwards);
  SI.Pressure p_in_rear = Medium.pressure(rear.state_forwards);
  Medium.MassFraction Xi_in_rear[Medium.nXi] = Medium.massFraction(rear.state_forwards);

  SI.SpecificEnthalpy h_in_fore = Medium.specificEnthalpy(fore.state_rearwards);
  SI.Pressure p_in_fore = Medium.pressure(fore.state_rearwards);
  Medium.MassFraction Xi_in_fore[Medium.nXi] = Medium.massFraction(fore.state_rearwards);

  SI.Pressure dp(start=0);
  SI.Pressure dr_corr;

equation
  if not massFlowFromInput then
    m_flow_set = m_flow_set_par;
  end if;

  dr_corr = min(dp,0);

  rear.m_flow + fore.m_flow = 0;
  rear.r  - fore.r -  dr_corr  = (der(m_flow) + (m_flow-m_flow_set)/TC)*L;
  der(dp)*TC =  fore.r - rear.r;

  fore.state_forwards = Medium.setState_phX(p_in_rear-dp,h_in_rear,Xi_in_rear);
  rear.state_rearwards = Medium.setState_phX(p_in_fore+dp,h_in_fore,Xi_in_fore); // + because of the inverted direction

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-56,54},{64,-66}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-70,0},{80,0}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{40,0},{-48,0}},
          color={28,108,200},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Line(
          points={{-52,-30},{52,-30}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-52,30},{52,30}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{0,60}},
          color={28,108,200},
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Undirected implementation of MCV.</p>
<p>This component can be used to emulate a mass-flow regulated valve. </p>
<p><span style=\"color: #ff0000;\">Currently not working!</span></p>
</html>"));
end MCV;
