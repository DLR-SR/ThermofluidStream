within ThermofluidStream.Idealized.Tests.Processes.Isochoric;
model Fixed "Example - Isochoric process"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation(choicesAllMatching=true);

  parameter SI.MassFlowRate m_flow = 1 "Mass flow rate";
  parameter Medium.AbsolutePressure p_in=100000 "Inlet pressure";
  parameter Medium.Temperature T_in=293.15 "Inlet temperature";
  parameter SI.TemperatureDifference dT = 10 "Temperature difference";
  final parameter Medium.Temperature T_out=T_in + dT "Outlet temperature";
  final parameter Medium.SpecificHeatCapacity cv = Medium.specificHeatCapacityCv(Medium.setState_pT(p_in, T_in));
  final parameter SI.HeatFlowRate Q_flow = m_flow*cv*dT "Heat flow rate";

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation(Placement(transformation(extent={{140,140},{160,160}})));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation(Placement(transformation(extent={{-130,100},{-110,120}})));
  Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation(Placement(transformation(extent={{-70,100},{-50,120}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out) annotation(Placement(transformation(extent={{-100,100},{-80,120}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation(Placement(transformation(extent={{-20,100},{0,120}})));
  Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation(Placement(transformation(extent={{40,100},{60,120}})));
  ThermofluidStream.Idealized.Processes.Isochoric T_out1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out) annotation(Placement(transformation(extent={{10,100},{30,120}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation(Placement(transformation(extent={{-130,60},{-110,80}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink2(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-70,60},{-50,80}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out) annotation(Placement(transformation(extent={{-100,60},{-80,80}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource(E_flow=Q_flow) annotation(Placement(transformation(extent={{-120,30},{-100,50}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation(Placement(transformation(extent={{-20,60},{0,80}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink3(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{40,60},{60,80}})));
  ThermofluidStream.Idealized.Processes.Isochoric T_out2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out) annotation(Placement(transformation(extent={{10,60},{30,80}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource1(E_flow=Q_flow) annotation(Placement(transformation(extent={{-10,30},{10,50}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in)   annotation(Placement(transformation(extent={{-130,0},{-110,20}})));
  Boundaries.Sink_m sink4(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation(Placement(transformation(extent={{-70,0},{-50,20}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT3(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=dT,
    T_out_fixed=T_out) annotation(Placement(transformation(extent={{-100,0},{-80,20}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource2(E_flow=Q_flow) annotation(Placement(transformation(extent={{-120,-30},{-100,-10}})));
equation
  connect(source.outlet,dT1. inlet) annotation(Line(
      points={{-110,110},{-100,110}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1.outlet, sink.inlet) annotation(Line(
      points={{-80,110},{-70,110}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, T_out1.inlet) annotation(Line(
      points={{0,110},{10,110}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out1.outlet, sink1.inlet) annotation(Line(
      points={{30,110},{40,110}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, dT2.inlet) annotation(Line(
      points={{-110,70},{-100,70}},
      color={28,108,200},
      thickness=0.5));
  connect(dT2.outlet, sink2.inlet) annotation(Line(
      points={{-80,70},{-70,70}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out, dT2.Q_flow_in) annotation(Line(points={{-99,40},{-90,40},{-90,62}}, color={255,170,85}));
  connect(source3.outlet, T_out2.inlet) annotation(Line(
      points={{0,70},{10,70}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out2.outlet, sink3.inlet) annotation(Line(
      points={{30,70},{40,70}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource1.E_flow_out, T_out2.Q_flow_in) annotation(Line(points={{11,40},{20,40},{20,62}}, color={255,170,85}));
  connect(source4.outlet, dT3.inlet) annotation(Line(
      points={{-110,10},{-100,10}},
      color={28,108,200},
      thickness=0.5));
  connect(dT3.outlet, sink4.inlet) annotation(Line(
      points={{-80,10},{-70,10}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource2.E_flow_out, dT3.Q_flow_in) annotation(Line(points={{-99,-20},{-90,-20},{-90,2}}, color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-160},{160,160}})),
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
    <a href=\"modelica://ThermoFluidStream.Idealized.Processes.Isochoric\">Isochoric</a> process defined by parameters.
  </p>
</html>"));
end Fixed;
