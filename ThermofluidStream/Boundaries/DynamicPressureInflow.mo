within ThermofluidStream.Boundaries;
model DynamicPressureInflow "Extension of (p,T) source to (p,T,velocity)"

  extends Interfaces.SISOFlow(final clip_p_out=true);

  parameter Boolean assumeConstantDensity=true "= true, if incompressibility is assumed (use '= false' for Ma > 0.3)"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean velocityFromInput = false "= true, if input connector for outlet velocity is enabled"
    annotation(Dialog(group="Nozzle / Diffusor definition"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Velocity v_in_par = 0 "Inlet velocity"
    annotation(Dialog(group="Nozzle / Diffusor definition", enable=not velocityFromInput));
  parameter Boolean areaFromInput = false "= true, if input connector for cross section area is enabled" annotation(Dialog(group="Nozzle / Diffusor definition"),Evaluate=true, HideResult=true, choices(checkBox=true));

  parameter SI.Area A_par = 1 "Outlet cross-section area"
    annotation(Dialog(group="Nozzle / Diffusor definition", enable=not areaFromInput));
  parameter Boolean extrapolateQuadratic = false "= true, if extrapolating negative velocities purely quadratic"
    annotation(Dialog(tab="Advanced", group="Regularization"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Regularization threshold of mass flow rate"
    annotation(Dialog(tab="Advanced", group="Regularization", enable = not extrapolateQuadratic));

  // ------ Parameter Display Configuration  ------------------------
  parameter Boolean displayCompressibilityApproach = true "= true, if assumeConstantDensity is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayInletVelocity = true "= true, if inlet velocity v_in_par is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayOutletArea = true "= true, if outlet cross section area A_par is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayInertance = false "= true, if inertance L is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter Boolean dv_in = displayParameters and not velocityFromInput and displayInletVelocity "Display inlet velocity"
    annotation(Evaluate=true, HideResult=true);
  final parameter Boolean displayA = displayOutletArea and not areaFromInput "Display outlet cross section area"
    annotation(Evaluate=true, HideResult=true);
  final parameter String compressibilityString = if assumeConstantDensity then "incompressible" else "compressible"
    annotation(Evaluate=true, HideResult=true);
  final parameter String displayPos1=
    if displayCompressibilityApproach then
      compressibilityString
    elseif displayA then
      "A_out = %A_par"
    elseif displayInertance then
      "L = %L"
    else "" annotation(Evaluate=true, HideResult=true);
  final parameter String displayPos2=
    if displayCompressibilityApproach and displayA then
      "A_out = %A_par"
    elseif displayInertance and not displayPos1 == "L = %L" then
      "L = %L"
    else "" annotation(Evaluate=true, HideResult=true);
  final parameter String displayPos3=
    if displayCompressibilityApproach and displayA and displayInertance then
      "L = %L"
    else "" annotation(Evaluate=true, HideResult=true);
  //----------------------------------------------------------------

  Modelica.Blocks.Interfaces.RealInput A_var(unit = "m2") if areaFromInput "Outlet cross section area input connector [m2]" annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
        rotation=180,
        origin={120,-60}),iconTransformation(extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,-60})));
  Modelica.Blocks.Interfaces.RealInput v_in_var(unit="m/s") if velocityFromInput "Inlet velocity input connector [m/s]" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-118,-60}),
                         iconTransformation(extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-60})));

protected
  Modelica.Blocks.Interfaces.RealInput A(unit = "m2") "Internal connector for cross-section area of outlet";

  SI.Density rho_in =  Medium.density(inlet.state) "Inlet density";
  SI.Density rho_out "Outlet density";
  SI.Density rho_mean "Mean density";

  Modelica.Blocks.Interfaces.RealInput v_in(unit="m/s") "Internal connector for inlet velocity";
  SI.Velocity v_out "Outlet velocity";
  SI.Velocity v_mean "Mean velocity";
  SI.Velocity delta_v "Velocity difference";

equation

   connect(A_var, A);
   if not areaFromInput then
     A = A_par;
   end if;

   connect(v_in_var, v_in);
   if not velocityFromInput then
     v_in = v_in_par;
   end if;

   if assumeConstantDensity then
      rho_out = rho_in;
   else
      rho_out = Medium.density(outlet.state);
   end if;

  v_out = inlet.m_flow/(rho_out*A);

  if extrapolateQuadratic then
    v_mean = (v_out+v_in)*0.5;
  else
    //the mean velocity is limited to half the velocity that is bound to the actual mass-flow rate
    v_mean =Undirected.Internal.regStep(
      sign(v_in)*m_flow,
      (v_out + v_in)*0.5,
      0.5*v_out,
      m_flow_reg);
  end if;
  delta_v = v_in - v_out;
  rho_mean = 0.5*(rho_in + rho_out);

  dp = rho_mean*delta_v*v_mean;
  h_out = h_in + delta_v*v_mean;
  Xi_out = Xi_in;

  annotation (
    Icon(graphics={
        Text(visible=displayInstanceName,
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Text(visible=displayParameters,
          extent={{-150,-100},{150,-130}},
          textColor={0,0,0},
          textString=displayPos1),
        Text(visible=displayParameters,
          extent={{-150,-140},{150,-170}},
          textColor={0,0,0},
          textString=displayPos2),
        Text(visible=displayParameters,
          extent={{-150,-180},{150,-210}},
          textColor={0,0,0},
          textString=displayPos3),
        Text(visible=dv_in,
          extent={{-210,-45},{-10,-75}},
          textColor={0,0,0},
          textString="v_in = %v_in_par",
          horizontalAlignment=TextAlignment.Right),
        Rectangle(
          extent={{0,78},{64,-82}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{100,0},{-100,0}},
          color={28,108,200},
          thickness=0.5),
        Rectangle(
          extent={{0,80},{60,-80}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,255,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{12,80},{12,-80}},
          color={255,255,255},
          thickness=1),
        Line(
          points={{28,80},{28,-80}},
          color={255,255,255},
          thickness=0.5),
        Line(points={{44,80},{44,-80}}, color={255,255,255}),
        Line(
          points={{60,80},{60,-80}},
          color={0,127,0},
          thickness=0.5),
        Line(visible=velocityFromInput, points={{-100,-60},{-80,-60},{0,0}}, color={0,0,127}),
        Line(visible=areaFromInput,
          points={{60,0},{90,-60},{100,-60}},
          color={0,0,127})}),
    Documentation(info="<html>
<p>This inflow boundary is supposed to start an area of the model where dynamic pressure is taken into account. The area is ended with <a href=\"modelica://ThermofluidStream.Boundaries.DynamicPressureOutflow\">DynamicPressureOutflows</a>.</p>
<p>Components that take dynamic pressure into account (marked with green symbols) should only be used in areas surrounded by DynamicPressureInflows and DynamicPressureOutflows. </p>
<p>The components input velocity can be set to a fixed value or given by a signal. From this reference inflow velocity the medium is accelerated to fit the outflow velocity, that is computed by the area of the component. The sign of the velocity is defined to match the sign of the mass-flow rate at the inlet.</p>
<p>The pressure difference resulting from the velocity difference is based on the total pressure balance, implicitly assuming a nozzle/diffusor of suitable area ratio. When the sign of the velocity does not match the sign of the mass-flow rate, this assumption cannot be upheld. The model then extrapolates the dynamic pressure difference in order to maintain a stable and well-natured behavior but its validity is lost. </p>
<p>The area can be set to a fixed value or given by a signal, representing a variable-area inlet.</p>
<p>By default, the density is assumed to be constant across the component and only the inlet density is used for the calculation of the velocity. This assumption can be reverted by setting <code>assumeConstantDensity = false</code>. This will lead to a non-linear equation system of size 1, as the outlet velocity is calculated based on the outlet density.</p>
</html>"));
end DynamicPressureInflow;
