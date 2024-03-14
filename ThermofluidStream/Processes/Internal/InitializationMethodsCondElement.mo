within ThermofluidStream.Processes.Internal;
type InitializationMethodsCondElement = enumeration(
    T "Temperature T_0",
    h "specific enthalpy h_0",
    inlet "inlet state") "Choices for Initialization of state h of ConductionElement"
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Choices for initialization of a state h.
</p>
</html>"));
