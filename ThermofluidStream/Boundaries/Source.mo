within ThermofluidStream.Boundaries;
model Source "Source (p,T,Xi) or (p,h,Xi)"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Source. Make sure it is the same as the one
the inlet the source is connected to.
</p>
</html>"));
  parameter Boolean pressureFromInput = false "= true, if pressure input connector is enabled"
    annotation(Dialog(group="Pressure"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Pressure p0_par = Medium.p_default "Pressure set value"
    annotation(Dialog(group="Pressure", enable = not pressureFromInput));
  parameter Boolean temperatureFromInput = false "= true, if temperature input connector is enabled"
    annotation(Dialog(group="Temperature", enable = not setEnthalpy),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Temperature T0_par = Medium.T_default "Temperature set value"
    annotation(Dialog(group="Temperature", enable = not setEnthalpy and not temperatureFromInput));
  parameter Boolean xiFromInput = false "= true, if mass fractions input connector is enabled"
    annotation(Dialog(group="Mass fractions"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Medium.MassFraction Xi0_par[Medium.nXi] = Medium.X_default[1:Medium.nXi] "Mass fractions set value"
    annotation(Dialog(group="Mass fractions", enable = not xiFromInput));
  parameter Boolean setEnthalpy = false "= true, if specific enthalpy is set, (= false to set temperature)"
    annotation(Dialog(group="Specific enthalpy"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean enthalpyFromInput = false "= true, if specific enthalpy input connector is enabled"
    annotation(Dialog(group="Specific enthalpy", enable = setEnthalpy),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.SpecificEnthalpy h0_par = Medium.h_default "Specific enthalpy set value"
    annotation(Dialog(group="Specific enthalpy", enable = setEnthalpy and not enthalpyFromInput));
  parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance"
    annotation (Dialog(tab="Advanced"));

  // ------ Parameter Display Configuration  ------------------------
  parameter Boolean displayPressure = true "= true, if pressure p0_par is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters and not pressureFromInput),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayTemperature = true "= true, if temperature T0_par or specific enthalpy h0_par is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters and not temperatureFromInput),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayMassFractions = false "= true, if mass fractions Xi0_par are displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters and not xiFromInput),Evaluate=true, HideResult=true, choices(checkBox=true));
  // parameter Boolean displayTemperatureOrEnthalpy = true "= true, if temperature T0_par or specific enthalpy h0_par is displayed"
  //  annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters and not temperatureFromInput),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayInertance = false "= true, if inertance L is displayed"
    annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter Boolean displayP = displayPressure and not pressureFromInput
    annotation(Evaluate=true, HideResult=true);
  final parameter Boolean displayT = displayTemperature and not temperatureFromInput and not setEnthalpy
    annotation(Evaluate=true, HideResult=true);
  final parameter Boolean displayH = displayTemperature and not enthalpyFromInput and setEnthalpy
    annotation(Evaluate=true, HideResult=true);
  final parameter Boolean displayXi = displayMassFractions and not xiFromInput
    annotation(Evaluate=true, HideResult=true);

  final parameter String displayPos1=
    if displayP then
      "p = %p0_par"
    elseif displayT then
      "T = %T0_par"
    elseif displayH then
      "h = %h0_par"
    elseif displayXi then
      "Xi = %Xi0_par"
    elseif displayInertance then
      "L = %L"
    else "";
  final parameter String displayPos2=
    if displayP and displayT then
      "T = %T0_par"
    elseif displayP and displayH then
      "h = %h0_par"
    elseif displayXi and (displayP or displayT or displayH)  then
      "Xi = %Xi0_par"
    elseif  displayInertance and (displayP or displayT or displayH or displayXi) then
      "L = %L"
    else "";
  final parameter String displayPos3=
    if displayXi and displayP and (displayT or displayH)  then
      "Xi = %Xi0_par"
    elseif  displayInertance and not displayPos2 == "L = %L" and not displayPos1 == "L = %L" then
      "L = %L"
    else "";
  final parameter String displayPos4=
    if displayP and  (displayT or displayH) and displayXi  and displayInertance then
      "L = %L"
    else "" annotation(Evaluate=true, HideResult=true);
  //-----------------------------------------------------------------

  Modelica.Blocks.Interfaces.RealInput p0_var(unit="Pa") if pressureFromInput "Pressure input connector [Pa]"
    annotation (Placement(transformation(extent={{-40,40},{0,80}}), iconTransformation(extent={{-40,40},{0,80}})));
  Modelica.Blocks.Interfaces.RealInput T0_var(unit = "K") if not setEnthalpy and temperatureFromInput "Temperature input connector [K]"
    annotation (Placement(transformation(extent={{-40,-20},{0,20}}),
                                                                   iconTransformation(extent={{-40,-20},{0,20}})));
  Modelica.Blocks.Interfaces.RealInput h0_var(unit = "J/kg") if setEnthalpy and enthalpyFromInput "Enthalpy input connector [J/kg]"
    annotation (Placement(transformation(extent={{0,-20},{40,20}}), iconTransformation(extent={{-40,-20},{0,20}})));
  Modelica.Blocks.Interfaces.RealInput xi_var[Medium.nXi](each unit = "kg/kg") if xiFromInput "Mass fractions connector [kg/kg]"
    annotation (Placement(transformation(extent={{-40,-80},{0,-40}}), iconTransformation(extent={{-40,-80},{0,-40}})));
  Interfaces.Outlet outlet(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));

protected
  Modelica.Blocks.Interfaces.RealInput p0(unit="Pa") "Internal pressure connector";
  Modelica.Blocks.Interfaces.RealInput T0(unit = "K") "Internal temperature connector";
  Modelica.Blocks.Interfaces.RealInput h0(unit = "J/kg") "Internal enthalpy connector";
  Modelica.Blocks.Interfaces.RealInput Xi0[Medium.nXi](each unit = "kg/kg") "Internal mass fractions connector";

equation
   connect(T0_var, T0);
   if not temperatureFromInput or setEnthalpy then
     T0 = T0_par;
   end if;

   connect(p0_var, p0);
   if not pressureFromInput then
     p0 = p0_par;
   end if;

   connect(xi_var, Xi0);
   if not xiFromInput then
     Xi0 = Xi0_par;
   end if;

   connect(h0_var, h0);
   if not enthalpyFromInput or not setEnthalpy then
     h0 = h0_par;
   end if;

  L*der(outlet.m_flow) = outlet.r - 0;
  outlet.state =  if not setEnthalpy then Medium.setState_pTX(p0,T0,Xi0) else Medium.setState_phX(p0, h0, Xi0);

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
        Text(visible=displayParameters,
          extent={{-150,-170},{150,-200}},
          textColor={0,0,0},
          textString=displayPos3),
        Text(visible=displayParameters,
          extent={{-150,-240},{150,-210}},
          textColor={0,0,0},
          textString=displayPos4),
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
          points={{60,0},{100,0}},
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
          thickness=1)}), Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Source of a Thermofluid Stream. The state can be given as fix values or as a real signal. </p>
<p>Before its inertance the source has an inertial pressure of 0 by definition.</p>
</html>"));
end Source;
