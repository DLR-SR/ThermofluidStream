within ThermofluidStream.Processes.Internal;
type ReferencePressureDropFunction = enumeration(
    linear,
    quadratic,
    customExponent) "Provides the choice of linear or quadratic pressure loss functions"     annotation (
    Documentation(info="<html>
<p>Different choices for pressure drop function.</p>
</html>"));
