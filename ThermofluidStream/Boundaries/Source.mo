within ThermofluidStream.Boundaries;
model Source "Boundary model of a source"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model"
     annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Source. Make sure it is the same as the one
the inlet the source is connected to.
</p>
</html>"));

  parameter Boolean setEnthalpy = false "Prescribe specific enthalpy instead of temperature?";
  parameter Boolean pressureFromInput = false "Use input connector for pressure?";
  parameter Boolean temperatureFromInput = false "Use input connector for temperature?"
    annotation(Dialog(enable = not setEnthalpy));
  parameter Boolean enthalpyFromInput = false "Use input connector for specific enthalpy"
    annotation(Dialog(enable = setEnthalpy));
  parameter Boolean xiFromInput = false "Use input connector for mass fraction?";
  parameter SI.Temperature T0_par = Medium.T_default "Temperature set value"
    annotation(Dialog(enable = not setEnthalpy and not temperatureFromInput));
  parameter SI.Pressure p0_par = Medium.p_default "Pressure set value"
    annotation(Dialog(enable = not pressureFromInput));
  parameter SI.SpecificEnthalpy h0_par = Medium.h_default "Specific enthalpy set value"
    annotation(Dialog(enable = setEnthalpy and not enthalpyFromInput));
  parameter Medium.MassFraction Xi0_par[Medium.nXi] = Medium.X_default[1:Medium.nXi] "Mass fraction set value"
    annotation(Dialog(enable = not xiFromInput));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance"
    annotation (Dialog(tab="Advanced"));

  Modelica.Blocks.Interfaces.RealInput p0_var(unit="Pa")= p0 if pressureFromInput "Pressure input connector [Pa]"
    annotation (Placement(transformation(extent={{-40,40},{0,80}}), iconTransformation(extent={{-40,40},{0,80}})));
  Modelica.Blocks.Interfaces.RealInput T0_var(unit = "K") = T0 if temperatureFromInput "Temperature input connector [K]"
    annotation (Placement(transformation(extent={{-40,0},{0,40}}), iconTransformation(extent={{-40,-20},{0,20}})));
  Modelica.Blocks.Interfaces.RealInput h0_var(unit = "J/kg")= h0 if enthalpyFromInput "Enthalpy input connector [J/kg]"
    annotation (Placement(transformation(extent={{-40,-40},{0,0}}), iconTransformation(extent={{-40,-20},{0,20}})));
  Modelica.Blocks.Interfaces.RealInput xi_var[Medium.nXi](each unit = "kg/kg")= Xi0 if xiFromInput "Mass fraction connector [kg/kg]"
    annotation (Placement(transformation(extent={{-40,-80},{0,-40}}), iconTransformation(extent={{-40,-80},{0,-40}})));
  Interfaces.Outlet outlet(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));

protected
  outer DropOfCommons dropOfCommons;

  SI.Temperature T0;
  SI.Pressure p0;
  SI.SpecificEnthalpy h0;
  Medium.MassFraction Xi0[Medium.nXi];

equation

   if not temperatureFromInput then
     T0 = T0_par;
   end if;

   if not pressureFromInput then
     p0 = p0_par;
   end if;

   if not xiFromInput then
     Xi0 = Xi0_par;
   end if;

   if not enthalpyFromInput then
     h0 = h0_par;
   end if;

  L*der(outlet.m_flow) = outlet.r - 0;
  outlet.state =  if not setEnthalpy then Medium.setState_pTX(p0,T0,Xi0) else Medium.setState_phX(p0, h0, Xi0);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{0,76},{64,-84}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{0,80},{60,-80}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{60,0},{80,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{60,80},{60,-80}},
          color={28,108,200},
          thickness=0.5),
        Line(points={{44,80},{44,-80}}, color={255,255,255}),
        Line(
          points={{28,80},{28,-80}},
          color={255,255,255},
          thickness=0.5),
        Line(
          points={{12,80},{12,-80}},
          color={255,255,255},
          thickness=1)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Source of a Thermofluid Stream. The state can be given as fix values or as a real signal. </p>
<p>Before its inertance the source has an inertial pressure of 0 by definition.</p>
</html>"));
end Source;
