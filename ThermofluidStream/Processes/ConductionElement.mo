within ThermofluidStream.Processes;
model ConductionElement "Model of quasi-stationary mass and heat transfer"

  extends Internal.PartialConductionElement;

  parameter Boolean useHeatTransferPropertyInput = false "= true, if input connector for either U or k_par is enabled"
    annotation(Dialog(group="Thermal Conductance"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean resistanceFromAU = true "= true, if thermal conductance is given by U*A"
    annotation(Dialog(group="Thermal Conductance"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Area A = 1 "Heat transfer area"
    annotation(Dialog(group="Thermal Conductance", enable=resistanceFromAU));
  parameter SI.CoefficientOfHeatTransfer U = 200 "Overall heat transfer coefficient"
    annotation(Dialog(group="Thermal Conductance", enable=(resistanceFromAU and not useHeatTransferPropertyInput)));
  parameter SI.ThermalConductance k_par = 200 "Thermal conductance"
    annotation(Dialog(group="Thermal Conductance", enable=(not resistanceFromAU and not useHeatTransferPropertyInput)));
  //final parameter SI.ThermalConductance k_internal = if resistanceFromAU then A*U else k_par;

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
    if useHeatTransferPropertyInput and resistanceFromAU then "A=%A"
    elseif not useHeatTransferPropertyInput and resistanceFromAU  then "A=%A, U=%U"
    elseif not useHeatTransferPropertyInput and not resistanceFromAU then "k=%k_par"
    else "" annotation(Evaluate=true, HideResult=true);
  //-----------------------------------------------------------------

  Modelica.Blocks.Interfaces.RealInput U_var(unit = "W/(m2.K)") if (useHeatTransferPropertyInput and resistanceFromAU) "Overall heat transfer coefficient input connector [W/(m2.K)]"
    annotation (Placement(transformation(extent={{-20,20},{20,-20}},
        rotation=90,
        origin={-60,-120})));
  Modelica.Blocks.Interfaces.RealInput k_var(unit="W/K") if (useHeatTransferPropertyInput and not resistanceFromAU) "Thermal conductance input connector [W/K]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120})));

protected
  Modelica.Blocks.Interfaces.RealInput U_internal(unit = "W/(m2.K)") "Internal connector for overall heat transfer coefficient";
  Modelica.Blocks.Interfaces.RealInput k_internal(unit="W/K") "Internal connector for thermal conductance";

equation
  connect(U_var, U_internal);
  if resistanceFromAU and not useHeatTransferPropertyInput then
    U_internal = U;
  end if;

  connect(k_var, k_internal);
  if not resistanceFromAU and not useHeatTransferPropertyInput then
    k_internal = k_par;
  end if;

  k_internal = A*U_internal;
  k = k_internal;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
      Text(
          extent={{-150,-60},{150,-90}},
          textColor={0,0,0},
          textString=parameterString),
        Line(
          points={{0,-60},{0,-100}},
          color={191,0,0},
          pattern=LinePattern.Dot),
        Line(visible = useHeatTransferPropertyInput,
        points={{-60,-100},{0,-100}}, color={0,0,127})}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
  <p>
    This model represents an element with a fixed volume (fig. 1). The mass inside the volume is assumed quasi-stationary, meaning it is computed statically using the volume and density, and the inlet mass flow is coupled to the outlet mass flow.
  </p>
  <p>
    <strong>Because of this, the ConductionElement cannot be used as a loop breaker.</strong>
  </p>
  <p>
    The advantage of this approach is that multiple ConductionElements can be connected in series without causing oscillations or fast eigenvalues between their masses. The ConductionElement implements conservation of mass and energy equations for the fluid contained within the component.
  </p>
  <p>
    For further details, see the documentation of the base class <a href=\"modelica://ThermofluidStream.Processes.Internal.PartialConductionElement\">Internal.PartialConductionElement</a>.
  </p>
  <p>
    The <code>useHeatTransferPropertyInput</code> option can be selected to enable input connectors for the overall heat transfer coefficient <code>U</code> or the thermal conductance <code>k = U*A</code>. The <code>resistanceFromAU</code> checkbox determines which quantity is activated:
  </p>
  <ul>
    <li><code>useHeatTransferPropertyInput = true</code> and <code>resistanceFromAU = true</code>: enables the <code>U</code> input (overall heat transfer coefficient)</li>
    <li><code>useHeatTransferPropertyInput = true</code> and <code>resistanceFromAU = false</code>: enables the <code>k</code> input (thermal conductance)</li>
    <li><code>useHeatTransferPropertyInput = false</code> and <code>resistanceFromAU = true</code>: enables the <code>U</code> parameter (overall heat transfer coefficient)</li>
    <li><code>useHeatTransferPropertyInput = false</code> and <code>resistanceFromAU = false</code>: enables the <code>k</code> parameter (thermal conductance)</li>
  </ul>
</html>"));
end ConductionElement;
