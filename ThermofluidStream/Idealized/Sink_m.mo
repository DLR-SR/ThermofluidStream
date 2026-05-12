within ThermofluidStream.Idealized;
model Sink_m "Sink (m_flow)"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  import ValueSpecification = ThermofluidStream.Idealized.Utilities.Types.ValueSpecification;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Sink. Make sure it is the same as the one
the outlet the sink is connected to.
</p>
</html>"));
  parameter ValueSpecification m_flowSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Fixed "Method for specifying the value of the mass flow rate" annotation (Dialog(group="Specification"), Evaluate=true);
  parameter SI.MassFlowRate m_flow_fixed = 0 "Fixed mass flow rate"
    annotation(Dialog(group="Mass flow rate",
      enable = m_flowSpec == ValueSpecification.Fixed),
      HideResult = not m_flowSpec == ValueSpecification.Fixed);
  parameter ThermofluidStream.Utilities.Units.Inertance L=dropOfCommons.L "Inertance"
    annotation (Dialog(tab="Advanced", enable = not neglectInertance), HideResult = neglectInertance);
  parameter Boolean neglectInertance = true "=true, if mass flow rate dynamics are neglected - advanced mode!"
    annotation(Dialog(tab="Advanced"), Evaluate=true, HideResult=true);
  parameter Boolean showMassFlowRate = true "= true to show the fixed mass flow rate value m_flow_fixed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable = displayParameters and m_flowSpec == ValueSpecification.Fixed), Evaluate=true, HideResult=true, choices(checkBox=true));

  ThermofluidStream.Interfaces.Inlet inlet(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_prescribed(unit="kg/s") if m_flowSpec == ValueSpecification.Prescribed "Prescribed mass flow rate [kg/s]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation=180,origin={20,0})));

  Medium.AbsolutePressure p = Medium.pressure(inlet.state) "Steady state pressure"
    annotation(HideResult=true);
  SI.Pressure r "Inertial pressure"
    annotation(HideResult=true);

protected
  Modelica.Blocks.Interfaces.RealInput m_flow(unit="kg/s") "Mass flow rate [kg/s], required due to the conditional connector m_flow_prescribed";

equation
  connect(m_flow_prescribed, m_flow);
  if m_flowSpec == ValueSpecification.Fixed then
    m_flow = m_flow_fixed;
  end if;

  if not neglectInertance then
    der(inlet.m_flow)*L = inlet.r - r;
  else
    0 = inlet.r - r;
  end if;

  //r + p = p0;
  inlet.m_flow = m_flow;

  annotation (defaultComponentName="sink", Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Text(visible=displayParameters and showMassFlowRate and m_flowSpec == ThermoFluidStreamPlus.Types.ValueSpecification.Fixed,
          extent={{-150,-90},{150,-120}},
          textColor={0,0,0},
          textString="ṁ = %m_flow_fixed"),
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
        Line(points={{-44,80},{-44,-80}}, color={255,255,255})}),
                                            Diagram(
        coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
  <p>
    Model of a mass flow rate boundary condition.
  </p>
  
  <p>
    The outlet pressure is not a boundary condition.
  </p>

  <p>
    Discontinuous mass flow rates require <code>neglectInertance = true</code>. 
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Sink_m;
