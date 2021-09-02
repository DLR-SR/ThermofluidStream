within ThermofluidStream.Processes;
model ConductionElement "Element with quasi-stationary mass and heatport"
  extends Internal.PartialConductionElement;

  parameter Boolean resistanceFromAU = true
    annotation(Dialog(group="Thermal Conductance"));
  parameter SI.Area A = 1 "Contact area of element with medium"
    annotation(Dialog(group="Thermal Conductance", enable=resistanceFromAU));
  parameter SI.CoefficientOfHeatTransfer U = 200 "Heat transfer coefficient to medium"
    annotation(Dialog(group="Thermal Conductance", enable=resistanceFromAU));
  parameter SI.ThermalConductance k_par = 200 "Thermal conductance heatport->fluid"
    annotation(Dialog(group="Thermal Conductance", enable=not resistanceFromAU));

equation
  k = (if noEvent(resistanceFromAU) then U*A else k_par);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This Model is an element with a fixed volume (fig. 1). The mass in the volume is assumed quasi-stationary (statically computed with volume and density), and the inlet massflow is coupled to the outlet massflow. </p>
<p><span style=\"color: #f47d23;\">Because of this the ConductionElement cannot be used as a loop breaker</span><span style=\"color: #b83d00;\">. </span></p>
<p>The advantage is that multiple ConductionElements can be put behind each other without worrying about oscilations or fast eigenvalues between their masses. The ConductionElement implements equations for conservation of mass and energy for the Fluid mass contained within it.</p>
<p>For further Documentation see the Documentation of the Motherclass.</p>
</html>"));
end ConductionElement;
