within ThermofluidStream.Boundaries.Internal;
type InitializationMethodsPhaseSeperator = enumeration(
    h "Specific enthalpy h_0",
    M "Mass M_0",
    l "Liquid Level l_0",
    x "Vapor Quality x_0") "Choices for initialization of state h of PhaseSeperator"
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Choices for initialization of a state h.
</p>
</html>"));
