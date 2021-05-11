within ThermofluidStream.Processes.Tests;
model Power "Constant power with limited tourque"
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange
    annotation (Placement(transformation(extent={{66,-10},{86,10}})));

  parameter SI.Power P "Max power";
  parameter SI.Torque tau_max "Max tourque";

protected
  Modelica.SIunits.AngularVelocity omega = der(flange.phi);
  constant Real eps(unit="1") = 1e-7;

equation
  - flange.tau = min(P/(abs(omega) + eps), tau_max);

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><span style=\"font-size: 12pt;\">Delivers tourque, such that its delvers the set power, as long as tourque is under the maximum tourque, and maximum tourque else.</span></p>
</html>"));
end Power;
