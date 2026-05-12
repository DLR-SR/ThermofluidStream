within ThermofluidStream.Idealized.Examples.AirCycle;
model Step6Junction
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{120,80},{140,100}})));

  ThermofluidStream.Idealized.Processes.Adiabatic compressor(
    redeclare package Medium = Medium,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=200000) annotation(Placement(transformation(extent={{-80,-10},{-60,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic turbine(
    redeclare package Medium = Medium,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=100000) annotation(Placement(transformation(extent={{20,-10},{40,10}})));
  ThermofluidStream.Boundaries.Source airSource(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-150,-10},{-130,10}})));
  ThermofluidStream.Idealized.Processes.Isobaric heatExchangerSideA(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed=293.15) annotation(Placement(transformation(extent={{-40,-10},{-20,10}})));
  ThermofluidStream.Utilities.showRealValue coefficientOfPerformance(
    description="COP",
    use_numberPort=false,
    number=(inletEnthalpyFlowRate.value - outletEnthalpyFlowRate.value)/(compressor.P + turbine.P),
    displayVariable=false) "Warning: COP goes to infinity  for compressor.eta= turbine.eta = 1 and dp = 0 (no error of the model). " annotation(Placement(transformation(extent={{0,40},{20,60}})));
  Boundaries.Sink_m airSink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{140,-10},{160,10}})));
  Processes.Isenthalpic valve(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.OutletPressure,
    p_out_fixed=100000) annotation(Placement(transformation(extent={{40,-40},{60,-20}})));
  ThermofluidStream.Topology.SplitterT2
                                     splitter(displayInstanceName=false, redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-10,10},{10,-10}})));
  Sources.MassFlowRate massFlowRateValve(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{10,-40},{30,-20}})));
  Modelica.Blocks.Sources.Ramp massFlowRateValveRamp(
    height=1,
    duration=1,
    offset=0) annotation(Placement(transformation(extent={{-30,-56},{-10,-36}})));
  ThermofluidStream.Sensors.SingleFlowSensor inletEnthalpyFlowRate(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps) annotation(Placement(transformation(extent={{-120,-10},{-100,10}})));
  ThermofluidStream.Sensors.SingleFlowSensor outletEnthalpyFlowRate(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps) annotation(Placement(transformation(extent={{110,-10},{130,10}})));
  Topology.JunctionT2 junction(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{70,10},{90,-10}})));
equation
  connect(compressor.outlet, heatExchangerSideA.inlet) annotation(
    Line(
      points={{-60,0},{-40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerSideA.outlet, splitter.inlet) annotation(
    Line(
      points={{-20,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter.outletB, turbine.inlet) annotation(
    Line(
      points={{10,0},{20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter.outletA, massFlowRateValve.inlet) annotation(Line(
      points={{0,-10},{0,-30},{10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateValve.outlet, valve.inlet) annotation(Line(
      points={{30,-30},{40,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateValveRamp.y, massFlowRateValve.m_flow_prescribed) annotation(Line(points={{-9,-46},{20,-46},{20,-38}}, color={0,0,127}));
  connect(airSource.outlet, inletEnthalpyFlowRate.inlet) annotation(Line(
      points={{-130,0},{-120,0}},
      color={28,108,200},
      thickness=0.5));
  connect(outletEnthalpyFlowRate.outlet, airSink.inlet) annotation(Line(
      points={{130,0},{140,0}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine.outlet, junction.inletB) annotation(Line(
      points={{40,0},{70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(valve.outlet, junction.inletA) annotation(Line(
      points={{60,-30},{80,-30},{80,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(junction.outlet, outletEnthalpyFlowRate.inlet) annotation(Line(
      points={{90,0},{110,0}},
      color={28,108,200},
      thickness=0.5));
  connect(inletEnthalpyFlowRate.outlet, compressor.inlet) annotation(Line(
      points={{-100,0},{-80,0}},
      color={28,108,200},
      thickness=0.5));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-180,-100},{180,100}}), graphics={
        Text(
          extent={{-90,6},{-84,0}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-54,6},{-48,0}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-2,6},{4,0}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{46,6},{52,0}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{62,-20},{68,-26}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{98,6},{104,0}},
          textColor={28,108,200},
          textString="6")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    In a sixth step, a junction is introduced to recombine the flow from the turbine with the bypass valve.
  </p>

  <p>
    To obtain a balanced system (number of equations = number of unknowns), one of the junction inlets 
    (either <code>A</code> or <code>B</code>) must remain free, comparable to a 
    <a href=\"modelica://ThermofluidStream.Idealized.Sources.Sink_free\">Sink_free</a> boundary.
  </p>

  <p>
    Further documentation is available in the 
    <a href=\"modelica://ThermofluidStream.Idealized.Examples.AirCycle\">AirCycle</a> package.
  </p>
</html>"));
end Step6Junction;
