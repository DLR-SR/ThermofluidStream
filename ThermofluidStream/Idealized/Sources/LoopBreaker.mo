within ThermofluidStream.Idealized.Sources;
model LoopBreaker "Loop breaker model - Underdetermined (1 equation)"
  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  import ThermalSpecification = ThermofluidStream.Idealized.Utilities.Types.ThermalSpecification;
  import ValueSpecification = ThermofluidStream.Idealized.Utilities.Types.ValueSpecification;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);
  parameter ValueSpecification pSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Fixed "Specifies whether the outlet pressure is fixed or prescribed" annotation (Dialog(group="Pressure"), Evaluate=true);
  parameter Medium.AbsolutePressure p_out_fixed = Medium.p_default "Fixed outlet pressure"
    annotation(Dialog(group="Pressure",
      enable = pSpec == ValueSpecification.Fixed),
      HideResult = not pSpec == ValueSpecification.Fixed);
  parameter ThermalSpecification thermalSpec=ThermofluidStream.Idealized.Utilities.Types.ThermalSpecification.Temperature "Thermal quantity used to define the outlet state" annotation (Dialog(group="Thermal"), Evaluate=true);
  parameter ValueSpecification thermalValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Fixed "Specifies whether the outlet thermal quantity is fixed or prescribed" annotation (Dialog(group="Thermal"), Evaluate=true);
  parameter Medium.Temperature T_out_fixed = Medium.T_default "Fixed outlet temperature"
    annotation(Dialog(group="Thermal",
      enable = thermalSpec == ThermalSpecification.Temperature and thermalValueSpec == ValueSpecification.Fixed),
      HideResult = not thermalSpec == ThermalSpecification.Temperature or not thermalValueSpec == ValueSpecification.Fixed);
  parameter Medium.SpecificEnthalpy h_out_fixed = Medium.h_default "Fixed outlet specific enthalpy"
    annotation(Dialog(group="Thermal",
      enable = thermalSpec == ThermalSpecification.SpecificEnthalpy and thermalValueSpec == ValueSpecification.Fixed),
      HideResult = not thermalSpec == ThermalSpecification.SpecificEnthalpy or not thermalValueSpec == ValueSpecification.Fixed);
  parameter ValueSpecification XiSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Fixed "Specifies whether the outlet mass fractions are fixed or prescribed" annotation (Dialog(group="Mass fractions"), Evaluate=true);
  parameter Medium.MassFraction Xi_out_fixed[Medium.nXi] = Medium.X_default[1:Medium.nXi] "Fixed outlet mass fractions"
    annotation(Dialog(group="Mass fractions",
      enable = XiSpec == ValueSpecification.Fixed),
      HideResult = not XiSpec == ValueSpecification.Fixed);

  parameter ThermofluidStream.Utilities.Units.Inertance L = dropOfCommons.L "Inertance"
    annotation (Dialog(tab="Advanced", enable = not neglectInertance), HideResult = neglectInertance);
  parameter Boolean neglectInertance = true "=true, if mass flow rate dynamics are neglected - advanced mode!"
    annotation(Dialog(tab="Advanced"),Evaluate=true, HideResult=true);

  parameter AssertionLevel assertionLevel = AssertionLevel.warning "Assertion level"
    annotation(Dialog(tab="Advanced",group="Accepted errors"));
  parameter SI.PressureDifference tol_p(displayUnit="Pa") = 1e-5*Medium.p_default "Absolute tolerance for pressure p_in, p_out"
    annotation(Dialog(tab="Advanced",group="Accepted errors"));
  parameter SI.SpecificEnthalpy tol_h = 500 "Absolute tolerance for specific enthalpy h_in, h_out"
    annotation(Dialog(tab="Advanced",group="Accepted errors"));
  parameter SI.MassFlowRate tol_m_flow = 1e-3 "Absolute tolerance for mass flow rate m_flow_in, m_flow_out"
    annotation(Dialog(tab="Advanced",group="Accepted errors"));
  parameter SI.MassFlowRate tol_Xi = 1e-5 "Absolute tolerance for mass fractions Xi_in, Xi_out"
    annotation(Dialog(tab="Advanced",group="Accepted errors"));
  parameter Boolean showPressure = true "= true to show the fixed outlet pressure value p_out_fixed"
    annotation(Dialog(tab="Layout", group="Display parameters", enable = displayParameters and pSpec == ValueSpecification.Fixed), Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean showThermalSpecification = true "= true to show the fixed outlet thermal specification value (either T_out_fixed or h_out_fixed)"
    annotation(Dialog(tab="Layout", group="Display parameters", enable = displayParameters and thermalValueSpec == ValueSpecification.Fixed), Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean showMassFractions = false "= true to show the fixed outlet mass fraction values Xi_out_fixed"
    annotation(Dialog(tab="Layout", group="Display parameters", enable = displayParameters and XiSpec == ValueSpecification.Fixed), Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter String name = getInstanceName();

  Modelica.Blocks.Interfaces.RealInput p_out_prescribed(unit="Pa") if pSpec == ValueSpecification.Prescribed "Prescribed outlet pressure [Pa]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={100,-120})));
  Modelica.Blocks.Interfaces.RealInput T_out_prescribed(unit="K") if thermalValueSpec == ValueSpecification.Prescribed and thermalSpec == ThermalSpecification.Temperature "Prescribed outlet temperature [K]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={60,-120})));
  Modelica.Blocks.Interfaces.RealInput h_out_prescribed(unit="J/kg") if thermalValueSpec == ValueSpecification.Prescribed and thermalSpec == ThermalSpecification.SpecificEnthalpy "Prescribed outlet specific enthalpy [J/kg]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={20,-120})));
  Modelica.Blocks.Interfaces.RealInput Xi_out_prescribed[Medium.nXi](each unit = "kg/kg") if XiSpec == ValueSpecification.Prescribed "Prescribed outlet mass fractions [kg/kg]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={-20,-120})));

  ThermofluidStream.Interfaces.Inlet inlet(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  ThermofluidStream.Interfaces.Outlet outlet(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));

  SI.MassFlowRate m_flow_in = inlet.m_flow "Mass flow rate"
    annotation(HideResult=true);
  Medium.AbsolutePressure p_in = Medium.pressure(inlet.state) "Inlet pressure"
    annotation(HideResult=true);
  Medium.SpecificEnthalpy h_in = Medium.specificEnthalpy(inlet.state) "Inlet specific enthalpy"
    annotation(HideResult=true);
  Medium.MassFraction Xi_in[Medium.nXi] = Medium.massFraction(inlet.state) "Inlet mass fractions"
    annotation(HideResult=true);
  SI.MassFlowRate m_flow_out = -outlet.m_flow "Mass flow rate outlet"
    annotation(HideResult=true);
  SI.MassFlowRate dm_flow "Mass flow rate difference";
  SI.Pressure dp "Pressure difference";
  SI.SpecificEnthalpy dh "Specific enthalpy difference";
  ThermofluidStream.Idealized.Utilities.Types.MassFractionDifference dXi[Medium.nXi] "Mass fraction difference";

protected
  Modelica.Blocks.Interfaces.RealInput p_out(unit="Pa") "Outlet pressure [Pa], required due to the conditional connector p_out_prescribed";
  Modelica.Blocks.Interfaces.RealInput T_out(unit="K") "Outlet temperature [K], required due to the conditional connector T_out_prescribed";
  Modelica.Blocks.Interfaces.RealInput h_out(unit="J/kg") "Outlet specific enthalpy [J/kg], required due to the conditional connector h_out_prescribed";
  Modelica.Blocks.Interfaces.RealInput Xi_out[Medium.nXi](each unit = "kg/kg") "Outlet mass fractions [kg/kg], required due to the conditional connector Xi_out_prescribed";

equation
  assert(noEvent(abs(dm_flow) < tol_m_flow), "Mass flow rate mismatch in "+ name, assertionLevel);
  assert(noEvent(abs(dp) < tol_p), "Pressure mismatch in "+ name, assertionLevel);
  assert(noEvent(abs(dh) < tol_h), "Specific enthalpy mismatch in "+ name, assertionLevel);
  assert(noEvent(Modelica.Math.Vectors.norm(dXi) < tol_Xi), "Mass fraction mismatch in "+ name, assertionLevel);

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

  if not neglectInertance then
    L*der(outlet.m_flow) = outlet.r - 0;
  else
    outlet.r = 0;
  end if;

  dp = p_out - p_in;
  dh = h_out - h_in;
  dm_flow = m_flow_out - m_flow_in;
  dXi = Xi_out - Xi_in;

  annotation(defaultComponentName="loopBreaker", Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,110},{150,70}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Text(visible = displayParameters and showPressure and pSpec == ThermoFluidStreamPlus.Types.ValueSpecification.Fixed,
          extent={{-150,-20},{150,-50}},
          textColor={0,0,0},
          textString="p_out = %p_out_fixed"),
        Text(visible = displayParameters and showThermalSpecification and thermalValueSpec == ThermoFluidStreamPlus.Types.ValueSpecification.Fixed and thermalSpec == ThermoFluidStreamPlus.Types.ThermalSpecification.Temperature,
          extent={{-150,-60},{150,-90}},
          textColor={0,0,0},
          textString="T_out = %T_out_fixed"),
        Text(visible = displayParameters and showThermalSpecification and thermalValueSpec == ThermoFluidStreamPlus.Types.ValueSpecification.Fixed and thermalSpec == ThermoFluidStreamPlus.Types.ThermalSpecification.SpecificEnthalpy,
          extent={{-150,-60},{150,-90}},
          textColor={0,0,0},
          textString="h_out = %h_out_fixed"),
        Text(visible = displayParameters and showMassFractions and XiSpec == ThermoFluidStreamPlus.Types.ValueSpecification.Fixed,
          extent={{-150,-100},{150,-130}},
          textColor={0,0,0},
          textString="Xi_out = %Xi_out_fixed"),
        Line(
          points={{-100,0},{0,20},{102,0}},
          color={28,108,200},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(visible = pSpec == ThermoFluidStreamPlus.Types.ValueSpecification.Prescribed,
          points={{100,0},{100,-100}}, color={0,0,127}),
        Line(visible = thermalValueSpec == ThermoFluidStreamPlus.Types.ValueSpecification.Prescribed and thermalSpec == ThermoFluidStreamPlus.Types.ThermalSpecification.Temperature,
          points={{100,0},{100,-100},{60,-100}}, color={0,0,127}),
        Line(visible = thermalValueSpec == ThermoFluidStreamPlus.Types.ValueSpecification.Prescribed and thermalSpec == ThermoFluidStreamPlus.Types.ThermalSpecification.SpecificEnthalpy,
          points={{100,0},{100,-100},{20,-100}}, color={0,0,127}),
        Line(visible = XiSpec == ThermoFluidStreamPlus.Types.ValueSpecification.Prescribed,
          points={{100,0},{100,-100},{-20,-100}}, color={0,0,127}),
        Ellipse(
          extent={{-98,58},{-62,22}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-96,42},{-64,38}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
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
    Documentation(info="<html>
  <p>
    Combination of <a href=\"modelica://ThermofluidStream.Boundaries.Source\">ThermofluidStream.Source</a>
    with <a href=\"modelica://ThermoFluidStream.Idealized.Sources.Sink_free\">Sink_free</a> to artificially close a loop.<br>
    Cyclic loops without a loop breaker lead to algebraic equations which can make the system unsolvable. 
    The loop-breaker acts as both a source and a sink, defining a beginning (source) and an end (sink) in the loop, breaking the algebraic equations. 
 </p>

  <p>
    The model is locally underdetermined (1 equation missing) and therefore must be connected to an overdetermined one 
    (e.g., <a href=\"modelica://ThermoFluidStream.Idealized.Sources.MassFlowRate\">MassFlowRate</a>) to ensure that the overall system balanced.
  </p>
  
  <p>
    Ensure that the inlet state and the outlet state are equal.
    The model only checks equality but does not enforce them, since this would create the algebraic loop.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end LoopBreaker;
