within ThermofluidStream.Topology;
model JunctionN "Junction with N inlets and one outlet"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));

  parameter Integer N(min=1) = 1 "Number of inlets";
  parameter Boolean assumeConstantDensity = true "= true, if mixture states are determined by mass flow rates"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.MassFlowRate m_flow_eps = dropOfCommons.m_flow_reg "Regularization threshold for small mass flows"
    annotation (Dialog(tab="Advanced"));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance of each inlet/outlet"
    annotation (Dialog(tab="Advanced"));

  Interfaces.Inlet inlets[N](redeclare package Medium = Medium) "Vector of N inlets"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
      iconTransformation(extent={{-120,-20},{-80,20}})));
  Interfaces.Outlet outlet(redeclare package Medium = Medium) "Outlet"
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
      iconTransformation(extent={{80,-20},{120,20}})));

  // used by DynamicJunctionN
  output Real w[N](each unit="1") "Regularized weighting factor for specific enthalpy";
  output SI.Density rho[N] = Medium.density(inlets.state) "Density at inlets";

protected
  SI.Pressure p[N] = Medium.pressure(inlets.state) "(Steady mass-flow) pressure at inlets";
  SI.SpecificEnthalpy h[N] =  Medium.specificEnthalpy(inlets.state) "Specific enthapy at inlets";
  Medium.MassFraction Xi[Medium.nXi,N] "Mass factions at inlets";

  SI.Pressure p_mix "Outlet (steady mass-flow) pressure";
  SI.Pressure r_mix "Outlet inertial pressure";
  SI.SpecificEnthalpy h_mix "Outlet specific enthalpy";
  Medium.MassFraction Xi_mix[Medium.nXi] "Outlet mass fractions";

  Real w2[N](each unit="1") "Regularized weighting factors for steady mass flow pressure";

  SI.Pressure r_in[N] "Inertial pressure of inlets";

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

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,65},{150,25}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
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
          extent={{-120,-20},{-80,-60}},
          textColor={175,175,175},
          textString="%N")}),
      Diagram(coordinateSystem(preserveAspectRatio=true)));
end JunctionN;
