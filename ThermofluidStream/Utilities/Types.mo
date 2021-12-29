within ThermofluidStream.Utilities;
package Types "Types that are not units needed."
  extends Modelica.Icons.TypesPackage;
  type InitializationMethods = enumeration(
      state,
      derivative,
      steadyState,
      none)
    "Choices for Initialization of a state."
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p><span style=\"font-family: Courier New;\">Choices for Initialization of a state.</span></p>
<p><br><span style=\"font-family: Courier New;\">These are:</span></p>
<p><span style=\"font-family: Courier New;\">&quot;state&quot;: initialize a state with a value</span></p>
<p><span style=\"font-family: Courier New;\">&quot;derivative&quot;: initialize the derivative of a state with a value</span></p>
<p><span style=\"font-family: Courier New;\">&quot;none&quot;: no initialization for this state</span></p>
<p><span style=\"font-family: Courier New;\">&quot;steadyState&quot;: zero derivative</span></p>
</html>"));
  annotation (Documentation(info="<html>
<p>Types that are not units needed for Thermofluid simulation. Unit types should be defined not here but in Utilities.Units.</p>
</html>"));
end Types;
