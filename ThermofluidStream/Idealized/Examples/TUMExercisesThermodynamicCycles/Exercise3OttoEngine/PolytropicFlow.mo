within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise3OttoEngine;
model PolytropicFlow
  extends ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise3OttoEngine.BaseModel(redeclare package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir);

  Processes.PolytropicPerfectGas
                           compression(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
    rhoRatio_fixed=compressionRatio,
    rho_out_fixed=d2) annotation(Placement(transformation(extent={{-70,0},{-50,20}})));
  ThermofluidStream.Idealized.Processes.Isochoric combustion(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    T_out_fixed(displayUnit="K") = T3) annotation(Placement(transformation(extent={{-30,0},{-10,20}})));
  Processes.PolytropicPerfectGas
                           expansion(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
    rhoRatio_fixed=1/compressionRatio,
    rho_out_fixed=d1,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.PolytropicEfficiency)
                      annotation(Placement(transformation(extent={{10,0},{30,20}})));
  ThermofluidStream.Idealized.Processes.Isochoric gasExchange(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    T_out_fixed(displayUnit="K") = T1) annotation(Placement(transformation(extent={{50,0},{70,20}})));
  Sources.LoopBreaker_m loopBreaker(
    redeclare package Medium = Medium,
    m_flow_in_par=1,
    p_out_fixed=p1,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.Temperature,
    T_out_fixed=T1) annotation(Placement(transformation(extent={{0,40},{-20,60}})));
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
  EnergyFlow.Components.Sum shaftPower(n_in=4) annotation(Placement(transformation(extent={{80,-30},{100,-10}})));
equation
  connect(compression.outlet, combustion.inlet)annotation(
    Line(
      points={{-50,10},{-30,10}},
      color={28,108,200},
      thickness=0.5));
  connect(combustion.outlet, expansion.inlet)annotation(
    Line(
      points={{-10,10},{10,10}},
      color={28,108,200},
      thickness=0.5));
  connect(expansion.outlet, gasExchange.inlet)annotation(
    Line(
      points={{30,10},{50,10}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker.outlet, compression.inlet)annotation(
    Line(
      points={{-20,50},{-80,50},{-80,10},{-70,10}},
      color={28,108,200},
      thickness=0.5));
  connect(gasExchange.outlet, loopBreaker.inlet)annotation(
    Line(
      points={{70,10},{80,10},{80,50},{0,50}},
      color={28,108,200},
      thickness=0.5));
  connect(expansion.P_out, shaftPower.E_flow_in[1]) annotation(Line(points={{20,3},{20,-20},{80,-20},{80,-22.25}},
                                                                                                              color={255,170,85}));
  connect(compression.P_out, shaftPower.E_flow_in[2]) annotation(Line(points={{-60,3},{-60,-24},{80,-24},{80,-20.75}},
                                                                                                                  color={255,170,85}));
  connect(combustion.P_out, shaftPower.E_flow_in[3]) annotation(Line(points={{-10,-1},{-10,-22},{80,-22},{80,-19.25}}, color={255,170,85}));
  connect(gasExchange.P_out, shaftPower.E_flow_in[4]) annotation(Line(points={{70,-1},{70,-17.75},{80,-17.75}}, color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-100},{180,100}}), graphics={
        Text(
          extent={{-46,16},{-40,10}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-6,16},{0,10}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{34,16},{40,10}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{-80,56},{-74,50}},
          textColor={28,108,200},
          textString="1")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info=""));
end PolytropicFlow;
