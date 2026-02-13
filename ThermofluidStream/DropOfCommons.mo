within ThermofluidStream;
model DropOfCommons "Model for global parameters"

  parameter Utilities.Units.Inertance L = 0.01 "Inertance of the flow"
      annotation(Dialog(tab="Advanced"));

  parameter SI.MassFlowRate m_flow_reg = 0.01
    "Regularization threshold of mass flow rate"
    annotation(Dialog(group="Regularization"));
  parameter SI.AngularVelocity omega_reg = 1
    "Angular velocity used for regularization"
    annotation(Dialog(group="Regularization"));
  parameter SI.Density rho_min = 1e-10 "Minimum allowed density"
    annotation(Dialog(group="Regularization"));
  parameter SI.Pressure p_min = 100 "Minimal steady-state pressure"
    annotation(Dialog(group="Regularization"));
  parameter Real k_volume_damping(unit="1")= 0.1 "Volume damping factor multiplicator"
    annotation(Dialog(group="Regularization"));
  parameter SI.Acceleration g = Modelica.Constants.g_n "Acceleration of gravity";

  parameter AssertionLevel assertionLevel = AssertionLevel.error "Global assertion level";

  parameter Boolean displayInstanceNames = false "= true, if ThermofluidStream instance names are displayed" annotation(Dialog(group="Layout"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayParameters = false "= true, if displaying parameters is enabled" annotation(Dialog(group="Layout"),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter Integer instanceNameColor[3] = {28,108,200}; // {28,108,200}

  annotation (defaultComponentName="dropOfCommons",
    defaultComponentPrefixes="inner",
    missingInnerMessage="
Your model is using an outer \"dropOfCommons\" component but
an inner \"dropOfCommons\" component is not defined.
Use ThermoFluidStream.DropOfCommons in your model
to specify system properties.",Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-80,-60},{80,-100}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{0,100},{16,36},{80,-32},{0,-100},{-82,-30},{-18,36},{0,100}},
          lineColor={170,213,255},
          smooth=Smooth.Bezier,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{6,42},{20,16},{44,-14},{22,-38},{6,42}},
          smooth=Smooth.Bezier,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-6,-76},{-40,-62},{-56,-30},{-30,-44},{-6,-76}},
          pattern=LinePattern.None,
          smooth=Smooth.Bezier,
          fillColor={19,76,141},
          fillPattern=FillPattern.Solid)}), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/dlr_logo.png\"/>(c) 2020-2021, DLR, Institute of System Dynamics and Control</p>
</html>"));
end DropOfCommons;
