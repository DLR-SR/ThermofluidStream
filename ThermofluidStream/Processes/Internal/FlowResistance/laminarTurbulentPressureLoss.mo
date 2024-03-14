within ThermofluidStream.Processes.Internal.FlowResistance;
function laminarTurbulentPressureLoss "Pressure loss function (Cheng 2008) for laminar, transient and turbulent flow regimes"
  extends Internal.FlowResistance.partialPressureLoss;
  import Modelica.Constants.pi;

  input SI.Length ks_input(min=1e-7) = 1e-7 "Surface roughness"
    annotation(Dialog(enable=(material == ThermofluidStream.Processes.Internal.Material.other)));
  input ThermofluidStream.Processes.Internal.Material material=ThermofluidStream.Processes.Internal.Material.other "Material of pipe"
    annotation (Dialog(enable=true));

protected
  constant SI.ReynoldsNumber R_laminar_DarcyWeisbach_min = 500 "Minimal Reynolds number to use the general equation. Laminar flow before";
  SI.Length ks "Surface roughness";

  Real a(unit="1") "Laminar flow factor for the DarcyWeisbach equation (= 1 for laminar flow, = 0 for turbulent flow)";
  Real b(unit="1") "Turbulent flow factor for the DarcyWeisbach equation (= 1 for fully smooth turbulent flow, = 0 for fully rough turbulent flow)";
  Real lambda_aux(unit="1") "Darcy friction factor for Darcy-Weisbach equation";

  SI.Velocity u "Velocity";
  SI.ReynoldsNumber Re "Reynolds number";
  constant Real eps(unit="1") = 0.001;
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

  assert(ks <r, "Surface roughness shall be smaller than pipe radius");

  u :=m_flow/(r^2*pi*rho);
  // add eps to Re to avoid 0^0 error in computation of lambda_aux for Re=0 (-> a=1).
  Re :=abs(u)*rho*2*r/mu + eps;

  // cheng 2008. Formulas for Friction Factor in Transitional Regimes. Journal of Hydraulic Engineering.
  a := 1/(1+(Re/2720)^9);
  b := 1/(1+(Re/(160*2*r/ks))^2);
  //compute lambda_aux = Re*lambda to avoid division by zero at Re=0 and to avoid if-else
  lambda_aux := 64^a * Re^(1-a) * ((1.8*log10(Re/6.8))^(2*(a-1)*b) * (2*log10(3.7*2*r/ks))^(2*(a-1)*(1-b)));

  pressureLoss := lambda_aux*l*mu*u/(8*r^2);

  annotation (Documentation(info="<html>
  <p>Pressure loss according to&nbsp;Darcy&ndash;Weisbach, for laminar, transient and turbulent flow.</p>
<p>In order to avoid a 0^0 for Re=0 (and therefore a = 1) in the computation of lambda_aux, we add epsilon=0.01 to Re to lower bound it in a smooth way.</p>
<p>ks_input defines the pipe roughness. It can be selected from a list of materials or given directly.</p>
<p><img src=\"modelica://Thermofluidstream/Resources/Doku/ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss.PNG\"/></p>
<p><br>Cheng, Nian-Sheng (2008). Formulas for friction factor in transitional regimes. In:Journal of Hydraulic Engineering134.9, pp. 1357-1362</p>
<p>Elmqvist, Hilding, Hubertus Tummescheit, and Martin Otter (2003). Object-orientedmodeling of thermo-fluid systems. In:3rd International Modelica Conference,pp. 269-286.</p>
</html>"));
end laminarTurbulentPressureLoss;
