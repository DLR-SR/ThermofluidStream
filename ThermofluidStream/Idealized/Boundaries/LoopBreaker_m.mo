within ThermofluidStream.Idealized.Boundaries;
model LoopBreaker_m "Loop breaker model with mass flow rate setpoint"
  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  import ThermalSpecification = ThermofluidStream.Types.ThermalSpecification;
  import ValueSpecification = ThermofluidStream.Types.ValueSpecification;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);
  parameter ValueSpecification m_flowSpec = ThermofluidStream.Types.ValueSpecification.Fixed "Method for specifying the value of the inlet mass flow rate" annotation(
    Dialog(group="Mass flow rate"), Evaluate=true);
  parameter SI.MassFlowRate m_flow_in_par = 0 "Fixed inlet mass flow rate" annotation(
    Dialog(group="Mass flow rate",
      enable = m_flowSpec == ValueSpecification.Fixed),
    HideResult = not m_flowSpec == ValueSpecification.Fixed);
  parameter ValueSpecification pSpec = ThermofluidStream.Types.ValueSpecification.Fixed "Specifies whether the outlet pressure is fixed or prescribed" annotation(
    Dialog(group="Pressure"), Evaluate=true);
  parameter Medium.AbsolutePressure p_out_fixed = Medium.p_default "Fixed outlet pressure" annotation(
    Dialog(group="Pressure",
      enable = pSpec == ValueSpecification.Fixed),
    HideResult = not pSpec == ValueSpecification.Fixed);
  parameter ThermalSpecification thermalSpec = ThermofluidStream.Types.ThermalSpecification.Temperature "Thermal quantity used to define the outlet state" annotation(
    Dialog(group="Thermal"), Evaluate=true);
  parameter ValueSpecification thermalValueSpec = ThermofluidStream.Types.ValueSpecification.Fixed "Specifies whether the outlet thermal quantity is fixed or prescribed" annotation(
    Dialog(group="Thermal"), Evaluate=true);
  parameter Medium.Temperature T_out_fixed = Medium.T_default "Fixed outlet temperature" annotation(
    Dialog(group="Thermal",
      enable = thermalSpec == ThermalSpecification.Temperature and thermalValueSpec == ValueSpecification.Fixed),
    HideResult = not thermalSpec == ThermalSpecification.Temperature or not thermalValueSpec == ValueSpecification.Fixed);
  parameter Medium.SpecificEnthalpy h_out_fixed = Medium.h_default "Fixed outlet specific enthalpy" annotation(
    Dialog(group="Thermal",
      enable = thermalSpec == ThermalSpecification.SpecificEnthalpy and thermalValueSpec == ValueSpecification.Fixed),
    HideResult = not thermalSpec == ThermalSpecification.SpecificEnthalpy or not thermalValueSpec == ValueSpecification.Fixed);
  parameter ValueSpecification XiSpec = ThermofluidStream.Types.ValueSpecification.Fixed "Specifies whether the outlet mass fractions are fixed or prescribed" annotation(
    Dialog(group="Mass fractions"), Evaluate=true);
  parameter Medium.MassFraction Xi_out_fixed[Medium.nXi] = Medium.X_default[1:Medium.nXi] "Fixed outlet mass fractions" annotation(
    Dialog(group="Mass fractions",
      enable = XiSpec == ValueSpecification.Fixed),
    HideResult = not XiSpec == ValueSpecification.Fixed);
  parameter Boolean considerInertance = dropOfCommons.considerInertance "=true, if transient momentum (inertance) term is considered; disable only for advanced use" annotation(
    Dialog(tab="Advanced"), Evaluate=true, HideResult=true);
  parameter ThermofluidStream.Utilities.Units.Inertance L = dropOfCommons.L "Inertance" annotation(
    Dialog(tab="Advanced", enable = considerInertance), HideResult = not considerInertance);
  parameter AssertionLevel assertionLevel = AssertionLevel.warning "Assertion level" annotation(
    Dialog(tab="Advanced", group="Accepted errors"));
  parameter SI.PressureDifference tol_p(displayUnit="Pa") = 1e-5*Medium.p_default "Absolute tolerance for pressure p_in, p_out" annotation(
    Dialog(tab="Advanced", group="Accepted errors"));
  parameter SI.SpecificEnthalpy tol_h = 10 "Absolute tolerance for specific enthalpy h_in, h_out" annotation(
    Dialog(tab="Advanced", group="Accepted errors"));
  parameter SI.MassFlowRate tol_m_flow = 1e-3 "Absolute tolerance for mass flow rate m_flow_in, m_flow_out" annotation(
    Dialog(tab="Advanced", group="Accepted errors"));
  parameter Medium.MassFraction tol_Xi = 1e-5 "Absolute tolerance for mass fractions Xi_in, Xi_out" annotation(
    Dialog(tab="Advanced", group="Accepted errors"));
  parameter Boolean showMassFlowRate = true "= true to show the fixed inlet mass flow rate value m_flow_in_fixed" annotation(
    Dialog(tab="Layout", group="Display parameters", enable = displayParameters and m_flowSpec == ValueSpecification.Fixed), Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean showPressure = true "= true to show the fixed outlet pressure value p_out_fixed" annotation(
    Dialog(tab="Layout", group="Display parameters", enable=displayParameters and pSpec == ValueSpecification.Fixed), Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean showThermalSpecification = true "= true to show the fixed outlet thermal specification value (either T_out_fixed or h_out_fixed)" annotation(
    Dialog(tab="Layout", group="Display parameters", enable=displayParameters and thermalValueSpec == ValueSpecification.Fixed), Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean showMassFractions = false "= true to show the fixed outlet mass fraction values Xi_out_fixed" annotation(
    Dialog(tab="Layout", group="Display parameters", enable = displayParameters and XiSpec == ValueSpecification.Fixed), Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter String name = getInstanceName();

  Modelica.Blocks.Interfaces.RealInput m_flow_in_prescribed(unit="kg/s") if m_flowSpec ==ValueSpecification.Prescribed "Prescribed inlet mass flow rate [kg/s]" annotation(
    Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={-100,-120})));
  Modelica.Blocks.Interfaces.RealInput p_out_prescribed(unit="Pa") if pSpec ==ValueSpecification.Prescribed "Prescribed outlet pressure [Pa]" annotation(
    Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={100,-120})));
  Modelica.Blocks.Interfaces.RealInput T_out_prescribed(unit="K") if thermalValueSpec ==ValueSpecification.Prescribed  and thermalSpec ==ThermalSpecification.Temperature "Prescribed outlet temperature [K]" annotation(
    Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={60,-120})));
  Modelica.Blocks.Interfaces.RealInput h_out_prescribed(unit="J/kg") if thermalValueSpec ==ValueSpecification.Prescribed  and thermalSpec ==ThermalSpecification.SpecificEnthalpy "Prescribed outlet specific enthalpy [J/kg]" annotation(
    Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={20,-120})));
  Modelica.Blocks.Interfaces.RealInput Xi_out_prescribed[Medium.nXi](each unit = "kg/kg") if XiSpec ==ValueSpecification.Prescribed "Prescribed outlet mass fractions [kg/kg]" annotation(
    Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={-20,-120})));

  ThermofluidStream.Interfaces.Inlet inlet(redeclare package Medium = Medium) annotation(
    Placement(transformation(extent={{-120,-20},{-80,20}})));
  ThermofluidStream.Interfaces.Outlet outlet(redeclare package Medium = Medium) annotation(
    Placement(transformation(extent={{80,-20},{120,20}})));

  SI.MassFlowRate m_flow_out = -outlet.m_flow "Outlet mass flow rate" annotation(
    HideResult = true);
  Medium.AbsolutePressure p_in = Medium.pressure(inlet.state) "Inlet pressure" annotation(
    HideResult = true);
  Medium.SpecificEnthalpy h_in = Medium.specificEnthalpy(inlet.state) "Inlet specific enthalpy" annotation(
    HideResult = true);
  Medium.MassFraction Xi_in[Medium.nXi] = Medium.massFraction(inlet.state) "Inlet mass fractions" annotation(
    HideResult = true);
  SI.Pressure dp "Pressure difference";
  SI.SpecificEnthalpy dh "Enthalpy difference";
  SI.MassFlowRate dm_flow "Mass flow rate difference";
  ThermofluidStream.Units.MassFractionDifference dXi[Medium.nXi](each nominal=0.0) "Mass fraction difference";

protected
  Modelica.Blocks.Interfaces.RealInput m_flow_in(unit="kg/s") "Inlet mass flow rate [kg/s], required due to the conditional connector p_out_prescribed";
  Modelica.Blocks.Interfaces.RealInput p_out(unit="Pa") "Outlet pressure [Pa], required due to the conditional connector p_out_prescribed";
  Modelica.Blocks.Interfaces.RealInput T_out(unit="K") "Outlet temperature [K], required due to the conditional connector p_out_prescribed";
  Modelica.Blocks.Interfaces.RealInput h_out(unit="J/kg") "Outlet specific enthalpy [J/kg], required due to the conditional connector p_out_prescribed";
  Modelica.Blocks.Interfaces.RealInput Xi_out[Medium.nXi](each unit = "kg/kg") "Outlet mass fractions [kg/kg], required due to the conditional connector p_out_prescribed";

equation
  assert(noEvent(abs(dm_flow) < tol_m_flow), "Mass flow rate mismatch in "+ name, assertionLevel);
  assert(noEvent(abs(dp) < tol_p), "Pressure mismatch in "+ name, assertionLevel);
  assert(noEvent(abs(dh) < tol_h), "Specific enthalpy mismatch in "+ name, assertionLevel);
  assert(noEvent(Modelica.Math.Vectors.norm(dXi) < tol_Xi), "Mass fraction mismatch in "+ name, assertionLevel);

  connect(m_flow_in_prescribed, m_flow_in);
  if m_flowSpec == ValueSpecification.Fixed then
    m_flow_in = m_flow_in_par;
  end if;

  connect(p_out_prescribed, p_out);
  if pSpec == ValueSpecification.Fixed then
    p_out = p_out_fixed;
  end if;

  connect(T_out_prescribed, T_out);
  if thermalValueSpec == ValueSpecification.Fixed and thermalSpec == ThermalSpecification.Temperature then
    T_out = T_out_fixed;
  end if;

  connect(h_out_prescribed, h_out);
  if thermalValueSpec == ValueSpecification.Fixed and thermalSpec == ThermalSpecification.SpecificEnthalpy then
    h_out = h_out_fixed;
  end if;

  connect(Xi_out_prescribed, Xi_out);
  if XiSpec == ValueSpecification.Fixed then
    Xi_out = Xi_out_fixed;
  end if;

  if thermalSpec == ThermalSpecification.Temperature then
    outlet.state = Medium.setState_pTX(p_out,T_out,Xi_out);
    h_out = Medium.specificEnthalpy(outlet.state);
  else // ThermalSpecification.SpecificEnthalpy
    outlet.state = Medium.setState_phX(p_out, h_out, Xi_out);
    T_out = Medium.temperature(outlet.state);
  end if;

  if considerInertance then
    L*der(outlet.m_flow) = outlet.r - 0;
  else
    outlet.r = 0;
  end if;

  dm_flow = m_flow_out - m_flow_in;
  dp = p_out - p_in;
  dh = h_out - h_in;
  dXi = Xi_out - Xi_in;

  inlet.m_flow = m_flow_in;

  annotation(
    defaultComponentName="loopBreaker",
    Icon(
      coordinateSystem(
        preserveAspectRatio=true),
      graphics={
        Text(
          extent={{-150,110},{150,70}},
          textString = if displayInstanceName then "%name" else "",
          textColor=dropOfCommons.instanceNameColor),
        Text(
          extent={{-150,30},{150,60}},
          textColor={0,0,0},
          textString = if displayParameters and showMassFlowRate and m_flowSpec == ThermofluidStream.Types.ValueSpecification.Fixed then "ṁ_in = %m_flow_in_par" else ""),
        Text(
          extent={{-150,-20},{150,-50}},
          textColor={0,0,0},
          textString = if displayParameters and showPressure and pSpec == ThermofluidStream.Types.ValueSpecification.Fixed then "p_out = %p_out_fixed" else ""),
        Text(
          extent={{-150,-60},{150,-90}},
          textColor={0,0,0},
          textString = if displayParameters and showThermalSpecification and thermalValueSpec == ThermofluidStream.Types.ValueSpecification.Fixed and thermalSpec == ThermofluidStream.Types.ThermalSpecification.Temperature then "T_out = %T_out_fixed" else ""),
        Text(
          extent={{-150,-60},{150,-90}},
          textColor={0,0,0},
          textString = if displayParameters and showThermalSpecification and thermalValueSpec == ThermofluidStream.Types.ValueSpecification.Fixed and thermalSpec == ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy then "h_out = %h_out_fixed" else ""),
        Text(
          extent={{-150,-100},{150,-130}},
          textColor={0,0,0},
          textString = if displayParameters and showMassFractions and XiSpec == ThermofluidStream.Types.ValueSpecification.Fixed then "Xi_out = %Xi_out_fixed" else ""),
        Line(
          points={{-100,0},{0,20},{100,0}},
          color={28,108,200},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points = if m_flowSpec == ThermofluidStream.Types.ValueSpecification.Prescribed then {{-100,0},{-100,-100}} else {{0,0}},
          color={0,0,127}),
        Line(
          points = if pSpec == ThermofluidStream.Types.ValueSpecification.Prescribed then {{100,0},{100,-100}} else {{0,0}},
          color={0,0,127}),
        Line(
          points = if thermalValueSpec == ThermofluidStream.Types.ValueSpecification.Prescribed and thermalSpec == ThermofluidStream.Types.ThermalSpecification.Temperature then {{100,0},{100,-100},{60,-100}} else {{0,0}},
          color={0,0,127}),
        Line(
          points = if thermalValueSpec == ThermofluidStream.Types.ValueSpecification.Prescribed and thermalSpec == ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy then {{100,0},{100,-100},{20,-100}} else {{0,0}},
          color={0,0,127}),
        Line(
          points = if XiSpec == ThermofluidStream.Types.ValueSpecification.Prescribed then {{100,0},{100,-100},{-20,-100}} else {{0,0}},
          color={0,0,127}),
        Ellipse(
          extent={{80,40},{100,20}},
          fillColor={238,46,47},
          pattern=LinePattern.None,
          fillPattern=if considerInertance then FillPattern.None else FillPattern.Solid),
        Text(
          extent={{-100,100},{100,0}},
          textColor={238,46,47},
          textString = DynamicSelect("", if abs(dp) > tol_p then "dp" else "")),
        Text(
          extent={{-100,70},{100,-30}},
          textColor={238,46,47},
          textString= DynamicSelect("", if abs(dh) > tol_h then "dh" else "")),
        Text(
          extent={{-100,30},{100,-70}},
          textColor={238,46,47},
          textString= DynamicSelect("", if abs(dm_flow) > tol_m_flow then "dm_flow" else "")),
        Text(
          extent={{-100,0},{100,-100}},
          textColor={238,46,47},
          textString= DynamicSelect("", if Modelica.Math.Vectors.norm(dXi) > tol_Xi then "dXi" else ""))}),
    Documentation(
      info="<html>
  <p>
    Combination of <a href=\"modelica://ThermofluidStream.Boundaries.Source\">ThermofluidStream.Source</a>
    with <a href=\"modelica://ThermofluidStream.Idealized.Boundaries.Sink_free\">Sink_m</a> to artificially close a loop.
    Cyclic loops without a loop breaker lead to algebraic loops which can make the system unsolvable. 
    The loop-breaker acts as both a source and a sink, defining a beginning (source) and an end (sink) in the loop, breaking the algebraic equations. 
 </p>
 
  <p>
    Inlet and outlet states of the loop breaker are independent of each other.  
    The outlet state of the loop breaker is prescribed, while the user must ensure that the inlet state is consistent.  
    Any deviation is indicated by a warning.
  </p>

  <p>
    Discontinuous mass flow rates require <code>considerInertance = false</code>, see <a href=\"modelica://ThermofluidStream.Idealized.UsersGuide.InertanceNeglect\">UsersGuide.InertanceNeglect</a>. 
  </p>

</html>",
      revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end LoopBreaker_m;
