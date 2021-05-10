within ThermofluidStream.Processes.Internal.FlowResistance;
function laminarTurbulentPressureLoss
  "Laminar and turbolent flow regimes pressure loss function"
  extends Internal.FlowResistance.partialPressureLoss;
  import Modelica.Constants.pi;

  parameter SI.Length ks_input(min=1e-7) = 1e-7 "Pipe roughness"
    annotation(Dialog(enable=(material == ThermofluidStream.Processes.Internal.Material.other)));

  parameter ThermofluidStream.Processes.Internal.Material material=ThermofluidStream.Processes.Internal.Material.other "Material of pipe" annotation (
     choices(
      choice=ThermofluidStream.Processes.Internal.Material.concrete "Concrete ks=5mm",
      choice=ThermofluidStream.Processes.Internal.Material.wood "Wood ks=0.5mm",
      choice=ThermofluidStream.Processes.Internal.Material.castIron "Cast Iron ks=0.25mm",
      choice=ThermofluidStream.Processes.Internal.Material.galvanizedIron "Galvanized Iron ks=0.15mm",
      choice=ThermofluidStream.Processes.Internal.Material.steel "Steel ks=0.059mm",
      choice=ThermofluidStream.Processes.Internal.Material.drawnPipe "Drawn Pipe ks=0.0015mm"));

protected
  constant Real R_laminar_DarcyWeisbach_min(unit="1") = 500 "Minimal Reynolds number to use the general equation. Laminar flow before";
  SI.Length ks "pipe roughness";

  Real a(unit="1") "laminar flow factor for the DarcyWeisbach equation (1=laminar flow; 0=turbolent flow)";
  Real b(unit="1") "turbolent flow factor for DarcyWeisbach equation (1=fully smooth turbolent flow; 0= fully rough turbolent flow)";
  Real lambda(unit="1") "darcy friction factor for DarcyWeisbach equation";

  SI.Velocity u  "median flow velocity";
  Real Re(unit="1") "Reynolds number for flow though the pipe";

algorithm
  if material == ThermofluidStream.Processes.Internal.Material.concrete then
    ks :=5e-3;
  elseif material == ThermofluidStream.Processes.Internal.Material.wood then
    ks :=0.5e-3;
  elseif material == ThermofluidStream.Processes.Internal.Material.castIron then
    ks :=0.25e-3;
  elseif material == ThermofluidStream.Processes.Internal.Material.galvanizedIron then
    ks :=0.15e-3;
  elseif material == ThermofluidStream.Processes.Internal.Material.steel then
    ks :=0.059e-3;
  elseif material == ThermofluidStream.Processes.Internal.Material.drawnPipe then
    ks :=0.0015e-3;
  else
    ks :=ks_input;
  end if;

  assert(ks <r, "ks must be smaller than r");

  u :=m_flow/(r^2*pi*rho);
  Re :=abs(u)*rho*2*r/mu;

  if noEvent(R_laminar_DarcyWeisbach_min < Re) then
      // chang 2008. Formulas for Friction Factor in Transitional Regimes. Journal of Hydraulic Engineering.
      a := 1/(1+(Re/2720)^9);
      b := 1/(1+(Re/(160*2*r/ks))^2);
      lambda := (64/Re)^a * (1.8*log10(Re/6.8))^(2*(a-1)*b) * (2*log10(3.7*2*r/ks))^(2*(a-1)*(1-b));

      pressureLoss :=sign(m_flow)*lambda*l/(2*r)*rho/2*u^2;
  else
    pressureLoss := m_flow * (8*mu*l)/(pi*rho*r^4);
  end if;

  annotation (Documentation(info="<html>
<p><span style=\"font-family: Courier New;\">Pressure loss after after&nbsp;Darcy&ndash;Weisbach, which is valid in laminar and turbulent flow regimes. </span></p>
<p><span style=\"font-family: Courier New;\">pressureLoss&nbsp;:=<span style=\"color: #ff0000;\">sign</span>(m_flow)*lambda*l/(2*r)*rho/2*u^2;</p>
<p><span style=\"font-family: Courier New;\">ks_input defines the pipe roughness. It can be selected from a list of materials or given directly.</span></p>
<p><span style=\"font-family: Courier New;\">The forula for the darcy&nbsp;friction&nbsp;factor is taken from chang&nbsp;2008.&nbsp;Formulas&nbsp;for&nbsp;Friction&nbsp;Factor&nbsp;in&nbsp;Transitional&nbsp;Regimes.&nbsp;Journal&nbsp;of&nbsp;Hydraulic&nbsp;Engineering.</span></p>
<p><span style=\"font-family: Courier New;\">For low Reynolds numbers laminar flow is assumed, for numerical reasons.</span></p>
</html>"));
end laminarTurbulentPressureLoss;
