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

  parameter Boolean displayInstanceNames = true "= true, if ThermofluidStream instance names are displayed" annotation(Dialog(group="Layout"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayParameters = true "= true, if displaying parameters is enabled" annotation(Dialog(group="Layout"),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter Integer instanceNameColor[3] = {28,108,200}; // Default Color: {28,108,200}

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
</html>", info="<html>
<p>The <strong>DropOfCommons</strong> defines global parameters and settings for simulation models. This model serves several purposes: </p>
<ul>
<li>It provides <strong>default physical constants</strong> (e.g., gravity acceleration) and flow properties (e.g., inertance) that are used by all components in the model.</li>
<li>It defines <strong>regularization parameters</strong> (e.g., minimal density, minimal pressure, mass flow threshold, angular velocity, and volume damping factor) that ensure numerical stability of transient simulations. These parameters must be adjusted to match the characteristics of the simulated system, for example, if the system&rsquo;s design involves mass flows on the order of magnitude of the regularization threshold (m_flow_reg), or angular velocities near omega_reg, their values should be updated to prevent artificial inaccuracies. Detailed information on the volume damping factor is available in the <a href=\"modelica://ThermofluidStream.Boundaries.Internal.PartialVolume\">PartialVolume</a> documentation.</li>
<li>It defines <strong>global assertion and error handling</strong> behavior via the <span style=\"font-family: Courier New;\">assertionLevel</span> parameter.</li>
<li>It provides <strong>layout and visualization settings</strong> for model diagrams, such as displaying instance names and parameter values.</li>
</ul>
<p>Since the global parameters defined in DropOfCommons are used by multiple ThermofluidStream components, exactly one instance of this model needs to be present at the top level of a simulation model. The basic declaration is: </p>
<p style=\"margin-left: 40px;\"><strong><span style=\"font-family: Courier New;\">inner</span></strong> ThermofluidStream.DropOfCommons dropOfCommons </p>
<p>Note, it must be an <strong>inner</strong> declaration with instance name <strong>dropOfCommons</strong> so that all components of a ThermofluidStream model can reference it. When dragging the &quot;DropOfCommons&quot; object from the package browser into the diagram layer, this declaration is automatically generated (defined via annotations in the model). </p>
<p>All flow, density, pressure, and visualization parameters in a simulation model are resolved relative to the settings in this dropOfCommons instance. Adjusting these parameters allows controlling global simulation behavior, visualization preferences, and regularization methods consistently across all components. </p>
</html>"));
end DropOfCommons;
