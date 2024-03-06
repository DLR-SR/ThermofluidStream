within ThermofluidStream.Boundaries;
model DynamicPressureOutflow
  "Flow from a reference velocity through a certain cross section"

  extends Interfaces.SISOFlow(final clip_p_out=true);

  parameter Boolean displayOutletVelocity = true "= true, if you wish to display the inlet velocity parameter value (this does not work for velocityFromInput)" annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayInletArea = true "= true, if you wish to display the outlet area parameter value (this does not work for areaFromInput)" annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayCompressibilityApproach = true "= true, if you wish to display assumeConstantDensity" annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));


  final parameter String compressibilityString = if assumeConstantDensity then "incompressible" else "compressible"  annotation(Evaluate=true, HideResult=true);
  final parameter Boolean d1c = displayParameters and displayCompressibilityApproach "displayCompressibilityApproach at position 1" annotation(Evaluate=true, HideResult=true);
  final parameter Boolean d1A = displayParameters and displayInletArea and not areaFromInput and not d1c "displayInletArea at position 1" annotation(Evaluate=true, HideResult=true);
  final parameter Boolean d2A = displayParameters and displayInletArea and not areaFromInput and not d1A "displayInletArea at position 2" annotation(Evaluate=true, HideResult=true);
  final parameter Boolean d1v = displayParameters and displayOutletVelocity and not velocityFromInput and not d1c and not d1A "displayOutletVelocity at position 1" annotation(Evaluate=true, HideResult=true);
  final parameter Boolean d2v = displayParameters and displayOutletVelocity and not velocityFromInput and not d2A and not d1v "displayOutletVelocity  at position 2" annotation(Evaluate=true, HideResult=true);
  final parameter Boolean d3v = displayParameters and displayOutletVelocity and not velocityFromInput and not d1v and not d2v "displayOutletVelocity  at position 3" annotation(Evaluate=true, HideResult=true);



  parameter Boolean areaFromInput = false "= true to use input connector for inlet cross section area";
  parameter Boolean velocityFromInput = false "= true to use input connector for outlet velocity";
  parameter SI.Area A_par = 1 "Inlet cross-section area"
    annotation(Dialog(enable=not areaFromInput));
  parameter SI.Velocity v_out_par = 0 "Outlet velocity set value"
    annotation(Dialog(enable=not velocityFromInput));
  parameter Boolean assumeConstantDensity= true "= true for incompressibility assumption applied, use '= false' for Ma > 0.3";
  parameter Boolean extrapolateQuadratic = false "= true to extrapolate negative velocities purely quadratic"
    annotation(Dialog(tab="Advanced", group="Regularization"));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Regularization threshold of mass flow rate"
    annotation(Dialog(tab="Advanced", group="Regularization", enable = not extrapolateQuadratic));

  Modelica.Blocks.Interfaces.RealInput A_var(unit = "m2") if areaFromInput "Area input connector [m2]" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-104,-60}),
                         iconTransformation(extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-60})));
  Modelica.Blocks.Interfaces.RealInput v_out_var(unit="m/s") if velocityFromInput "Velocity input connector [m/s]" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-96,-60}), iconTransformation(extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,-60})));

protected
  Modelica.Blocks.Interfaces.RealInput A(unit = "m2") "Internal connector for cross-section area of inlet boundary";

  SI.Velocity v_in;
  Modelica.Blocks.Interfaces.RealInput v_out(unit="m/s") "Internal connector for reference velocity";

  SI.Density rho_in =  Medium.density(inlet.state) "density of medium entering";
  SI.Density rho_out "density of medium exiting";

  SI.Velocity v_mean;
  SI.Velocity delta_v;
  SI.Density rho_mean "Mean density";
equation
   connect(A_var, A);
   if not areaFromInput then
     A = A_par;
   end if;

   connect(v_out_var, v_out);
   if not velocityFromInput then
     v_out = v_out_par;
   end if;

   if assumeConstantDensity then
      rho_out = rho_in;
   else
      rho_out = Medium.density(outlet.state);
   end if;

  v_in = inlet.m_flow/(rho_in*A);

  if extrapolateQuadratic then
    v_mean = (v_out+v_in)*0.5;
  else
    //the mean velocity is limited to half the velocity that is bound to the actual mass-flow rate
    v_mean =Undirected.Internal.regStep(
      sign(v_out)*m_flow,
      (v_out + v_in)*0.5,
      0.5*v_in,
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
          textColor={0,0,255}),
        Text(visible=d1c,
          extent={{-150,-100},{150,-130}},
          textColor={0,0,0},
          textString=compressibilityString),
        Text(visible=d1v,
          extent={{-150,-100},{150,-130}},
          textColor={0,0,0},
          textString="v_out = %v_out_par"),
        Text(visible=d1A,
          extent={{-150,-100},{150,-130}},
          textColor={0,0,0},
          textString="A_in = %A_par"),
        Text(visible=d2v,
          extent={{-150,-140},{150,-170}},
          textColor={0,0,0},
          textString="v_out = %v_out_par"),
        Text(visible=d2A,
          extent={{-150,-140},{150,-170}},
          textColor={0,0,0},
          textString="A_in = %A_par"),
        Text(visible=d3v,
          extent={{-150,-180},{150,-210}},
          textColor={0,0,0},
          textString="v_out = %v_out_par"),
        Rectangle(
          extent={{-58,76},{6,-84}},
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
          extent={{-30,80},{30,-80}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,255,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={-30,0},
          rotation=180),
        Line(
          points={{-12,80},{-12,-80}},
          color={255,255,255},
          thickness=1),
        Line(
          points={{-28,80},{-28,-80}},
          color={255,255,255},
          thickness=0.5),
        Line(
          points={{-44,80},{-44,-80}},
          color={255,255,255}),
        Line(
          points={{-60,80},{-60,-80}},
          color={0,127,0},
          thickness=0.5),
        Line(visible=areaFromInput, points={{-100,-60},{-92,-60},{-60,0}}, color={28,108,200}),
        Line(visible=velocityFromInput, points={{100,-60},{60,-60},{0,0}}, color={28,108,200})}),
    Documentation(info="<html>
<p>This outflow boundary is supposed to end an area of the model where dynamic pressure is taken into account. The area is started with <a href=\"modelica://ThermofluidStream.Boundaries.DynamicPressureInflow\">DynamicPressureInflows</a>. </p>
<p>Components that take dynamic pressure into account (marked with green symbols) should only be used in areas surrounded by DynamicPressureInflows and DynamicPressureOutflows. </p>
<p>The components output velocity can be set to a fixed value or given by a signal. From the inflow velocity, that is computed by the area of the component, the flow is decelerated to the reference outflow velocity. The sign of the velocity is defined to match the sign of the mass-flow rate at the inlet.</p>
<p>The pressure difference resulting from the velocity difference is based on the total pressure balance, implicitly assuming a nozzle/diffusor of suitable area ratio. When the sign of the velocity does not match the sign of the mass-flow rate, this assumption cannot be upheld. The model then extrapolates the dynamic pressure difference in order to maintain a stable and well-natured behavior but its validity is lost. </p>
<p>The area can be set to a fixed value or given by a signal, representing a variable-area outlet.</p>
<p>By default, the density is assumed to be constant across the component and only the inlet density is used for the calculation of the velocity. This assumption can be reverted by setting <code>assumeConstantDensity = false</code>. This will lead to a non-linear equation system of size 1, as the outlet velocity is calculated based on the outlet density.</p>
</html>"));
end DynamicPressureOutflow;
