within ThermofluidStream.FlowControl.Internal.ControlValve;
partial function partialValveCharacteristics "partial function for control valve characteristics"

  input Real u(unit="1");
  input Real k_min(unit="1");

  output Real k_u(unit="1");

end partialValveCharacteristics;
