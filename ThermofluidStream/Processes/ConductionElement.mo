within ThermofluidStream.Processes;
model ConductionElement "Model of quasi-stationary mass and heat transfer"

  extends Internal.PartialConductionElement;

  parameter Boolean resistanceFromInput = false "= true, if input connector for either U or k_par is enabled"
    annotation(Dialog(group="Thermal Conductance"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean resistanceFromAU = true "= true, if thermal conductance is given by U*A"
    annotation(Dialog(group="Thermal Conductance"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Area A = 1 "Heat transfer area"
    annotation(Dialog(group="Thermal Conductance", enable=resistanceFromAU));
  parameter SI.CoefficientOfHeatTransfer U = 200 "Overall heat transfer coefficient"
    annotation(Dialog(group="Thermal Conductance", enable=(resistanceFromAU and not resistanceFromInput)));
  parameter SI.ThermalConductance k_par = 200 "Thermal conductance"
    annotation(Dialog(group="Thermal Conductance", enable=(not resistanceFromAU and not resistanceFromInput)));
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
    if resistanceFromInput and resistanceFromAU then "A=%A"
    elseif not resistanceFromInput and resistanceFromAU  then "A=%A, U=%U"
    elseif not resistanceFromInput and not resistanceFromAU then "k=%k_par"
    else "" annotation(Evaluate=true, HideResult=true);
  //-----------------------------------------------------------------

  Modelica.Blocks.Interfaces.RealInput U_var(unit = "W/(m2.K)") if (resistanceFromInput and resistanceFromAU) "Overall heat transfer coefficient input connector [W/(m2.K)]"
    annotation (Placement(transformation(extent={{-20,20},{20,-20}},
        rotation=90,
        origin={-60,-120})));
  Modelica.Blocks.Interfaces.RealInput k_var(unit="W/K") if (resistanceFromInput and not resistanceFromAU) "Thermal conductance input connector [W/K]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120})));

protected
  Modelica.Blocks.Interfaces.RealInput U_internal(unit = "W/(m2.K)") "Internal connector for overall heat transfer coefficient";
  Modelica.Blocks.Interfaces.RealInput k_internal(unit="W/K") "Internal connector for thermal conductance";

equation
  connect(U_var, U_internal);
  if resistanceFromAU and not resistanceFromInput then
    U_internal = U;
  end if;

  connect(k_var, k_internal);
  if not resistanceFromAU and not resistanceFromInput then
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
          visible=not displayAnything,
          points={{0,-60},{0,-100}},
          color={191,0,0}),
        Line(visible = resistanceFromInput,
        points={{-60,-100},{0,-100}}, color={0,0,127})}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>This model is an element with a fixed volume (fig. 1). The mass in the volume is assumed quasi-stationary (statically computed with volume and density), and the inlet massflow is coupled to the outlet massflow. </p>
<p><strong>Because of this the ConductionElement cannot be used as a loop breaker.</strong> </p>
<p>The advantage is that multiple ConductionElements can be put behind each other without worrying about oscillations or fast eigenvalues between their masses. The ConductionElement implements equations for conservation of mass and energy for the fluid mass contained in the component. </p>
<p>For further documentation see the documentation of the <a href=\"modelica://ThermofluidStream.Processes.Internal.PartialConductionElement\">motherclass</a>. </p>
<p>ResistanceFromInput can be selected to enable input connectors for the overall heat transfer coefficient U or thermal conductance k. The resistanceFromAU checkbox defines which input gets enabled.</p>
<ul>
<li>ResistanceFromInput=<strong>true</strong> and resistanceFromAU=<strong>true</strong>: U input gets enabled (overall heat transfer coefficient)</li>
<li>ResistanceFromInput=<strong>true</strong> and resistanceFromAU=<strong>false</strong>: k input gets enabled (thermal conductance)</li>
</ul>
</html>"));
end ConductionElement;
