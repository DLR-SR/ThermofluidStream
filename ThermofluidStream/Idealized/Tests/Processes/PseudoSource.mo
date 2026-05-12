within ThermofluidStream.Idealized.Tests.Processes;
model PseudoSource "Example - PseudoSource"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir   constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)annotation(
    Placement(transformation(extent={{140,140},{160,160}})));

  Modelica.Blocks.Sources.Pulse massFlowRate(period=0.3) annotation(Placement(transformation(extent={{110,110},{90,130}})));
  Modelica.Blocks.Sources.Pulse pressure(
    amplitude=1e5,
    period=0.3,
    offset=1e5,
    startTime=0.2) annotation(Placement(transformation(extent={{-80,116},{-60,136}})));
  Modelica.Blocks.Sources.Pulse temperature(
    amplitude=100,
    period=0.3,
    offset=273.15 + 20,
    startTime=0.1) annotation(Placement(transformation(extent={{-80,70},{-60,90}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    T(displayUnit="ms") = 0.01,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0) annotation(Placement(transformation(extent={{80,110},{60,130}})));
  ThermofluidStream.Idealized.Processes.PseudoSource pseudoSource(
    redeclare package Medium = Medium,
    p_out_fixed=200000,
    T_out_fixed=308.15,
    Xi_out_fixed={0.2},
    showMassFractions=true) annotation(Placement(transformation(extent={{-10,110},{10,130}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true,
    xiFromInput=true) annotation(Placement(transformation(extent={{-50,110},{-30,130}})));
  ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{30,110},{50,130}})));
  Modelica.Blocks.Sources.Pulse massFractions(
    amplitude=-0.2,
    period=0.3,
    offset=0.1,
    startTime=0.15) annotation(Placement(transformation(extent={{-80,24},{-60,44}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true,
    xiFromInput=true) annotation(Placement(transformation(extent={{-50,70},{-30,90}})));
  ThermofluidStream.Idealized.Processes.PseudoSource pseudoSource1(
    redeclare package Medium = Medium,
    p_out_fixed=200000,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    h_out_fixed=Medium.specificEnthalpy_pTX(
        2e5,
        308.15,
        {0.2}),
    Xi_out_fixed={0.2},
    showMassFractions=true) annotation(Placement(transformation(extent={{-10,70},{10,90}})));
  ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{30,70},{50,90}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true,
    xiFromInput=true) annotation(Placement(transformation(extent={{-50,30},{-30,50}})));
  ThermofluidStream.Idealized.Processes.PseudoSource pseudoSource2(
    redeclare package Medium = Medium,
    pSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    T_out_fixed=308.15,
    Xi_out_fixed={0.2},
    showMassFractions=true) annotation(Placement(transformation(extent={{-10,30},{10,50}})));
  ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{30,30},{50,50}})));
  Modelica.Blocks.Sources.Pulse pressure1(
    amplitude=2.5e5,
    period=0.3,
    offset=0.5e5,
    startTime=0.05)
                   annotation(Placement(transformation(extent={{120,10},{100,30}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true,
    xiFromInput=true) annotation(Placement(transformation(extent={{-50,-10},{-30,10}})));
  ThermofluidStream.Idealized.Processes.PseudoSource pseudoSource3(
    redeclare package Medium = Medium,

    p_out_fixed=200000,
    thermalValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    Xi_out_fixed={0.2},
    showMassFractions=true) annotation(Placement(transformation(extent={{-10,-10},{10,10}})));
  ThermofluidStream.Boundaries.Sink_m sink3(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Blocks.Sources.Pulse temperature1(
    amplitude=50,
    period=0.3,
    offset=273.15,
    startTime=0.025) annotation(Placement(transformation(extent={{120,-30},{100,-10}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true,
    xiFromInput=true) annotation(Placement(transformation(extent={{-50,-50},{-30,-30}})));
  ThermofluidStream.Idealized.Processes.PseudoSource pseudoSource4(
    redeclare package Medium = Medium,

    p_out_fixed=200000,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    thermalValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    Xi_out_fixed={0.2},
    showMassFractions=true) annotation(Placement(transformation(extent={{-10,-50},{10,-30}})));
  ThermofluidStream.Boundaries.Sink_m sink4(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{30,-50},{50,-30}})));
  Modelica.Blocks.Sources.Pulse specificEnthalpy(
    amplitude=Medium.specificEnthalpy_pTX(
        2e5,
        353.15,
        {0.2}) - Medium.specificEnthalpy_pTX(
        2e5,
        293.15,
        {0.2}),
    period=0.3,
    offset=Medium.specificEnthalpy_pTX(
        2e5,
        293.15,
        {0.2}),
    startTime=0.25) annotation(Placement(transformation(extent={{120,-70},{100,-50}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true,
    xiFromInput=true) annotation(Placement(transformation(extent={{-50,-90},{-30,-70}})));
  ThermofluidStream.Idealized.Processes.PseudoSource pseudoSource5(
    redeclare package Medium = Medium,
    XiSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,

    p_out_fixed=200000,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.Temperature,
    T_out_fixed=293.15,
    showMassFractions=true) annotation(Placement(transformation(extent={{-12,-90},{8,-70}})));
  ThermofluidStream.Boundaries.Sink_m sink5(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{30,-90},{50,-70}})));
  Modelica.Blocks.Sources.Pulse massFractions1(
    amplitude=-0.4,
    period=0.3,
    offset=0.2,
    startTime=0.12) annotation(Placement(transformation(extent={{120,-110},{100,-90}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true,
    xiFromInput=true) annotation(Placement(transformation(extent={{-50,-130},{-30,-110}})));
  ThermofluidStream.Idealized.Processes.PseudoSource pseudoSource6(
    redeclare package Medium = Medium,
    pSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.Temperature,
    thermalValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    XiSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    showMassFractions=true) annotation(Placement(transformation(extent={{-10,-130},{10,-110}})));
  ThermofluidStream.Boundaries.Sink_m sink6(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{30,-130},{50,-110}})));
equation
  connect(firstOrder.u, massFlowRate.y) annotation(Line(points={{82,120},{89,120}}, color={0,0,127}));
  connect(source.outlet, pseudoSource.inlet) annotation(Line(
      points={{-30,120},{-10,120}},
      color={28,108,200},
      thickness=0.5));
  connect(pseudoSource.outlet, sink.inlet) annotation(Line(
      points={{10,120},{30,120}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.m_flow_prescribed, firstOrder.y) annotation(Line(points={{42,120},{59,120}}, color={0,0,127}));
  connect(source.p0_var, pressure.y) annotation(Line(points={{-42,126},{-59,126}}, color={0,0,127}));
  connect(source.T0_var, temperature.y) annotation(Line(points={{-42,120},{-52,120},{-52,80},{-59,80}}, color={0,0,127}));
  connect(massFractions.y, source.xi_var[1]) annotation(Line(points={{-59,34},{-56,34},{-56,114},{-42,114}}, color={0,0,127}));
  connect(source1.outlet, pseudoSource1.inlet) annotation(Line(
      points={{-30,80},{-10,80}},
      color={28,108,200},
      thickness=0.5));
  connect(pseudoSource1.outlet, sink1.inlet) annotation(Line(
      points={{10,80},{30,80}},
      color={28,108,200},
      thickness=0.5));
  connect(firstOrder.y, sink1.m_flow_prescribed) annotation(Line(points={{59,120},{52,120},{52,80},{42,80}}, color={0,0,127}));
  connect(source1.p0_var, pressure.y) annotation(Line(points={{-42,86},{-48,86},{-48,126},{-59,126}}, color={0,0,127}));
  connect(source1.T0_var, temperature.y) annotation(Line(points={{-42,80},{-59,80}}, color={0,0,127}));
  connect(source1.xi_var[1], massFractions.y) annotation(Line(points={{-42,74},{-56,74},{-56,34},{-59,34}}, color={0,0,127}));
  connect(source2.outlet, pseudoSource2.inlet) annotation(Line(
      points={{-30,40},{-10,40}},
      color={28,108,200},
      thickness=0.5));
  connect(pseudoSource2.outlet, sink2.inlet) annotation(Line(
      points={{10,40},{30,40}},
      color={28,108,200},
      thickness=0.5));
  connect(sink2.m_flow_prescribed, firstOrder.y) annotation(Line(points={{42,40},{52,40},{52,120},{59,120}}, color={0,0,127}));
  connect(source2.p0_var, pressure.y) annotation(Line(points={{-42,46},{-48,46},{-48,126},{-59,126}}, color={0,0,127}));
  connect(source2.T0_var, temperature.y) annotation(Line(points={{-42,40},{-52,40},{-52,80},{-59,80}}, color={0,0,127}));
  connect(source2.xi_var[1], massFractions.y) annotation(Line(points={{-42,34},{-59,34}}, color={0,0,127}));
  connect(pressure1.y, pseudoSource2.p_out_prescribed) annotation(Line(points={{99,20},{10,20},{10,28}}, color={0,0,127}));
  connect(source3.outlet, pseudoSource3.inlet) annotation(Line(
      points={{-30,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pseudoSource3.outlet, sink3.inlet) annotation(Line(
      points={{10,0},{30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sink3.m_flow_prescribed, firstOrder.y) annotation(Line(points={{42,0},{52,0},{52,120},{59,120}}, color={0,0,127}));
  connect(source3.p0_var, pressure.y) annotation(Line(points={{-42,6},{-48,6},{-48,126},{-59,126}}, color={0,0,127}));
  connect(source3.T0_var, temperature.y) annotation(Line(points={{-42,0},{-52,0},{-52,80},{-59,80}}, color={0,0,127}));
  connect(source3.xi_var[1], massFractions.y) annotation(Line(points={{-42,-6},{-56,-6},{-56,34},{-59,34}}, color={0,0,127}));
  connect(temperature1.y, pseudoSource3.T_out_prescribed) annotation(Line(points={{99,-20},{6,-20},{6,-12}}, color={0,0,127}));
  connect(source4.outlet, pseudoSource4.inlet) annotation(Line(
      points={{-30,-40},{-10,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(pseudoSource4.outlet, sink4.inlet) annotation(Line(
      points={{10,-40},{30,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(sink4.m_flow_prescribed, firstOrder.y) annotation(Line(points={{42,-40},{52,-40},{52,120},{59,120}}, color={0,0,127}));
  connect(source4.p0_var, pressure.y) annotation(Line(points={{-42,-34},{-48,-34},{-48,126},{-59,126}}, color={0,0,127}));
  connect(source4.T0_var, temperature.y) annotation(Line(points={{-42,-40},{-52,-40},{-52,80},{-59,80}}, color={0,0,127}));
  connect(source4.xi_var[1], massFractions.y) annotation(Line(points={{-42,-46},{-56,-46},{-56,34},{-59,34}}, color={0,0,127}));
  connect(source5.p0_var, pressure.y) annotation(Line(points={{-42,-74},{-48,-74},{-48,126},{-59,126}}, color={0,0,127}));
  connect(source5.T0_var, temperature.y) annotation(Line(points={{-42,-80},{-52,-80},{-52,80},{-59,80}}, color={0,0,127}));
  connect(source5.xi_var[1], massFractions.y) annotation(Line(points={{-42,-86},{-56,-86},{-56,34},{-59,34}}, color={0,0,127}));
  connect(pseudoSource5.inlet, source5.outlet) annotation(Line(
      points={{-12,-80},{-30,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(pseudoSource5.outlet, sink5.inlet) annotation(Line(
      points={{8,-80},{30,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(massFractions1.y, pseudoSource5.Xi_out_prescribed[1]) annotation(Line(points={{99,-100},{-4,-100},{-4,-92}},
                                                                                                               color={0,0,127}));
  connect(sink5.m_flow_prescribed, firstOrder.y) annotation(Line(points={{42,-80},{52,-80},{52,120},{59,120}}, color={0,0,127}));
  connect(source6.outlet, pseudoSource6.inlet) annotation(Line(
      points={{-30,-120},{-10,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(pseudoSource6.outlet, sink6.inlet) annotation(Line(
      points={{10,-120},{30,-120}},
      color={28,108,200},
      thickness=0.5));
  connect(sink6.m_flow_prescribed, firstOrder.y) annotation(Line(points={{42,-120},{52,-120},{52,120},{59,120}}, color={0,0,127}));
  connect(source6.p0_var, pressure.y) annotation(Line(points={{-42,-114},{-48,-114},{-48,126},{-59,126}}, color={0,0,127}));
  connect(source6.T0_var, temperature.y) annotation(Line(points={{-42,-120},{-52,-120},{-52,80},{-59,80}}, color={0,0,127}));
  connect(source6.xi_var[1], massFractions.y) annotation(Line(points={{-42,-126},{-56,-126},{-56,34},{-59,34}}, color={0,0,127}));
  connect(pressure1.y, pseudoSource6.p_out_prescribed) annotation(Line(points={{99,20},{66,20},{66,-138},{10,-138},{10,-132}}, color={0,0,127}));
  connect(pseudoSource6.T_out_prescribed, temperature1.y) annotation(Line(points={{6,-132},{6,-142},{74,-142},{74,-20},{99,-20}}, color={0,0,127}));
  connect(pseudoSource6.Xi_out_prescribed[1], massFractions1.y) annotation(Line(points={{-2,-132},{-2,-148},{80,-148},{80,-100},{99,-100}},
                                                                                                                                    color={0,0,127}));
  connect(specificEnthalpy.y, pseudoSource4.h_out_prescribed) annotation(Line(points={{99,-60},{2,-60},{2,-52}}, color={0,0,127}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-160},{160,160}}), graphics={Text(
          extent={{-160,160},{-100,140}},
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
    <a href=\"modelica://ThermoFluidStream.Idealized.Processes.PseudoSource\">PseudoSource</a> model 
    to set outlet pressure, temperature/specific enthalpy and mass fractions.
  </p>
</html>"));
end PseudoSource;
