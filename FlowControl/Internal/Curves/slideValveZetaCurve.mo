within ThermofluidStream.FlowControl.Internal.Curves;
record slideValveZetaCurve "Basic Slide Valve"

  extends Curves.partialCharacteristicZetaCurves(zetaTable=
  [0.0, 10000000000.0;
  0.1, 100.0;
  0.12, 97.8;
  0.2, 35.0;
  0.3, 10.0;
  0.4, 4.6;
  0.5, 2.06;
  0.6, 0.98;
  0.7, 0.44;
  0.8, 0.17;
  0.9, 0.06;
  1.0, 1e-5]);


  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end slideValveZetaCurve;
