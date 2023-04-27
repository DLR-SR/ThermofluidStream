within ThermofluidStream.Undirected.FlowControl.Internal;
partial model PartialValve "Partial implementation of a physical valve"
  extends Interfaces.SISOBiFlow(final clip_p_out=true);

  parameter Boolean invertInput = false "Non-inverted: 0=closed, 1=open";
  parameter Real k_min(unit="1", min = 0.001, max = 1) = 0.03 "Remaining flow at actuation signal u = 0 (fraction of maximum mass flow at u = 1)";

  Modelica.Blocks.Interfaces.RealInput u_in(unit="1") "Valve control signal []"
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80})));

  Real u(unit="1") "actuation input for flow calculation";

  parameter Modelica.Units.SI.Pressure dp_ref=1e5
    "Reference pressure difference"
    annotation (Dialog(tab="Advanced", group="Reference values"));
  parameter Modelica.Units.SI.Density rho_ref=1000 "Reference density"
    annotation (Dialog(tab="Advanced", group="Reference values"));

protected
  constant Real secondsPerHour(final unit="s/h") = 3600 "Parameter for unit conversion";

  //Medium properties
  Modelica.Units.SI.Density rho_rear_in=Medium.density(rear.state_forwards);
  Modelica.Units.SI.Density rho_fore_in=Medium.density(fore.state_rearwards);

  SI.MassFlowRate m_flow_ref "Reference mass flow derived from flow coefficient inputs";
  Real k_u(unit="1") "Kv/Kvs, respecting flow characteristics";

equation
  //Inversion of input signal, actuation has to be between 0 and 1
  assert(u_in <=1 and u_in >=0, "Actuator signal out of valid range [0,1]", level = AssertionLevel.warning);
  if invertInput then
      u = max(0, min(1, 1-u_in));
  else
      u = max(0, min(1, u_in));
  end if;

   //forwards model
  dp_fore = -sign(m_flow)*dp_ref*(rho_ref/rho_rear_in)*(1/(k_u)*(m_flow/m_flow_ref))^2;
  h_fore_out = h_rear_in;
  Xi_fore_out = Xi_rear_in;

  //rearwards model
  dp_rear = sign(m_flow)*dp_ref*(rho_ref/rho_fore_in)*(1/(k_u)*(m_flow/m_flow_ref))^2;
  h_rear_out = h_fore_in;
  Xi_rear_out = Xi_fore_in;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Partial&nbsp;implementation&nbsp;of&nbsp;a&nbsp;physical&nbsp;valve.</p>
</html>"));
end PartialValve;
