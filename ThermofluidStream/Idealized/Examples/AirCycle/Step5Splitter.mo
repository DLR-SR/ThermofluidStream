within ThermofluidStream.Idealized.Examples.AirCycle;
model Step5Splitter
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)annotation(
    Placement(transformation(extent={{120,80},{140,100}})));

  ThermofluidStream.Idealized.Processes.Adiabatic compressor(
    redeclare package Medium = Medium,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=200000) annotation(Placement(transformation(extent={{-70,-10},{-50,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic turbine(
    redeclare package Medium = Medium,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=100000) annotation(Placement(transformation(extent={{30,-10},{50,10}})));
  ThermofluidStream.Boundaries.Source airSource(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-180,-10},{-160,10}})));
  ThermofluidStream.Idealized.Processes.Isobaric heatExchangerSideA(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed=293.15) annotation(Placement(transformation(extent={{-30,-10},{-10,10}})));
  ThermofluidStream.Utilities.showRealValue coefficientOfPerformance(
    description="COP",
    use_numberPort=false,
    number=(inletEnthalpyFlowRate.value - (outlet1EnthalpyFlowRate.value + outlet2EnthalpyFlowRate.value))/(compressor.P + turbine.P),
    displayVariable=false) "Warning: COP goes to infinity  for compressor.eta= turbine.eta = 1 and dp = 0 (no error of the model). " annotation(Placement(transformation(extent={{0,40},{20,60}})));
  Sources.Sink_free airSink(redeclare package Medium = Medium)annotation(
    Placement(transformation(extent={{100,-10},{120,10}})));
  Processes.Isenthalpic valve(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.OutletPressure,
    p_out_fixed=100000) annotation(Placement(transformation(extent={{50,-40},{70,-20}})));
  ThermofluidStream.Topology.SplitterT2
                                     splitter(displayInstanceName=false, redeclare package Medium = Medium) annotation(Placement(transformation(extent={{0,10},{20,-10}})));
  Sources.MassFlowRate massFlowRateValve(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{20,-40},{40,-20}})));
  Sources.Sink_free airSink1(redeclare package Medium = Medium)annotation(
    Placement(transformation(extent={{120,-40},{140,-20}})));
  Modelica.Blocks.Sources.Ramp massFlowRateValveRamp(
    height=1,
    duration=1,
    offset=0) annotation(Placement(transformation(extent={{-30,-56},{-10,-36}})));
  Sources.MassFlowRate massFlowRateIn(
    redeclare package Medium = Medium,

    m_flow_fixed=1) annotation(Placement(transformation(extent={{-110,-10},{-90,10}})));
  ThermofluidStream.Sensors.SingleFlowSensor inletEnthalpyFlowRate(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps) annotation(Placement(transformation(extent={{-150,-10},{-130,10}})));
  ThermofluidStream.Sensors.SingleFlowSensor outlet1EnthalpyFlowRate(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps) annotation(Placement(transformation(extent={{70,-10},{90,10}})));
  ThermofluidStream.Sensors.SingleFlowSensor outlet2EnthalpyFlowRate(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps) annotation(Placement(transformation(extent={{90,-40},{110,-20}})));
equation
  connect(compressor.outlet, heatExchangerSideA.inlet)annotation(
    Line(
      points={{-50,0},{-30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerSideA.outlet, splitter.inlet)annotation(
    Line(
      points={{-10,0},{0,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter.outletB, turbine.inlet)annotation(
    Line(
      points={{20,0},{30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter.outletA, massFlowRateValve.inlet) annotation(Line(
      points={{10,-10},{10,-30},{20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateValve.outlet, valve.inlet) annotation(Line(
      points={{40,-30},{50,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateValveRamp.y, massFlowRateValve.m_flow_prescribed) annotation(Line(points={{-9,-46},{30,-46},{30,-38}}, color={0,0,127}));
  connect(massFlowRateIn.outlet, compressor.inlet) annotation(Line(
      points={{-90,0},{-70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(airSource.outlet, inletEnthalpyFlowRate.inlet) annotation(Line(
      points={{-160,0},{-150,0}},
      color={28,108,200},
      thickness=0.5));
  connect(inletEnthalpyFlowRate.outlet, massFlowRateIn.inlet) annotation(Line(
      points={{-130,0},{-110,0}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine.outlet, outlet1EnthalpyFlowRate.inlet) annotation(Line(
      points={{50,0},{70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(outlet1EnthalpyFlowRate.outlet, airSink.inlet) annotation(Line(
      points={{90,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(airSink1.inlet, outlet2EnthalpyFlowRate.outlet) annotation(Line(
      points={{120,-30},{110,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(valve.outlet, outlet2EnthalpyFlowRate.inlet) annotation(Line(
      points={{70,-30},{90,-30}},
      color={28,108,200},
      thickness=0.5));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-180,-100},{140,100}}), graphics={
        Text(
          extent={{-80,6},{-74,0}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-44,6},{-38,0}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{8,6},{14,0}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{56,6},{62,0}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{72,-20},{78,-26}},
          textColor={28,108,200},
          textString="5")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    In a fifth step, a splitter is introduced. The bypass flow routed through the valve is commonly used to control the air cycle.
  </p>

  <p>
    Further documentation is available in the 
    <a href=\"modelica://ThermoFluidStream.Idealized.Examples.AirCycle\">AirCycle</a> package.
  </p>
</html>"));
end Step5Splitter;
