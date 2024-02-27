within ThermofluidStream.Boundaries;
model TerminalSource "Source that imposes m_flow = 0"

  extends ThermofluidStream.Utilities.DisplayComponentNameIndividually; //Define the display of the component name for your component.

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Source. Make sure it is the same as the one
the inlet the source is connected to.
</p>
</html>"));

  parameter SI.Time TC = 0.1 "Time constant for pressure adaption"
    annotation(Dialog(tab="Advanced"));
  parameter SI.SpecificEnthalpy h = Medium.h_default "Source enthalpy";
  parameter Medium.MassFraction[Medium.nXi] Xi = Medium.X_default[1:Medium.nXi] "Source mass fraction";
  parameter SI.Pressure p_0 = Medium.p_default "Initial pressure";

  Interfaces.Outlet outlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}}), iconTransformation(extent={{80,-20},{120,20}})));

protected
  SI.Pressure p(stateSelect=StateSelect.prefer);

initial equation
  p = p_0;

equation
  outlet.m_flow = 0;

  TC * der(p) = outlet.r;
  outlet.state = Medium.setState_phX(p, h, Xi);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Text(visible=displayComponentName,
          extent={{-150,60},{150,100}},
          textString="%name",
          textColor={0,0,255}),
        Rectangle(
          extent={{34,26},{74,-34}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{50,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Rectangle(
          extent={{30,30},{70,-30}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{70,30},{30,-30}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{30,30},{70,-30}},
          color={28,108,200},
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Source that terminates the flow. </p>
<p>It imposes a m_flow=0 boundary and with a time constant, adapts the pressure such that the inertial pressure r goes to zero.</p>
</html>"));
end TerminalSource;
