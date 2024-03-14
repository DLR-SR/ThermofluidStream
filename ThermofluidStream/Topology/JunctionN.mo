within ThermofluidStream.Topology;
model JunctionN "Junction with N inlets and one outlet"
  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));

  parameter Integer N(min=1) = 1 "Number of inlets";
  parameter Boolean assumeConstantDensity = true "If true only mass-flow rate will determine the mixing";
  parameter SI.MassFlowRate m_flow_eps = dropOfCommons.m_flow_reg "Regularization threshold for small mass flows"
    annotation (Dialog(tab="Advanced"));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance on each Branch of Component"
    annotation (Dialog(tab="Advanced"));

  Interfaces.Inlet inlets[N](redeclare package Medium = Medium) "vector of N inlets"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
      iconTransformation(extent={{-120,-20},{-80,20}})));
  Interfaces.Outlet outlet(redeclare package Medium = Medium) "outlet"
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
      iconTransformation(extent={{80,-20},{120,20}})));

  // these are needed by DynamicJunctionN
  output Real w[N](each unit="1") "regularized weighting factor for specific enthalpy";
  output SI.Density rho[N] = Medium.density(inlets.state) "density at inlets";

protected
  outer DropOfCommons dropOfCommons;

  SI.Pressure p[N] = Medium.pressure(inlets.state) "(steady mass-flow) pressure at inlets";
  SI.SpecificEnthalpy h[N] =  Medium.specificEnthalpy(inlets.state) "specific enthapy at inlets";
  Medium.MassFraction Xi[Medium.nXi,N] "mass factions at inlets";

  SI.Pressure p_mix "(steady mass-flow) pressure at the outlet";
  SI.Pressure r_mix "inertial pressure at outlet";
  SI.SpecificEnthalpy h_mix "specific enthalpy at outlet";
  Medium.MassFraction Xi_mix[Medium.nXi] "medium composition at outlet";

  Real w2[N](each unit="1") "regularized weighting factor for steady mass flow pressure";

  SI.Pressure r_in[N];

  function mfk = Utilities.Functions.massFractionK(redeclare package Medium = Medium);

equation
  sum(inlets.m_flow) + outlet.m_flow = 0;

  for i in 1:N loop
    der(inlets[i].m_flow) * L = inlets[i].r - r_in[i];

    // OM_WORKAROUND
    for j in 1:Medium.nXi loop
      Xi[j,i] = mfk(inlets[i].state, j);
    end for;
    //instead of
    /* Xi[:,i] = Medium.massFraction(inlets[i].state); */

    p[i] + r_in[i] = p_mix + r_mix;
    w[i] = (abs(inlets[i].m_flow)+m_flow_eps) / (sum(abs(inlets.m_flow))+N*m_flow_eps);
    w2[i] = ((abs(inlets[i].m_flow) + m_flow_eps)/rho[i]) / (sum((abs(inlets.m_flow) + m_flow_eps*ones(N))./rho));
  end for;
  der(outlet.m_flow) * L =  outlet.r - r_mix;

  if not assumeConstantDensity then
    p_mix = sum(w2.*p);
  else
    p_mix = sum(w.*p);
  end if;
  h_mix = sum(w.*h);
  Xi_mix = Xi*w;

  outlet.state = Medium.setState_phX(p_mix,h_mix,Xi_mix);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-100,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{-100,10}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{-100,-10}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-6,6},{6,-6}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{-90,80},{-50,40}},
          textColor={175,175,175},
          textString="%N")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
end JunctionN;
