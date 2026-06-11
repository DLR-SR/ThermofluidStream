within ThermofluidStream.Idealized.Tests.Processes.PolytropicPerfectGas;
model PrescribedCycleFailing
  extends ThermofluidStream.Idealized.Tests.Processes.PolytropicPerfectGas.PartialPrescribed;
  extends Modelica.Icons.Example;

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{286,194},{306,214}})));

  ThermofluidStream.Boundaries.Source source31(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-270,-170},{-250,-150}})));
  .ThermofluidStream.Boundaries.Sink_m sink31(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-210,-170},{-190,-150}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas P_eta_pol(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-240,-170},{-220,-150}})));
  ThermofluidStream.Boundaries.Source source32(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-160,-170},{-140,-150}})));
  .ThermofluidStream.Boundaries.Sink_m sink32(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-100,-170},{-80,-150}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas P_n(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.PolytropicExponent,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-130,-170},{-110,-150}})));
  ThermofluidStream.Boundaries.Source source33(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-50,-170},{-30,-150}})));
  .ThermofluidStream.Boundaries.Sink_m sink33(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{10,-170},{30,-150}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas P_eta_is(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.IsentropicEfficiency,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-20,-170},{0,-150}})));

equation
  connect(source31.outlet, P_eta_pol.inlet) annotation(Line(
      points={{-250,-160},{-240,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(P_eta_pol.outlet, sink31.inlet) annotation(Line(
      points={{-220,-160},{-210,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(source32.outlet, P_n.inlet) annotation(Line(
      points={{-140,-160},{-130,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(P_n.outlet, sink32.inlet) annotation(Line(
      points={{-110,-160},{-100,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(source33.outlet, P_eta_is.inlet) annotation(Line(
      points={{-30,-160},{-20,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(P_eta_is.outlet, sink33.inlet) annotation(Line(
      points={{0,-160},{10,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(sink31.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{-198,-160},{-180,-160},{-180,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink32.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{-88,-160},{-70,-160},{-70,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink33.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{22,-160},{40,-160},{40,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(P_eta_pol.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-230,-168},{-230,-194},{268,-194},{268,0},{279,0}}, color={255,170,85}));
  connect(P_n.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-120,-168},{-120,-194},{268,-194},{268,0},{279,0}}, color={255,170,85}));
  connect(P_eta_is.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-10,-168},{-10,-194},{268,-194},{268,0},{279,0}}, color={255,170,85}));

  connect(source31.p0_var, inletPressure.y) annotation (Line(points={{-262,-154},{-280,-154},{-280,160},{-329,160}}, color={0,0,127}));
  connect(source32.p0_var, inletPressure.y) annotation (Line(points={{-152,-154},{-160,-154},{-160,-140},{-280,-140},{-280,160},{-329,160}}, color={0,0,127}));
  connect(source33.p0_var, inletPressure.y) annotation (Line(points={{-42,-154},{-52,-154},{-52,-140},{-280,-140},{-280,160},{-329,160}}, color={0,0,127}));
  connect(source31.T0_var, inletTemperature.y) annotation (Line(points={{-262,-160},{-284,-160},{-284,120},{-329,120}}, color={0,0,127}));
  connect(source32.T0_var, inletTemperature.y) annotation (Line(points={{-152,-160},{-164,-160},{-164,-144},{-284,-144},{-284,120},{-329,120}}, color={0,0,127}));
  connect(source33.T0_var, inletTemperature.y) annotation (Line(points={{-42,-160},{-56,-160},{-56,-144},{-284,-144},{-284,120},{-329,120}}, color={0,0,127}));
  connect(P_eta_pol.processSpec_prescribed, polytropicEfficiency.y) annotation (Line(points={{-224,-172},{-224,-178},{-288,-178},{-288,-60},{-319,-60}}, color={0,0,127}));
  connect(P_n.processSpec_prescribed, polytropicExponent.y) annotation (Line(points={{-114,-172},{-114,-182},{-292,-182},{-292,-80},{-319,-80}}, color={0,0,127}));
  connect(P_eta_is.processSpec_prescribed, isentropicEfficiency.y) annotation (Line(points={{-4,-172},{-4,-186},{-296,-186},{-296,-110},{-319,-110}}, color={0,0,127}));
  annotation(
    Documentation(
      info="<html>
  <p>
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.PolytropicPerfectGas\">PolytropicPerfectGas</a> test for time dependent (boundary) conditions (mass flow rate and power given, Cycle). 
  </p>

  <p>
    This test currently fails.
  </p>
</html>",
    revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"),
    Diagram(graphics={Polygon(
          points={{-6,44},{-22,-8},{-2,-8},{-18,-50},{28,8},{2,8},{20,44},{-6,44}},
          fillPattern = FillPattern.Solid,
          fillColor={238,46,47},
          pattern=LinePattern.None), Text(
          extent={{40,20},{104,-16}},
          textColor={238,46,47},
          textString="fails")}),
    Icon(graphics={   Polygon(
          points={{2,78},{-28,-12},{-2,-12},{-32,-84},{36,4},{2,4},{38,80},{2,78}},
          fillPattern = FillPattern.Solid,
          fillColor={238,46,47},
          pattern=LinePattern.None)}));
end PrescribedCycleFailing;
