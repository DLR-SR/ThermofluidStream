within ThermofluidStream.FlowControl.Internal;
partial model PartialValve "Partial implementation of a physical valve"

  extends Interfaces.SISOFlow(final clip_p_out=true);

  parameter Boolean invertInput = false "= true, if input u_in is inverted"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Real k_min(unit="1", min = 1e-5, max = 1) = 0.03 "Remaining flow at actuation signal u = 0";

  Modelica.Blocks.Interfaces.RealInput u_in(unit="1") "Valve control input signal []"
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80})));

  Real u(unit="1") "Actuation input for flow calculation";
  parameter Modelica.Units.SI.Pressure dp_ref=1e5
    "Reference pressure difference"
    annotation (Dialog(tab="Advanced", group="Reference values"));
  parameter Modelica.Units.SI.Density rho_ref=1000 "Reference density"
    annotation (Dialog(tab="Advanced", group="Reference values"));

protected
  final constant Real secondsPerHour(final unit="s/h") = 3600 "Unit conversion parameter";

  //Medium properties
  Modelica.Units.SI.Density rho=Medium.density(inlet.state) "Inlet density";

  parameter SI.MassFlowRate m_flow_ref(fixed = false) "Reference mass flow rate derived from flow coefficient inputs";
  Real k_u(unit="1") "Kv/Kvs, respecting flow characteristics";

equation
  //Inversion of input signal, actuation has to be between 0 and 1
  assert(u_in <=1 and u_in >=0, "Actuator signal out of valid range [0,1]", level = AssertionLevel.warning);
  if invertInput then
      u = max(0, min(1, 1-u_in));
  else
      u = max(0, min(1, u_in));
  end if;

  //Generic pressure loss calculation
  dp = -sign(inlet.m_flow)*dp_ref*(rho_ref/rho)*(1/(k_u)*(inlet.m_flow/m_flow_ref))^2;
  h_out = h_in;
  Xi_out = Xi_in;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,-60},{150,-100}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor)}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>
Partial implementation of a physical valve.
The interpretation of input <code>u_in</code> depends on
<code>invertInput</code> as follows.
</p>
<ul>
  <li>
    <code>invertInput = false</code> (non-inverted): 0=closed, 1=open;
  </li>
  <li>
    <code>invertInput = true</code> (inverted): 0=open, 1=closed.
  </li>
</ul>
</html>"));
end PartialValve;
