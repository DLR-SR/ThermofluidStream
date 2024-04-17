within ThermofluidStream.Examples.Utilities;
model Piston "Piston model with steam on both sides"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model"
    annotation (Documentation(info="<html>
<p>Model of the medium in the Piston. The medium is typically Two-phase.</p>
</html>"));

  parameter ThermofluidStream.Utilities.Units.Inertance L = dropOfCommons.L "Inertance at inlet and outlet"
    annotation (Dialog(tab="Advanced"));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Regularization threshold of mass flow rate"
    annotation(Dialog(tab="Advanced"));

  parameter SI.Area A "Area of piston";
  parameter SI.Length l_stroke "Stroke length of motion";
  parameter SI.Volume V_dead "Dead volume at both ends";
  parameter Boolean outputX = false "Enable piston position output";

  parameter Boolean initializeX = true "Initialize piston position"
    annotation(Dialog(tab="Initials"));
  parameter SI.Pressure p0_left = 1e5 "Left side initial temperature"
    annotation(Dialog(tab="Initials"));
  parameter SI.Pressure p0_right = 1e5 "Right side initial temperature"
    annotation(Dialog(tab="Initials"));
  parameter SI.Mass m0_left = 2 "Left side initial mass"
    annotation(Dialog(tab="Initials"));
  parameter SI.Mass m0_right = 2 "Right side initial mass"
    annotation(Dialog(tab="Initials"));
  parameter SI.Length x0(min=0, max=1) = 0.5 "Initial piston position"
    annotation(Dialog(tab="Initials", enable=initializeX));

  Undirected.Interfaces.Rear port_left(
    redeclare package Medium = Medium,
    r=r_left_port,
    m_flow=m_flow_left,
    state_rearwards=medium_left.state,
    state_forwards=state_in_left) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        origin={-100,42},
        rotation=-90), iconTransformation(
        extent={{-20,-20},{20,20}},
        origin={-100,42},
        rotation=-90)));
  Undirected.Interfaces.Rear port_right(
    redeclare package Medium = Medium,
    r=r_right_port,
    m_flow=m_flow_right,
    state_rearwards=medium_right.state,
    state_forwards=state_in_right) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        origin={100,42},
        rotation=90), iconTransformation(
        extent={{-20,-20},{20,20}},
        origin={100,42},
        rotation=90)));
  Modelica.Mechanics.Translational.Interfaces.Flange_a flange
    annotation(Placement(transformation(extent={{-10,-10},{10,10}}, origin={100,0}, rotation=0),
      iconTransformation(extent={{-10,-10},{10,10}}, origin={100,0}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput x_out(unit="") = x if outputX "Unitless piston position []"
    annotation(Placement(transformation(extent={{-10,-10},{10,10}}, origin={60,-48}, rotation=-90),
      iconTransformation(extent={{-10,-10},{10,10}}, origin={60,-48}, rotation=-90)));

  Medium.ThermodynamicState state_in_left, state_in_right;
  SI.MassFlowRate m_flow_left, m_flow_right;
  SI.Pressure r_left_port, r_right_port;
  SI.Pressure r_left_intern=ThermofluidStream.Undirected.Internal.regStep(
      m_flow_left,
      medium_left.p - Medium.pressure(state_in_left),
      0,
      m_flow_reg);
  SI.Pressure r_right_intern=ThermofluidStream.Undirected.Internal.regStep(
      m_flow_right,
      medium_right.p - Medium.pressure(state_in_right),
      0,
      m_flow_reg);

  SI.EnthalpyFlowRate H_flow_left = (if noEvent(m_flow_left >= 0) then Medium.specificEnthalpy(state_in_left) else medium_left.h) * m_flow_left;
  SI.EnthalpyFlowRate H_flow_right = (if noEvent(m_flow_right >= 0) then Medium.specificEnthalpy(state_in_right) else medium_right.h) * m_flow_right;
  SI.MassFlowRate Xi_flow_left[Medium.nXi] = (if noEvent(m_flow_left >= 0) then Medium.massFraction(state_in_left) else medium_left.Xi) * m_flow_left;
  SI.MassFlowRate Xi_flow_right[Medium.nXi] = (if noEvent(m_flow_right >= 0) then Medium.massFraction(state_in_right) else medium_right.Xi) * m_flow_left;

  //states
  SI.Mass M_left;
  SI.Mass M_right;
  Medium.BaseProperties medium_left;
  Medium.BaseProperties medium_right;
  Real x(unit="1", min=0, max=1);
  SI.Length l = x*l_stroke;

protected
  outer DropOfCommons dropOfCommons;

initial equation
 medium_left.p = p0_left;
 medium_right.p = p0_right;
 M_left = m0_left;
 M_right = m0_right;
 if initializeX then
   x = x0;
 end if;

equation
  der(m_flow_left)*L = r_left_port - r_left_intern;
  der(m_flow_right)*L = r_right_port - r_right_intern;

  flange.f = noEvent(A*(medium_right.p-medium_left.p) + (if x>=1 then 1e5*(exp((x-1)*100)-1) else 0) - (if x<=0 then 1e5*(exp((-x)*100)-1) else 0));
  flange.s = l;

  medium_left.d = M_left/(V_dead + l*A);
  medium_right.d = M_right/(V_dead + (l_stroke-l)*A);

  der(M_left) = m_flow_left;
  der(M_right) = m_flow_right;

  der(M_left*medium_left.u)   = -medium_left.p*A*der(l) + H_flow_left;
  der(M_right*medium_right.u) =  medium_right.p*A*der(l) + H_flow_right;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false),
    graphics={
      Rectangle(
        extent={{-76,-34},{84,26}},
        fillColor={215,215,215},
        fillPattern=FillPattern.Solid,
        pattern=LinePattern.None),
      Rectangle(
        extent={{-80,-30},{80,30}},
        lineColor={28,108,200},
        fillColor={255,255,255},
        lineThickness=0.5,
        fillPattern=FillPattern.Solid,
        pattern=LinePattern.Solid),
      Line(
        points={{-50,30},{-50,-30}},
        color={28,108,200},
        pattern=LinePattern.Solid),
      Rectangle(
        extent={{-60,-25},{-40,25}},
        lineColor={28,108,200},
        fillColor={255,255,255},
        lineThickness=0.5,
        fillPattern=FillPattern.Solid,
        pattern=LinePattern.Solid),
      Rectangle(
        extent={{-40,-5},{90,5}},
        lineColor={28,108,200},
        fillColor={255,255,255},
        lineThickness=0.5,
        fillPattern=FillPattern.Solid,
        pattern=LinePattern.Solid),
        Line(
          points={{-100,42},{-80,30}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{80,30},{100,42}},
          color={28,108,200},
          thickness=0.5)}),
    Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
In a piston a different pressure of fluids perform mechanical linear work.
</p>
<p>
Depending on <code>push_left</code>, the left (when pushleft is true) side or
the right (when pushleft is false) side is connected to the input, and the other
side is connected to the output.
</p>
<p>
<code>x</code> is a nondimensional piston position, 0 being left and 1 being right.
</p>
<p>
The piston has soft stops and a dead volume at both ends.
</p>
</html>"));
end Piston;
