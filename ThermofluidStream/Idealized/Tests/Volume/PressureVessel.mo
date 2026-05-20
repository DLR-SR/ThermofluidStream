within ThermofluidStream.Idealized.Tests.Volume;
model PressureVessel
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.CO2
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium" annotation(
    choicesAllMatching=true);

    parameter SI.Radius r = 1 "Radius (sphere)";
    final parameter SI.Area A = 4*r^2*Modelica.Constants.pi "Surface area";
    final parameter SI.Volume V = 4/3*r^3*Modelica.Constants.pi "Volume";

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-100,-10},{-80,10}})));
  ThermofluidStream.Boundaries.Volume pressureTank(
    redeclare package Medium = Medium,
    useHeatport=true,
    useOutlet=false,
    A=A,
    U=10,
    p_start=100000,
    T_start=293.15,
    enableFreeInlet=true,
    V_par=V) annotation(Placement(transformation(extent={{20,-10},{40,10}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(Placement(transformation(extent={{80,80},{100,100}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressor(
    eta_fixed=0.9,
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-70,-10},{-50,10}})));
  ThermofluidStream.Idealized.Sources.MassFlowRate massFlowRate(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15) annotation(Placement(transformation(extent={{80,-30},{60,-10}})));
  Modelica.Blocks.Sources.RealExpression tankPressure(y=pressureTank.medium.p) annotation(Placement(transformation(extent={{-80,-40},{-60,-20}})));
equation
  connect(source.outlet, compressor.inlet) annotation(Line(
      points={{-80,0},{-70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pressureTank.inlet, massFlowRate.outlet) annotation(Line(
      points={{20,0},{0,0}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.outlet, massFlowRate.inlet) annotation(Line(
      points={{-50,0},{-20,0}},
      color={28,108,200},
      thickness=0.5));

  connect(fixedTemperature.port, pressureTank.heatPort) annotation(Line(points={{60,-20},{30,-20},{30,-8}}, color={191,0,0}));
  connect(tankPressure.y, compressor.outletSpec_prescribed) annotation(Line(points={{-59,-30},{-50,-30},{-50,-12}}, color={0,0,127}));
  annotation(experiment(StopTime=100), Documentation(info="<html> 
  <p> 
    This model simulates a pressure tank that is continuously filled.
  </p> 
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end PressureVessel;
