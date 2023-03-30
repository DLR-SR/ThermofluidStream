within ThermofluidStream.Processes;
model FlowResistance "Flow resistance model"
  extends Interfaces.SISOFlow(final L=if computeL then l/(r^2*pi) else L_value, final clip_p_out=true);

  import Modelica.Constants.pi "Constant Pi";

  parameter Internal.ShapeOfResistance shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular "Shape of cross sectional area"
    annotation (Dialog(group = "Geometry",enable=true),
    choices(
      choice=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular "Circular",
      choice=ThermofluidStream.Processes.Internal.ShapeOfResistance.rectangle "Rectangle",
      choice=ThermofluidStream.Processes.Internal.ShapeOfResistance.other "Rectangle"));

  parameter SI.Length l(min=0) "Length of pipe" annotation (Dialog(group = "Geometry"));
  parameter SI.Radius r(min=0) = 0 "Radius of pipe"
  annotation (Dialog(group = "Geometry", enable=(shape == ThermofluidStream.Processes.Internal.ShapeOfResistance.circular)));
  parameter SI.Length a(min=0) = 0 "Rectangle width"
    annotation(Dialog(group = "Geometry", enable=(shape == ThermofluidStream.Processes.Internal.ShapeOfResistance.rectangle)));
  parameter SI.Length b(min=0) = 0 "Rectangle height"
    annotation(Dialog(group = "Geometry", enable=(shape == ThermofluidStream.Processes.Internal.ShapeOfResistance.rectangle)));
  parameter SI.Area areaCross = Modelica.Constants.pi*r*r "Cross section area"
    annotation(Dialog(group = "Geometry", enable=(shape == ThermofluidStream.Processes.Internal.ShapeOfResistance.other)));
  parameter SI.Length perimeter = 2*Modelica.Constants.pi*r "Wetted perimeter of cross-section"
    annotation(Dialog(group = "Geometry", enable=(shape == ThermofluidStream.Processes.Internal.ShapeOfResistance.other)));

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
          "No function selected"),
        choice(
          redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss
          "Linear-quadratic"),
        choice(
          redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarPressureLoss
          "Laminar (Hagen-Poiseuille)"),
        choice(
          redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss
          "Laminar-turbulent (Cheng2008)"),
        choice(
          redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLossHaaland
          "Laminar-turbulent (Haaland1983)")),
      Documentation(info="<html>
<p>
This function computes the pressure loss of the fluid depending on the massflow,
some medium properties and the geometry of the pipe.
</p>
</html>"));

protected
  SI.Density rho_in = max(rho_min, Medium.density(inlet.state))
    "Density of medium entering";
  SI.DynamicViscosity mu_in = Medium.dynamicViscosity(inlet.state)
    "Dynamic viscosity of medium entering";
  SI.Length perimeterActual "Actual perimeter of resistance";
  SI.Area areaCrossActual "Actual area of resistance";
  SI.Length r_h "Hydraulic radius of resistance";

equation
  dp = -pLoss(m_flow, rho_in, mu_in, r_h, l);
  h_out = h_in;
  Xi_out = Xi_in;

  //Match relevant geometrical values from inputs
  if shape == ThermofluidStream.Processes.Internal.ShapeOfResistance.circular then
    perimeterActual = 2*Modelica.Constants.pi*r;
    areaCrossActual = Modelica.Constants.pi*r*r;
    r_h = r;
  elseif shape == ThermofluidStream.Processes.Internal.ShapeOfResistance.rectangle then
    perimeterActual = 2*a+2*b;
    areaCrossActual = a*b;
    r_h = areaCrossActual/perimeterActual;
  elseif shape == ThermofluidStream.Processes.Internal.ShapeOfResistance.other then
    perimeterActual = perimeter;
    areaCrossActual = areaCross;
    r_h = areaCrossActual/perimeterActual;
  end if;

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
