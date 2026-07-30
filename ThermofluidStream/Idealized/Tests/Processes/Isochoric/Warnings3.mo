within ThermofluidStream.Idealized.Tests.Processes.Isochoric;
model Warnings3 "Example - Isochoric process"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);
  parameter Medium.AbsolutePressure p_in=100000 "Inlet pressure";
  parameter Medium.Temperature T_in=293.15 "Inlet temperature";

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                                                                                                    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  ThermofluidStream.Idealized.Processes.Isochoric isochoricCycle(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed)
                       annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  EnergyFlow.Sources.PrescribedEnergyFlow
                                     energyFlowSource                annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  .ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                                                                                                     annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  ThermofluidStream.Idealized.Processes.Isochoric isochoricFlow(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed)
                       annotation (Placement(transformation(extent={{50,-10},{70,10}})));

  Modelica.Blocks.Sources.Trapezoid
                                heatFlowRate(
    amplitude=1e3,
    rising=0.01,
    falling=0.01,
    period=1,
    startTime=0.25)
                   annotation (Placement(transformation(extent={{-110,-40},{-90,-20}})));
  Modelica.Blocks.Sources.Trapezoid massFlowRate(
    amplitude=1,
    rising=0.01,
    falling=0.01,
    period=1,
    offset=0,
    startTime=0.5) annotation (Placement(transformation(extent={{-70,-80},{-50,-60}})));
  inner DropOfCommons                   dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{100,80},{120,100}})));
equation
  connect(source.outlet, isochoricCycle.inlet) annotation (Line(
      points={{-60,0},{-50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(isochoricCycle.outlet, sink.inlet) annotation (Line(
      points={{-30,0},{-20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out, isochoricCycle.Q_flow_in) annotation (Line(points={{-49,-30},{-40,-30},{-40,-8}}, color={255,170,85}));
  connect(source1.outlet, isochoricFlow.inlet) annotation (Line(
      points={{40,0},{50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(isochoricFlow.outlet, sink1.inlet) annotation (Line(
      points={{70,0},{80,0}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out, isochoricFlow.Q_flow_in) annotation (Line(points={{-49,-30},{60,-30},{60,-8}}, color={255,170,85}));

  connect(heatFlowRate.y, energyFlowSource.E_flow) annotation (Line(points={{-89,-30},{-72,-30}}, color={0,0,127}));
  connect(massFlowRate.y, sink.m_flow_prescribed) annotation (Line(points={{-49,-70},{0,-70},{0,0},{-8,0}},      color={0,0,127}));
  connect(sink1.m_flow_prescribed, massFlowRate.y) annotation (Line(points={{92,0},{100,0},{100,-70},{-49,-70}},
                                                                                                               color={0,0,127}));
  annotation(
    Documentation(
      info="<html>
  <p>
    This example checks if warnings are issued correctly in the case of mass flow rate and heat flow rate given.
  </p>
</html>",
      revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"), Diagram(coordinateSystem(extent={{-120,-100},{120,100}})));
end Warnings3;
