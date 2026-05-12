within ThermofluidStream.Idealized.Tests.Processes.MassFractionModifier;
model Working "Example - Mass fraction modifier"
  extends Modelica.Icons.Example;

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{140,140},{160,160}})));

  ThermofluidStream.Idealized.Processes.MassFractionModifier composition(redeclare package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa, outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Composition.MassFractionsDifference) annotation (Placement(transformation(extent={{-10,100},{10,120}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa,
    pressureFromInput=true,
    temperatureFromInput=true)
    annotation (Placement(transformation(extent={{-50,100},{-30,120}})));
  ThermofluidStream.Idealized.Sink_m sink(redeclare package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{30,100},{50,120}})));

  Modelica.Blocks.Sources.Pulse massFlowRate(
    amplitude=1,
    period=0.3,
    offset=0)
    annotation (Placement(transformation(extent={{110,100},{90,120}})));
  Modelica.Blocks.Sources.Pulse pressure(
    amplitude=1e5,
    period=0.3,
    offset=1e5,
    startTime=0.2) annotation (Placement(transformation(extent={{-80,120},{-60,140}})));
  Modelica.Blocks.Sources.Pulse temperature(
    amplitude=100,
    period=0.3,
    offset=273.15 + 20,
    startTime=0.1) annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    T(displayUnit="ms") = 0.01,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0) annotation (Placement(transformation(extent={{80,100},{60,120}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa,
    pressureFromInput=true,
    temperatureFromInput=true)
                   annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
  ThermofluidStream.Idealized.Processes.MassFractionModifier composition1(redeclare package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa, outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Composition.OutletMassFractions) annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  ThermofluidStream.Idealized.Sink_m sink1(redeclare package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{30,60},{50,80}})));
  ThermofluidStream.Idealized.Processes.MassFractionModifier composition2(
    redeclare package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Composition.MassFractionsDifference,
    dXi_fixed={0.2}) annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir,
    pressureFromInput=true,
    temperatureFromInput=true,
    xiFromInput=true)
    annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  ThermofluidStream.Idealized.Sink_m sink2(redeclare package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{30,0},{50,20}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir,
    pressureFromInput=true,
    temperatureFromInput=true,
    xiFromInput=true)
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  ThermofluidStream.Idealized.Processes.MassFractionModifier composition3(
    redeclare package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Composition.OutletMassFractions,
    Xi_out_fixed={0.3}) annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  ThermofluidStream.Idealized.Sink_m sink3(redeclare package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
  Modelica.Blocks.Sources.Pulse massFractions(
    amplitude=0.1,
    period=0.3,
    offset=0.1,
    startTime=0.15) annotation (Placement(transformation(extent={{-86,-6},{-66,14}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir,
    pressureFromInput=true,
    temperatureFromInput=true,
    xiFromInput=true)
    annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
  ThermofluidStream.Idealized.Processes.MassFractionModifier composition4(
    redeclare package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Composition.MassFractionsDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  ThermofluidStream.Idealized.Sink_m sink4(redeclare package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{30,-80},{50,-60}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir,
    pressureFromInput=true,
    temperatureFromInput=true,
    xiFromInput=true)
    annotation (Placement(transformation(extent={{-50,-120},{-30,-100}})));
  ThermofluidStream.Idealized.Processes.MassFractionModifier composition5(
    redeclare package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Composition.OutletMassFractions,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-10,-120},{10,-100}})));
  ThermofluidStream.Idealized.Sink_m sink5(redeclare package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{30,-120},{50,-100}})));
  Modelica.Blocks.Sources.Pulse deltaMassFractions(
    amplitude=0.1,
    period=0.3,
    offset=-0.05,
    startTime=0.25) annotation (Placement(transformation(extent={{100,-100},{80,-80}})));
  Modelica.Blocks.Sources.Pulse massFractions1(
    amplitude=0.25,
    period=0.3,
    offset=0.05,
    startTime=0.25) annotation (Placement(transformation(extent={{100,-140},{80,-120}})));
equation
  connect(source.outlet, composition.inlet) annotation (Line(
      points={{-30,110},{-10,110}},
      color={28,108,200},
      thickness=0.5));
  connect(composition.outlet, sink.inlet) annotation (Line(
      points={{10,110},{30,110}},
      color={28,108,200},
      thickness=0.5));
  connect(firstOrder.u, massFlowRate.y) annotation (Line(points={{82,110},{89,110}}, color={0,0,127}));
  connect(sink.m_flow_prescribed, firstOrder.y) annotation (Line(points={{42,110},{59,110}}, color={0,0,127}));
  connect(pressure.y, source.p0_var) annotation (Line(points={{-59,130},{-48,130},{-48,116},{-42,116}}, color={0,0,127}));
  connect(temperature.y, source.T0_var) annotation (Line(points={{-59,90},{-52,90},{-52,110},{-42,110}}, color={0,0,127}));
  connect(source1.outlet, composition1.inlet) annotation (Line(
      points={{-30,70},{-10,70}},
      color={28,108,200},
      thickness=0.5));
  connect(composition1.outlet, sink1.inlet) annotation (Line(
      points={{10,70},{30,70}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.m_flow_prescribed, firstOrder.y) annotation (Line(points={{42,70},{52,70},{52,110},{59,110}}, color={0,0,127}));
  connect(source1.p0_var, pressure.y) annotation (Line(points={{-42,76},{-48,76},{-48,130},{-59,130}}, color={0,0,127}));
  connect(source1.T0_var, temperature.y) annotation (Line(points={{-42,70},{-52,70},{-52,90},{-59,90}}, color={0,0,127}));
  connect(source2.outlet, composition2.inlet) annotation (Line(
      points={{-30,10},{-10,10}},
      color={28,108,200},
      thickness=0.5));
  connect(composition2.outlet, sink2.inlet) annotation (Line(
      points={{10,10},{30,10}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet,composition3. inlet) annotation (Line(
      points={{-30,-30},{-10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(composition3.outlet,sink3. inlet) annotation (Line(
      points={{10,-30},{30,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(sink2.m_flow_prescribed, firstOrder.y) annotation (Line(points={{42,10},{52,10},{52,110},{59,110}}, color={0,0,127}));
  connect(sink3.m_flow_prescribed, firstOrder.y) annotation (Line(points={{42,-30},{52,-30},{52,110},{59,110}}, color={0,0,127}));
  connect(source2.p0_var, pressure.y) annotation (Line(points={{-42,16},{-48,16},{-48,130},{-59,130}}, color={0,0,127}));
  connect(source3.p0_var, pressure.y) annotation (Line(points={{-42,-24},{-48,-24},{-48,130},{-59,130}}, color={0,0,127}));
  connect(source2.T0_var, temperature.y) annotation (Line(points={{-42,10},{-52,10},{-52,90},{-59,90}}, color={0,0,127}));
  connect(source3.T0_var, temperature.y) annotation (Line(points={{-42,-30},{-52,-30},{-52,90},{-59,90}}, color={0,0,127}));
  connect(massFractions.y, source2.xi_var[1]) annotation (Line(points={{-65,4},{-42,4}}, color={0,0,127}));
  connect(source3.xi_var[1], massFractions.y) annotation (Line(points={{-42,-36},{-56,-36},{-56,4},{-65,4}}, color={0,0,127}));
  connect(source4.p0_var, pressure.y) annotation (Line(points={{-42,-64},{-48,-64},{-48,130},{-59,130}}, color={0,0,127}));
  connect(source4.T0_var, temperature.y) annotation (Line(points={{-42,-70},{-52,-70},{-52,90},{-59,90}}, color={0,0,127}));
  connect(source4.xi_var[1], massFractions.y) annotation (Line(points={{-42,-76},{-56,-76},{-56,4},{-65,4}}, color={0,0,127}));
  connect(source4.outlet, composition4.inlet) annotation (Line(
      points={{-30,-70},{-10,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(composition4.outlet, sink4.inlet) annotation (Line(
      points={{10,-70},{30,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(source5.outlet, composition5.inlet) annotation (Line(
      points={{-30,-110},{-10,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(composition5.outlet, sink5.inlet) annotation (Line(
      points={{10,-110},{30,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(sink4.m_flow_prescribed, firstOrder.y) annotation (Line(points={{42,-70},{52,-70},{52,110},{59,110}}, color={0,0,127}));
  connect(sink5.m_flow_prescribed, firstOrder.y) annotation (Line(points={{42,-110},{52,-110},{52,110},{59,110}}, color={0,0,127}));
  connect(source5.p0_var, pressure.y) annotation (Line(points={{-42,-104},{-48,-104},{-48,130},{-59,130}}, color={0,0,127}));
  connect(source5.T0_var, temperature.y) annotation (Line(points={{-42,-110},{-52,-110},{-52,90},{-59,90}}, color={0,0,127}));
  connect(source5.xi_var[1], massFractions.y) annotation (Line(points={{-42,-116},{-56,-116},{-56,4},{-65,4}}, color={0,0,127}));
  connect(deltaMassFractions.y, composition4.outletSpec_prescribed[1]) annotation (Line(points={{79,-90},{10,-90},{10,-82}}, color={0,0,127}));
  connect(massFractions1.y, composition5.outletSpec_prescribed[1]) annotation (Line(points={{79,-130},{10,-130},{10,-122}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-160},{160,160}}), graphics={Text(
          extent={{-160,120},{-100,100}},
          textColor={28,108,200},
          textString="Dry Air (nXi = 0)"),           Text(
          extent={{-160,20},{-100,0}},
          textColor={28,108,200},
          textString="Moist Air (nXi = 1)")}),
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
    <a href=\"modelica://ThermoFluidStream.Idealized.Processes.MassFractionModifier\">MassFractionModifier</a> model 
    to change the mass fractions while keeping pressure and temperature constant.
  </p>
</html>"));
end Working;
