within ThermofluidStream.Boundaries;
model CreateState "Create state signal as output"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info =          "<html>
<p>Model of the medium for this thermodynamic state connector.</p>
</html>"));

  parameter Boolean PFromInput = false "= true, if pressure input connector is enabled"
    annotation(Dialog(group="Pressure"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Pressure p_par = Medium.p_default "Pressure set value"
    annotation(Dialog(group="Pressure", enable = not PFromInput));
  parameter Boolean TFromInput = false "= true, if temperature input connector is enabled"
    annotation(Dialog(group="Temperature", enable = not setEnthalpy),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Temperature T_par = Medium.T_default "Temperature set value"
    annotation(Dialog(group="Temperature", enable = not setEnthalpy and not TFromInput));
  parameter Boolean XiFromInput = false "= true, if mass fractions input connector is enabled"
    annotation(Dialog(group="Mass fractions"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Medium.MassFraction Xi_par[Medium.nXi] = Medium.X_default[1:Medium.nXi] "Mass fraction set value"
    annotation(Dialog(group="Mass fractions", enable = not XiFromInput));
  parameter Boolean setEnthalpy = false "= true to set specific enthalpy, (= false to set temperature)"
    annotation(Dialog(group="Specific enthalpy"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean hFromInput = false "= true, if specific enthalpy input connector is enabled"
    annotation(Dialog(group="Specific enthalpy", enable = setEnthalpy),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.SpecificEnthalpy h0_par = Medium.h_default "Specific enthalpy set value"
    annotation(Dialog(group="Specific enthalpy", enable = setEnthalpy and not hFromInput));

  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance"
    annotation (Dialog(tab="Advanced"));

  // ------ Parameter Display Configuration  ------------------------
  parameter Boolean displayPressure = true "= true to display the pressure set value p_par" annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters and not PFromInput),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayTemperature = true "= true to display the temperature set value T_par" annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters and not TFromInput),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter Boolean displayP = displayPressure and not PFromInput annotation(Evaluate=true, HideResult=true);
  final parameter Boolean displayT = displayTemperature and not TFromInput and not setEnthalpy annotation(Evaluate=true, HideResult=true);
  final parameter String displayPos1=
    if displayP then
      "p = %p_par"
    elseif displayT then
      "T = %T_par"
    else "" annotation(Evaluate=true, HideResult=true);
  final parameter String displayPos2=
    if displayP and displayT then
      "T = %T_par"
    else "" annotation(Evaluate=true, HideResult=true);
  //----------------------------------------------------------------

  Interfaces.StateOutput y(redeclare package Medium = Medium) annotation (
      Placement(transformation(extent={{80,-20},{120,20}}), iconTransformation(
          extent={{80,-20},{120,20}})));
  Modelica.Blocks.Interfaces.RealInput p_inp(unit="Pa") if PFromInput "Input for pressure [Pa]"
    annotation (Placement(transformation(extent={{-120,40},{-80,80}}),
        iconTransformation(extent={{-120,40},{-80,80}})));
  Modelica.Blocks.Interfaces.RealInput T_inp(unit="K") if not setEnthalpy and TFromInput "Input for Temperature [K]"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealInput h0_var(unit = "J/kg") if setEnthalpy and hFromInput "Enthalpy input connector [J/kg]"
    annotation (Placement(transformation(extent={{-40,-20},{0,20}}),iconTransformation(extent={{-40,-20},{0,20}})));
  Modelica.Blocks.Interfaces.RealInput Xi_inp[Medium.nXi](each unit="kg/kg") if XiFromInput "Vector input for Mass fraction [kg/kg]"
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}}),
        iconTransformation(extent={{-120,-80},{-80,-40}})));

protected
  Modelica.Blocks.Interfaces.RealInput p(unit="Pa") "Internal pressure connector";
  Modelica.Blocks.Interfaces.RealInput T(unit="K") "Internal temperature connector";
  Modelica.Blocks.Interfaces.RealInput h(unit = "J/kg") "Internal specific enthalpy connector";
  Modelica.Blocks.Interfaces.RealInput Xi[Medium.nXi](each unit="kg/kg") "Internal mass fractions connector";

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
          textColor=dropOfCommons.instanceNameColor),
        Text(visible=displayParameters,
          extent={{-150,-90},{150,-120}},
          textColor={0,0,0},
          textString=displayPos1),
        Text(visible=displayParameters,
          extent={{-150,-130},{150,-160}},
          textColor={0,0,0},
          textString=displayPos2),
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
