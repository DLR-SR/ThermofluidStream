within ThermofluidStream.Processes.Internal.FlowResistance;
function referencePressureLoss "Pressure loss function based on reference values"
  extends Internal.FlowResistance.partialPressureLoss;

  input SI.Pressure dp_ref "Reference pressure loss"
    annotation(Dialog(enable=true));
  input SI.MassFlowRate m_flow_ref "Reference mass flow rate"
    annotation(Dialog(enable=true));
  input SI.Density rho_ref "Reference density"
    annotation(Dialog(enable=true));
  input ThermofluidStream.Processes.Internal.ReferencePressureDropFunction dp_function=ThermofluidStream.Processes.Internal.ReferencePressureDropFunction.linear "Pressure loss function"
    annotation (Dialog(enable=true));
  input Real m(unit = "1") = 1.5 "Exponent for pressure loss function"
    annotation(Dialog(enable=(dp_function == ThermofluidStream.Processes.Internal.ReferencePressureDropFunction.customExponent)));

algorithm
  if dp_function == ThermofluidStream.Processes.Internal.ReferencePressureDropFunction.linear then
    pressureLoss := rho_ref/rho*dp_ref*m_flow/m_flow_ref;
  elseif dp_function == ThermofluidStream.Processes.Internal.ReferencePressureDropFunction.quadratic then
    pressureLoss := rho_ref/rho*dp_ref*Modelica.Fluid.Utilities.regSquare(m_flow/m_flow_ref);
  elseif dp_function == ThermofluidStream.Processes.Internal.ReferencePressureDropFunction.customExponent then
    pressureLoss := rho_ref/rho*dp_ref*Modelica.Fluid.Utilities.regPow(m_flow/m_flow_ref, m);
  end if;

  annotation (Documentation(info="<html>
<p>
This function calculates the pressure drop according a reference pressure
drop at a reference mass flow rate and reference density.
</p>
<blockquote><pre>
dp/dp_ref =  rho_ref/rho * (m_flow/m_flow_ref)^m
</pre></blockquote>
<p>
The correlation can be assumed to be linear (m=1), quadratic (m=2) or with
a custom exponent&nbsp;m.
</p>
</html>"));
end referencePressureLoss;
