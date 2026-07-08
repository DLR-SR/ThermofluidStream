within ThermofluidStream.Processes.Internal.FlowResistance;
model pleaseSelectPressureLoss "Please select pressure loss model"
  extends Internal.FlowResistance.partialPressureLoss;

algorithm
  assert(false, "Please select pressure loss model");

  pressureLoss :=0;

  annotation (Documentation(info="<html>
<p>
Pressure loss model without actual equations with an always failing assert to
output a meaningful error, when the user forgot to select a model. This should
be used as a default.
</p>
</html>"));
end pleaseSelectPressureLoss;
