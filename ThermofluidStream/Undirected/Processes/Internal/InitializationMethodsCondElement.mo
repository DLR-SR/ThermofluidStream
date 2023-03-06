within ThermofluidStream.Undirected.Processes.Internal;
type InitializationMethodsCondElement = enumeration(
    T "Temperature T_0",
    h "specific enthalpy h_0",
    fore "input state from fore",
    rear "input state from rear",
    port "regularized input state from fore or rear, depending on massflow") "Choices for initialization of state h of undirected ConductionElement"
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Choices for initialization of a state h.
</p>
</html>"));
