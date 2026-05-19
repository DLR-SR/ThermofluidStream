within ThermofluidStream.Idealized.Examples.OttoCycle;
model PolytropicFlow
  extends ThermofluidStream.Idealized.Examples.OttoCycle.BaseModel(redeclare package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir);

  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas compression(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
    rhoRatio_fixed=compressionRatio,
    rho_out_fixed=d2) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  ThermofluidStream.Idealized.Processes.Isochoric combustion(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    T_out_fixed(displayUnit="K") = T3) annotation(Placement(transformation(extent={{-30,-10},{-10,10}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas expansion(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
    rhoRatio_fixed=1/compressionRatio,
    rho_out_fixed=d1,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.PolytropicEfficiency) annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  ThermofluidStream.Idealized.Processes.Isochoric gasExchange(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    T_out_fixed(displayUnit="K") = T1) annotation(Placement(transformation(extent={{50,-10},{70,10}})));
  ThermofluidStream.Idealized.Sources.LoopBreaker_m loopBreaker(
    redeclare package Medium = Medium,
    m_flow_in_par=1,
    p_out_fixed=p1,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.Temperature,
    T_out_fixed=T1) annotation (Placement(transformation(extent={{0,30},{-20,50}})));
  ThermofluidStream.Utilities.showRealValue maximumPressure(
    description="p_max",
    use_numberPort=false,
    number=combustion.outlet.state.p,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-60,-100},{-40,-80}})));
  ThermofluidStream.Utilities.showRealValue netWork(
    description="w_n",
    use_numberPort=false,
    number=compression.w_exp + expansion.w_exp,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-20,-100},{0,-80}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="eff",
    use_numberPort=false,
    number=shaftPower.E_flow_out/combustion.Q_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{20,-100},{40,-80}})));
  ThermofluidStream.Idealized.EnergyFlow.Components.Sum shaftPower(n_in=4) annotation (Placement(transformation(extent={{70,-40},{90,-20}})));
equation
  connect(compression.outlet, combustion.inlet) annotation(
    Line(
      points={{-50,0},{-30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(combustion.outlet, expansion.inlet) annotation(
    Line(
      points={{-10,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(expansion.outlet, gasExchange.inlet) annotation(
    Line(
      points={{30,0},{50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker.outlet, compression.inlet) annotation(
    Line(
      points={{-20,40},{-80,40},{-80,0},{-70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(gasExchange.outlet, loopBreaker.inlet) annotation(
    Line(
      points={{70,0},{80,0},{80,40},{0,40}},
      color={28,108,200},
      thickness=0.5));
  connect(expansion.P_out, shaftPower.E_flow_in[1]) annotation(Line(points={{20,-7},{20,-30},{70,-30},{70,-32.25}},
                                                                                                              color={255,170,85}));
  connect(compression.P_out, shaftPower.E_flow_in[2]) annotation(Line(points={{-60,-7},{-60,-34},{70,-34},{70,-30.75}},
                                                                                                                  color={255,170,85}));
  connect(combustion.P_out, shaftPower.E_flow_in[3]) annotation(Line(points={{-10,-11},{-10,-32},{70,-32},{70,-29.25}},color={255,170,85}));
  connect(gasExchange.P_out, shaftPower.E_flow_in[4]) annotation (Line(points={{70,-11},{70,-14},{60,-14},{60,-27.75},{70,-27.75}}, color={255,170,85}));
  annotation(Diagram(graphics={
        Text(
          extent={{-46,6},{-40,0}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-6,6},{0,0}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{34,6},{40,0}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{-80,46},{-74,40}},
          textColor={28,108,200},
          textString="1")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    Example of an Otto cycle engine model.
  </p>

  <p>
    This example makes use of the following components and settings:
  </p>

  <ul>
    <li>
      <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.SimpleAir\">SimpleAir</a> medium model
      (ideal gas with <code>R = 287 J/(kg·K)</code> and <code>gamma = 1.40</code>)
    </li>
    <li>
      <a href=\"modelica://ThermofluidStream.Idealized.Processes.PolytropicPerfectGas\">PolytropicPerfectGas</a> process model
    </li>
    <li>
      <code>systemSpec = Flow</code>
      (<a href=\"modelica://ThermofluidStream.Idealized.Types.SystemModel\">SystemModel</a>)
    </li>
  </ul>

  <p>
    This setup is based on the fact that the specific work of a thermodynamic cycle is given by the closed integral in the <code>p–v</code> diagram (pressure - specific volume).
    Therefore, integrating with respect to volume, <code>p*dv</code> (boundary work as typically transferred in a piston–cylinder system),
    and integrating with respect to pressure, <code>v*dp</code> (“artificial” shaft work of a dual stationary-flow process),
    yield the same net cycle work, even though the individual contributions of each process step differ.
  </p>
</html>"));
end PolytropicFlow;
