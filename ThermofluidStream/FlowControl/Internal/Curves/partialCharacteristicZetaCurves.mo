within ThermofluidStream.FlowControl.Internal.Curves;
partial record partialCharacteristicZetaCurves

  parameter Real zetaTable[:,:](each unit="1") = fill(0,0,2);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end partialCharacteristicZetaCurves;
