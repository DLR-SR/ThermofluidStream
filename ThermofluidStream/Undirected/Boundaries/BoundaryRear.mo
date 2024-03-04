within ThermofluidStream.Undirected.Boundaries;
model BoundaryRear "Generic Boundary model (may act as source or sink)"

  extends ThermofluidStream.Utilities.DisplayInstanceNameIndividually; //Define the display of the component name for your component.

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

  Modelica.Blocks.Interfaces.RealInput p0_var(unit="Pa") if pressureFromInput "Pressure input connector [Pa]"
    annotation (Placement(transformation(extent={{-40,40},{0,80}}), iconTransformation(extent={{-40,40},{0,80}})));
  Modelica.Blocks.Interfaces.RealInput T0_var(unit = "K") if not setEnthalpy and temperatureFromInput "Temperature input connector [K]"
    annotation (Placement(transformation(extent={{-40,0},{0,40}}), iconTransformation(extent={{-40,-20},{0,20}})));
  Interfaces.Fore fore(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
      iconTransformation(extent={{80,-20},{120,20}})));
  Modelica.Blocks.Interfaces.RealInput h0_var(unit = "J/kg") if setEnthalpy and enthalpyFromInput "Enthalpy input connector"
    annotation (Placement(transformation(extent={{-40,-40},{0,0}}), iconTransformation(extent={{-40,-20},{0,20}})));
  Modelica.Blocks.Interfaces.RealInput xi_var[Medium.nXi](each unit = "kg/kg") if xiFromInput "Mass fraction connector [kg/kg]"
    annotation (Placement(transformation(extent={{-40,-80},{0,-40}}), iconTransformation(extent={{-40,-80},{0,-40}})));

protected
  SI.Pressure p_rearwards = Medium.pressure(fore.state_rearwards);

  Modelica.Blocks.Interfaces.RealInput p0(unit="Pa") "Internal pressure connector";
  Modelica.Blocks.Interfaces.RealInput T0(unit = "K") "Internal temperature connector";
  Modelica.Blocks.Interfaces.RealInput h0(unit = "J/kg") "Internal enthalpy connector";
  Modelica.Blocks.Interfaces.RealInput Xi0[Medium.nXi](each unit = "kg/kg") "Internal mass fraction connector";

  SI.Pressure r;

equation

  connect(T0_var, T0);
  if not temperatureFromInput or setEnthalpy then
    T0 = T0_par;
  end if;

  connect(p0_var, p0);
  if not pressureFromInput then
    p0 = p0_par;
  end if;

  connect(h0_var, h0);
  if not enthalpyFromInput or not setEnthalpy then
     h0 = h0_par;
  end if;

  connect(xi_var, Xi0);
  if not xiFromInput then
    Xi0 = Xi0_par;
  end if;

  der(fore.m_flow)*L = fore.r-r;

  //if port.m_flow > 0 -> it is sink (r=p_set-p_in) else it is source (r=0)
  r = .ThermofluidStream.Undirected.Internal.regStep(fore.m_flow, p0 - p_rearwards, 0, m_flow_reg);

  fore.state_forwards = if not setEnthalpy then Medium.setState_pTX(p0,T0,Xi0) else Medium.setState_phX(p0,h0,Xi0);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor={0,0,255}),
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
          points={{60,0},{84,0}},
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
<p>A undirected boundary that can act as source and sink, depending on the rest of the system. The Boundary_rear has to be connected to the rear end of your model and therefore has a fore port.</p>
<p>At positive massflow the fore port acts as an outlet and therefore the boundary_rear is a source.</p>
</html>"));
end BoundaryRear;
