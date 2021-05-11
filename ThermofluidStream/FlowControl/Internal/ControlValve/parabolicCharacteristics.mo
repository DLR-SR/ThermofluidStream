within ThermofluidStream.FlowControl.Internal.ControlValve;
function parabolicCharacteristics "Parabolic"

  extends Internal.ControlValve.partialValveCharacteristics;

algorithm
  k_u := k_min + (1 - k_min)*u^2;

end parabolicCharacteristics;
