within ThermofluidStream.Idealized.Processes;
model PolytropicPerfectGas "Polytropic process, perfect gas"

  extends ThermofluidStream.Interfaces.SISOFlow(clip_p_out = false);

  import SystemSpecification = ThermofluidStream.Idealized.Types.SystemModel;
  import PowerSignal = ThermofluidStream.Idealized.Types.EnergyFlowSignalMode;
  import OutletSpecification = ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic;
  import ProcessSpecification = ThermofluidStream.Idealized.Types.PolytropicProcessSpecification;
  import ValueSpecification = ThermofluidStream.Types.ValueSpecification;

  parameter OutletSpecification outletSpec = ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureDifference "Quantity used to define the outlet state" annotation(
    Dialog(group="Specification"), Evaluate=true);
  parameter ValueSpecification outletValueSpec = ThermofluidStream.Types.ValueSpecification.Fixed "Specifies whether the quantity is fixed or prescribed" annotation(
    Dialog(group="Specification", enable = not outletSpec == OutletSpecification.Unspecified), Evaluate=true);
  parameter SI.PressureDifference dp_fixed = 0 "Fixed pressure difference (dp = p_out - p_in)" annotation(
    Dialog(group="Specification",
      enable = outletSpec == OutletSpecification.PressureDifference and outletValueSpec == ValueSpecification.Fixed),
    HideResult = not outletSpec == OutletSpecification.PressureDifference or not outletValueSpec == ValueSpecification.Fixed);
  parameter Real pRatio_fixed = 1 "Fixed pressure ratio (pRatio = p_out/p_in)" annotation(
    Dialog(group="Specification",
      enable = outletSpec == OutletSpecification.PressureRatio and outletValueSpec == ValueSpecification.Fixed),
      HideResult = not outletSpec == OutletSpecification.PressureRatio or not outletValueSpec == ValueSpecification.Fixed);
  parameter Medium.AbsolutePressure p_out_fixed = Medium.p_default "Fixed outlet pressure" annotation(
    Dialog(group="Specification",
      enable = (outletSpec == OutletSpecification.OutletPressure and outletValueSpec ==ValueSpecification.Fixed)  or (processSpec == ProcessSpecification.OutletPressure and processValueSpec ==ValueSpecification.Fixed)),
    HideResult = (not outletSpec == OutletSpecification.OutletPressure or not outletValueSpec == ValueSpecification.Fixed) and (not processSpec == ProcessSpecification.OutletPressure or not processValueSpec == ValueSpecification.Fixed));
  parameter Medium.Temperature T_out_fixed = Medium.T_default "Fixed outlet temperature" annotation(
    Dialog(group="Specification",
      enable = (outletSpec == OutletSpecification.OutletTemperature and outletValueSpec ==ValueSpecification.Fixed)  or (processSpec == ProcessSpecification.OutletTemperature and processValueSpec == ValueSpecification.Fixed)),
    HideResult = (not outletSpec == OutletSpecification.OutletTemperature or not outletValueSpec == ValueSpecification.Fixed) and (not processSpec == ProcessSpecification.OutletTemperature or not processValueSpec == ValueSpecification.Fixed));
  parameter Real rhoRatio_fixed = 1 "Fixed compression ratio (rho_out/rho_in)" annotation(
    Dialog(group="Specification",
      enable = outletValueSpec == ValueSpecification.Fixed  and outletSpec == OutletSpecification.CompressionRatio),
      HideResult = not outletValueSpec == ValueSpecification.Fixed or not outletSpec == OutletSpecification.CompressionRatio);
  parameter Medium.Density rho_out_fixed = Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default)) "Fixed outlet density" annotation(
    Dialog(group="Specification",
      enable = outletValueSpec ==ValueSpecification.Fixed and outletSpec == OutletSpecification.OutletDensity),
      HideResult = not outletValueSpec == ValueSpecification.Fixed or not outletSpec == OutletSpecification.OutletDensity);
  parameter SI.SpecificVolume v_out_fixed = 1/rho_out_fixed "Fixed outlet specific volume" annotation(
    Dialog(group="Specification",
      enable = outletValueSpec == ValueSpecification.Fixed  and outletSpec == OutletSpecification.OutletSpecificVolume),
    HideResult = not outletValueSpec == ValueSpecification.Fixed or not outletSpec == OutletSpecification.OutletSpecificVolume);
  parameter ProcessSpecification processSpec = ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.PolytropicEfficiency "Quantity used to define the process" annotation(
    Dialog(group="Specification"), Evaluate=true);
  parameter ValueSpecification processValueSpec = ThermofluidStream.Types.ValueSpecification.Fixed "Specifies whether the quantity is fixed or prescribed" annotation(Dialog(group="Specification"), Evaluate=true);
  parameter SI.Efficiency eta_pol_fixed = 1 "Fixed polytropic efficiency" annotation(
    Dialog(group="Specification",
      enable = processSpec == ProcessSpecification.PolytropicEfficiency and processValueSpec == ValueSpecification.Fixed),
      HideResult = not processSpec == ProcessSpecification.PolytropicEfficiency or not processValueSpec == ValueSpecification.Fixed);
  parameter Real n_fixed = Medium.isentropicExponent(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))  "Fixed polytropic exponent" annotation(
    Dialog(group="Specification",
      enable = processSpec == ProcessSpecification.PolytropicExponent and processValueSpec == ValueSpecification.Fixed),
    HideResult = not processSpec == ProcessSpecification.PolytropicExponent or not processValueSpec == ValueSpecification.Fixed);
  parameter SI.Efficiency eta_is_fixed = 1 "Fixed isentropic efficiency" annotation(
    Dialog(group="Specification",
      enable = processSpec == ProcessSpecification.IsentropicEfficiency and processValueSpec == ValueSpecification.Fixed),
      HideResult = not processSpec == ProcessSpecification.IsentropicEfficiency or not processValueSpec == ValueSpecification.Fixed);
  parameter PowerSignal powerSignal = ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Disabled "Power signal configuration" annotation(
    Dialog(group="Advanced specification"), Evaluate=true, HideResult=true);
  parameter SystemSpecification systemSpec = ThermofluidStream.Idealized.Types.SystemModel.Flow "Select whether the system is steady-flow (open) or a closed cycle (periodic)" annotation(
    Dialog(group="Advanced specification"), Evaluate=true);
  parameter Boolean showOutletSpecification = true "= true to show the fixed outlet specification value (either dp_fixed, pRatio_fixed, p_out_fixed, T_out_fixed, rhoRatio_fixed, rho_out_fixed or v_out_fixed)" annotation(
    Dialog(tab="Layout", group="Display parameters",
      enable = displayParameters and not outletSpec == OutletSpecification.Unspecified and outletValueSpec == ValueSpecification.Fixed),  Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean showProcessSpecification = true "= true to show the fixed process specification value (either eta_pol_fixed, n_fixed, eta_is_fixed, p_out_fixed or T_out_fixed)" annotation(
    Dialog(tab="Layout", group="Display parameters", enable = displayParameters and processValueSpec == ValueSpecification.Fixed),  Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean showPowerDirection = true "= true to show the actual power direction" annotation(
    Dialog(tab="Layout", group="Display parameters", enable=displayParameters), Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.AbsolutePressure p_inf = 1e5 "Ambient pressure (cycle process)" annotation(
    Dialog(group = "Closed cycle (periodic) process",
      enable = systemSpec == SystemSpecification.Cycle),
      HideResult = not systemSpec == SystemSpecification.Cycle);

  Modelica.Blocks.Interfaces.RealInput outletSpec_prescribed if outletValueSpec == ValueSpecification.Prescribed  and not outletSpec == OutletSpecification.Unspecified "Prescribed outlet specification [SI-units]" annotation(
    Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={100,-120})));
  Modelica.Blocks.Interfaces.RealInput processSpec_prescribed if processValueSpec == ValueSpecification.Prescribed  "Prescribed process specification [SI-units]" annotation(
    Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={60,-120})));
  EnergyFlow.Interfaces.EnergyFlowInput P_in = P if powerSignal == PowerSignal.Input "Power (dircted into the system) [W]" annotation(
    Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={0,-80})));
  EnergyFlow.Interfaces.EnergyFlowOutput P_out = -P if powerSignal == PowerSignal.Output "Power (directed out of the system) [W]" annotation(
    Placement(transformation(extent={{-10,-10},{10,10}},rotation=270,origin={0,-70})));

  Medium.Temperature T_in = Medium.temperature(inlet.state) "Inlet temperature";
  Medium.Density rho_in = Medium.density(inlet.state) "Inlet density" annotation(
    HideResult = not systemSpec == SystemSpecification.Cycle or not (outletSpec == OutletSpecification.CompressionRatio or outletSpec == OutletSpecification.OutletDensity or outletSpec == OutletSpecification.OutletSpecificVolume));
  SI.SpecificVolume v_in = 1/rho_in "Inlet specific volume" annotation(
    HideResult = not systemSpec == SystemSpecification.Cycle or not (outletSpec == OutletSpecification.CompressionRatio or outletSpec == OutletSpecification.OutletDensity or outletSpec == OutletSpecification.OutletSpecificVolume));

  Medium.IsentropicExponent gamma = Medium.isentropicExponent(inlet.state) "Isentropic exponent";
  Real R(final unit = "J/(kg.K)") = Modelica.Constants.R/Medium.molarMass(inlet.state) "Specific gas constant";
  Medium.SpecificHeatCapacity cp = Medium.specificHeatCapacityCp(inlet.state) "Specific isobaric heat capacity" annotation(
    HideResult = systemSpec == SystemSpecification.Cycle);
  Medium.SpecificHeatCapacity cv = cp - R "Specific isochoric heat capacity" annotation(
    HideResult = systemSpec == SystemSpecification.Flow);

  Medium.Temperature T_out "Outlet temperature" annotation(
    HideResult=true);
  SI.Temperature T_out_is "Isentropic outlet temperature";
  Medium.Density rho_out "Outlet density" annotation(
    HideResult = not systemSpec == SystemSpecification.Cycle or not (outletSpec == OutletSpecification.CompressionRatio or outletSpec == OutletSpecification.OutletDensity or outletSpec == OutletSpecification.OutletSpecificVolume));
  SI.SpecificVolume v_out = 1/rho_out "Outlet specific volume" annotation(
    HideResult = not systemSpec == SystemSpecification.Cycle or not (outletSpec == OutletSpecification.CompressionRatio or outletSpec == OutletSpecification.OutletDensity or outletSpec == OutletSpecification.OutletSpecificVolume));

  SI.TemperatureDifference dT = T_out - T_in "Temperature difference (T_out - T_in)";
  SI.TemperatureDifference dT_is = T_out_is - T_in "Isentropic temperature difference (T_out_is - T_in)";
  SI.SpecificEnthalpy dh = cp*dT "Specific enthalpy difference (h_out - h_in)" annotation(
    HideResult = systemSpec == SystemSpecification.Cycle);
  SI.SpecificEnergy du = cv*dT "Specific internal energy difference (u2 - u1) for stationary flow representation of a polytropic cycle process" annotation(
    HideResult = systemSpec == SystemSpecification.Flow);

  SI.Efficiency eta_is "Isentropic efficiency";
  SI.Efficiency eta_pol "Polytropic efficiency";
  Real n "Polytropic exponent";

  SI.SpecificEnthalpy w_s = dh "Specific shaft work" annotation(
    HideResult = systemSpec == SystemSpecification.Cycle); // More precisely dh = w_s + q
  SI.SpecificEnthalpy w_s_is = cp*dT_is "Isentropic specific shaft work" annotation(
    HideResult = systemSpec == SystemSpecification.Cycle);
  SI.SpecificEnthalpy w_p = n_aux*R*dT "Specific pressure work" annotation(
    HideResult = systemSpec == SystemSpecification.Cycle);

  // Stationary-flow representation of a polytropic cycle process
  SI.SpecificEnergy w_i = du "Specific internal work" annotation(
    HideResult = systemSpec == SystemSpecification.Flow); // More precisely du = w_i + q
  SI.SpecificEnergy w_i_net = du - w_amb "Net specific internal work" annotation(
    HideResult = systemSpec == SystemSpecification.Flow); // More precisely du = w_i + q
  SI.SpecificEnergy w_i_is = cv*dT_is "Specific isentropic internal work" annotation(
    HideResult = systemSpec == SystemSpecification.Flow);
  SI.SpecificEnergy w_exp = 1/(n-1)*R*dT  "Specific expansion work" annotation(
    HideResult = systemSpec == SystemSpecification.Flow);
  SI.SpecificEnergy w_amb = -p_inf*(v_out - v_in) "Specific ambient pressure work" annotation(
    HideResult = systemSpec == SystemSpecification.Flow);
  SI.SpecificEnergy w_exp_net = w_exp - w_amb  "Net specific expansion work" annotation(
    HideResult = systemSpec == SystemSpecification.Flow);

  SI.SpecificEnthalpy w_f = w_s - w_p "Specific friction work"; // More precisely w_s - w_p = w_f + q or w_i - w_exp =  w_f + q

  SI.Power P "Power"; // More precisely m_flow*dh = P + Q_flow or m*du/dt = P + Q_flow

protected
  Modelica.Blocks.Interfaces.RealInput outletSpec_actual "Actual outlet specification [SI-units], required due to the conditional connector outletSpec_prescribed";
  Modelica.Blocks.Interfaces.RealInput processSpec_actual "Actual process specification [SI-units], required due to the conditional connector processSpec_prescribed";

  Real n_aux "= n/(n-1); auxiliary variable"; //required to avoid implicit nonlinear equations
  Real gamma_aux = gamma/(gamma-1) "Auxiliary variable";

  Real pRatio = p_out/p_in "Pressure ratio p_out/p_in";
  Real TRatio(start = 1) = T_out/T_in "Temperature ratio T_out/T_in";
  Real TRatio_is(start = 1) = T_out_is/T_in "Isentropic temperature ratio T_out_is/T_in";
  Real rhoRatio = rho_out/rho_in "Compression ratio rho_out/rho_in" annotation(
    HideResult = not systemSpec == SystemSpecification.Cycle or not (outletSpec == OutletSpecification.CompressionRatio or outletSpec == OutletSpecification.OutletDensity or outletSpec == OutletSpecification.OutletSpecificVolume));
  Real log_pRatio = log(pRatio) "=log(pRatio)"; //required to avoid implicit nonlinear equations
  Real log_TRatio = log(TRatio) "=log(TRatio)"; //required to avoid implicit nonlinear equations
  Real log_TRatio_is = log(TRatio_is) "=log(TRatio_is)"; //required to avoid implicit nonlinear equations
  Real log_rhoRatio = log(rhoRatio) "=log(rhoRatio)" annotation(
    HideResult = not systemSpec == SystemSpecification.Cycle or not (outletSpec == OutletSpecification.CompressionRatio or outletSpec == OutletSpecification.OutletDensity or outletSpec == OutletSpecification.OutletSpecificVolume)); //required to avoid implicit nonlinear equations
  Real isCompression "=1.0 if p_out > p_in + eps"; //required to avoid implicit nonlinear equations
  Real isExpansion "=1.0 if p_out < p_in - eps"; //required to avoid implicit nonlinear equations
  constant Real eps = Modelica.Constants.eps;

equation
  connect(outletSpec_actual, outletSpec_prescribed);
  if outletValueSpec == ValueSpecification.Fixed  then
    if outletSpec == OutletSpecification.PressureDifference  then
      outletSpec_actual = dp_fixed;
    elseif outletSpec == OutletSpecification.PressureRatio  then
      outletSpec_actual = pRatio_fixed;
    elseif outletSpec == OutletSpecification.OutletPressure  then
      outletSpec_actual = p_out_fixed;
    elseif outletSpec == OutletSpecification.OutletTemperature  then
      outletSpec_actual = T_out_fixed;
    elseif outletSpec == OutletSpecification.CompressionRatio  then
      outletSpec_actual = rhoRatio_fixed;
    elseif outletSpec == OutletSpecification.OutletDensity  then
      outletSpec_actual = rho_out_fixed;
    elseif outletSpec == OutletSpecification.OutletSpecificVolume  then
      outletSpec_actual = v_out_fixed;
    else // outletSpec == OutletSpecification.Unspecified
    end if;
  end if;
  if outletSpec == OutletSpecification.PressureDifference  then
    dp = outletSpec_actual;
  elseif outletSpec == OutletSpecification.PressureRatio  then
    pRatio = outletSpec_actual;
  elseif outletSpec == OutletSpecification.OutletPressure  then
    p_out = outletSpec_actual;
  elseif outletSpec == OutletSpecification.OutletTemperature  then
    T_out = outletSpec_actual;
  elseif outletSpec == OutletSpecification.CompressionRatio  then
    rhoRatio = outletSpec_actual;
  elseif outletSpec == OutletSpecification.OutletDensity  then
    rho_out = outletSpec_actual;
  elseif outletSpec == OutletSpecification.OutletSpecificVolume  then
    v_out = outletSpec_actual;
  else // outletSpec == OutletSpecification.Unspecified, required to balance the model. outletSpec_actual will not be used in this case.
    dp = outletSpec_actual;
  end if;

  connect(processSpec_actual, processSpec_prescribed);
  if processValueSpec == ValueSpecification.Fixed  then
    if processSpec == ProcessSpecification.PolytropicEfficiency  then
      processSpec_actual = eta_pol_fixed;
    elseif processSpec == ProcessSpecification.PolytropicExponent  then
      processSpec_actual = n_fixed;
    elseif processSpec == ProcessSpecification.IsentropicEfficiency  then
      processSpec_actual = eta_is_fixed;
    elseif processSpec == ProcessSpecification.OutletPressure then
      processSpec_actual = p_out_fixed;
    else // processSpec == ProcessSpecification.OutletTemperature
      processSpec_actual = T_out_fixed;
    end if;
  end if;
  if processSpec == ProcessSpecification.PolytropicEfficiency  then
    eta_pol = processSpec_actual;
  elseif processSpec == ProcessSpecification.PolytropicExponent  then
    n = processSpec_actual;
  elseif processSpec == ProcessSpecification.IsentropicEfficiency  then
    eta_is = processSpec_actual;
  elseif processSpec == ProcessSpecification.OutletPressure then
    p_out = processSpec_actual;
  else // processSpec == ProcessSpecification.OutletTemperature
    T_out = processSpec_actual;
  end if;

  log_pRatio - log_rhoRatio = log_TRatio; // Ideal gas law: p_out/p_in * rho_in/rho_out = T_out/T_in <-> p/rho = R*T
  gamma_aux*log_TRatio_is = log_pRatio; // Entropy relation: p*v^gamma = const <-> (T_out/T_in)^gamma/(gamma-1) = (p_out/p_in). This will create a system of nonlinear equations of size 2 in case of (CompressionRatio or OutletDensity or OutletSpecificVolume) and IsentropicEfficiency

  isCompression =
    if outletSpec == OutletSpecification.OutletPressure or outletSpec == OutletSpecification.PressureRatio or outletSpec == OutletSpecification.PressureDifference or processSpec == ProcessSpecification.OutletPressure then sign((pRatio - 1) - eps)
    elseif outletSpec == OutletSpecification.OutletTemperature or processSpec == ProcessSpecification.OutletTemperature then sign((TRatio - 1) - eps)
    elseif outletSpec == OutletSpecification.CompressionRatio or outletSpec == OutletSpecification.OutletDensity or outletSpec == OutletSpecification.OutletSpecificVolume then sign((rhoRatio - 1) - eps)
    else sign(P - eps);
  isExpansion =
    if outletSpec == OutletSpecification.OutletPressure or outletSpec == OutletSpecification.PressureRatio or outletSpec == OutletSpecification.PressureDifference or processSpec == ProcessSpecification.OutletPressure then sign((1/pRatio - 1) - eps)
    elseif outletSpec == OutletSpecification.OutletTemperature or processSpec == ProcessSpecification.OutletTemperature then sign((1/TRatio - 1) - eps)
    elseif outletSpec == OutletSpecification.CompressionRatio or outletSpec == OutletSpecification.OutletDensity or outletSpec == OutletSpecification.OutletSpecificVolume then sign((1/rhoRatio - 1) - eps)
    else sign(-P - eps);

  // Isentropic efficiency
  // isentropic efficiency for stationary flow and periodic closed cycle models are equivalent in the case of constant isentropic coefficient kappa (using w_i and w_s)
  if processSpec == ProcessSpecification.IsentropicEfficiency then
    if noEvent(isCompression > 0) then
      w_s*eta_is = w_s_is;
    elseif noEvent(isExpansion > 0) then
      w_s_is*eta_is = w_s;
    else
      w_s = w_s_is;
    end if;
  else
    if noEvent(isCompression > 0) then
      w_s*eta_is = w_s_is;
    elseif noEvent(isExpansion > 0) then
      w_s_is*eta_is = w_s;
    else
      eta_is = 1; // Isentropic exponent eta_is is not well defined for p_out = p_in
    end if;
  end if;

  // Polytropic efficiency
  if processSpec == ProcessSpecification.PolytropicEfficiency then
    if noEvent(isCompression > 0) then
      gamma_aux*eta_pol = n_aux;
    elseif noEvent(isExpansion > 0) then
      n_aux*eta_pol = gamma_aux;
    else
      n_aux = gamma_aux; // Polytropic exponent n is not well defined for p_out = p_in
    end if;
  else
    if noEvent(isCompression > 0) then
      gamma_aux*eta_pol = n_aux;
    elseif noEvent(isExpansion > 0) then
      n_aux*eta_pol = gamma_aux;
    else
      eta_pol = 1; // Polytropic efficiency eta_pol is not well defined for p_out = p_in
    end if;
  end if;

  // Polytropic exponent
  if processSpec == ProcessSpecification.PolytropicExponent then
    n_aux*log_TRatio = log_pRatio;
  else
    if noEvent(isCompression > 0 or isExpansion > 0) or processSpec == ProcessSpecification.PolytropicEfficiency then
      n_aux*log_TRatio = log_pRatio;
    else
      n_aux = gamma_aux; // Polytropic exponent n is not well defined for p_out = p_in
    end if;
  end if;

  (n-1)*n_aux = n;

  // zero flow, zero power
  if powerSignal == PowerSignal.Input and noEvent(abs(P) < eps) and outletSpec == OutletSpecification.Unspecified and noEvent(abs(m_flow) < eps) then
    if processSpec == ProcessSpecification.OutletPressure then
      w_s = w_s_is;
    else
      w_s = 0;
    end if;
  elseif powerSignal == PowerSignal.Input and noEvent(abs(P) < eps) and not outletSpec == OutletSpecification.Unspecified then
    m_flow = 0;
  else
    if systemSpec == SystemSpecification.Flow then
      P = m_flow*w_s;
    else
      P = m_flow*w_i_net;
    end if;
  end if;
  Xi_out = Xi_in;
  h_out = h_in + dh;

  annotation(
    defaultComponentName = "polytropic",
    Icon(
      graphics={
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
        Ellipse(
          extent={{-50,50},{50,-50}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Text(
          extent={{-150,120},{150,80}},
          textString = if displayInstanceName then "%name" else "",
          textColor=dropOfCommons.instanceNameColor),
        Text(visible = systemSpec == ThermofluidStream.Idealized.Types.SystemModel.Flow,
          extent={{-30,30},{30,-30}},
          textColor={28,108,200},
          textString="n"),
        Text(
          extent= {{-40,30},{40,-30}},
          textColor={28,108,200},
          textString = if systemSpec == ThermofluidStream.Idealized.Types.SystemModel.Cycle then "n-c" else ""),
        Text(
          extent={{-150,-100},{150,-70}},
          textColor={0,0,0},
          textString = if not displayParameters or not showOutletSpecification or not outletValueSpec == ThermofluidStream.Types.ValueSpecification.Fixed or outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified then ""
          elseif outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureDifference then "Δp = %dp_fixed"
          elseif outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureRatio then "pRatio = %pRatio_fixed"
          elseif outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure then "p_out = %p_out_fixed"
          elseif outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature then "T_out = %T_out_fixed"
          elseif outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio then "rhoRatio = %rhoRatio_fixed"
          elseif outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletDensity then "rho_out = %rho_out_fixed"
          elseif outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletSpecificVolume then "v_out = %v_out_fixed"
          else "error"),
        Text(
          extent={{-150,-140},{150,-110}},
          textColor={0,0,0},
          textString = if not displayParameters or not showProcessSpecification or not processValueSpec == ThermofluidStream.Types.ValueSpecification.Fixed then ""
          elseif processSpec == ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.PolytropicEfficiency then "eta_pol = %eta_pol_fixed"
          elseif processSpec == ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.PolytropicExponent then "n = %n_fixed"
          elseif processSpec == ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.IsentropicEfficiency then "eta_is = %eta_is_fixed"
          elseif processSpec == ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletPressure then "p_out = %p_out_fixed"
          elseif processSpec == ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature then "T_out = %T_out_fixed"
          else "error"),
        Line(
          points = if not outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified and outletValueSpec == ThermofluidStream.Types.ValueSpecification.Prescribed then {{100,0},{100,-100}} else {{0,0}},
          color={0,0,127}),
        Line(
          points = if processValueSpec == ThermofluidStream.Types.ValueSpecification.Prescribed then {{100,0},{100,-100},{60,-100}} else {{0,0}},
          color={0,0,127}),
        Polygon(visible = showPowerDirection,
          origin={-40,-50},
          rotation = DynamicSelect(90, if P >= 0 then 90 else -90),
          points={{-18,3},{4,3},{4,10},{18,0},{4,-10},{4,-3},{-18,-3},{-18,3}},
          fillColor = {255,170,85},
          fillPattern = DynamicSelect(FillPattern.None, if abs(P) >= 1e-8 then FillPattern.Solid else FillPattern.None),
          pattern=LinePattern.None),
        Text(visible = showPowerDirection,
          origin={-60,-70},
          extent={{0,0},{36,36}},
          textColor={255,170,85},
          textStyle={TextStyle.Bold},
          textString = DynamicSelect("", if abs(P) < 1e-8 then "0" else "")),
        Text(
          extent={{-150,100},{150,60}},
          textColor={238,46,47},
          textString = if (outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified and not powerSignal == ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input)
          or (outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified and powerSignal == ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input and processSpec == ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature)
          or (outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature and processSpec == ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature)
          or ((outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureDifference or outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureRatio or outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure) and processSpec == ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletPressure)
          then "can't be balanced" else ""),
        Polygon(
          points={{-6,44},{-22,-8},{-2,-8},{-18,-50},{28,8},{2,8},{20,44},{-6,44}},
          fillColor={238,46,47},
          pattern=LinePattern.None,
          fillPattern = if (outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified and not powerSignal == ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input)
          or (outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified and powerSignal == ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input and processSpec == ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature)
          or (outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature and processSpec == ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature)
          or ((outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureDifference or outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureRatio or outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure) and processSpec == ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletPressure)
          then FillPattern.Solid else FillPattern.None),
        Ellipse(
          extent={{-98,58},{-62,22}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern = if not outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified and powerSignal == ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input
          then FillPattern.Solid else FillPattern.None),
        Rectangle(
          extent={{-78,24},{-82,56}},
          fillColor={28,108,200},
          fillPattern = if not outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified and powerSignal == ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input
          then FillPattern.Solid else FillPattern.None,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-96,42},{-64,38}},
          fillColor={28,108,200},
          fillPattern = if not outletSpec == ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified and powerSignal == ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input
          then FillPattern.Solid else FillPattern.None,
          pattern=LinePattern.None)}),
    Documentation(
      info="<html>
  <p>
    Polytropic process (<code>p*v^n = const.</code>) of a perfect gas (<code>p*v = R*T, cp = const.</code>) suitable for modeling
    compressors, blowers, fans, and turbines. The model can be used for a steady-flow open process or for a periodic closed cycle process.
  </p>


  <p>
    The following outlet quantities can be specified either as parameters or as time-varying input signals:
  </p>

  <ul>
    <li>Pressure difference: <code>dp = p_out - p_in</code></li>
    <li>Pressure ratio: <code>pRatio = p_out / p_in</code></li>
    <li>Outlet pressure: <code>p_out</code></li>
    <li>Outlet temperature: <code>T_out</code></li>
    <li>Compression ratio: <code>rhoRatio = rho_out / rho_in</code></li>
    <li>Outlet density: <code>rho_out</code></li>
    <li>Outlet specific volume: <code>v_out</code></li>
  </ul>

  <p>
    The following process quantities can be specified either as parameters or as time-varying input signals:
  </p>

  <ul>
    <li>Polytropic efficiency: <code>eta_pol</code></li>
    <li>Polytropic exponent: <code>n</code></li>
    <li>Isentropic efficiency: <code>eta_is</code></li>
    <li>Outlet pressure: <code>p_out</code></li>
    <li>Outlet temperature: <code>T_out</code></li>
  </ul>

  <p>
    Relevant specific works for a steady-flow open process are:
  </p>

  <ul>
    <li>shaft: <code> w_s (+ q) = dh = cp*dT</code></li>
    <li>pressure: <code>w_p + w_r = w_s, w_p = n/(n-1)*R*dT</code></li>
    <li>friction: <code>w_f</code></li>
  </ul>
  
  <p>
    Relevant specific works for a periodic closed cycle process are:
  </p>

  <ul>
    <li>internal: <code>w_i (+ q) = du = cv*dT</code></li>
    <li>expansion: <code>w_exp + w_r = w_i, w_exp = 1/(n-1)*R*dT</code></li>
    <li>ambient pressure: <code>w_amb = - p_inf*dv</code></li>
    <li>net expansion: <code>w_exp_net = w_exp - w_amb</code></li>
    <li>friction: <code>w_f</code></li>
  </ul>

  <p>
    Note:
  </p>

  <ul>
    <li>Defining the outlet temperature <code>T_out</code> twice yields an unbalanced model</li>
    <li>Defining the outlet pressure <code>p_out</code> twice yields an unbalanced model</li>
    <li>Defining the outlet temperature <code>T_out</code>, power <code>P</code> and mass flow rate <code>m_flow</code> yields an unbalanced model</li>
  </ul>
   
  <p>
    The power can optionally be an <code>EnergyFlowInput</code> or an
    <code>EnergyFlowOutput</code>; see
    <a href=\"modelica://ThermofluidStream.Idealized.UsersGuide.EnergyFlow\">
      UsersGuide.EnergyFlow
    </a>
    for details.
    During simulation, the physical positive direction of power is visualized on the icon layer
    by an orange arrow.
  </p>

  <p>
    The model supports four possible operating modes:
  </p>

  <ol>
    <li>
      If the <strong>outlet state is set</strong> and the <strong>power is not an input</strong>,
      the model is <strong>balanced</strong>.<br>
      In this case, the power <code>P</code> of a steady-flow open process is computed from the given specific enthalpy difference
      <code>dh</code> and mass flow rate <code>m_flow</code>:
      <code>P = m_flow*dh</code>. For a periodic closed process the power is computed from the given specific internal energy difference
      <code>du</code> and mean mass flow rate <code>m_flow</code>: <code>P = m_flow*du</code>, 
    </li>

    <li>
      If the <strong>outlet state is set</strong> and the <strong>power is an input</strong>,
      the model is locally <strong>overdetermined</strong>.<br>
      This condition is indicated by a plus symbol on the icon layer.
      The mass flow rate is then computed from the given power <code>P</code> and specific enthalpy
      difference <code>dh</code> or specific internal energy difference <code>du</code>:
      <code>m_flow = P/dh</code> or <code>m_flow = P/du</code>.
      To obtain an overall balanced system, a locally underdetermined component,
      such as
      <a href=\"modelica://ThermofluidStream.Idealized.Boundaries.Sink_free\">
        Sink_free
      </a>,
      must be connected.
    </li>

    <li>
      If the <strong>outlet state is not set</strong> and the <strong>power is an input</strong>,
      the model is <strong>balanced</strong>.<br>
      In this case, the specific enthalpy difference <code>dh</code> or specific internal energy difference <code>du</code> is calculated from the given
      mass flow rate <code>m_flow</code> and power <code>P</code>:
      <code>dh = P/m_flow</code> or <code>du = P/m_flow</code>.
    </li>

    <li>
      If the <strong>outlet state is not set</strong> and the <strong>power is not an input</strong>,
      the model is <strong>not permissible</strong>.<br>
      In this case, both the power <code>P</code> and the specific enthalpy difference <code>dh</code> (or the specific internal energy difference <code>du</code>)
      are unknown, and the equations
      <code>P = m_flow*dh</code> or <code>P = m_flow*du</code>
      cannot be balanced.
      This condition is indicated by a prominent red lightning symbol.
    </li>
  </ol>
  
  <p>
    Further assumptions for the polytropic process:
  </p>

  <ul>
    <li>
      Steady-state conditions: <code>dE_sys/dt = 0, dm_sys/dt = 0</code>
    </li>
    <li>
      No heat transfer: <code>Q_flow = 0</code>
    </li>
    <li>
      Losses accounted for via polytropic efficiency <code>eta_pol</code>, polytropic exponent <code>n</code> or isentropic efficiency <code>eta_is</code>
    </li>
    <li>
      No net external forces on the system: The control volume is not subject to acceleration as a rigid body, i.e. 
      <code>\\sum F_external = 0</code>.
    </li>
    <li>
      Rigid boundary,  no expansion work: <code>w_exp = 0</code>
    </li>
    <li>
      Negligible kinetic and potential energy changes: Differences between inlet and outlet are neglected, i.e. 
      <code>g*z_2 + 1/2*c_2^2 ≈ g*z_1 + 1/2*c_1^2</code>.
    </li>
    <li>
      Constant composition: No change in species mass fractions across the control volume, i.e. 
      <code>X_in = X_out</code>.
    </li>
  </ul> 

  <p>
    The heat flow rate can be accounted for as <code>P &rarr; P + Q_flow, w_s &rarr; w_s + q,  w_i &rarr; w_i + q, w_r &rarr; w_r + q</code>.
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
end PolytropicPerfectGas;
