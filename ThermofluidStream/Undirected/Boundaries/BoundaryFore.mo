within ThermofluidStream.Undirected.Boundaries;
model BoundaryFore "Generic Boundary model (may act as source or sink)"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Boundary. Make sure it is the same as the one the port is connected to.</p>
</html>"));

  parameter Boolean setEnthalpy = false "Prescribe specific enthalpy instead of temperature?";
  parameter Boolean temperatureFromInput = false "Use input connector for temperature?" annotation(Dialog(enable = not setEnthalpy));
  parameter Boolean pressureFromInput = false "Use input connector for pressure?";
  parameter Boolean enthalpyFromInput = false "Use input connector for specific enthalpy"
    annotation(Dialog(enable = setEnthalpy));
  parameter Boolean xiFromInput = false "Use input connector for mass Fraction?";
  parameter SI.SpecificEnthalpy h0_par = Medium.h_default "Specific enthalpy set value" annotation(Dialog(enable = setEnthalpy and not enthalpyFromInput));
  parameter SI.Temperature T0_par = Medium.T_default "Temperature set value" annotation(Dialog(enable = not setEnthalpy and not temperatureFromInput));
  parameter SI.Pressure p0_par = Medium.p_default "Pressure set value" annotation(Dialog(enable = not pressureFromInput));
  parameter Medium.MassFraction Xi0_par[Medium.nXi] = Medium.X_default[1:Medium.nXi] "Mass Fraction set value"
    annotation(Dialog(enable = not xiFromInput));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Regularization threshold of mass flow rate"
    annotation(Dialog(tab="Advanced"));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance of the boundary"
    annotation (Dialog(tab="Advanced"));

  Modelica.Blocks.Interfaces.RealInput p0_var(unit="Pa")= p0 if pressureFromInput "Pressure input connector [Pa]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=180, origin={20,60}),
      iconTransformation(extent={{-20,-20},{20,20}}, rotation=180, origin={20,60})));
  Modelica.Blocks.Interfaces.RealInput T0_var(unit = "K") = T0 if temperatureFromInput "Temperature input connector [K]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=180, origin={20,20}),
      iconTransformation(extent={{-20,-20},{20,20}}, rotation=180, origin={20,0})));
  Modelica.Blocks.Interfaces.RealInput h0_var(unit = "J/kg")= h0 if enthalpyFromInput "Enthalpy input connector"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=180, origin={20,-20}),
      iconTransformation(extent={{-20,-20},{20,20}}, rotation=180, origin={20,0})));
  Modelica.Blocks.Interfaces.RealInput xi_var[Medium.nXi](each unit = "kg/kg")= Xi0 if xiFromInput "Mass fraction connector [kg/kg]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=180, origin={20,-60}),
      iconTransformation(extent={{-20,-20},{20,20}}, rotation=180, origin={20,-60})));
  Interfaces.Rear rear(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
      iconTransformation(extent={{-80,-20},{-120,20}})));

protected
  outer DropOfCommons dropOfCommons;

  SI.Pressure p_forwards = Medium.pressure(rear.state_forwards);

  SI.Temperature T0;
  SI.Pressure p0;
  SI.SpecificEnthalpy h0;
  Medium.MassFraction Xi0[Medium.nXi];
  SI.Pressure r;

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

  der(rear.m_flow)*L = rear.r-r;

  //if port.m_flow > 0 -> it is sink (r=p_set-p_in) else it is source (r=0)
  r = .ThermofluidStream.Undirected.Internal.regStep(rear.m_flow, p0 - p_forwards, 0, m_flow_reg);

  rear.state_rearwards = if not setEnthalpy then Medium.setState_pTX(p0,T0,Xi0) else Medium.setState_phX(p0,h0,Xi0);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{4,76},{-60,-84}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{0,80},{-60,-80}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-60,0},{-84,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-60,80},{-60,-80}},
          color={28,108,200},
          thickness=0.5),
        Line(points={{-44,80},{-44,-80}}, color={255,255,255}),
        Line(
          points={{-26,80},{-26,-80}},
          color={255,255,255},
          thickness=0.5),
        Line(
          points={{-12,80},{-12,-80}},
          color={255,255,255},
          thickness=1)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>A undirected boundary that can act as source and sink, depending on the rest of the system. The Boundary_fore has to be connected to the fore end of your model and therefore has a rear port.</p>
<p>At positive massflow the rear port acts as an inlet and therefore the boundary_fore is a sink.</p>
</html>"));
end BoundaryFore;
