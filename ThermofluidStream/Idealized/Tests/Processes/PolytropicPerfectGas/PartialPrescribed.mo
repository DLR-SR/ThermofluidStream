within ThermofluidStream.Idealized.Tests.Processes.PolytropicPerfectGas;
model PartialPrescribed
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium annotation(
    choicesAllMatching = true);

  SI.Pressure p_in=inletPressure.y;
  SI.Temperature T_in=inletTemperature.y;
  Real pRatio=pressureRatio.y "Pressure ratio";
  Real Tr = T_out/T_in "Temperature ratio";
  Real Tr_is = T_out_is/T_in "Isentropic temperature ratio";
  Real vr = v_out/v_in "Specific volume ratio";
  SI.Efficiency eta_is=isentropicEfficiency.y "Isentropic efficiency";
  Medium.ThermodynamicState state_in = Medium.setState_pTX(p_in, T_in, Medium.X_default) "Inlet state";
  Medium.Density rho_in = Medium.density(state_in) "Inlet density";
  SI.SpecificVolume v_in = 1/rho_in "Inlet specific volume";
  Medium.IsentropicExponent gamma = Medium.isentropicExponent(state_in) "Isentropic exponent";
  Real R(final unit = "J/(kg.K)") = Modelica.Constants.R/Medium.molarMass(state_in) "Specific gas constant";
  Medium.SpecificHeatCapacity cp = Medium.specificHeatCapacityCp(state_in) "Isobaric heat capcity";

  Medium.AbsolutePressure p_out = p_in*pRatio "Outlet pressure";
  SI.PressureDifference dp = p_out - p_in "Pressure difference";
  SI.Temperature T_out_is = T_in*(p_out/p_in)^((gamma-1)/gamma) "Isentropic outlet temperature";
  SI.Temperature T_out = if pRatio >= 1 then T_in + 1/eta_is*(T_out_is - T_in) else T_in + eta_is*(T_out_is - T_in) "Outlet temperature";
  Medium.Density rho_out = p_out/(R*T_out) "Outlet density";
  Real rhoRatio = rho_out/rho_in "Compression ratio";
  SI.SpecificVolume v_out=1/rho_out "Outlet specific volume";

  Real n_aux = if noEvent(abs(pRatio - 1) < Modelica.Constants.eps) then gamma/(gamma-1) else log(pRatio)/log(T_out/T_in);
  Real n = n_aux/(n_aux -1)  "Polytropic exponent"; // n_aux = n/(n-1)
  Real k_aux = gamma/(gamma - 1);
  Real eta_pol = if pRatio >= 1 then n_aux/k_aux else k_aux/n_aux "Polytropic efficiency";
  SI.MassFlowRate m_flow=massFlowRate.y "Mass flow rate";
  SI.SpecificEnthalpy w_t = cp*(T_out - T_in) "Specific technical work";
  SI.Power P = m_flow*w_t "Power";

  Modelica.Blocks.Sources.SawTooth inletPressure(
    amplitude=1e5,
    period=1,
    offset=1e5,
    startTime=0.1) annotation(Placement(transformation(extent={{-350,150},{-330,170}})));
  Modelica.Blocks.Sources.SawTooth inletTemperature(
    amplitude=100,
    period=1,
    offset=293.15,
    startTime=0.2) annotation(Placement(transformation(extent={{-350,110},{-330,130}})));
  Modelica.Blocks.Sources.SawTooth pressureRatio(
    amplitude=1.5,
    period=1,
    offset=0.5,
    startTime=0.3) annotation(Placement(transformation(extent={{-340,56},{-320,76}})));
  Modelica.Blocks.Sources.SawTooth isentropicEfficiency(
    amplitude=-0.2,
    period=1,
    offset=0.9,
    startTime=0.4) annotation(Placement(transformation(extent={{-340,-120},{-320,-100}})));
  Modelica.Blocks.Sources.RealExpression pressureDifference(y=dp) annotation(Placement(transformation(extent={{-340,80},{-320,100}})));
  Modelica.Blocks.Sources.RealExpression outletPressure(y=p_out) annotation(Placement(transformation(extent={{-340,30},{-320,50}})));
  Modelica.Blocks.Sources.RealExpression outletTemperature(y=T_out) annotation(Placement(transformation(extent={{-340,10},{-320,30}})));
  Modelica.Blocks.Sources.RealExpression outletDensity(y=rho_out) annotation(Placement(transformation(extent={{-340,-30},{-320,-10}})));
  Modelica.Blocks.Sources.RealExpression outletSpecificVolume(y=v_out) annotation(Placement(transformation(extent={{-340,-50},{-320,-30}})));
  Modelica.Blocks.Sources.RealExpression polytropicEfficiency(y=eta_pol) annotation(Placement(transformation(extent={{-340,-70},{-320,-50}})));
  Modelica.Blocks.Sources.RealExpression polytropicExponent(y=n) annotation(Placement(transformation(extent={{-340,-90},{-320,-70}})));
  Modelica.Blocks.Continuous.FirstOrder
                                   massFlowRate(
    k=1,
    T=0.01,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0)     annotation(Placement(transformation(extent={{-340,-160},{-320,-140}})));
  EnergyFlow.Sources.PrescribedEnergyFlow energyFlowSource annotation(Placement(transformation(extent={{300,-10},{280,10}})));
  Modelica.Blocks.Sources.RealExpression power(y=P)          annotation(Placement(transformation(extent={{340,-10},{320,10}})));
  Modelica.Blocks.Sources.RealExpression compressionRatio(y=rhoRatio) annotation(Placement(transformation(extent={{-340,-10},{-320,10}})));
  Modelica.Blocks.Sources.SawTooth massFlowRate1(
    amplitude=-2,
    period=1,
    offset=1,
    startTime=0.05) annotation(Placement(transformation(extent={{-380,-160},{-360,-140}})));
equation

  connect(energyFlowSource.E_flow, power.y) annotation(Line(points={{302,0},{319,0}},     color={0,0,127}));
  connect(massFlowRate1.y, massFlowRate.u) annotation(Line(points={{-359,-150},{-342,-150}}, color={0,0,127}));
  annotation(experiment(StopTime=1.5), Diagram(coordinateSystem(extent={{-400,-200},{340,220}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, grid={2,2})),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    Base class.
  </p>
</html>"));
end PartialPrescribed;
