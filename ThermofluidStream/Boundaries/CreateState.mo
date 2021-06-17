within ThermofluidStream.Boundaries;
model CreateState "Create state signal as output"

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
  "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Model of the medium for this thermodynamic state connector.</p>
</html>"));

  parameter Boolean setEnthalpy = false "Prescribe specific enthalpy instead of temperature?";
  parameter Boolean PFromInput = false "Use default T";
  parameter Boolean TFromInput = false "Use default T"
    annotation(Dialog(enable = not setEnthalpy));
  parameter Boolean hFromInput = false "Use input connector for specific enthalpy"
    annotation(Dialog(enable = setEnthalpy));
  parameter Boolean XiFromInput = false "Use zero vector as Xi";
  parameter SI.Pressure p_par = Medium.p_default "Fixed temperature"
    annotation(Dialog(enable=not PFromInput));
  parameter SI.Temperature T_par = Medium.T_default "Fixed pressure"
    annotation(Dialog(enable = not setEnthalpy and not TFromInput));
  parameter SI.SpecificEnthalpy h0_par = Medium.h_default "Specific enthalpy set value"
    annotation(Dialog(enable = setEnthalpy and not hFromInput));
  parameter Medium.MassFraction[Medium.nXi] Xi_par = Medium.X_default[1:Medium.nXi] "Fixed mass fractions"
    annotation(Dialog(enable=not XiFromInput));

  Interfaces.StateOutput y(redeclare package Medium = Medium) annotation (
      Placement(transformation(extent={{80,-20},{120,20}}), iconTransformation(
          extent={{80,-20},{120,20}})));
  Modelica.Blocks.Interfaces.RealInput p_inp(unit="Pa") = p if PFromInput "Input for pressure [Pa]"
    annotation (Placement(transformation(extent={{-120,80},{-80,120}}),
        iconTransformation(extent={{-120,80},{-80,120}})));
  Modelica.Blocks.Interfaces.RealInput T_inp(unit="K") = T if TFromInput "Input for Temperature [K]"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealInput h0_var(unit = "J/kg")= h0 if hFromInput "Enthalpy input connector [J/kg]"
    annotation (Placement(transformation(extent={{-40,-40},{0,0}}),   iconTransformation(extent={{-40,-20},{0,20}})));
  Modelica.Blocks.Interfaces.RealInput Xi_inp[Medium.nXi](each unit="kg/kg") = Xi if XiFromInput "Vector input for Mass fraction [kg/kg]"
    annotation (Placement(transformation(extent={{-120,-120},{-80,-80}}),
        iconTransformation(extent={{-120,-120},{-80,-80}})));

protected
  SI.Pressure p;
  SI.Temperature T;
  SI.SpecificEnthalpy h;
  Medium.MassFraction Xi[Medium.nXi];

equation
  y.state = if not setEnthalpy then Medium.setState_pTX(p,T,Xi) else Medium.setState_phX(p, h, Xi);

  if not PFromInput then
    p = p_par;
  end if;
  if not TFromInput then
    T = T_par;
  end if;
  if not hFromInput then
    h = h0_par;
  end if;
  if not XiFromInput then
    Xi = Xi_par;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{0,0},{98,0}},
          color={162,29,33},
          thickness=0.5),
        Line(
          points={{-100,-100},{0,-100},{0,100}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-100,100},{0,100}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{-100,0}},
          color={28,108,200},
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Create a Thermodynamic state signal from T,p,Xi.</p>
</html>"));
end CreateState;
