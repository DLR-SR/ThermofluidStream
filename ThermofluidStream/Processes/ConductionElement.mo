within ThermofluidStream.Processes;
model ConductionElement "Element with quasi-stationary mass and heatport"
  extends Internal.PartialConductionElement;
  // Configure icon display options
  parameter Boolean displayVolume = true "= true to display the volume of the element" annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayConduction = true "= true to display thermal conductance of the element" annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter String parameterString=
  if displayParameters and displayVolume and displayConduction then
    "V=%V, "+conductionString
  elseif displayParameters and displayVolume and not displayConduction then
    "V=%V"
  elseif  displayParameters and not displayVolume  and displayConduction then
    conductionString
  else "";
  final parameter String conductionString=
  if resistanceFromAU then "A=%A, U=%U"
  else "k=%k_par";

  parameter Boolean resistanceFromAU = true
    "= true, if thermal conductance given by U*A"
    annotation(Dialog(group="Thermal Conductance"));
  parameter SI.Area A = 1 "Contact area of element with medium"
    annotation(Dialog(group="Thermal Conductance", enable=resistanceFromAU));
  parameter SI.CoefficientOfHeatTransfer U = 200 "Heat transfer coefficient to medium"
    annotation(Dialog(group="Thermal Conductance", enable=resistanceFromAU));
  parameter SI.ThermalConductance k_par = 200 "Thermal conductance heatport->fluid"
    annotation(Dialog(group="Thermal Conductance", enable=not resistanceFromAU));
  final parameter SI.ThermalConductance k_internal = if resistanceFromAU then A*U else k_par;
equation
  k = k_internal;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
      Text(
          extent={{-150,-60},{150,-90}},
          textColor={0,0,0},
          textString=parameterString),
        Line(visible=not parameterString=="", points={{0,-60},{0,-65}},
                                    color={191,0,0}),
        Line(visible=not parameterString=="", points={{0,-85},{0,-100}},
                                    color={191,0,0}),
        Line(
          visible=parameterString == "",
          points={{0,-60},{0,-100}},
          color={191,0,0})}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>
This model is an element with a fixed volume (fig. 1). The mass in the volume is
assumed quasi-stationary (statically computed with volume and density), and the
inlet massflow is coupled to the outlet massflow.
</p>
<p>
<strong>Because of this the ConductionElement cannot be used as a loop breaker.</strong>
</p>
<p>
The advantage is that multiple ConductionElements can be put behind each other
without worrying about oscillations or fast eigenvalues between their masses.
The ConductionElement implements equations for conservation of mass and energy
for the fluid mass contained in the component.
</p>
<p>
For further documentation see the documentation of the
<a href=\"modelica://ThermofluidStream.Processes.Internal.PartialConductionElement\">motherclass</a>.
</p>
</html>"));
end ConductionElement;
