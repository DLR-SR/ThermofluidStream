within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model PartialPrescribed "Base class"


  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir  constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);
  SI.MassFlowRate m_flow = firstOrder.y "Mass flow rate";
  Medium.AbsolutePressure p_in = inletPressure.y "Inlet pressure";
  Medium.Temperature T_in = inletTemperature.y "Inlet temperature";

  Real pRatio = pressureRatio.y "Pressure ratio";
  Medium.AbsolutePressure p_out = p_in*pRatio "Outlet pressure";
  SI.PressureDifference dp = p_out - p_in "Pressure difference";

  SI.Efficiency eta_is = isentropicEfficiency.y "Isentropic efficiency";

  Medium.ThermodynamicState state_in = Medium.setState_pT(p_in,T_in);

  ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.FullMedium adiabaticModel(
    redeclare final package Medium = Medium,
    final state_in=state_in,
    final p_out=p_out,
    final eta_is=eta_is) "Adiabatic process calculation";
  Medium.SpecificEnthalpy h_out = adiabaticModel.h_out "Outlet specific enthalpy";
  Medium.SpecificEnthalpy h_in = Medium.specificEnthalpy(state_in) "Inlet specific enthalpy";
  SI.SpecificEnthalpy dh = h_out - h_in "Specific enthalpy difference";

  SI.Power P = m_flow*dh "Power";

  inner ThermofluidStream.DropOfCommons dropOfCommons annotation(
    Placement(transformation(extent={{140,120},{160,140}})));

  Modelica.Blocks.Sources.SawTooth inletPressure(
    amplitude=1e5,
    period=1,
    offset=1e5,
    startTime=0.1) annotation(Placement(transformation(extent={{-100,100},{-80,120}})));
  Modelica.Blocks.Sources.SawTooth inletTemperature(
    amplitude=100,
    period=1,
    offset=293.15,
    startTime=0.2) annotation(Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Sources.SawTooth pressureRatio(
    amplitude=-1,
    period=1,
    offset=1.5,
    startTime=0.3) annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Sources.RealExpression outletPressure(y=p_out) annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.SawTooth massFlowRate(
    amplitude=-2,
    period=1,
    offset=1,
    startTime=0.4) annotation(Placement(transformation(extent={{-140,-100},{-120,-80}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    k=1,
    T=0.01,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0) annotation(Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Sources.RealExpression power(y=P) annotation (Placement(transformation(extent={{-140,-140},{-120,-120}})));
  EnergyFlow.Sources.PrescribedEnergyFlow energyFlowSource annotation(Placement(transformation(extent={{-100,-140},{-80,-120}})));
  Modelica.Blocks.Sources.RealExpression pressureDifference(y=dp) annotation(Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Modelica.Blocks.Sources.SawTooth isentropicEfficiency(
    amplitude=0.4,
    period=1,
    offset=0.5,
    startTime=0.35) annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
equation

  connect(massFlowRate.y, firstOrder.u) annotation (Line(points={{-119,-90},{-102,-90}}, color={0,0,127}));
  connect(power.y, energyFlowSource.E_flow) annotation (Line(points={{-119,-130},{-102,-130}}, color={0,0,127}));

  annotation(
    Diagram(
      coordinateSystem(
        extent={{-160,-160},{160,140}}, grid={2,2})),
    Documentation(
      info="<html>
  <p>
    Defines the input signals.
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
end PartialPrescribed;
