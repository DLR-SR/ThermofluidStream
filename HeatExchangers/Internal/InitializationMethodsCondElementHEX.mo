within ThermofluidStream.HeatExchangers.Internal;
type InitializationMethodsCondElementHEX = enumeration(
    h0 "Fixed value h0",
    rear "Initialize from rear (h=h_in_rear)",
    fore "Initialize from fore (h=h_in_fore)") "Choices for Initialization of state h of ConductionElementHEX"
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
        <p><span style=\"font-family: Courier New;\">Choices for Initailtaion of a state h.</span></p>
        </html>"));
