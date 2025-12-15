within ThermofluidStream.Processes.Internal.FlowResistance;
function laminarTurbulentPressureLossHaaland "Pressure loss function (Haaland 1983) for laminar, transient and turbulent flow regimes"
  extends Internal.FlowResistance.partialPressureLoss;

  import Modelica.Constants.pi;

  input SI.ReynoldsNumber Re_laminar = 2000 "Upper limit for laminar flow (Reynolds number)"
    annotation(Dialog(enable=true));
  input SI.ReynoldsNumber Re_turbulent = 4000 "Lower limit for turbulent flow (Reynolds number)"
    annotation(Dialog(enable=true));
  input Real shape_factor(unit="1") = 64 "Laminar pressure loss factor (Hagen-Poiseuille)"
    annotation(Dialog(enable=true));
  input Real n(unit="1") = 1 "Transition coefficient (see documentation)"
    annotation(Dialog(enable=true));
  input SI.Length ks_input(min=1e-7) = 1e-7 "Surface roughness"
    annotation (Dialog(enable=(material == ThermofluidStream.Processes.Internal.Material.other)));
  input ThermofluidStream.Processes.Internal.Material material = ThermofluidStream.Processes.Internal.Material.other "Material of pipe"
    annotation (Dialog(enable=true));

protected
  SI.Length ks "Surface roughness";

  SI.Length diameter=r*2 "Diameter";
  SI.Area area=pi*r^2 "Cross-sectional area";
  Real relative_roughness "Relative surface roughness";

  SI.ReynoldsNumber Re_abs "Absolute value of Reynolds number";
  SI.ReynoldsNumber Re_abs_limited "Limited absolute value of Reynolds number";

  Real friction_factor(unit="1");
  SI.Pressure pressureLossLaminar "Laminar pressure loss";
  SI.Pressure pressureLossTurbulent "Turbulent pressure loss";

  constant SI.ReynoldsNumber Re_small=1e-5 "Lower limit of turbulent Reynolds number to avoid division by zero";

algorithm
  if material == ThermofluidStream.Processes.Internal.Material.concrete then
    ks := 5e-3;
  elseif material == ThermofluidStream.Processes.Internal.Material.wood then
    ks := 0.5e-3;
  elseif material == ThermofluidStream.Processes.Internal.Material.castIron then
    ks := 0.25e-3;
  elseif material == ThermofluidStream.Processes.Internal.Material.galvanizedIron then
    ks := 0.15e-3;
  elseif material == ThermofluidStream.Processes.Internal.Material.steel then
    ks := 0.059e-3;
  elseif material == ThermofluidStream.Processes.Internal.Material.drawnPipe then
    ks := 0.0015e-3;
  else
    ks := ks_input;
  end if;

  relative_roughness := ks/diameter;

  //absolute Reynolds number
  Re_abs := abs(m_flow)*diameter/(area*mu);
  Re_abs_limited := max(Re_small, Re_abs);

  friction_factor :=
    (-1.8/n*log10((6.9/Re_abs_limited)^n + (relative_roughness/3.75)^(1.11*n)))^(-2);

  pressureLossLaminar := m_flow*mu*shape_factor*l/(2*rho*diameter^2*area);
  pressureLossTurbulent := m_flow*abs(m_flow)*friction_factor*l/(2*rho*diameter*
    area^2);

  pressureLoss := Utilities.Functions.blendFunction(
    y1=pressureLossLaminar,
    y2=pressureLossTurbulent,
    x1=Re_laminar,
    x2=Re_turbulent,
    x=Re_abs);

  annotation (Documentation(info="<html>
<p>Pressure loss after&nbsp;Darcy&ndash;Weisbach, for laminar, (transient?) and turbulent flow.</p>
<p>The friction factor is based on Haaland 1983.</p>
<p>Haaland, S. E. Simple and Explicit Formulas for the Friction Factor in Turbulent Pipe Flow. Journal of Fluids Engineering 105, 89-90; 10.1115/1.3240948 (1983).</p>
</html>"));
end laminarTurbulentPressureLossHaaland;
