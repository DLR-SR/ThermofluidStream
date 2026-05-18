within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise3OttoEngine;
model PolytropicCycle
  extends ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise3OttoEngine.BaseModel(redeclare package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir);

  Processes.PolytropicPerfectGas
                           compression(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
    rhoRatio_fixed=compressionRatio,
    rho_out_fixed=d2) annotation(Placement(transformation(extent={{-70,-10},{-50,10}})));
  ThermofluidStream.Idealized.Processes.Isochoric combustion(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    T_out_fixed(displayUnit="K") = T3) annotation(Placement(transformation(extent={{-30,-10},{-10,10}})));
  Processes.PolytropicPerfectGas
                           expansion(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
    rhoRatio_fixed=1/compressionRatio,
    rho_out_fixed=d1,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.PolytropicEfficiency)
                     annotation(Placement(transformation(extent={{10,-10},{30,10}})));
  ThermofluidStream.Idealized.Processes.Isochoric gasExchange(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    T_out_fixed(displayUnit="K") = T1) annotation(Placement(transformation(extent={{50,-10},{70,10}})));
  Sources.LoopBreaker_m loopBreaker(
    redeclare package Medium = Medium,
    m_flow_in_par=1,
    p_out_fixed=p1,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.Temperature,
    T_out_fixed=T1) annotation(Placement(transformation(extent={{0,30},{-20,50}})));
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
  EnergyFlow.Components.Sum shaftPower(n_in=2) annotation(Placement(transformation(extent={{70,-40},{90,-20}})));
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
  connect(expansion.P_out, shaftPower.E_flow_in[1]) annotation(Line(points={{20,-7},{20,-31.5},{70,-31.5}},  color={255,170,85}));
  connect(compression.P_out, shaftPower.E_flow_in[2]) annotation(Line(points={{-60,-7},{-60,-28},{70,-28},{70,-28.5}},
                                                                                                                  color={255,170,85}));
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
      <code>systemSpec = Cycle</code>
      (<a href=\"modelica://ThermofluidStream.Idealized.Types.SystemModel\">SystemModel</a>)
    </li>
  </ul>

  <h4>Problem description</h4>

  <p>
    A four-stroke Otto engine can be represented by the following idealized thermodynamic cycle:
  </p>

  <ul>
    <li><code>1 → 2</code>: Isentropic compression (T₁ = 300 K, p₁ = 1.00 bar, compression ratio φ = 10.0)</li>
    <li><code>2 → 3</code>: Isochoric heat addition (combustion process, T₃ = 2200 K)</li>
    <li><code>3 → 4</code>: Isentropic expansion (with V₄ = V₁)</li>
    <li><code>4 → 1</code>: Isochoric heat rejection (in practice realized via gas exchange of the displaced volume)</li>
  </ul>
</html>"));
end PolytropicCycle;
