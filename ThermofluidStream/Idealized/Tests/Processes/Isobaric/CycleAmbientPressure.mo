within ThermofluidStream.Idealized.Tests.Processes.Isobaric;
model CycleAmbientPressure "Example - Isobaric process"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

  parameter SI.MassFlowRate m_flow = 1 "Mass flow rate";

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{140,140},{160,160}})));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation (Placement(transformation(extent={{-150,20},{-130,40}})));
  Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaricHeating(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=10,
    p_inf=100000) annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{20,20},{40,40}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaricHeating1(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=10,
    p_inf=150000) annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation (Placement(transformation(extent={{60,20},{80,40}})));
  Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{120,20},{140,40}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaricHeating2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=10,
    p_inf=50000) annotation (Placement(transformation(extent={{90,20},{110,40}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation (Placement(transformation(extent={{-150,-40},{-130,-20}})));
  Boundaries.Sink_m sink3(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaricCooling(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=-10,
    p_inf=100000) annotation (Placement(transformation(extent={{-120,-40},{-100,-20}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Boundaries.Sink_m sink4(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaricCooling1(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=-10,
    p_inf=150000) annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  Boundaries.Sink_m sink5(redeclare package Medium = Medium, m_flow_fixed=m_flow) annotation (Placement(transformation(extent={{120,-40},{140,-20}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaricCooling2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dT_fixed=-10,
    p_inf=50000) annotation (Placement(transformation(extent={{90,-40},{110,-20}})));
equation
  connect(source.outlet, isobaricHeating.inlet) annotation (Line(
      points={{-130,30},{-120,30}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaricHeating.outlet, sink.inlet) annotation (Line(
      points={{-100,30},{-90,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, isobaricHeating1.inlet) annotation (Line(
      points={{-20,30},{-10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaricHeating1.outlet, sink1.inlet) annotation (Line(
      points={{10,30},{20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, isobaricHeating2.inlet) annotation (Line(
      points={{80,30},{90,30}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaricHeating2.outlet, sink2.inlet) annotation (Line(
      points={{110,30},{120,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, isobaricCooling.inlet) annotation (Line(
      points={{-130,-30},{-120,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaricCooling.outlet, sink3.inlet) annotation (Line(
      points={{-100,-30},{-90,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet, isobaricCooling1.inlet) annotation (Line(
      points={{-20,-30},{-10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaricCooling1.outlet, sink4.inlet) annotation (Line(
      points={{10,-30},{20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source5.outlet, isobaricCooling2.inlet) annotation (Line(
      points={{80,-30},{90,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaricCooling2.outlet, sink5.inlet) annotation (Line(
      points={{110,-30},{120,-30}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
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
    This example illustrates the influence of the ambient pressure on the power of a periodic isobaric closed-cycle process.<br>
    For <code>p = p_inf</code>, the net power is zero.<br> 
    For <code>p \\gt; p_inf</code> the net power is directed out of the system in case of a temperature increase (expansion) and into the system for a temperature decrease (compression). 
    For <code>p \\lt; p_inf</code> the net power is directed into of the system in case of a temperature increase (expansion) and out of the system for a temperature decrease (compression). 
  </p>
</html>"));
end CycleAmbientPressure;
