within ThermofluidStream.Processes.Internal;
type InitializationMethodsCondElement = enumeration(
    T "Temperature T_0",
    h "Specific enthalpy h_0",
    inlet "Inlet state") "Choices for initialization of state h of ConductionElement"
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Choices for initialization of a state h.
</p>
</html>"));
