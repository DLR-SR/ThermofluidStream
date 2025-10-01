within ThermofluidStream.Processes.Tests.Utilities;
model Sink_m "Sink (m_flow)"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Sink. Make sure it is the same as the one
the outlet the sink is connected to.
</p>
</html>"));
  parameter Boolean massFlowFromInput = false "= true, if mass flow rate input connector is enabled"
    annotation(Dialog(group="Pressure"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Modelica.Units.SI.MassFlowRate m_flow_par=0 "Mass flow rate set value" annotation (Dialog(group="Pressure", enable=not pressureFromInput));
  parameter ThermofluidStream.Utilities.Units.Inertance L=dropOfCommons.L "Inertance"
    annotation (Dialog(tab="Advanced"));

  // ------ Parameter Display Configuration  ------------------------
  parameter Boolean displayMassFlowRate = true "= true, if mass flow rate m_flow is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters and not pressureFromInput),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter Boolean displayM = displayMassFlowRate and not massFlowFromInput
    annotation(Evaluate=true, HideResult=true);
  final parameter String displayPos1=
    if displayM then
      "m_flow = %m_flow_par"
    else "";
  //-----------------------------------------------------------------

  ThermofluidStream.Interfaces.Inlet inlet(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_var(unit="kg/s") if massFlowFromInput "Mass flow rate input connector [kg/s]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation=180,origin={20,0})));

protected
  Modelica.Blocks.Interfaces.RealInput m_flow(unit="kg/s") "Internal mass flow rate connector";
  Modelica.Units.SI.Pressure r "Inertial pressure";
  Modelica.Units.SI.Pressure p=Medium.pressure(inlet.state) "Steady state pressure";

equation
  connect(m_flow_var, m_flow);
  if not massFlowFromInput then
    m_flow = m_flow_par;
  end if;

  der(inlet.m_flow)*L = inlet.r - r;
  //r + p = p0;
  inlet.m_flow = m_flow;

  annotation (defaultComponentName="sink", Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Text(visible=displayParameters,
          extent={{-150,-90},{150,-120}},
          textColor={0,0,0},
          textString=displayPos1),
        Rectangle(
          extent={{-56,76},{4,-84}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-60,80},{0,-80}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-100,0},{-60,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-60,80},{-60,-80}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-12,80},{-12,-80}},
          color={255,255,255},
          thickness=1),
        Line(
          points={{-28,80},{-28,-80}},
          color={255,255,255},
          thickness=0.5),
        Line(points={{-44,80},{-44,-80}}, color={255,255,255})}), Diagram(
        coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>

<p>
  Adaptation of 
  <a href=\"modelica://ThermofluidStream.Boundaries.Sink\">TFS Sink</a>, 
  allowing the specification of the mass flow rate at the sink.
</p>

<p>
  The mass flow rate must be continuously differentiable and free of discontinuities to ensure numerical stability and solver convergence.
</p>
<p>
  From a physical perspective, it is often preferable to impose pressure boundary conditions at the sink and control the mass flow rate by adjusting the source or sink pressure.
</p>



</html>"));
end Sink_m;
