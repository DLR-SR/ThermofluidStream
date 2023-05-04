within ThermofluidStream.Undirected.Boundaries;
model TerminalFore "Rear Boundary that imposes m_flow = 0"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Source. Make sure it is the same as
the one the inlet the source is connected to.
</p>
</html>"));

  parameter SI.Time TC = 0.1 "Time constant for pressure adaption"
    annotation(Dialog(tab="Advanced"));
  parameter SI.SpecificEnthalpy h = Medium.h_default "Source enthalpy";
  parameter Medium.MassFraction[Medium.nXi] Xi = Medium.X_default[1:Medium.nXi] "Source mass fraction";
  parameter SI.Pressure p_0 = Medium.p_default "Initial pressure";

  Interfaces.Rear rear(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
                                                                      iconTransformation(extent={{-120,-20},{-80,20}})));

protected
  SI.Pressure p(stateSelect=StateSelect.prefer);

initial equation
  p = p_0;

equation
  rear.m_flow = 0;

  TC * der(p) =rear.r;
  rear.state_rearwards = Medium.setState_phX(p, h, Xi);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-20,30},{20,-30}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={-46,-4},
          rotation=360),
        Line(
          points={{-10,0},{6,0}},
          color={28,108,200},
          thickness=0.5,
          origin={-74,0},
          rotation=360),
        Rectangle(
          extent={{-20,30},{20,-30}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={-50,0},
          rotation=360),
        Line(
          points={{20,30},{-20,-30}},
          color={28,108,200},
          thickness=0.5,
          origin={-50,0},
          rotation=360),
        Line(
          points={{-20,30},{20,-30}},
          color={28,108,200},
          thickness=0.5,
          origin={-50,0},
          rotation=360)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Fore Boundary that terminates the flow. The boundary has to be connected to the fore end of your model and therefore has a rear port.</p>
<p>It imposes a m_flow=0 boundary and with a time constant, adapts the pressure such, that inertial pressure r goes to zero.</p>
</html>"));
end TerminalFore;
