within ThermofluidStream.Idealized.Tests.Processes.Isochoric;
model Fixed2 "Example - Isochoric process"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  parameter SI.MassFlowRate m_flow=0   "Mass flow rate";
  parameter Medium.AbsolutePressure p_in=100000 "Inlet pressure";
  parameter Medium.Temperature T_in=293.15 "Inlet temperature";
  parameter SI.TemperatureDifference dT=10   "Temperature difference";
  final parameter Medium.Temperature T_out=T_in + dT "Outlet temperature";
  final parameter Medium.SpecificHeatCapacity cv = Medium.specificHeatCapacityCv(Medium.setState_pT(p_in, T_in));
  final parameter SI.HeatFlowRate Q_flow = m_flow*cv*dT "Heat flow rate";

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{80,80},{100,100}})));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT2c(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out) annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource(E_flow=Q_flow) annotation(Placement(transformation(extent={{-80,-80},{-60,-60}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-90,-40},{-70,-20}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink2(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-30,-40},{-10,-20}})));
  ThermofluidStream.Idealized.Processes.Isochoric T_out2c(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out) annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Boundaries.Source                   source1(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{10,20},{30,40}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink1(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{70,20},{90,40}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out) annotation (Placement(transformation(extent={{40,20},{60,40}})));
  Boundaries.Source                   source3(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)  annotation(Placement(transformation(extent={{10,-40},{30,-20}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink3(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{70,-40},{90,-20}})));
  ThermofluidStream.Idealized.Processes.Isochoric T_out2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out) annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
equation
  connect(source.outlet, dT2c.inlet) annotation (Line(
      points={{-70,30},{-60,30}},
      color={28,108,200},
      thickness=0.5));
  connect(dT2c.outlet, sink.inlet) annotation (Line(
      points={{-40,30},{-30,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, T_out2c.inlet) annotation (Line(
      points={{-70,-30},{-60,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out2c.outlet,sink2. inlet) annotation (Line(
      points={{-40,-30},{-30,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, dT2.inlet) annotation (Line(
      points={{30,30},{40,30}},
      color={28,108,200},
      thickness=0.5));
  connect(dT2.outlet,sink1. inlet) annotation (Line(
      points={{60,30},{70,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, T_out2.inlet) annotation (Line(
      points={{30,-30},{40,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out2.outlet,sink3. inlet) annotation (Line(
      points={{60,-30},{70,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out, T_out2c.Q_flow_in) annotation (Line(points={{-59,-70},{-50,-70},{-50,-38}}, color={255,170,85}));
  connect(energyFlowSource.E_flow_out, T_out2.Q_flow_in) annotation (Line(points={{-59,-70},{50,-70},{50,-38}}, color={255,170,85}));
  connect(dT2.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{50,22},{50,0},{0,0},{0,-70},{-59,-70}}, color={255,170,85}));
  connect(dT2c.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{-50,22},{-50,0},{0,0},{0,-70},{-59,-70}}, color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false, grid={2,2}),
                                           graphics={Text(
          extent={{-20,82},{20,60}},
          textColor={28,108,200},
          textString="fails for dT=0")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    This example illustrates several variants of using the 
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Isochoric\">Isochoric</a> process defined by parameters (outlet state and heat flow rate given)
  </p>

  <p>
    <code>dT = 0</code> is not supported (<code>m_flow := Q_flow/du</code> fails for <code>du = 0</code>.
  </p>
</html>"));
end Fixed2;
