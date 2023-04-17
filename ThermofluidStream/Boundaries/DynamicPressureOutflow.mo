within ThermofluidStream.Boundaries;
model DynamicPressureOutflow
  "Flow from a reference velocity through a certain cross section"
  extends Interfaces.SISOFlow(final clip_p_out=true);

  parameter Boolean areaFromInput = false "Use input connector for cross section area?";
  parameter Boolean velocityFromInput = false "Use input connector for inlet speed?";
  parameter SI.Area A_par = 1 "Cross-section area of outlet boundary"
    annotation(Dialog(enable=not areaFromInput));
  parameter SI.Velocity v_out_par = 0 "Reference velocity for p0. Positive velocity points from inside the boundary to outside"
    annotation(Dialog(enable=not velocityFromInput));
  parameter Boolean assumeConstantDensity=true "If true only inlet density is applied"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean extrapolateQuadratic = false "If true extrapolation for neagive velocities is done purly quadratic"
    annotation(Dialog(tab="Advanced", group="Regularization"));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Regularization threshold of mass flow rate"
    annotation(Dialog(tab="Advanced", group="Regularization", enable = not extrapolateQuadratic));

  Modelica.Blocks.Interfaces.RealInput A_var(unit = "m2") = A if areaFromInput "Area input connector [m2]" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100}), iconTransformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));
  Modelica.Blocks.Interfaces.RealInput v_out_var(unit="m/s")=v_out if velocityFromInput "Velocity input connector [m/s]" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,100}), iconTransformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,100})));

protected
  SI.Area A "Cross-section area of outlet boundary";

  SI.Velocity v_in;
  SI.Velocity v_out "Reference velocity for p0. Positive velocity points from inside the boundary to outside";

  SI.Density rho_in =  Medium.density(inlet.state) "density of medium entering";
  SI.Density rho_out "density of medium exiting";

  SI.Velocity v_mean;
  SI.Velocity delta_v;

equation
   if not areaFromInput then
     A = A_par;
   end if;

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

  dp = (rho_in+rho_out)*0.5*delta_v*v_mean;
  h_out = h_in + delta_v*v_mean;
  Xi_out = Xi_in;

  annotation (Icon(graphics={
        Rectangle(
          extent={{-58,76},{6,-84}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
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
          points={{80,0},{2,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-12,80},{-12,-80}},
          color={255,255,255},
          thickness=1),
        Line(
          points={{-28,80},{-28,-80}},
          color={255,255,255},
          thickness=0.5),
        Line(points={{-44,80},{-44,-80}},
                                        color={255,255,255}),
        Line(
          points={{-60,0},{-80,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-60,80},{-60,-80}},
          color={0,127,0},
          thickness=0.5)}), Documentation(info="<html>
<p>This Outflow Boundary is supposed to end a area of the model where dynamic pressure is taken into account. The area is started with DynamicPressureInflows. </p>
<p>Components that take dynamic pressure into account (marked with green symbols) should only be used in areas surrounded by DynamicPressureInflows and DynamicPressureOutflows. </p>
<p>The components output velocity can be set to a fixed Value or given by a signal. From the inflow velocity, that is computed by the Area of the Component, the flow is decelerated to the reference outflow velocity.</p>
<p>The pressure difference resulting from the velocity difference is based on the total pressure balance, implicitly assuming a nozzle/diffusor of suitable area ratio. When the sign of the velocity does not match the sign of the mass-flow rate, this assumption cannot be upheld. The model then extrapolates the dyanmic pressure difference in order to maintain a stable and well-natured behavior but its validity is lost. </p>
<p>The area can be set to a fixed value or given by a signal, representing a variable-area outlets.</p>
<p>In general the component has a non-linear equation system of size 1, because it computes the outlet velocity based on the outlet density. This can be resolved by setting Advanced-&gt;assumeConstantDensity=true (default: false), because then only the inlet density is used in the whole component.</p>
</html>"));
end DynamicPressureOutflow;
