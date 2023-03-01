within ThermofluidStream.Processes;
model FlowResistance "Flow resistance model"
  extends Interfaces.SISOFlow(final L=if computeL then l/(r^2*pi) else L_value, final clip_p_out=true);

  import Modelica.Constants.pi "Constant Pi";

  parameter SI.Radius r(min=0) "Radius of pipe";
  parameter SI.Length l(min=0) "Length of pipe";

  parameter Utilities.Units.Inertance L_value = dropOfCommons.L "Inertance of pipe"
    annotation(Dialog(tab="Advanced", enable=not computeL));
  parameter Boolean computeL = true "Compute L from r and l"
    annotation(Dialog(tab="Advanced"));
  parameter SI.Density rho_min = dropOfCommons.rho_min "Minimal input density"
    annotation(Dialog(tab="Advanced"));
  replaceable function pLoss = Internal.FlowResistance.pleaseSelectPressureLoss
    constrainedby Internal.FlowResistance.partialPressureLoss "Pressure loss function"
    annotation (
      choices(
        choice(
          redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.pleaseSelectPressureLoss
          "no function selected"),
        choice(
          redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss
          "linear-quadratic"),
        choice(
          redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarPressureLoss
          "laminar"),
        choice(
          redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss
          "laminar-turbulent Cheng2008"),
        choice(
          redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLossHaaland
          "laminar-turbulent Haaland1983")),
      Documentation(info="<html>
<p>
This function computes the pressure loss of the fluid depending on the massflow,
some medium properties and the geometry of the pipe.
</p>
</html>"));

protected
  SI.Density rho_in = max(rho_min, Medium.density(inlet.state))
    "density of medium entering";
  SI.DynamicViscosity mu_in = Medium.dynamicViscosity(inlet.state)
    "dynamic viscosity of medium entering";

equation
  dp = -pLoss(m_flow, rho_in, mu_in, r, l);
  h_out = h_in;
  Xi_out = Xi_in;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-56,54},{64,-66}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-70,0},{80,0}},
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
          rotation=180)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Implementation of a flow resistance pipe with different selectable
flow resistance functions (laminar, laminar-turbulent, linear-quadratic).
</p>
</html>"));
end FlowResistance;
