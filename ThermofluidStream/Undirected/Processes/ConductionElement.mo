within ThermofluidStream.Undirected.Processes;
model ConductionElement "Model of quasi-sationary mass and heat transfer"

  extends Internal.PartialConductionElement;

  parameter Boolean resistanceFromAU = true "= true, if thermal conductance is given by U*A"
    annotation(Dialog(group="Thermal Conductance"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Area A = 1 "Heat transfer area"
    annotation(Dialog(group="Thermal Conductance", enable=resistanceFromAU));
  parameter SI.CoefficientOfHeatTransfer U = 200 "Thermal transmittance"
    annotation(Dialog(group="Thermal Conductance", enable=resistanceFromAU));
  parameter SI.ThermalConductance k_par = 200 "Thermal conductance"
    annotation(Dialog(group="Thermal Conductance", enable=not resistanceFromAU));
  final parameter SI.ThermalConductance k_internal = if resistanceFromAU then A*U else k_par;

  // ------ Parameter Display Configuration  ------------------------
  parameter Boolean displayVolume = true "= true, if volume V is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayConduction = true "= true, if thermal conductance is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter Boolean displayAnything = displayParameters and (displayVolume or displayConduction)
    annotation(Evaluate=true, HideResult=true);
  final parameter String parameterString=
    if displayParameters and displayVolume and displayConduction then
      "V=%V, "+conductionString
    elseif displayParameters and displayVolume and not displayConduction then
      "V=%V"
    elseif  displayParameters and not displayVolume  and displayConduction then
      conductionString
    else "" annotation(Evaluate=true, HideResult=true);
  final parameter String conductionString=
    if resistanceFromAU then "A=%A, U=%U"
    else "k=%k_par" annotation(Evaluate=true, HideResult=true);
  //-----------------------------------------------------------------

equation
  k = k_internal;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
      Text(
          extent={{-150,-60},{150,-90}},
          textColor={0,0,0},
          textString=parameterString),
        Line(visible=displayAnything, points={{0,-60},{0,-65}},
                                    color={191,0,0}),
        Line(visible=displayAnything, points={{0,-85},{0,-100}},
                                    color={191,0,0}),
        Line(
          visible=not displayAnything,
          points={{0,-60},{0,-100}},
          color={191,0,0})}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>
Undirected implementation of the Conduction Element.
</p>
<p>
This model is an element with a fixed volume (fig. 1). The mass in the volume is
assumed quasi-stationary (statically computed with volume and density), and the
fore massflow is coupled to the rear massflow.
</p>
<p>
<strong>Because of this the ConductionElement cannot be used as a loop breaker.</strong>
</p>
<p>
The advantage is that multiple ConductionElements can be put behind each other
without worrying about oscillations or fast eigenvalues between their masses.
The ConductionElement implements equations for conservation of mass and energy
for the fluid mass contained within it.
</p>
<p>
For further documentation see the documentation of the
<a href=\"modelica://ThermofluidStream.Undirected.Processes.Internal.PartialConductionElement\">motherclass</a>.
</p>
</html>"));
end ConductionElement;
