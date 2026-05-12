within ThermofluidStream.Idealized.Topology.BaseClasses;
partial model Junction "Partial junction"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus(displayInstanceName = false);

  import Specification = ThermofluidStream.Idealized.Topology.Types.FreeJunctionInlet;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));
  parameter Specification free =ThermofluidStream.Idealized.Topology.Types.FreeJunctionInlet.A      "Free inlet"
    annotation(choices(__Dymola_radioButtons=true,
    choice = ThermoFluidStream.Idealized.Topology.Types.FreeJunctionInlet.A "A",
    choice = ThermoFluidStream.Idealized.Topology.Types.FreeJunctionInlet.B "B"),Evaluate=true);
  parameter SI.MassFlowRate m_flow_eps = dropOfCommons.m_flow_reg "Regularization threshold for small mass flows"
    annotation (Dialog(tab="Advanced"));
  parameter ThermofluidStream.Utilities.Units.Inertance L=dropOfCommons.L "Inertance of each inlet/outlet"
    annotation (Dialog(tab="Advanced",
      enable = not neglectInertance),
      HideResult = neglectInertance);
  parameter Boolean neglectInertance = true "=true, if mass flow rate dynamics are neglected - advanced mode!"
    annotation(Dialog(tab="Advanced"),Evaluate=true, HideResult=true);
  parameter AssertionLevel assertionLevel = AssertionLevel.warning "Assertion level"
    annotation(Dialog(group="Warnings"));
  parameter Real relTol_dp_AB = 1e-3 "Relative tolerance for inlet pressure difference pA, pB"
    annotation(Dialog(group="Warnings"));
  final parameter String name = getInstanceName();

  //Real equalInletPressures "= 1.0 if within tolerance, = -1.0 if tolerance is exceeded";
  Real isDPWithinTol "= 1.0 if pressure difference is within tolerance, = -1.0 if tolerance is exceeded";
  Medium.ThermodynamicState stateA "Inlet A state";
  Medium.ThermodynamicState stateB "Inlet B state";
  SI.MassFlowRate m_flowA "Mass flow rate inlet A";
  SI.MassFlowRate m_flowB "Mass flow rate inlet B";

  // Regularized mass flow rates (used for mixing of specific enthalpy and mass fractions
  // stream connector would be necessary to model reverse flow correctly)
  SI.MassFlowRate m_flowA_reg = max(m_flowA,m_flow_eps) "Regularized mass flow rate";
  SI.MassFlowRate m_flowB_reg = max(m_flowB,m_flow_eps) "Regularized mass flow rate";
  Real dp_AB_rel "Relative difference in pressure at junction inlets";
  ThermofluidStream.Interfaces.Outlet outlet(redeclare package Medium = Medium) "Outlet"
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));

  Medium.SpecificEnthalpy h_mix "Outlet specific enthalpy";
  Medium.AbsolutePressure p_mix "Outlet (steady mass-flow) pressure";
  SI.Pressure r_mix "Outlet inertial pressure";
  Medium.MassFraction Xi_mix[Medium.nXi] "Outlet mass fractions";

protected
  Medium.AbsolutePressure pA = Medium.pressure(stateA) "(Steady mass-flow) pressure at inlet A";
  Medium.AbsolutePressure pB = Medium.pressure(stateB) "(Steady mass-flow) pressure at inlet B";

  Medium.SpecificEnthalpy hA =  Medium.specificEnthalpy(stateA) "Specific enthapy at inlet A";
  Medium.SpecificEnthalpy hB =  Medium.specificEnthalpy(stateB) "Specific enthapy at inlet B";

  Medium.MassFraction XiA[Medium.nXi] = Medium.massFraction(stateA) "Mass factions at inlet A";
  Medium.MassFraction XiB[Medium.nXi] = Medium.massFraction(stateB) "Mass factions at inlet B";

  Real wA(unit="1") "Regularized weighting factor for specific enthalpy and mass fractions A";
  Real wB(unit="1") "Regularized weighting factor for specific enthalpy and mass fractions B";

  SI.Pressure rA2 "Inertial pressure A (at junction)";
  SI.Pressure rB2 "Inertial pressure B (at junction)";

  SI.Pressure rA "Inertial pressure of inlet A";
  SI.Pressure rB "Inertial pressure of inlet B";

equation
  m_flowA + m_flowB + outlet.m_flow = 0;
  if not neglectInertance then
    der(m_flowA) * L = rA - rA2;
    der(m_flowB) * L = rB - rB2;
  else
    0 = rA - rA2;
    0 = rB - rB2;
  end if;

  if free == Specification.A then
    pB + rB2 = p_mix + r_mix;
    p_mix = pB;
  else
    pA + rA2 = p_mix + r_mix;
    p_mix = pA;
  end if;

  wA = m_flowA_reg / (m_flowA_reg + m_flowB_reg);
  wB = m_flowB_reg / (m_flowA_reg + m_flowB_reg);

  if not neglectInertance then
    der(outlet.m_flow) * L =  outlet.r - r_mix;
  else
   0 =  outlet.r - r_mix;
  end if;

  h_mix = hA*wA + hB*wB;
  Xi_mix = XiA*wA + XiB*wB;

  outlet.state = Medium.setState_phX(p_mix,h_mix,Xi_mix);

  dp_AB_rel = abs(pA + rA2 - (pB + rB2))/max(pA + rA2, pB + rB2);
  isDPWithinTol = sign(relTol_dp_AB  - dp_AB_rel);
  assert(noEvent(dp_AB_rel  <= relTol_dp_AB),
    "In \"" + name +"\" the inlet pressures differ beyond the specified tolerance.",
    assertionLevel);

  annotation (defaultComponentName = "junction", Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Line(
          points={{-2,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-20,20},{20,-20}},
          fillColor= DynamicSelect({170,213,255},{204 -34*isDPWithinTol, 129.5 + 83.5*isDPWithinTol, 151 + 104*isDPWithinTol}),
          lineColor= DynamicSelect({28,108,200},{14 + 14*isDPWithinTol, 54 + 54*isDPWithinTol, 100 + 100*isDPWithinTol}),
          fillPattern=FillPattern.Solid,
          lineThickness=0.5)}),
      Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    Base model for ideal junction that should be used when the mass flow rate is specified at one or both inlets. 
  </p>
  <p>
    The model is locally underdetermined (one equation missing) and therefore must be connected to an overdetermined component 
    (e.g., <a href=\"modelica://ThermoFluidStream.Idealized.Sources.MassFlowRate\">MassFlowRate</a>) 
    to ensure that the overall system is not underdetermined.
  </p>
</html>"));
end Junction;
