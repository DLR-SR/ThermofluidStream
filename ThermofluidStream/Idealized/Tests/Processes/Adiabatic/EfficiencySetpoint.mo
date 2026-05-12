within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model EfficiencySetpoint
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.CO2
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium"annotation(
    choicesAllMatching=true);

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-96,-10},{-76,10}})));
  ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-36,-10},{-16,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressor(
    redeclare package Medium = Medium,
    eta_fixed=0.8,
    dp_fixed=100000) annotation(Placement(transformation(extent={{-66,-10},{-46,10}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(Placement(transformation(extent={{80,80},{100,100}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{10,-10},{30,10}})));
  ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{70,-10},{90,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressor1(
    redeclare package Medium = Medium,
    etaSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=0.7) annotation(Placement(transformation(extent={{0,-40},{20,-20}})));
equation
  connect(source.outlet,compressor. inlet)annotation(
    Line(
      points={{-76,0},{-66,0}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.outlet,sink. inlet)annotation(
    Line(
      points={{-46,0},{-36,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, compressor1.inlet) annotation(Line(
      points={{30,0},{40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor1.outlet, sink1.inlet) annotation(Line(
      points={{60,0},{70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression.y, compressor1.eta_prescribed) annotation(Line(points={{21,-30},{56,-30},{56,-12}}, color={0,0,127}));
  annotation(                   Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end EfficiencySetpoint;
