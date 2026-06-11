within ThermofluidStream.Idealized.Tests.Processes.Isochoric;
model PartialPrescribed "Base class"

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);
  SI.MassFlowRate m_flow = firstOrder.y "Mass flow rate";
  Medium.AbsolutePressure p_in = inletPressure.y "Inlet pressure";
  Medium.Temperature T_in = inletTemperature.y "Inlet temperature";
  SI.TemperatureDifference dT = temperatureDifference.y "Temperature difference";
  Medium.Temperature T_out = T_in + dT "Outlet temperature";
  Medium.Density rho = Medium.density(state_in) "Density";
  Medium.ThermodynamicState state_in = Medium.setState_pTX(p_in, T_in, Medium.X_default) "Inlet state";
  Medium.ThermodynamicState state_out = Medium.setState_dTX(rho, T_out, Medium.X_default) "Outlet state";
  SI.SpecificEnthalpy h_in = Medium.specificEnthalpy(state_in) "Inlet specific enthalpy";
  SI.SpecificEnthalpy h_out = Medium.specificEnthalpy(state_out) "Outlet specific enthalpy";
  SI.Pressure p_out = Medium.pressure(state_out) "Outlet pressure";
  SI.SpecificEnergy u_in = h_in - p_in/rho "Inlet specific internal energy";
  SI.SpecificEnergy u_out = h_out - p_out/rho "Outlet specific internal energy";
  SI.SpecificEnergy du = u_out - u_in "Specific internal energy difference";
  SI.HeatFlowRate Q_flow = m_flow*du "Heat flow rate";

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{140,80},{160,100}})));

  Modelica.Blocks.Sources.SawTooth inletPressure(
    amplitude=1e5,
    period=1,
    offset=1e5,
    startTime=0.1) annotation(Placement(transformation(extent={{-100,70},{-80,90}})));
  Modelica.Blocks.Sources.SawTooth inletTemperature(
    amplitude=100,
    period=1,
    offset=293.15,
    startTime=0.2) annotation(Placement(transformation(extent={{-100,30},{-80,50}})));
  Modelica.Blocks.Sources.SawTooth temperatureDifference(
    amplitude=-40,
    period=1,
    offset=20,
    startTime=0.3) annotation(Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.RealExpression outletTemperature(y=T_out) annotation(Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.SawTooth massFlowRate(
    amplitude=-2,
    period=1,
    offset=1,
    startTime=0.4) annotation(Placement(transformation(extent={{-140,-70},{-120,-50}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    k=1,
    T=0.01,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0) annotation(Placement(transformation(extent={{-100,-70},{-80,-50}})));
  Modelica.Blocks.Sources.RealExpression heatFlowRate(y=Q_flow) annotation(Placement(transformation(extent={{-140,-110},{-120,-90}})));
  EnergyFlow.Sources.PrescribedEnergyFlow
                                     energyFlowSource               annotation(Placement(transformation(extent={{-100,-110},{-80,-90}})));
equation

  connect(massFlowRate.y, firstOrder.u) annotation (Line(points={{-119,-60},{-102,-60}}, color={0,0,127}));
  connect(heatFlowRate.y, energyFlowSource.E_flow) annotation (Line(points={{-119,-100},{-102,-100}}, color={0,0,127}));

  annotation(
    Diagram(
      coordinateSystem(
        extent={{-160,-120},{160,100}})),
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
