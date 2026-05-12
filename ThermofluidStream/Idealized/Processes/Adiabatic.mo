within ThermofluidStream.Idealized.Processes;
model Adiabatic "Adiabatic process"

  extends ThermofluidStream.Interfaces.SISOFlow(clip_p_out = false);

  import OutletSpecification = ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic;
  import ValueSpecification = ThermofluidStream.Types.ValueSpecification;
  import PowerSignal = ThermofluidStream.Idealized.Types.EnergyFlowSignalMode;

  replaceable model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium constrainedby ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.BaseClasses.PartialAdiabatic
    "Thermodynamic model used for adiabatic process calculation"
    annotation(Evaluate = true, choices(
      choice(redeclare model ThermodynamicModel = ThermoFluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium
        "h_out_is = h(p_out, s_in)"),
      choice(redeclare model ThermodynamicModel = ThermoFluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IdealGasConstantGamma
        "p*v = R*T, gamma = const"),
      choice(redeclare model ThermodynamicModel = ThermoFluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.PerfectGas
        "p*v = R*T, cp = const"),
      choice(redeclare model ThermodynamicModel = ThermoFluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IncompressibleFluid
        "rho = const: h_out_is = dp/rho_in + h_in"),
      choice(redeclare model ThermodynamicModel = ThermoFluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IsothermalReference
        "h_out_is = h(p_out, T_in)")));

  parameter PowerSignal powerSignal =ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Disabled      "Power signal configuration"
    annotation (Dialog(group="Specification"), Evaluate=true, HideResult=true);
  parameter Boolean specifyOutlet = true "= true, if the outlet state is explicitly specified"
    annotation (Dialog(group="Specification"),Evaluate=true,HideResult=true,choices(checkBox=true));
  parameter OutletSpecification outletSpec =ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.PressureDifference      "Quantity used to define the outlet state"
    annotation (Dialog(group="Specification", enable=specifyOutlet), Evaluate=true, HideResult= not specifyOutlet);
  parameter ValueSpecification outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed "Specifies whether the quantity is fixed or prescribed" annotation (
    Dialog(group="Specification", enable=specifyOutlet),
    Evaluate=true,
    HideResult=not specifyOutlet);
  parameter SI.PressureDifference dp_fixed = 0 "Fixed pressure difference (dp = p_out - p_in)"
    annotation(Dialog(group="Specification",
      enable = specifyOutlet and outletSpec == OutletSpecification.PressureDifference and outletValueSpec ==ValueSpecification.Fixed),
      HideResult = not specifyOutlet or not outletSpec == OutletSpecification.PressureDifference or not outletValueSpec == ValueSpecification.Fixed);
  parameter Real pr_fixed = 1 "Fixed pressure ratio (pr = p_out/p_in)"
    annotation(Dialog(group="Specification",
      enable = specifyOutlet and outletSpec == OutletSpecification.PressureRatio and outletValueSpec ==ValueSpecification.Fixed),
      HideResult = not specifyOutlet or not outletSpec == OutletSpecification.PressureRatio or not outletValueSpec == ValueSpecification.Fixed);
  parameter Medium.AbsolutePressure p_out_fixed = Medium.p_default "Fixed outlet pressure"
    annotation(Dialog(group="Specification",
      enable = specifyOutlet and outletSpec == OutletSpecification.OutletPressure and outletValueSpec ==ValueSpecification.Fixed),
      HideResult = not specifyOutlet or not outletSpec == OutletSpecification.OutletPressure or not outletValueSpec == ValueSpecification.Fixed);
  parameter ValueSpecification etaSpec=ThermofluidStream.Types.ValueSpecification.Fixed "Specifies whether the isentropic efficiency is fixed or prescribed" annotation (Dialog(group="Efficiency"), Evaluate=true);
  parameter SI.Efficiency eta_fixed = 1 "Fixed isentropic efficiency"
    annotation(Dialog(group="Efficiency",
      enable = etaSpec ==ValueSpecification.Fixed),
      HideResult = not etaSpec == ValueSpecification.Fixed);
  parameter Boolean enableFilter = true "=true to enable a first order filter for the outlet pressure"
    annotation(Dialog(group="Outlet pressure filter (for specifyOutlet == false and powerSignal == Input)",
      enable = not specifyOutlet and powerSignal == PowerSignal.Input), Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Time TC = 1 "Filter time constant"
    annotation(Dialog(group="Outlet pressure filter (for specifyOutlet == false and powerSignal == Input)",
      enable = enableFilter and not specifyOutlet and powerSignal == PowerSignal.Input),
      HideResult = not enableFilter or specifyOutlet or not powerSignal == PowerSignal.Input);
  parameter SI.Power P_nom = 1 "Nominal power (influences filter time constant)"
    annotation(Dialog(group="Outlet pressure filter (for specifyOutlet == false and powerSignal == Input)",
      enable = enableFilter and not specifyOutlet and powerSignal == PowerSignal.Input),
      HideResult = not enableFilter or specifyOutlet or not powerSignal == PowerSignal.Input);
  parameter SI.PressureDifference dp_nom = 1e5 "Nominal pressure difference (influences filter time constant)"
    annotation(Dialog(group="Outlet pressure filter (for specifyOutlet == false and powerSignal == Input)",
      enable = enableFilter and not specifyOutlet and powerSignal == PowerSignal.Input),
      HideResult = not enableFilter or specifyOutlet or not powerSignal == PowerSignal.Input);
  parameter SI.PressureDifference dp_start = 0 "Pressure difference start value (filter initialization)"
    annotation(Dialog(group="Outlet pressure filter (for specifyOutlet == false and powerSignal == Input)",
      enable = enableFilter and not specifyOutlet and powerSignal == PowerSignal.Input),
      HideResult = not enableFilter or specifyOutlet or not powerSignal == PowerSignal.Input);
  parameter Boolean showOutletSpecification = true "= true to show the fixed outlet specification value (either dp_fixed, pr_fixed or p_out_fixed)"
    annotation(Dialog(tab="Layout", group="Display parameters",
      enable = displayParameters and specifyOutlet and outletValueSpec ==ValueSpecification.Fixed),  Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean showEfficiency = true "= true to show the fixed isentropic efficiency value eta_is_fixed"
    annotation(Dialog(tab="Layout", group="Display parameters", enable = displayParameters and etaSpec ==ValueSpecification.Fixed),  Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean showPowerDirection = true "= true to show the actual power direction"
    annotation(Dialog(tab="Layout", group="Display parameters", enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));

  Modelica.Blocks.Interfaces.RealInput outletSpec_prescribed if specifyOutlet and outletValueSpec ==ValueSpecification.Prescribed  "Prescribed outlet specification [SI-units]"
    annotation(Placement(transformation(extent={{-20,-20},{20,20}}, rotation=90, origin={100,-120})));
  Modelica.Blocks.Interfaces.RealInput eta_prescribed if etaSpec ==ValueSpecification.Prescribed  "Prescribed isentropic efficiency [-]"
    annotation(Placement(transformation(extent={{-20,-20},{20,20}}, rotation=90, origin={60,-120})));
  EnergyFlow.Interfaces.EnergyFlowInput P_in = P_in_internal if powerSignal == PowerSignal.Input "Power (dircted into the system) [W]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={0,-80})));
  EnergyFlow.Interfaces.EnergyFlowOutput P_out = -P if powerSignal == PowerSignal.Output "Power (directed out of the system) [W]"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=270,origin={0,-70})));

  SI.Efficiency eta_is "Isentropic efficiency";
  SI.SpecificEnthalpy dh "Difference in specific enthalpy dh = h_out - h_in";
  Real pr = p_out/p_in "Pressure ratio";
  SI.Power P "Power (technical work flow rate)";
  SI.Power P_in_internal "Power directed into the system (calculated based on the outlet pressure)"
    annotation(HideResult = true);

  final ThermodynamicModel adiabaticModel(
    redeclare final package Medium = Medium,
    final state_in=inlet.state,
    final p_out=p_out,
    final eta_is=eta_is) "Adiabatic process calculation";

protected
  Modelica.Blocks.Interfaces.RealInput outletSpec_actual "Actual outlet specification [SI-units], required due to the conditional connector outletSpec_prescribed";
  Modelica.Blocks.Interfaces.RealInput eta_actual "Actual isentropic efficiency [-], required due to the conditional connector eta_prescribed";

initial equation
  if not specifyOutlet and enableFilter then
    dp = dp_start;
  end if;

equation
  connect(outletSpec_actual, outletSpec_prescribed);
  if specifyOutlet and outletValueSpec ==ValueSpecification.Fixed  then
    if outletSpec == OutletSpecification.PressureDifference then
      outletSpec_actual = dp_fixed;
    elseif outletSpec == OutletSpecification.PressureRatio then
      outletSpec_actual = pr_fixed;
    else // OutletSpecification.OutletPressure
      outletSpec_actual = p_out_fixed;
    end if;
  end if;
  if outletSpec == OutletSpecification.PressureDifference then
    dp = outletSpec_actual;
  elseif outletSpec == OutletSpecification.PressureRatio then
    pr = outletSpec_actual;
  else // OutletSpecification.OutletPressure
    p_out = outletSpec_actual;
  end if;

  connect(eta_actual, eta_prescribed);
  if etaSpec ==ValueSpecification.Fixed  then
    eta_actual = eta_fixed;
  end if;
  eta_is = eta_actual;

  if not specifyOutlet and enableFilter then // filter pressure difference to avoid NLE
    TC*der(dp)/dp_nom = (P_in_internal - P)/P_nom;
  else
    P_in_internal = P;
  end if;

  dh = h_out - h_in;
  h_out = adiabaticModel.h_out;
  P = m_flow*dh;
  Xi_out = Xi_in;

  annotation (Icon(graphics={
        Text(visible= displayParameters and showEfficiency and etaSpec == ThermoFluidStreamPlus.Types.ValueSpecification.Fixed,
          extent={{-150,-140},{150,-110}},
          textColor={0,0,0},
          textString="η = %eta_fixed"),
        Text(visible= displayParameters and showOutletSpecification and specifyOutlet and outletSpec == ThermoFluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.PressureDifference and outletValueSpec == ThermoFluidStreamPlus.Types.ValueSpecification.Fixed,
          extent={{-150,-100},{150,-70}},
          textColor={0,0,0},
          textString="Δp = %dp_fixed"),
        Text(visible= displayParameters and showOutletSpecification and specifyOutlet and outletSpec == ThermoFluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.PressureRatio and outletValueSpec == ThermoFluidStreamPlus.Types.ValueSpecification.Fixed,
          extent={{-150,-100},{150,-70}},
          textColor={0,0,0},
          textString="pr = %pr_fixed"),
        Text(visible= displayParameters and showOutletSpecification and specifyOutlet and outletSpec == ThermoFluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure and outletValueSpec == ThermoFluidStreamPlus.Types.ValueSpecification.Fixed,
          extent={{-150,-100},{150,-70}},
          textColor={0,0,0},
          textString="p_out = %p_out_fixed"),
        Line(visible = specifyOutlet and outletValueSpec == ThermoFluidStreamPlus.Types.ValueSpecification.Prescribed,
          points={{100,0},{100,-100}},
          color={0,0,127}),
        Line(visible = etaSpec == ThermoFluidStreamPlus.Types.ValueSpecification.Prescribed,
          points={{100,0},{100,-100},{60,-100}},
          color={0,0,127}),
        Polygon(visible = not specifyOutlet and not powerSignal == ThermoFluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
          points={{-6,44},{-22,-8},{-2,-8},{-18,-50},{28,8},{2,8},{20,44},{-6,44}},
          fillPattern = if not specifyOutlet and not powerSignal == ThermoFluidStream.Idealized.Types.EnergyFlowSignalMode.Input then FillPattern.Solid else FillPattern.None,
          fillColor={238,46,47},
          pattern=LinePattern.None),
        Ellipse(visible=specifyOutlet and powerSignal == ThermoFluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
          extent={{-98,58},{-62,22}},pattern=LinePattern.None,fillColor={170,213,255},fillPattern=FillPattern.Solid),
        Rectangle(visible=specifyOutlet and powerSignal == ThermoFluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
          extent={{-78,24},{-82,56}},fillColor={28,108,200},fillPattern=FillPattern.Solid,pattern=LinePattern.None),
        Rectangle(visible=specifyOutlet and powerSignal == ThermoFluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
          extent={{-96,42},{-64,38}}, fillColor={28,108,200}, fillPattern=FillPattern.Solid, pattern=LinePattern.None),
        Text(visible = not specifyOutlet and not powerSignal == ThermoFluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
          extent={{-150,100},{150,60}},
          textString= if not specifyOutlet and not powerSignal == ThermoFluidStream.Idealized.Types.EnergyFlowSignalMode.Input then "can't be balanced" else "",
          textColor={238,46,47}),
        Text(visible = enableFilter and not specifyOutlet and powerSignal == ThermoFluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
          extent={{-100,-70},{0,-100}},
          textColor={255,170,85},
          textString="filter"),
        Rectangle(visible = 1.0 < 0.0,
          extent={{-200,200},{200,-200}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
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
          extent={{-20,20},{20,-20}},
          textColor={28,108,200},
          textString="s"),
        Polygon(visible = showPowerDirection,
          origin={-40,-50},
          rotation = if P >= 0 then 90 else -90,
          points={{-18,3},{4,3},{4,10},{18,0},{4,-10},{4,-3},{-18,-3},{-18,3}},
          fillColor = {255,170,85},
          fillPattern = if abs(P) >= 1e-8 then FillPattern.Solid else FillPattern.None,
          pattern=LinePattern.None),
        Text(visible = showPowerDirection,
          origin={-60,-70},
          extent={{0,0},{36,36}},
          textColor={255,170,85},
          textStyle={TextStyle.Bold},
          textString = if abs(P) < 1e-8 then "0" else "")}),
      Documentation(info="<html>
  <p>
    Adiabatic process suitable for modeling both hydraulic pumps and turbines (incompressible media) 
    as well as compressors, blowers, fans, and turbines (compressible media) with a fixed isentropic efficiency 
    <code>eta_is</code>.
  </p>

  <p>
    The following quantities can be specified either as parameters or as time-varying input signals:
  </p>

  <ul>
    <li>Pressure difference: <code>dp = p_out - p_in</code></li>
    <li>Pressure ratio: <code>pr = p_out / p_in</code></li>
    <li>Outlet pressure: <code>p_out</code></li>
  </ul>

  <p>
    Different assumptions can be used to calculate the adiabatic reversible
    reference process, see 
    <a href=\"modelica://ThermoFluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow\">Utilities.AdiabaticModels</a>:
  </p>
  
  <ul>
    <li>Universal - based on <code>Medium.specificEntropy()</code></li>
    <li>Ideal gas - <code>p*v = R*T, gamma = const.</code></li>
    <li>Perfect gas - <code>p*v = R*T, gamma, cp = const.</code></li>
    <li>Incompressible fluid - density <code>rho = const.</code></li>
  </ul>  

  <p>
    The power can optionally be an <code>EnergyFlowInput</code> or an
    <code>EnergyFlowOutput</code>; see
    <a href=\"modelica://ThermoFluidStream.Idealized.UsersGuide.EnergyFlow\">
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
      In this case, the power <code>P</code> is computed from the given specific enthalpy difference
      <code>dh</code> and mass flow rate <code>m_flow</code>:
      <code>P = m_flow*dh</code>.
    </li>

    <li>
      If the <strong>outlet state is set</strong> and the <strong>power is an input</strong>,
      the model is locally <strong>overdetermined</strong>.<br>
      This condition is indicated by a plus symbol on the icon layer.
      The mass flow rate is then computed from the given power <code>P</code> and specific enthalpy
      difference <code>dh</code>:
      <code>m_flow = P/dh</code>.
      To obtain an overall balanced system, a locally underdetermined component,
      such as
      <a href=\"modelica://ThermoFluidStream.Idealized.Sources.Sink_free\">
        Sink_free
      </a>,
      must be connected.
    </li>

    <li>
      If the <strong>outlet state is not set</strong> and the <strong>power is an input</strong>,
      the model is <strong>balanced</strong>.<br>
      In this case, the specific enthalpy difference <code>dh</code> is calculated from the given
      mass flow rate <code>m_flow</code> and power <code>P</code>:
      <code>dh = P/m_flow</code>.
      Determining the outlet pressure <code>p_out</code> from <code>dh</code> introduces one implicit
      nonlinear equation.
      This implicit equation can be avoided by enabling <code>enableFilter</code>.
      The filter behavior can be tuned using the time constant <code>TC</code>, the nominal pressure
      difference <code>dp_nom</code>, and the nominal power <code>P_nom</code>.
      Note that all three parameters are signed quantities.
    </li>

    <li>
      If the <strong>outlet state is not set</strong> and the <strong>power is not an input</strong>,
      the model is <strong>not permissible</strong>.<br>
      In this case, both the power <code>P</code> and the specific enthalpy difference <code>dh</code>
      are unknown, and the equation
      <code>P = m_flow*dh</code>
      cannot be balanced.
      This condition is indicated by a prominent red lightning symbol.
    </li>
  </ol>
  
  <p>
    Further assumptions for the adiabatic process:
  </p>

  <ul>
    <li>Steady-state conditions: <code>dE_sys/dt = 0, dm_sys/dt = 0</code></li>
    <li>No heat transfer: <code>Q_flow = 0</code></li>
    <li>Losses accounted for via isentropic efficiency: <code>eta_is</code></li>
    <li>
        No net external forces on the system: The control volume is not subject to acceleration as a rigid body, i.e. 
        <code>\\sum F_external = 0</code>.
      </li>
    <li>Rigid boundary: <code>Wdot_v = 0</code> (no boundary work)</li>
    <li>Neglect difference in kinetic and potential energy of the fluid: <code>g*z_2 + 1/2*c_2^2 = g*z_1 + 1/2*c_1^2</code></li>
    <li>No change in mass fractions: <code>X_in = X_out</code></li>
  </ul>  
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Adiabatic;
