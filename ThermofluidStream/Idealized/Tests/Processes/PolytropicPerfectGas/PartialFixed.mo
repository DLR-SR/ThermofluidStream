within ThermofluidStream.Idealized.Tests.Processes.PolytropicPerfectGas;
model PartialFixed "Parameter definition"
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium annotation(
    choicesAllMatching = true);
  parameter Medium.AbsolutePressure p_in=100000 "Inlet pressure";
  parameter Medium.Temperature T_in=293.15 "Inlet temperature";
  parameter Real pRatio=2  "Fixed pressure ratio (pRatio = p_out/p_in)";
  parameter SI.Efficiency eta_is=0.9 "Fixed isentropic efficiency";
  parameter SI.MassFlowRate m_flow=0   "Fixed mass flow rate";

  final parameter Medium.ThermodynamicState state_in = Medium.setState_pTX(p_in, T_in, Medium.X_default) "Inlet state";
  final parameter Medium.Density rho_in = Medium.density(state_in) "Inlet density";
  final parameter SI.SpecificVolume v_in = 1/rho_in "Inlet specific volume";
  final parameter Medium.IsentropicExponent gamma = Medium.isentropicExponent(state_in) "Isentropic exponent";
  final parameter Real R(final unit = "J/(kg.K)") = Modelica.Constants.R/Medium.molarMass(state_in) "Specific gas constant";
  final parameter Medium.SpecificHeatCapacity cp = Medium.specificHeatCapacityCp(state_in) "Specific heat capacity at constant pressure";

  final parameter Medium.AbsolutePressure p_out = p_in*pRatio "Fixed outlet pressure";
  final parameter SI.PressureDifference dp = p_out - p_in "Fixed pressure difference (dp = p_out - p_in)";
  final parameter Medium.Temperature T_out_is = T_in*(p_out/p_in)^((gamma-1)/gamma);
  final parameter Medium.Temperature T_out = if pRatio >= 1 then T_in + 1/eta_is*(T_out_is - T_in) else T_in + eta_is*(T_out_is - T_in) "Fixed outlet temperature";
  final parameter Medium.Density rho_out = p_out/(R*T_out) "Fixed outlet density";
  final parameter Real rhoRatio = rho_out/rho_in "Fixed compression ratio";
  final parameter SI.SpecificVolume v_out=1/rho_out "Fixed outlet specific volume";

  final parameter Real gamma_aux = gamma/(gamma - 1);
  final parameter Real n_aux = if abs(pRatio - 1) > Modelica.Constants.eps then log(pRatio)/log(T_out/T_in) else gamma_aux;
  final parameter Real n = n_aux/(n_aux -1)  "Fixed polytropic exponent"; // n_aux = n/(n-1)

  final parameter Real eta_pol = if pRatio >= 1 then n_aux/gamma_aux else gamma_aux/n_aux "Fixed polytropic efficiency";
  final parameter SI.SpecificEnthalpy w_t = cp*(T_out - T_in) "Fixed specific technical work";
  final parameter SI.Power P = m_flow*w_t "Fixed power";

  annotation (Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    Base class.
  </p>
</html>"));
end PartialFixed;
