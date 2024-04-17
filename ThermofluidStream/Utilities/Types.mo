within ThermofluidStream.Utilities;
package Types "Types that are not units needed."
  extends Modelica.Icons.TypesPackage;
  type InitializationMethods = enumeration(
      none
      "No initialization",
      steadyState
      "Steady state initialization (derivatives of states are zero)",
      state
      "Initialization with initial states",
      derivative
      "Initialization with initial derivatives of states")
    "Choices for initialization of a state."
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>
Choices for initialization of a&nbsp;state.
</p>
</html>"));

  annotation (Documentation(info="<html>
<p>
Types that are not units needed for Thermofluid simulation.
Unit types should be defined not here but in Utilities.Units.
</p>
</html>"));
end Types;
