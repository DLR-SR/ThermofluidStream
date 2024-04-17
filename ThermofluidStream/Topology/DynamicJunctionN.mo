within ThermofluidStream.Topology;
model DynamicJunctionN "Junction with N inlets and one outlet, taking dynamic pressure into account"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));
  parameter Boolean assumeConstantDensity=true "= true, if incompressibility is assumed (use '= false' for Ma > 0.3)"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Integer N(min=1) = 1 "Number of inlets";
  parameter SI.Area A[N] "Cross section area of inlets";
  parameter SI.Area A_out "Outlet cross section area";
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Regularization threshold for small mass flows"
    annotation (Dialog(tab="Advanced"));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance of each inlet/outlet"
    annotation (Dialog(tab="Advanced"));

  Interfaces.Inlet inlets[N](redeclare package Medium = Medium) "Vector of N inlets"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
      iconTransformation(extent={{-120,-20},{-80,20}})));
  Interfaces.Outlet outlet(redeclare package Medium = Medium) "Outlet"
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
      iconTransformation(extent={{80,-20},{120,20}})));
  JunctionN junction(
    redeclare package Medium = Medium,
    N=N,
    assumeConstantDensity=assumeConstantDensity) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Boundaries.DynamicPressureInflow
                   dynamicPressureInflow(
    redeclare package Medium = Medium,
    velocityFromInput=true,
    A_par=A_out,
    assumeConstantDensity=assumeConstantDensity,
    extrapolateQuadratic=true)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.RealExpression v_mix(y=sqrt(sum(junction.w .* (junction.inlets.m_flow ./ (junction.rho.*A)) .^ 2)))
    "Conservation of kinetic energy" annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));

equation
  connect(inlets, junction.inlets) annotation (Line(
      points={{-100,0},{-40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureInflow.outlet, outlet) annotation (Line(
      points={{40,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(junction.outlet, dynamicPressureInflow.inlet) annotation (Line(
      points={{-20,0},{20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(v_mix.y, dynamicPressureInflow.v_in_var) annotation (Line(points={{1,-20},{12,-20},{12,-6},{18,-6}},
                                                                                                      color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
       Text(visible=displayInstanceName,
          extent={{-150,65},{150,25}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Line(
          points={{-100,0},{100,0}},
          color={0,127,0},
          thickness=0.5),
        Ellipse(
          extent={{-6,6},{6,-6}},
          lineColor={0,127,0},
          fillColor={170,255,170},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{-120,-20},{-80,-60}},
          textColor={175,175,175},
          textString="%N"),
        Ellipse(
          extent={{-20,20},{20,-20}},
          lineThickness=0.5,
          lineColor={170,255,170})}),
    Diagram(
      coordinateSystem(preserveAspectRatio=true),
      graphics={
        Text(
          extent={{-40,60},{40,40}},
          textColor={28,108,200},
          textString="Use of dynamicInflow instead of nozzle,
because velocity can directly be set, instead of A,
that will need regularization for low massflow.")}),
    Documentation(info="<html>
<p>Junction that takes dynamic pressure into account.</p>
<p>This junction model (see fig. 1) mixes fluids of different velocity entering the mixing chamber by different cross section areas and outputs the mixed fluid on an outlet with a separate area.</p>
<p>The pressure balance is done on the steady-state pressure, and mixing (red) assumes to preserve the kinetic energy of the fluid, resulting in an effective mixing velocity and area. This implies, that the mixing area A_mix changes during the simulation, which can be interpreted as narrowing down the mixing area by flow separation. </p>
<p>After mixing the fluid is accelerated to match the outlet area. </p>
<p>In general the component has two non-linear equation systems of size 1. This can be resolved by setting Advanced-&gt;assumeConstantDensity=true (default: false), simplifying several computations under the assumption of constant density of all fluid streams being mixed.</p>
<p><img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Topology.DynamicJunctionN.png\"/></p>
<p>fig. 1</p>
</html>"));
end DynamicJunctionN;
