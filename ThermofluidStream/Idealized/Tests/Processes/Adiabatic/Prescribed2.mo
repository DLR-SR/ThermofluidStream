within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model Prescribed2 "Example - adiabatic process"
  extends ThermofluidStream.Idealized.Tests.Processes.Adiabatic.PartialPrescribed(dropOfCommons(considerInertance=false));
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconInertanceNeglect;

  .ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true) annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{20,30},{40,50}})));
  ThermofluidStream.Idealized.Processes.Adiabatic dp1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    etaSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink1(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pRatio1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    etaSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true) annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink2(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pOut1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    etaSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
equation
  connect(source.outlet,dp1. inlet) annotation (Line(
      points={{-20,40},{-10,40}},
      color={28,108,200},
      thickness=0.5));
  connect(dp1.outlet, sink.inlet) annotation (Line(
      points={{10,40},{20,40}},
      color={28,108,200},
      thickness=0.5));

  connect(source1.outlet, pRatio1.inlet) annotation (Line(
      points={{-20,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio1.outlet, sink1.inlet) annotation (Line(
      points={{10,0},{20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, pOut1.inlet) annotation (Line(
      points={{-20,-40},{-10,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(pOut1.outlet, sink2.inlet) annotation (Line(
      points={{10,-40},{20,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(source.p0_var, inletPressure.y) annotation (Line(points={{-32,46},{-40,46},{-40,110},{-79,110}}, color={0,0,127}));
  connect(source1.p0_var, inletPressure.y) annotation (Line(points={{-32,6},{-40,6},{-40,110},{-79,110}}, color={0,0,127}));
  connect(source2.p0_var, inletPressure.y) annotation (Line(points={{-32,-34},{-40,-34},{-40,110},{-79,110}}, color={0,0,127}));
  connect(source.T0_var, inletTemperature.y) annotation (Line(points={{-32,40},{-44,40},{-44,70},{-79,70}}, color={0,0,127}));
  connect(source1.T0_var, inletTemperature.y) annotation (Line(points={{-32,0},{-44,0},{-44,70},{-79,70}}, color={0,0,127}));
  connect(source2.T0_var, inletTemperature.y) annotation (Line(points={{-32,-40},{-44,-40},{-44,70},{-79,70}}, color={0,0,127}));
  connect(dp1.eta_prescribed, isentropicEfficiency.y) annotation (Line(points={{6,28},{6,20},{-48,20},{-48,-50},{-79,-50}}, color={0,0,127}));
  connect(pRatio1.eta_prescribed, isentropicEfficiency.y) annotation (Line(points={{6,-12},{6,-20},{-48,-20},{-48,-50},{-79,-50}}, color={0,0,127}));
  connect(pOut1.eta_prescribed, isentropicEfficiency.y) annotation (Line(points={{6,-52},{6,-60},{-48,-60},{-48,-50},{-79,-50}}, color={0,0,127}));
  connect(dp1.outletSpec_prescribed, pressureDifference.y) annotation (Line(points={{10,28},{10,16},{-52,16},{-52,-20},{-79,-20}}, color={0,0,127}));
  connect(pRatio1.outletSpec_prescribed, pressureRatio.y) annotation (Line(points={{10,-12},{10,-24},{-56,-24},{-56,30},{-79,30}}, color={0,0,127}));
  connect(pOut1.outletSpec_prescribed, outletPressure.y) annotation (Line(points={{10,-52},{10,-64},{-60,-64},{-60,0},{-79,0}}, color={0,0,127}));
  connect(dp1.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{0,32},{0,24},{-64,24},{-64,-130},{-79,-130}}, color={255,170,85}));
  connect(pRatio1.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{0,-8},{0,-16},{-64,-16},{-64,-130},{-79,-130}}, color={255,170,85}));
  connect(pOut1.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{0,-48},{0,-56},{-64,-56},{-64,-130},{-79,-130}}, color={255,170,85}));
  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Documentation(
      info="<html>
  <p>
    This example illustrates several variants of using the 
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a> process defined by parameters (outlet state and power given, FullMedium model).
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
    Diagram(graphics={
        Polygon(
          points={{40,60},{80,60},{80,80},{60,80},{60,120},{40,120},{40,60}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{70,110},{150,90}},
          textColor={238,46,47},
          textString="requires considerInertance = false
see User's Guide",
          horizontalAlignment=TextAlignment.Left)}));
end Prescribed2;
