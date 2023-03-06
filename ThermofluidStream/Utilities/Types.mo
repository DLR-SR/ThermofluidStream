within ThermofluidStream.Utilities;
package Types "Types that are not units needed."
  extends Modelica.Icons.TypesPackage;
  type InitializationMethods = enumeration(
      state,
      derivative,
      steadyState,
      none)
    "Choices for Initialization of a state."
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>
Choices for Initialization of a state. These are:
</p>
<ul>
  <li><code>state</code>: initialize a state with a value</li>
  <li><code>derivative</code>: initialize the derivative of a state with a value</li>
  <li><code>none</code>: no initialization for this state</li>
  <li><code>steadyState</code>: zero derivative</li>
</ul>
</html>"));

  annotation (Documentation(info="<html>
<p>
Types that are not units needed for Thermofluid simulation.
Unit types should be defined not here but in Utilities.Units.
</p>
</html>"));
end Types;
