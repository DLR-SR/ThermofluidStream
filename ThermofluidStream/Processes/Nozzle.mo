within ThermofluidStream.Processes;
model Nozzle "Model for dynamic pressure difference"
  extends ThermofluidStream.Interfaces.SISOFlow(final L = L_value, final clip_p_out=true);

  parameter Boolean assumeConstantDensity=true "= true, if incompressibility is assumed (use '= false' for Ma > 0.3)"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean area_in_FromInput = false "= true, if input connector for inlet cross section area is enabled"
    annotation(Dialog(group="Nozzle / Diffusor definition"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Area A_in = 1 "Inlet cross-sectional area"
    annotation(Dialog(group="Nozzle / Diffusor definition", enable=not areaFromInput));
  parameter Boolean area_out_FromInput = false "= true, if input connector for outlet cross section area is enabled"
    annotation(Dialog(group="Nozzle / Diffusor definition"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Area A_out = 1 "Outlet cross-sectional area"
    annotation(Dialog(group="Nozzle / Diffusor definition", enable=not areaFromInput));
  parameter ThermofluidStream.Utilities.Units.Inertance L_value = dropOfCommons.L "Inertance"
    annotation(Dialog(tab="Advanced"));

  // ------ Parameter Display Configuration  ------------------------
  parameter Boolean displayCompressibilityApproach = true "= true, if  assumeConstantDensity is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayInletArea = true "= true, if inlet area A_in is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayOutletArea = true "= true, if outlet area A_out is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayInertance = false "=true, if inertance L is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter Boolean dA_in = displayInletArea and not area_in_FromInput "Display inlet area"
    annotation(Evaluate=true, HideResult=true);
  final parameter Boolean dA_out = displayOutletArea and not area_out_FromInput "Display outlet area"
    annotation(Evaluate=true, HideResult=true);
  final parameter Boolean displayA = dA_in or dA_out "Display inlet area or display outlet area"
    annotation(Evaluate=true, HideResult=true);
  final parameter String AreaString=
    if dA_in and dA_out then "A_in=%A_in, A_out=%A_out"
    elseif dA_in and not dA_out then "A_in = %A_in"
    elseif not dA_in and dA_out then "A_out = %A_out"
    else ""
    annotation(Evaluate=true, HideResult=true);
  final parameter String compressibilityString=
    if assumeConstantDensity then "incompressible"
    else "compressible"
    annotation(Evaluate=true, HideResult=true);
  final parameter String displayPos1=
    if displayCompressibilityApproach then
      compressibilityString
    elseif displayA then
      AreaString
    elseif displayInertance then
      "L = %L_value"
    else "" annotation(Evaluate=true, HideResult=true);
  final parameter String displayPos2=
    if displayCompressibilityApproach and displayA then
      AreaString
    elseif displayInertance and not displayPos1 == "L = %L" then
      "L = %L_value"
    else "" annotation(Evaluate=true, HideResult=true);
  final parameter String displayPos3=
    if displayCompressibilityApproach and displayA and displayInertance then
      "L = %L_value"
    else "" annotation(Evaluate=true, HideResult=true);
  //-----------------------------------------------------------------

  Modelica.Blocks.Interfaces.RealInput A_in_var(unit = "m2") if area_in_FromInput "Inlet cross-sectional area input connector [m2]" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,170}), iconTransformation(extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-60})));
  Modelica.Blocks.Interfaces.RealInput A_out_var(unit = "m2") if area_out_FromInput "Outlet cross-sectional area input connector [m2]" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,170}), iconTransformation(extent={{20,-20},{-20,20}},
        rotation=0,
        origin={120,-60})));


protected
  Modelica.Blocks.Interfaces.RealInput A_in_internal(unit = "m2") "Internal connector for inlet cross-sectional area";
  Modelica.Blocks.Interfaces.RealInput A_out_internal(unit = "m2") "Internal connector for outlet cross-section area";

  SI.Density rho_in = Medium.density(inlet.state) "Inlet density";
  SI.Density rho_out "Outlet density";

  SI.Velocity v_in "Inlet velocity";
  SI.Velocity v_out "Outlet velocity";
  //SI.Density rho_mean;
equation

   connect(A_in_var, A_in_internal);
   if not area_in_FromInput then
     A_in_internal = A_in;
   end if;

  connect(A_out_var, A_out_internal);
   if not area_out_FromInput then
     A_out_internal = A_out;
   end if;

   if assumeConstantDensity then
      rho_out = rho_in;
   else
      rho_out = Medium.density(outlet.state);
   end if;

  v_in = m_flow/(rho_in*A_in_internal);
  v_out = m_flow/(rho_out*A_out_internal);
  //rho_mean = (rho_in + rho_out)/2;
  dp = (rho_in/2)*v_in^2 - (rho_out/2)*v_out^2; //beware of density assumption....
  h_out = h_in + 1/2*(v_in^2 - v_out^2);
  Xi_out = Xi_in;

    annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Text(visible=displayParameters,
          extent={{-150,-70},{150,-100}},
          textColor={0,0,0},
          textString=displayPos1),
        Text(visible=displayParameters,
          extent={{-150,-110},{150,-140}},
          textColor={0,0,0},
          textString=displayPos2),
        Text(visible=displayParameters,
          extent={{-150,-150},{150,-180}},
          textColor={0,0,0},
          textString=displayPos3),
        Ellipse(
          extent={{-56,54},{64,-66}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-100,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-42,42},{42,-42}},
          lineColor={28,108,200}),
        Polygon(
          points={{0,60},{-60,0},{0,-60},{60,0},{0,60}},
          lineColor={28,108,200}),
        Ellipse(
          extent={{-42,42},{42,-42}},
          lineColor={170,255,170},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Sphere),
        Ellipse(
          extent={{-42,42},{42,-42}},
          lineColor={0,140,72},
          lineThickness=0.5),
        Line(visible= area_in_FromInput, points={{-102,-60},{-92,-60},{-60,0}},  color={28,108,200}),
        Line(visible= area_out_FromInput, points={{100,-60},{90,-60},{60,0}},  color={28,108,200})}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Implementation of a nozzle taking gas dynamic effects into account.</p>
<p>By default, the density is assumed to be constant across the component. This assumption can be reverted by setting <code>assumeConstantDensity = false</code> and hence the outlet velocity is computed by the outlet density. Beware that this will lead to a non-linear equation system in the component.</p>
<p>By definition, the sign of the velocity matches the sign of the mass-flow rate at the inlet.</p>
</html>"));
end Nozzle;
