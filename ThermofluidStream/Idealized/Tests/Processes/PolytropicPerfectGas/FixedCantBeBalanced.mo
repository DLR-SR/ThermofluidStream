within ThermofluidStream.Idealized.Tests.Processes.PolytropicPerfectGas;
model FixedCantBeBalanced "Example - Isochoric process"
  extends Modelica.Icons.Example;

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)annotation(
    Placement(transformation(extent={{160,120},{180,140}})));

  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas T_out_T_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature) annotation(Placement(transformation(extent={{-10,-10},{10,10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas p_out_p_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletPressure) annotation(Placement(transformation(extent={{40,-10},{60,10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas pRatio_p_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureRatio,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletPressure) annotation(Placement(transformation(extent={{40,30},{60,50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas dp_p_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureDifference,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletPressure) annotation(Placement(transformation(extent={{40,70},{60,90}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas P_T_out(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified,
    dp_fixed=dp,
    pRatio_fixed=pRatio,
    p_out_fixed=p_out,
    T_out_fixed=T_out,
    rhoRatio_fixed=rhoRatio,
    rho_out_fixed=rho_out,
    v_out_fixed=v_out,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature,
    eta_pol_fixed=eta_pol,
    n_fixed=n,
    eta_is_fixed=eta_is) annotation(Placement(transformation(extent={{-10,-60},{10,-40}})));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    Versions of <a href=\"modelica://ThermoFluidStream.Idealized.Processes.PolytropicPerfectGas\">PolytropicPerfectGas</a> that can not be balanced.
  </p>
</html>"));
end FixedCantBeBalanced;
