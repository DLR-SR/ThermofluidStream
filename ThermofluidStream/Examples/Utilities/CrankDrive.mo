within ThermofluidStream.Examples.Utilities;
model CrankDrive "Equation based model of a crank drive."

  parameter SI.Length rodLength "Length of the linear moving rod";
  parameter SI.Radius crankPoint "Distance of the crank Point to the center";
  parameter SI.Mass translationMass "Inertial mass of the linear motion";
  parameter SI.Inertia J_flyweel "Inertial mass of the circular motion";

  parameter SI.Angle phi0 = 0 "Initial angle";
  parameter SI.AngularVelocity omega0 = 0 "Initial angular velocity";

  Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
    annotation (Placement(transformation(extent={{190,-10},{210,10}}),
        iconTransformation(extent={{190,-10},{210,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput h_out = (h >= 0)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={200,-102}),iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={200,-100})));

  SI.Length h;
  SI.Length d1;
  SI.Length d2;
  SI.Angle phi = flange_a.phi;
  SI.AngularVelocity omega = der(phi);
  SI.Velocity v = der(flange_b.s);
  SI.Torque tau_f = -h*flange_b.f;
  SI.Force x = flange_b.s/crankPoint/2;

initial equation
  phi = phi0;
  omega = omega0;

equation

  d1 = crankPoint*cos(phi);
  h = crankPoint*sin(phi);
  d2 = sqrt(rodLength^2 - h^2);

  flange_b.s = (rodLength + crankPoint) - d2 + d1;

  (der(omega)*J_flyweel -h*der(v)*translationMass) = flange_a.tau +tau_f;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{300,100}}),
                         graphics={
        Ellipse(
          extent={{120,-80},{280,80}},
          lineColor={162,29,33},
          lineThickness=0.5),
        Line(
          points={{DynamicSelect(200, 200 -cos(phi)*80), DynamicSelect(-80, -sin(phi)*80)},{DynamicSelect(200, 200 + cos(phi)*80),DynamicSelect(80, sin(phi)*80)}},
          color={162,29,33},
          thickness=0.5),
        Line(
          points={{DynamicSelect(120, 200 -cos(phi+1.571)*80), DynamicSelect(0, -sin(phi+1.571)*80)},{DynamicSelect(280, 200 + cos(phi+1.571)*80),DynamicSelect(0, sin(phi+1.571)*80)}},
          color={162,29,33},
          thickness=0.5),
        Line(
          points={{DynamicSelect(143, 200 -cos(phi+0.7854)*80), DynamicSelect(57, -sin(phi+0.7854)*80)},{DynamicSelect(257, 200 + cos(phi+0.7854)*80),DynamicSelect(-57, sin(phi+0.7854)*80)}},
          color={162,29,33},
          thickness=0.5),
        Line(
          points={{DynamicSelect(143, 200 -cos(phi-0.7854)*80), DynamicSelect(-57, -sin(phi-0.7854)*80)},{DynamicSelect(257, 200 + cos(phi-0.7854)*80),DynamicSelect(57, sin(phi-0.7854)*80)}},
          color={162,29,33},
          thickness=0.5),
        Line(
          points={{DynamicSelect(-100, -100+x*100),0},{DynamicSelect(-40, -40+x*100),0},{DynamicSelect(200, 200 + cos(phi)*60), DynamicSelect(-60, sin(phi)*60)}},
          color={162,29,33},
          thickness=0.5),
        Ellipse(
          extent={{DynamicSelect(-44, -44+x*100),-4},{DynamicSelect(-36, -36+x*100),4}},
          lineColor={162,29,33},
          lineThickness=0.5,
          fillColor={255,221,224},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{DynamicSelect(196, 196 + cos(phi)*60), DynamicSelect(-64, -4 + sin(phi)*60)},{DynamicSelect(204, 204 + cos(phi)*60),DynamicSelect(-56, 4 + sin(phi)*60)}},
          lineColor={162,29,33},
          lineThickness=0.5,
          fillColor={255,221,224},
          fillPattern=FillPattern.Solid)}), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{300,
            100}})),
    Documentation(info="<html>
<p>
This model is an equation based model of a crank drive. It can be used to convert
linear motion into circular motion.
</p>
<p>
Phi is the angle of the flyweel, 0 is the right-most position.
</p>
</html>"));
end CrankDrive;
