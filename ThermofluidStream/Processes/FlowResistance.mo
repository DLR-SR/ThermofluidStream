within ThermofluidStream.Processes;
model FlowResistance "Flow resistance model"
  extends Interfaces.SISOFlow(final L=if computeL then l/areaHydraulic else
        L_value, final clip_p_out=true);

  import Modelica.Constants.pi "Constant Pi";
  import ThermofluidStream.Processes.Internal.ShapeOfResistance "Shape of cross sectional area";

  replaceable function pLoss = Internal.FlowResistance.pleaseSelectPressureLoss
    constrainedby Internal.FlowResistance.partialPressureLoss
    "Pressure loss function" annotation (choices(
      choice(redeclare function pLoss =
            ThermofluidStream.Processes.Internal.FlowResistance.pleaseSelectPressureLoss
          "No function selected"),
      choice(redeclare function pLoss =
            ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss
          "Linear-quadratic"),
      choice(redeclare function pLoss =
            ThermofluidStream.Processes.Internal.FlowResistance.laminarPressureLoss
          "Laminar (Hagen-Poiseuille)"),
      choice(redeclare function pLoss =
            ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss
          "Laminar-turbulent (Cheng2008)"),
      choice(redeclare function pLoss =
            ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLossHaaland
          "Laminar-turbulent (Haaland1983)"),
      choice(redeclare function pLoss =
            ThermofluidStream.Processes.Internal.FlowResistance.zetaPressureLoss
          "Fixed pressure loss coefficient"),
      choice(redeclare function pLoss =
            ThermofluidStream.Processes.Internal.FlowResistance.referencePressureLoss
          "Use reference point (dp, m_flow, d)_ref")), Documentation(info="<html>
<p>
This function computes the pressure loss of the fluid depending on the massflow,
some medium properties and the geometry of the pipe.
</p>
</html>"));
  parameter SI.Length l(min=0) "Length" annotation (Dialog(group="Geometry"));
  parameter ShapeOfResistance shape=ThermofluidStream.Processes.Internal.ShapeOfResistance.circular
    "Cross section shape" annotation (Dialog(group="Geometry", enable=true));
  parameter SI.Radius r(min=0) = 0 "Radius" annotation (Dialog(group="Geometry",
        enable=(shape == ThermofluidStream.Processes.Internal.ShapeOfResistance.circular)));
  parameter SI.Length a(min=0) = 0 "Rectangle width" annotation (Dialog(group="Geometry",
        enable=(shape == ThermofluidStream.Processes.Internal.ShapeOfResistance.rectangle)));
  parameter SI.Length b(min=0) = 0 "Rectangle height" annotation (Dialog(group="Geometry",
        enable=(shape == ThermofluidStream.Processes.Internal.ShapeOfResistance.rectangle)));
  parameter SI.Area areaCrossInput(min=0) = 0 "Cross-sectional area"
    annotation (Dialog(group="Geometry", enable=(shape == ThermofluidStream.Processes.Internal.ShapeOfResistance.other)));
  parameter SI.Length perimeterInput(min=0) = 0 "Wetted perimeter" annotation (
      Dialog(group="Geometry", enable=(shape == ThermofluidStream.Processes.Internal.ShapeOfResistance.other)));
  parameter Boolean computeL=true
    "= true, if inertance L is computed from the geometry" annotation (
    Dialog(tab="Advanced", group="Inertance"),
    Evaluate=true,
    HideResult=true,
    choices(checkBox=true));
  parameter Utilities.Units.Inertance L_value=dropOfCommons.L "Inertance"
    annotation (Dialog(
      tab="Advanced",
      group="Inertance",
      enable=not computeL));
  parameter SI.Density rho_min=dropOfCommons.rho_min "Minimal inlet density"
    annotation (Dialog(tab="Advanced"));
  parameter SI.Pressure p_reference = 6e5
    "Reference value for the intensity of coloring";

  Real phi(min=0, max=1) "Normalized pressure for coloring the flow resistance";

  final parameter SI.Length D_h=4*areaCross/perimeter "Hydraulic diameter";
  final parameter SI.Length perimeter=if shape == ShapeOfResistance.circular
       then 2*pi*r elseif shape == ShapeOfResistance.rectangle then 2*a + 2*b
       else perimeterInput "Perimeter";
  final parameter SI.Area areaCross=if shape == ShapeOfResistance.circular
       then pi*r*r elseif shape == ShapeOfResistance.rectangle then a*b else
      areaCrossInput "Cross-sectional area";
  final parameter SI.Area areaHydraulic=pi*D_h*D_h*1/4
    "Hydraulic cross-sectional area";

protected
  SI.Density rho_in=max(rho_min, Medium.density(inlet.state)) "Inlet density";
  SI.DynamicViscosity mu_in=Medium.dynamicViscosity(inlet.state)
    "Inlet dynamic viscosity";

equation
  dp = -pLoss(
    m_flow,
    rho_in,
    mu_in,
    D_h/2,
    l);
  h_out = h_in;
  Xi_out = Xi_in;
  phi = noEvent(max(0, min(1, abs(dp)/p_reference)));

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(
          visible=displayInstanceName,
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
          fillColor=DynamicSelect({255,255,255}, if dropOfCommons.showColor == true
               then {255,integer(255*(1 - phi)),integer(255*(1 - phi))} else {255,
              255,255}),
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
          rotation=180)}),
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>
Implementation of a flow resistance pipe with different selectable
flow resistance functions (laminar, laminar-turbulent, linear-quadratic).
</p>
</html>"));
end FlowResistance;
