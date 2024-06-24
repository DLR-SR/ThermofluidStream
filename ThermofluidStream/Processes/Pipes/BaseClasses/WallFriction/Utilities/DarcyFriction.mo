within ThermofluidStream.Processes.Pipes.BaseClasses.WallFriction.Utilities;
function DarcyFriction
  extends Modelica.Icons.Function;

  input Modelica.Units.SI.MassFlowRate m_flow "Mass flow rate";
  input Modelica.Units.SI.Length D_h "Hydraulic diameter";
  input Modelica.Units.SI.Length Delta(min = 0) "Relaitiv roughness";
  input Modelica.Units.SI.Density rho "Inlet density";
  input Modelica.Units.SI.DynamicViscosity mu "Dynamic viscosity";
  input Real Re1 "Lower boundary Re for laminar-turbulent transition regime";
  input Real Re2 "Upper boundary Re for laminar-turbulent transition regime";
  output Internal.Types.DarcyFrictionFactor lambda "Darcy friction factor";
protected
  Modelica.Units.SI.Area A_0 = pi/4*D_h^2;

  function interpolateInRegion2 "Interpolation in log-log space using a cubic Hermite polynomial, where x=log10(Re), y=log10(lambda2)"
    extends Modelica.Icons.Function;
    input Modelica.Units.SI.ReynoldsNumber Re "Known independent variable";
    input Modelica.Units.SI.ReynoldsNumber Re1 "Boundary between laminar regime and transition";
    input Modelica.Units.SI.ReynoldsNumber Re2 "Boundary between transition and turbulent regime";
    input Real Delta(min = 0) "Relative roughness";
    input Modelica.Units.SI.MassFlowRate m_flow "Mass flow rate from inlet to outlet";
    output Real lambda2 "Unknown return value";
    output Real dlambda2_dm_flow "Derivative of return value";
    // point lg(lambda2(Re1)) with derivative at lg(Re1)
  protected
    Real x1 = log10(Re1);
    Real y1 = log10(64*Re1);
    Real y1d = 1;
    // Point lg(lambda2(Re2)) with derivative at lg(Re2)
    Real aux2 = Delta/3.7 + 5.74/Re2^0.9;
    Real aux3 = log10(aux2);
    Real L2 = 0.25*(Re2/aux3)^2;
    Real x2 = log10(Re2);
    Real y2 = log10(L2);
    Real y2d = 2 + (2*5.74*0.9)/(log(aux2)*Re2^0.9*aux2);
    // Point of interest in transformed space
    Real x = log10(Re);
    Real y;
    Real dy_dx "Derivative in transformed space";
  algorithm
    // Interpolation
    (y,dy_dx) := ThermofluidStream.Processes.Pipes.Internal.Utilities.cubicHermite_withDerivative(
        x,
        x1,
        x2,
        y1,
        y2,
        y1d,
        y2d);
    // Return value
    lambda2 := 10^y;
    // Derivative of return value
    dlambda2_dm_flow := lambda2/abs(m_flow)*dy_dx;
    annotation (
      smoothOrder = 1);
  end interpolateInRegion2;

  SI.ReynoldsNumber Re "Reynolds Number";
  Real lambda2 "Modified friction coefficient (= lambda*Re^2)";
  Real dlambda2_dm_flow "dlambda2/dm_flow";
  Real aux1;
  Real aux2;
algorithm
  // determine Reynolds number
  Re := abs(m_flow)*D_h/(A_0*mu);
  aux1 := D_h/(A_0*mu);
  // use correlation for lambda2 depending on actual conditions
  if Re <= Re1 then
    lambda2 := 64*Re "Hagen-Poiseuille";
    dlambda2_dm_flow := 64*aux1 "Hagen-Poiseuille";
  elseif Re >= Re2 then
    lambda2 := 0.25*(Re/log10(Delta/3.7 + 5.74/Re^0.9))^2 "Swamee-Jain";
    aux2 := Delta/3.7 + 5.74/((aux1*abs(m_flow))^0.9);
    dlambda2_dm_flow := 0.5*aux1*Re*log(10)^2*(1/(log(aux2)^2) + (5.74*0.9)/(log(aux2)^3*Re^0.9*aux2)) "Swamee-Jain";
  else
    (lambda2, dlambda2_dm_flow) := interpolateInRegion2(Re, Re1, Re2, Delta, m_flow);
  end if;
  lambda := lambda2/Re^2;
  annotation (
    Documentation(info="<html>
<p>
Function calculating Darcy friction factor lambda as f(m_flow, D_h, Delta, rho, mu, Re1, Re2), where:
</p>

<ul>
<li>m_flow: mass flow rate [kg/s]</li>
<li>D_h: hydraulic diameter [m]</li>
<li>Delta: relative roughness [m/m]</li>
<li>rho: density [kg/m^3]</li>
<li>mu: dynamic viscosity [Pa.s]</li>
<li>Re1: lower Reynolds Number boundary for laminar-turbulent transition flow regime [-]</li>
<li>Re2: upper Reynolds Number boundary for laminar-turbulent transition flow regime [-]</li>
</ul>

<p>
The function is extracted from <a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.WallFriction.Detailed.Internal.dp_fric_of_m_flow\">dp_fric_of_m_flow</a>.
</p>

<p>
<em>[P. Jordan; HTWG Konstanz; 01/24]</em>
</p>

<p>
<img src=\"modelica://ThermofluidStream/Resources/Doku/Fluid_HTWG/HTWG_en_Markenzeichen_klein_pos_1C.png\" alt=\"HTWG Konstanz\" width=\"350\" height=\"100\">
</p>
</html>"));
end DarcyFriction;
