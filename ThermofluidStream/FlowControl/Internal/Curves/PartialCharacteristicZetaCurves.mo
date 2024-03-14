within ThermofluidStream.FlowControl.Internal.Curves;
partial record PartialCharacteristicZetaCurves
  "Partial record for valve's pressure drop coefficient zeta"

  parameter Real zetaTable[:,:](each unit="1") = fill(0,0,2)
    "Pressure drop coefficient zeta";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Extend this partial record and fill in <code>zetaTable</code> to
specify pressure drop coefficient &zeta; (col. 2) of a&nbsp;particular
valve over valve&apos;s control input (col. 1).
</p>
</html>"));
end PartialCharacteristicZetaCurves;
