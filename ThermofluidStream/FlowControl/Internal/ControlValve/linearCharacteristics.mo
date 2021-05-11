within ThermofluidStream.FlowControl.Internal.ControlValve;
function linearCharacteristics "Linear"

  extends Internal.ControlValve.partialValveCharacteristics;

algorithm
  k_u := k_min + (1 - k_min)*u;

end linearCharacteristics;
