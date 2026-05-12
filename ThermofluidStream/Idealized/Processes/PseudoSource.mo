within ThermofluidStream.Idealized.Processes;
model PseudoSource "Model to set the outlet state"
  extends ThermofluidStream.Interfaces.SISOFlow(final clip_p_out=false);

  import ThermalSpecification = ThermofluidStream.Types.ThermalSpecification;
  import ValueSpecification = ThermofluidStream.Types.ValueSpecification;

  parameter ValueSpecification pSpec=ThermofluidStream.Types.ValueSpecification.Fixed "Specifies whether the outlet pressure is fixed or prescribed" annotation(Dialog(group="Pressure"), Evaluate=true);
  parameter Medium.AbsolutePressure p_out_fixed = Medium.p_default "Fixed outlet pressure" annotation(
    Dialog(group="Pressure",
      enable = pSpec ==ValueSpecification.Fixed),
      HideResult = not pSpec == ValueSpecification.Fixed);
  parameter ThermalSpecification thermalSpec=ThermofluidStream.Types.ThermalSpecification.Temperature "Thermal quantity used to define the outlet state" annotation(Dialog(group="Thermal"), Evaluate=true);
  parameter ValueSpecification thermalValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed "Specifies whether the outlet thermal quantity is fixed or prescribed" annotation(Dialog(group="Thermal"), Evaluate=true);
  parameter Medium.Temperature T_out_fixed = Medium.T_default "Fixed outlet temperature" annotation(
    Dialog(group="Thermal",
      enable = thermalSpec ==ThermalSpecification.Temperature  and thermalValueSpec ==ValueSpecification.Fixed),
      HideResult = not thermalSpec == ThermalSpecification.Temperature or not thermalValueSpec == ValueSpecification.Fixed);
  parameter Medium.SpecificEnthalpy h_out_fixed = Medium.h_default "Fixed outlet specific enthalpy" annotation(
    Dialog(group="Thermal",
      enable = thermalSpec ==ThermalSpecification.SpecificEnthalpy  and thermalValueSpec ==ValueSpecification.Fixed),
      HideResult = not thermalSpec == ThermalSpecification.SpecificEnthalpy or not thermalValueSpec == ValueSpecification.Fixed);
  parameter ValueSpecification XiSpec=ThermofluidStream.Types.ValueSpecification.Fixed "Specifies whether the outlet mass fractions are fixed or prescribed" annotation(Dialog(group="Mass fractions"), Evaluate=true);
  parameter Medium.MassFraction Xi_out_fixed[Medium.nXi] = Medium.X_default[1:Medium.nXi] "Fixed outlet mass fractions" annotation(
    Dialog(group="Mass fractions",
      enable = XiSpec ==ValueSpecification.Fixed),
      HideResult = not XiSpec == ValueSpecification.Fixed);

  parameter Boolean showPressure = true "= true to show the fixed outlet pressure value p_out_fixed" annotation(
    Dialog(tab="Layout", group="Display parameters", enable = displayParameters and pSpec ==ValueSpecification.Fixed),  Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean showThermalSpecification = true "= true to show the fixed thermal outlet value (either T_out_fixed or h_out_fixed)" annotation(
    Dialog(tab="Layout",group="Display parameters",enable = displayParameters and thermalValueSpec ==ValueSpecification.Fixed), Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean showMassFractions = false "= true to show the fixed mass fraction values Xi_out_fixed" annotation(
    Dialog(tab="Layout", group="Display parameters", enable = displayParameters and XiSpec ==ValueSpecification.Fixed),  Evaluate=true, HideResult=true, choices(checkBox=true));

  Modelica.Blocks.Interfaces.RealInput p_out_prescribed(unit="Pa") if pSpec ==ValueSpecification.Prescribed  "Prescribed outlet pressure [Pa]" annotation(
    Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={100,-120})));
  Modelica.Blocks.Interfaces.RealInput T_out_prescribed(unit="K") if thermalValueSpec ==ValueSpecification.Prescribed  and thermalSpec ==ThermalSpecification.Temperature  "Outlet temperature input connector [K]"
  annotation(Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={60,-120})));
  Modelica.Blocks.Interfaces.RealInput h_out_prescribed(unit="J/kg") if thermalValueSpec ==ValueSpecification.Prescribed  and thermalSpec ==ThermalSpecification.SpecificEnthalpy  "Outlet specific enthalpy input connector [J/kg]" annotation(
    Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={20,-120})));
  Modelica.Blocks.Interfaces.RealInput Xi_out_prescribed[Medium.nXi](each unit = "kg/kg") if XiSpec ==ValueSpecification.Prescribed  "Outlet mass fractions connector [kg/kg]" annotation(
    Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={-20,-120})));

  SI.TemperatureDifference dT "Temperature difference";
  SI.SpecificEnthalpy dh "Difference in specific enthalpy";
  Medium.Temperature T_in = Medium.temperature(inlet.state) "Inlet temperature" annotation(
    HideResult = true);
  Medium.Temperature T_out "Outlet temperature" annotation(
    HideResult = true);

protected
  Modelica.Blocks.Interfaces.RealInput p_out_actual(unit="Pa") "Actual outlet pressure [Pa], required due to the conditional connector p_out_prescribed";
  Modelica.Blocks.Interfaces.RealInput T_out_actual(unit="K") "Actual outlet temperature [K], required due to the conditional connector T_out_prescribed";
  Modelica.Blocks.Interfaces.RealInput h_out_actual(unit="J/kg") "Actual outlet specific enthalpy [J/kg], required due to the conditional connector h_out_prescribed";
  Modelica.Blocks.Interfaces.RealInput Xi_out_actual[Medium.nXi](each unit = "kg/kg") "Actual outlet mass fractions [kg/kg], required due to the conditional connector Xi_out_prescribed";

equation

  connect(p_out_actual, p_out_prescribed);
  if pSpec ==ValueSpecification.Fixed  then
    p_out_actual = p_out_fixed;
  end if;
  p_out = p_out_actual;

  connect(T_out_actual, T_out_prescribed);
  if thermalValueSpec ==ValueSpecification.Fixed  and thermalSpec ==ThermalSpecification.Temperature  then
    T_out_actual = T_out_fixed;
  end if;
  T_out = T_out_actual;

  connect(h_out_actual, h_out_prescribed);
  if thermalValueSpec ==ValueSpecification.Fixed  and thermalSpec ==ThermalSpecification.SpecificEnthalpy   then
    h_out_actual = h_out_fixed;
  end if;
  h_out = h_out_actual;

  connect(Xi_out_actual, Xi_out_prescribed);
  if XiSpec ==ValueSpecification.Fixed  then
    Xi_out_actual = Xi_out_fixed;
  end if;
  Xi_out = Xi_out_actual;

  if thermalSpec ==ThermalSpecification.Temperature  then
    h_out = Medium.specificEnthalpy_pTX(p_out, T_out, Xi_out);
  else //  ThermalSpecification.SpecificEnthalpy
    T_out = Medium.temperature(outlet.state);
  end if;

  dh = h_out - h_in;
  dT = T_out - T_in;

  annotation(defaultComponentName = "composition", Icon(graphics={
        Text(visible=displayInstanceName,
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
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-50,20},{50,-20}},
          textColor={28,108,200},
          textString="pTX"),
        Text(visible = displayParameters and showPressure and pSpec == ThermofluidStream.Types.ValueSpecification.Fixed,
          extent={{-150,-60},{150,-90}},
          textColor={0,0,0},
          textString="p_out = %p_out_fixed"),
        Text(visible = displayParameters and showThermalSpecification and thermalValueSpec == ThermofluidStream.Types.ValueSpecification.Fixed and thermalSpec == ThermofluidStream.Types.ThermalSpecification.Temperature,
          extent={{-150,-130},{150,-100}},
          textColor={0,0,0},
          textString="T_out = %T_out_fixed"),
        Text(visible = displayParameters and showThermalSpecification and thermalValueSpec == ThermofluidStream.Types.ValueSpecification.Fixed and thermalSpec == ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
          extent={{-150,-130},{150,-100}},
          textColor={0,0,0},
          textString="h_out = %h_out_fixed"),
        Text(visible = displayParameters and showMassFractions and XiSpec == ThermofluidStream.Types.ValueSpecification.Fixed,
          extent={{-150,-140},{150,-170}},
          textColor={0,0,0},
          textString="Xi_out = %Xi_out_fixed"),
        Line(visible = pSpec == ThermofluidStream.Types.ValueSpecification.Prescribed,
          points={{100,0},{100,-100}}, color={0,0,127}),
        Line(visible = thermalValueSpec == ThermofluidStream.Types.ValueSpecification.Prescribed and thermalSpec == ThermofluidStream.Types.ThermalSpecification.Temperature,
          points={{100,0},{100,-100},{60,-100}}, color={0,0,127}),
        Line(visible = thermalValueSpec == ThermofluidStream.Types.ValueSpecification.Prescribed and thermalSpec == ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
          points={{100,0},{100,-100},{20,-100}}, color={0,0,127}),
        Line(visible = XiSpec == ThermofluidStream.Types.ValueSpecification.Prescribed,
          points={{100,0},{100,-100},{-20,-100}}, color={0,0,127})}), Documentation(info="<html>
  <p>
    Artificial process to set the outlet state as parameters or as time-varying input signal:
  </p>   

  <ul>
    <li>Pressure, temperature, mass fractions: <code>(p,T,Xi)</code> or</li>
    <li>Pressure, specific enthalpy, mass fractions: <code>(p,h,Xi)</code></li>
  </ul>

  <p>
    See the example <a href=\"modelica://ThermofluidStream.Idealized.Tests.Processes.PseudoSource\">Tests.Processes.PseudoSource</a>.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end PseudoSource;
