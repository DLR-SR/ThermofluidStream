within ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow;
model PerfectGas "Adiabatic process, perfect gas (p*v = R*T, cp = const.)"

  extends ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.BaseClasses.PartialIdealGas;
  // unknowns - equations = 2

  import ValueSpecification = ThermofluidStream.Idealized.Utilities.Types.ValueSpecification2;

  parameter ValueSpecification cpSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification2.State "Specifies whether the isobaric heat capacity is fixed or obtained from the inlet state" annotation (Dialog(group="Assumptions"), Evaluate=true);
  parameter Medium.SpecificHeatCapacity cp_fixed = 1000 "Constant specific heat capacity"
    annotation(Dialog(group="Assumptions",
      enable = cpSpec == ValueSpecification.Fixed),
      HideResult = not cpSpec == ValueSpecification.Fixed);
  parameter Real relTolCp = 1e-2 "Relative tolerance between specific isobaric heat capacities cp_in, cp_out"
    annotation(Dialog(group="Warnings",
      enable = cpSpec == ValueSpecification.State),
      HideResult = not cpSpec == ValueSpecification.State);

  Medium.Temperature T_out "Outlet temperature";

  Medium.SpecificHeatCapacity cp "Specific isobaric heat capacity";
  Medium.SpecificHeatCapacity cp_in = Medium.specificHeatCapacityCp(state_in) "Specific isobaric heat capacity (inlet)";
  Medium.SpecificHeatCapacity cp_out = Medium.specificHeatCapacityCp(Medium.setState_phX(p_out,h_out,Xi_in)) "Specific isobaric heat capacity (outlet)";
  Real delta_cp_rel = abs(cp_out - cp_in)/max(cp_out,cp_in) "Relative difference of specific heat capacities cp_in, cp_out"
    annotation(HideResult = not cpSpec == ValueSpecification.State);
  Real isCpWithinTol = sign(relTolCp - delta_cp_rel) "= 1.0 if within tolerance, = -1.0 if tolerance is exceeded"
    annotation(HideResult = not cpSpec == ValueSpecification.State);

equation
  if cpSpec == ValueSpecification.State then
    assert(noEvent(delta_cp_rel < relTolCp),
      "In \"" + name +"\" the specific isobaric heat capacity varies between inlet and outlet beyond the specified tolerance.",
      assertionLevel);
  end if;
  cp = if cpSpec == ValueSpecification.State then cp_in else cp_fixed;
  w_t_is = cp*(T_out_is - T_in);
  w_t = cp*(T_out - T_in);
  h_out = Medium.specificEnthalpy(Medium.setState_pTX(p_out, T_out, Xi_in)); // OM Workaround

  annotation (Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    The model calculates the outlet specific enthalpy based on:
  </p>
  
  <ul>
    <li>Inlet state</li>
    <li>Outlet pressure</li>
    <li>Isentropic efficiency</li>
  </ul>
  
  <p>
    The model assumes a perfect gas (<code>p*v = R*T, cp = const.</code>).
  </p>
</html>"));
end PerfectGas;
