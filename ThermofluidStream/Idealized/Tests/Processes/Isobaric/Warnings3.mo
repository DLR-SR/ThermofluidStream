within ThermofluidStream.Idealized.Tests.Processes.Isobaric;
model Warnings3 "Example - Isobaric process"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  parameter Medium.AbsolutePressure p=200000 "Pressure (inlet = outlet)";
  parameter Medium.Temperature T_in=293.15 "Inlet temperature";
  parameter SI.AbsolutePressure p_inf=100000 "Ambient pressure";

  EnergyFlow.Sources.PrescribedEnergyFlow
                                     energyFlowSource                annotation(Placement(transformation(extent={{-50,-10},{-30,10}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in) annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaricFlow(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    p_inf=p_inf)       annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                                                                                                    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in) annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaricCycle(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    p_inf=p_inf)       annotation (Placement(transformation(extent={{-10,-20},{10,-40}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                                                                                                     annotation (Placement(transformation(extent={{20,-40},{40,-20}})));

  Modelica.Blocks.Sources.Trapezoid heatFlowRate(
    amplitude=1e3,
    rising=0.01,
    falling=0.01,
    period=1,
    startTime=0.25) annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Sources.Trapezoid massFlowRate(
    amplitude=1,
    rising=0.01,
    falling=0.01,
    period=1,
    offset=0,
    startTime=0.5) annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  inner DropOfCommons                   dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{80,80},{100,100}})));
equation
  connect(source.outlet, isobaricFlow.inlet) annotation (Line(
      points={{-20,30},{-10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaricFlow.outlet, sink.inlet) annotation (Line(
      points={{10,30},{20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out, isobaricFlow.Q_flow_in) annotation (Line(points={{-29,0},{0,0},{0,22}},                     color={255,170,85}));
  connect(source1.outlet, isobaricCycle.inlet) annotation (Line(
      points={{-20,-30},{-10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaricCycle.outlet, sink1.inlet) annotation (Line(
      points={{10,-30},{20,-30}},
      color={28,108,200},
      thickness=0.5));

  connect(isobaricCycle.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{0,-22},{0,0},{-29,0}},     color={255,170,85}));
  connect(energyFlowSource.E_flow, heatFlowRate.y) annotation (Line(points={{-52,0},{-69,0}}, color={0,0,127}));
  connect(massFlowRate.y, sink.m_flow_prescribed) annotation (Line(points={{59,0},{50,0},{50,30},{32,30}}, color={0,0,127}));
  connect(sink1.m_flow_prescribed, massFlowRate.y) annotation (Line(points={{32,-30},{50,-30},{50,0},{59,0}}, color={0,0,127}));
  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Documentation(
      revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>",
      info="<html>
  <p>
    This example checks if warnings are issued correctly in the case of mass flow rate and heat flow rate given.
  </p>
</html>"));
end Warnings3;
