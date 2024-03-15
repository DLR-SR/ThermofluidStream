within ThermofluidStream.Undirected.Processes;
model FlowResistance "Flow resistance model"
  extends Interfaces.SISOBiFlow(final L=if computeL then l/(r^2*pi) else L_value, final clip_p_out=true);

  import Modelica.Constants.pi "Constant number pi";

  parameter SI.Radius r(min=0) "Radius";
  parameter SI.Length l(min=0) "Length";
  replaceable function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.pleaseSelectPressureLoss
    constrainedby ThermofluidStream.Processes.Internal.FlowResistance.partialPressureLoss
    "Pressure loss function"
    annotation(choicesAllMatching=true, Documentation(info="<html>
<p>Pressure loss function used in the flow resistance.</p>
</html>"));

  parameter Boolean computeL = true "= true, if inertance L is computed from the geometry"
    annotation(Dialog(tab="Advanced",group="Inertance"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Utilities.Units.Inertance L_value = dropOfCommons.L "Inertance"
    annotation(Dialog(tab="Advanced",group="Inertance", enable=not computeL));
  parameter SI.Density rho_min = dropOfCommons.rho_min "Minium inlet density"
    annotation(Dialog(tab="Advanced"));

protected
  SI.Density rho_rear_in = max(rho_min, Medium.density(rear.state_forwards)) "Inlet density of rear port";
  SI.DynamicViscosity mu_rear_in = Medium.dynamicViscosity(rear.state_forwards) "Inlet dynamic viscosity of rear port";

  SI.Density rho_fore_in = max(rho_min, Medium.density(fore.state_rearwards)) "Inlet density of fore port";
  SI.DynamicViscosity mu_fore_in = Medium.dynamicViscosity(fore.state_rearwards) "Inlet dynamic viscosity of fore port";

equation
  //Forwards model
  dp_fore = -pLoss(m_flow, rho_rear_in, mu_rear_in, r, l);
  h_fore_out = h_rear_in;
  Xi_fore_out = Xi_rear_in;

  //Rearwards model
  dp_rear = -pLoss(-m_flow, rho_fore_in, mu_fore_in, r, l);
  h_rear_out = h_fore_in;
  Xi_rear_out = Xi_fore_in;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
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
        Line(
          points={{40,0},{-48,0}},
          color={28,108,200},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Line(
          points={{-44,-40},{0,-10},{44,-40}},
          color={28,108,200},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Line(
          points={{-44,-15},{0,15},{44,-15}},
          color={28,108,200},
          thickness=0.5,
          smooth=Smooth.Bezier,
          origin={0,25},
          rotation=180)}), Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Undirected implementation of the FlowResistance with different selectable flow resistance functions (laminar, laminar-turbulent, linear-quadratic). The output pressure can be clipped to a certain value.</p>
</html>"));
end FlowResistance;
