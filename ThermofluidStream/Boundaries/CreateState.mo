within ThermofluidStream.Boundaries;
model CreateState "Create state signal as output"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;
  // Configure icon display options
  parameter Boolean displayPressure = true "= true to display the pressure set value p0_par (this does not work for PFromInput)" annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters and not PFromInput),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayTemperature = true "= true to display the temperature set value T0_par (this does not work for TFromInput)" annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters and not TFromInput),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter Boolean d1p = displayParameters and displayPressure and not PFromInput  "displayPressure at position 1" annotation(Evaluate=true, HideResult=true); //d1p -> Display at position 1 p=pressure
  final parameter Boolean d1T = displayParameters and displayTemperature and not TFromInput and not setEnthalpy and not d1p  "displayTemperature at position 1" annotation(Evaluate=true, HideResult=true);
  final parameter Boolean d2T = displayParameters and displayTemperature and not TFromInput and not setEnthalpy and not d1T  "displayTemperature at position 2" annotation(Evaluate=true, HideResult=true);

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
  "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Model of the medium for this thermodynamic state connector.</p>
</html>"));

  parameter Boolean setEnthalpy = false "= true to set specific enthalpy, (= false to set temperature)";
  parameter Boolean PFromInput = false "= true to use pressure input connector";
  parameter Boolean TFromInput = false "= true to use temperature input connector"
    annotation(Dialog(enable = not setEnthalpy));
  parameter Boolean hFromInput = false "= true to use specific enthalpy input connector"
    annotation(Dialog(enable = setEnthalpy));
  parameter Boolean XiFromInput = false "= true to use mass fraction input connector";
  parameter SI.Pressure p_par = Medium.p_default "Pressure set value"
    annotation(Dialog(enable=not PFromInput));
  parameter SI.Temperature T_par = Medium.T_default "Temperature set value"
    annotation(Dialog(enable = not setEnthalpy and not TFromInput));
  parameter SI.SpecificEnthalpy h0_par = Medium.h_default "Specific enthalpy set value"
    annotation(Dialog(enable = setEnthalpy and not hFromInput));
  parameter Medium.MassFraction[Medium.nXi] Xi_par = Medium.X_default[1:Medium.nXi] "Mass fraction set value"
    annotation(Dialog(enable=not XiFromInput));

  Interfaces.StateOutput y(redeclare package Medium = Medium) annotation (
      Placement(transformation(extent={{80,-20},{120,20}}), iconTransformation(
          extent={{80,-20},{120,20}})));
  Modelica.Blocks.Interfaces.RealInput p_inp(unit="Pa") if PFromInput "Input for pressure [Pa]"
    annotation (Placement(transformation(extent={{-120,40},{-80,80}}),
        iconTransformation(extent={{-120,40},{-80,80}})));
  Modelica.Blocks.Interfaces.RealInput T_inp(unit="K") if not setEnthalpy and TFromInput "Input for Temperature [K]"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealInput h0_var(unit = "J/kg") if setEnthalpy and hFromInput "Enthalpy input connector [J/kg]"
    annotation (Placement(transformation(extent={{-40,-40},{0,0}}), iconTransformation(extent={{-40,-20},{0,20}})));
  Modelica.Blocks.Interfaces.RealInput Xi_inp[Medium.nXi](each unit="kg/kg") if XiFromInput "Vector input for Mass fraction [kg/kg]"
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}}),
        iconTransformation(extent={{-120,-80},{-80,-40}})));

protected
  Modelica.Blocks.Interfaces.RealInput p(unit="Pa") "Internal pressure connector";
  Modelica.Blocks.Interfaces.RealInput T(unit="K") "Internal temperature connector";
  Modelica.Blocks.Interfaces.RealInput h(unit = "J/kg") "Internal enthalpy connector";
  Modelica.Blocks.Interfaces.RealInput Xi[Medium.nXi](each unit="kg/kg") "Internal mass fraction connector";

equation
  y.state = if not setEnthalpy then Medium.setState_pTX(p,T,Xi) else Medium.setState_phX(p, h, Xi);

  connect(p_inp, p);
  if not PFromInput then
    p = p_par;
  end if;

  connect(T_inp, T);
  if not TFromInput or setEnthalpy then
    T = T_par;
  end if;

  connect(h0_var, h);
  if not hFromInput or not setEnthalpy then
    h = h0_par;
  end if;

  connect(Xi_inp, Xi);
  if not XiFromInput then
    Xi = Xi_par;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible=displayInstanceName,
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor={0,0,255}),
        Text(visible=d1p,
          extent={{-150,-90},{150,-120}},
          textColor={0,0,0},
          textString="p = %p_par"),
        Text(visible=d1T,
          extent={{-150,-90},{150,-120}},
          textColor={0,0,0},
          textString="T = %T_par"),
        Text(visible=d2T,
          extent={{-150,-130},{150,-160}},
          textColor={0,0,0},
          textString="T = %T_par"),
        Line(
          points={{0,0},{98,0}},
          color={162,29,33},
          thickness=0.5),
        Line(
          points={{-100,-60},{0,-60},{0,60}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-100,60},{0,60}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,0},{-100,0}},
          color={28,108,200},
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Create a Thermodynamic state signal from T,p,Xi.</p>
</html>"));
end CreateState;
