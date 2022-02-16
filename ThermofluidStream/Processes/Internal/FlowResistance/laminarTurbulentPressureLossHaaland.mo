within ThermofluidStream.Processes.Internal.FlowResistance;

function laminarTurbulentPressureLossHaaland
extends Internal.FlowResistance.partialPressureLoss;

import Modelica.Constants.pi;

// Inputs
input Real Re_laminar(unit"1") = 2000 "Upper Reynolds number boundary for laminar flow in pipe";
input Real Re_turbulent(unit"1") = 4000 "Lower Reynolds number boundary for turbulent flow in pipe";
input Real shape_factor(unit"1") = 64 "Laminar pressure loss factor based on Hagen-Poiseuille loss";
input SI.Length es = 15e-6 "Roughness of pipe material";

// Parameters and Variables

protected
SI.Length diameter "Diameter of Pipe";
SI.Area area "Area of Pipe";
Real relative_roughness "Relative Roughness of Pipe";

SI.MassFlowRate m_flow_abs "absolute value of mass flow";
Real Re_abs "absolute value of Reynolds number";
Real Re_abs_limited "limited absolute value of Reynolds number";

Real friction_factor;
SI.Pressure pressureLossLaminar "Laminar Pressure Loss";
SI.Pressure pressureLossTurbulent "Turbulent Pressure Loss";
SI.Pressure pressureLoss "Total Pressures Loss in pipe";

algorithm

diameter := r*2; // computation of diameter of Pipe
area := Modelica.Constants.pi * r^2; // cross-sectional area of pipe
relative_roughness := es/diameter;

if m_flow >= 0 then
  m_flow_abs := m_flow;
  elseif m_flow < 0 then
  m_flow_abs := -m_flow;
  end if;

//m_flow_abs := abs(m_flow); // absolute value of mass flow
Re_abs := m_flow_abs * diameter /(area*mu); // absolute Reynolds number

if Re_abs > 1 then
  Re_abs_limited := Re_abs;
  else
  Re_abs_limited := 1;
  end if;

friction_factor := 1 / (-1.8 * log10(6.9/Re_abs_limited + (relative_roughness/3.7)^1.11))^2;

pressureLossLaminar := m_flow * mu * shape_factor * l /(2 * rho * diameter^2 * area);
pressureLossTurbulent := m_flow * mu * friction_factor * l /(2 * rho * diameter * area^2);

pressureLoss := Utilities.Functions.blendFunction(y1=pressureLossLaminar, y2=pressureLossTurbulent, x1=Re_laminar, x2=Re_turbulent, x=Re_abs);

annotation(Documentation(info="<html>
<p><span style=\font-family: Courier New;\">Pressure loss after&nbsp;Darcy&ndash;Weisbach, which is valid in laminar and turbulent flow regimes.
<p><span style=\font-family: Courier New;\">The friction factor is based on Haaland 1983.
<p><span style=\font-family: Courier New;\">Haaland, S. E. Simple and Explicit Formulas for the Friction Factor in Turbulent Pipe Flow. Journal of Fluids Engineering 105, 89–90; 10.1115/1.3240948 (1983).<html>"));
end laminarTurbulentPressureLossHaaland;
