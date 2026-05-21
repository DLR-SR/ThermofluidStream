within ThermofluidStream.Idealized.Tests.Processes.Isochoric;
model Fixed3 "Example - Isochoric process"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);
  parameter SI.MassFlowRate m_flow=1 "Mass flow rate";
  parameter Medium.AbsolutePressure p_in=100000 "Inlet pressure";
  parameter Medium.Temperature T_in=293.15 "Inlet temperature";
  parameter SI.TemperatureDifference dT=20 "Temperature difference";
  final parameter Medium.Temperature T_out=T_in + dT "Outlet temperature";
  final parameter Medium.SpecificHeatCapacity cv = Medium.specificHeatCapacityCv(Medium.setState_pT(p_in, T_in));
  final parameter SI.HeatFlowRate Q_flow = m_flow*cv*dT "Heat flow rate";

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{80,80},{100,100}})));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  ThermofluidStream.Idealized.Processes.Isochoric isochoricCycle(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource(E_flow=Q_flow) annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  .ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  ThermofluidStream.Idealized.Processes.Isochoric isochoricFlow(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out) annotation (Placement(transformation(extent={{40,-10},{60,10}})));

equation
  connect(source.outlet, isochoricCycle.inlet) annotation (Line(
      points={{-70,0},{-60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(isochoricCycle.outlet, sink.inlet) annotation (Line(
      points={{-40,0},{-30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out, isochoricCycle.Q_flow_in) annotation (Line(points={{-59,-30},{-50,-30},{-50,-8}}, color={255,170,85}));
  connect(source1.outlet, isochoricFlow.inlet) annotation (Line(
      points={{30,0},{40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(isochoricFlow.outlet, sink1.inlet) annotation (Line(
      points={{60,0},{70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out, isochoricFlow.Q_flow_in) annotation (Line(points={{-59,-30},{50,-30},{50,-8}}, color={255,170,85}));

  annotation(
    Diagram(
      graphics={
        Text(
          extent={{-80,80},{60,60}},
          textColor={28,108,200},
          textString="The simulation fails for m_flow = 0.")}),
    Documentation(
      info="<html>
  <p>
    This example illustrates several variants of using the 
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Isochoric\">Isochoric</a> process defined by parameters (mass flow rate and heat flow rate given)
  </p>

  <p>
    <code>m_flow = 0</code> is not supported (<code>du := Q_flow/m_flow</code> fails for <code>m_flow = 0</code>.
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
end Fixed3;
