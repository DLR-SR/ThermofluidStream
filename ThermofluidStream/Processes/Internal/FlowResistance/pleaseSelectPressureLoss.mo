within ThermofluidStream.Processes.Internal.FlowResistance;
function pleaseSelectPressureLoss "Please select pressure loss function"
  extends Internal.FlowResistance.partialPressureLoss;

algorithm
  assert(false, "Please select pressure loss function");

  pressureLoss :=0;

  annotation (Documentation(info="<html>
<p>
Pressure loss function without actual equations with an always failing assert to
output a meaningful error, when the user forgot to select a function. This should
be used as a default.
</p>
</html>"));
end pleaseSelectPressureLoss;
