within ThermofluidStream.Undirected.Topology;
model JunctionMN "Generalized junction/splitter for undirected flow"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model for the Junction" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>This is the replaceable package that determines the medium of the Junction. Make sure it fits the medium in all models connected to the ports of the Junction.</p>
</html>"));

  parameter Integer N(min=0) = 1 "Number of rears";
  parameter Integer M(min=0) = 1 "Number of fors";
  parameter Boolean assumeConstantDensity = true "If true only mass-flow rate will determine the mixing"
    annotation (Dialog(tab="Advanced"));
  parameter Utilities.Units.Inertance L = dropOfCommons.L "Inertance for each branch"
    annotation(Dialog(tab="Advanced"));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Regularization threshold of mass flow rate"
    annotation(Dialog(tab="Advanced"));

  Interfaces.Rear rears[N](redeclare package Medium = Medium) "Rear ports"
      annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={-100,0}),
        iconTransformation(extent={{-20,-20},{20,20}}, origin={-100,0})));
  Interfaces.Fore fores[M](redeclare package Medium = Medium) "Fore ports"
      annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={100,0}),
        iconTransformation(extent={{-20,-20},{20,20}}, origin={100,0})));

  SI.Pressure p_mix "mixing p assuming positive massflow";

protected
  outer DropOfCommons dropOfCommons;

  SI.Pressure rs[M+N] "rs of the connectors internal of L";
  SI.Pressure r_mix "mixed r assuming positive massflow";

  SI.MassFlowRate inflows[M+N] "massflows assuming positive massflow";
  SI.Density rhos[M+N] "density at inlets";

  SI.Pressure ps[M+N] "pressure of medium entering";
  SI.Pressure ps_out[M+N] "pressure of medium exeting";

  SI.SpecificEnthalpy hs[M+N] "specific enthalpy of medium entering";
  SI.SpecificEnthalpy hs_out[M+N] "specific enthalpy of medium exeting";

  Medium.MassFraction Xis[Medium.nXi,M+N] "mass fraction of medium entering";
  Medium.MassFraction Xis_out[Medium.nXi,M+N] "mass fraction of medium exeting";

equation
  // rears are 1:N
  der(rears.m_flow)*L = rears.r-rs[1:N];
  for i in 1:N loop
     // inputs ports
    Xis[:,i] = Medium.massFraction(rears[i].state_forwards);
    ps[i] = Medium.pressure(rears[i].state_forwards);
    hs[i] = Medium.specificEnthalpy(rears[i].state_forwards);
    rhos[i] = Medium.density(rears[i].state_forwards);
    // inflows, p_equation and set output
    inflows[i] = max(rears[i].m_flow, m_flow_reg);
    Internal.regStep(rears[i].m_flow, ps[i], ps_out[i], m_flow_reg) + rs[i] = p_mix + r_mix;
    rears[i].state_rearwards = Medium.setState_phX(ps_out[i],hs_out[i],Xis_out[:,i]);
  end for;

  // fores are N+1:end
  der(fores.m_flow)*L = fores.r-rs[N+1:end];
  for i in 1:M loop
     // inputs ports
    Xis[:,N+i] = Medium.massFraction(fores[i].state_rearwards);
    ps[N+i] = Medium.pressure(fores[i].state_rearwards);
    hs[N+i] = Medium.specificEnthalpy(fores[i].state_rearwards);
    rhos[N+i] = Medium.density(fores[i].state_rearwards);
    // inflows, p_equation and set output
    inflows[N+i] = max(fores[i].m_flow, m_flow_reg);
    Internal.regStep(fores[i].m_flow, ps[N+i], ps_out[N+i], m_flow_reg) + rs[N+i] = p_mix + r_mix;
    fores[i].state_forwards = Medium.setState_phX(ps_out[N+i],hs_out[N+i],Xis_out[:,N+i]);
  end for;

  // Mass balance
  sum(rears.m_flow) + sum(fores.m_flow) = 0;
  //compute p_mix for rs computation
  if assumeConstantDensity then
    p_mix =(ps*inflows)/sum(inflows);
  else
    p_mix =(ps*(inflows./rhos))/sum((inflows./rhos));
  end if;

  // compute output quantities
  for i in 1:M+N loop
    Xis_out[:,i] = (Xis*inflows - Xis[:,i]*inflows[i]) /(sum(inflows) - inflows[i]);
    hs_out[i] = (hs*inflows - hs[i]*inflows[i]) /(sum(inflows) - inflows[i]);
    ps_out[i] = (ps*inflows - ps[i]*inflows[i]) /(sum(inflows) - inflows[i]);
  end for;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-84,0},{84,0}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-6,6},{6,-6}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{60,20},{100,60}},
          textColor={175,175,175},
          textString="%M"),
        Text(
          extent={{-100,20},{-60,60}},
          textColor={175,175,175},
          textString="%N")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model represents a generalized junction/splitter for undirected flow with N rear and M fore ports. </p>
<p>Note that in the undirected case a distinction between junction and splitter is not possible, since the flow direction is unknown in advance. </p>
</html>"));
end JunctionMN;
