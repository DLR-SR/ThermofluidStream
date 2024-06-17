within ThermofluidStream.Processes.Pumps.CentrifugalPumps.BasedOnCoefficients;
model CentrifugalPumpCoefficients "Centrifugal pump based on 3+1+2 coefficients for head, power and efficiency"
  extends ThermofluidStream.Processes.Pumps.BaseClasses.PartialCentrifugalPumpEfficiency;
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange annotation (Placement(transformation(extent={{-10,-110},{10,-90}}), iconTransformation(extent={{-10,-110},{10,-90}})));
  SI.Angle phi = flange.phi "Angle";
equation
  tau = flange.tau;
  w = der(phi);
  annotation (Icon(graphics={
    Rectangle(lineColor={64,64,64},
      fillColor={192,192,192},
      fillPattern=FillPattern.HorizontalCylinder,
      extent={{-28,-18.3334},{28,1.66664}},
          rotation=270,
          origin={8.333,-74}),
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,60},{60,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,-60},{60,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-100,0},{100,0}},
          color={28,108,200},
          thickness=0.5)}));
end CentrifugalPumpCoefficients;
