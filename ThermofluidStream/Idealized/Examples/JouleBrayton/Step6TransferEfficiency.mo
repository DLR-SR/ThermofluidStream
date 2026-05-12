within ThermofluidStream.Idealized.Examples.JouleBrayton;
model Step6TransferEfficiency
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{140,80},{160,100}})));

  Processes.Adiabatic lowPressureCompressor(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,
    pr_fixed=2,
    p_out_fixed=200000) annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Processes.Adiabatic highPressureTurbine(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    enableFilter=true,
    TC=0.01,
    P_nom(displayUnit="kW") = 500000,
    dp_nom=2000000,
    eta_fixed=0.8,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  ThermofluidStream.Boundaries.Source
                    airSource(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation (Placement(transformation(extent={{-156,-10},{-136,10}})));
  Processes.Isobaric firstCombustion(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,

    T_out_fixed=1673.15) annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Sources.Ramp outletPressure(
    height=19e5,
    duration=1,
    offset=1.0e5)
                annotation (Placement(transformation(extent={{-150,-46},{-130,-26}})));
  ThermofluidStream.HeatExchangers.CounterFlowNTU recuperator(
    redeclare package MediumA = Medium,
    redeclare package MediumB = Medium,
    A=10,
    k_NTU=200) annotation (Placement(transformation(extent={{-30,-4},{-10,16}})));
  Sink_m airSink(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-38,44})));
  Processes.Isobaric cooler(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,

    T_out_fixed=293.15) annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Processes.Adiabatic highPressureCompressor(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,

    p_out_fixed=2000000) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Processes.Isobaric secondCombustion(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,

    T_out_fixed=1673.15) annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Processes.Adiabatic lowPressureTurbine(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,

    p_out_fixed=100000) annotation (Placement(transformation(extent={{130,-10},{150,10}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="efficiency",
    use_numberPort=false,
    number=generatorPower.E_flow_out/(firstCombustion.Q_flow + secondCombustion.Q_flow),
    displayVariable=false) annotation (Placement(transformation(extent={{0,60},{20,80}})));
  EnergyFlow.Components.FixedTransferEfficiency highPressureShaft(eta=0.95) annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  EnergyFlow.Components.FixedTransferEfficiency lowPressureShaft(eta=0.95) annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  EnergyFlow.Components.FixedTransferEfficiency generatorPower(eta=0.99) annotation (Placement(transformation(extent={{180,-40},{200,-20}})));
  EnergyFlow.Components.Sum lowPressurePower(n_in=2) annotation (Placement(transformation(extent={{150,-40},{170,-20}})));
equation
  connect(airSource.outlet, lowPressureCompressor.inlet)
    annotation (Line(
      points={{-136,0},{-120,0}},
      color={28,108,200},
      thickness=0.5));
  connect(airSink.inlet, recuperator.outletB)
    annotation (Line(
      points={{-38,34},{-38,12},{-30,12}},
      color={28,108,200},
      thickness=0.5));
  connect(lowPressureCompressor.outlet, cooler.inlet)
    annotation (Line(
      points={{-100,0},{-90,0}},
      color={28,108,200},
      thickness=0.5));
  connect(cooler.outlet, highPressureCompressor.inlet)
    annotation (Line(
      points={{-70,0},{-60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(recuperator.outletA, firstCombustion.inlet)
    annotation (Line(
      points={{-10,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(highPressureCompressor.outlet, recuperator.inletA)
    annotation (Line(
      points={{-40,0},{-30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(firstCombustion.outlet, highPressureTurbine.inlet)
    annotation (Line(
      points={{30,0},{50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(highPressureTurbine.outlet, secondCombustion.inlet)
    annotation (Line(
      points={{70,0},{90,0}},
      color={28,108,200},
      thickness=0.5));
  connect(secondCombustion.outlet, lowPressureTurbine.inlet)
    annotation (Line(
      points={{110,0},{130,0}},
      color={28,108,200},
      thickness=0.5));
  connect(lowPressureTurbine.outlet, recuperator.inletB) annotation (Line(
      points={{150,0},{158,0},{158,18},{-4,18},{-4,12},{-10,12}},
      color={28,108,200},
      thickness=0.5));
  connect(lowPressureTurbine.P_out, lowPressurePower.E_flow_in[1]) annotation (Line(points={{140,-7},{140,-28},{150,-28},{150,-31.5}},
                                                                                                                                 color={255,170,85}));
  connect(lowPressureShaft.E_flow_out, lowPressurePower.E_flow_in[2]) annotation (Line(points={{41,-40},{140,-40},{140,-32},{150,-32},{150,-28.5}},
                                                                                                                                   color={255,170,85}));
  connect(lowPressurePower.E_flow_out, generatorPower.E_flow_in) annotation (Line(points={{171.7,-30},{178,-30}},    color={255,170,85}));
  connect(outletPressure.y, lowPressureCompressor.outletSpec_prescribed) annotation (Line(points={{-129,-36},{-100,-36},{-100,-12}}, color={0,0,127}));
  connect(highPressureShaft.E_flow_out, highPressureTurbine.P_in) annotation (Line(points={{11,-20},{60,-20},{60,-8}}, color={255,170,85}));
  connect(highPressureShaft.E_flow_in, highPressureCompressor.P_out) annotation (Line(points={{-12,-20},{-50,-20},{-50,-7}}, color={255,170,85}));
  connect(lowPressureShaft.E_flow_in, lowPressureCompressor.P_out) annotation (Line(points={{18,-40},{-110,-40},{-110,-7}}, color={255,170,85}));
  annotation (experiment(startTime=-1), Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-100},{160,100}}), graphics={
        Text(
          extent={{-132,6},{-126,0}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-98,6},{-92,0}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-68,6},{-62,0}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-38,6},{-32,0}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{-4,6},{2,0}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{36,6},{42,0}},
          textColor={28,108,200},
          textString="6"),
        Text(
          extent={{76,6},{82,0}},
          textColor={28,108,200},
          textString="7"),
        Text(
          extent={{116,6},{122,0}},
          textColor={28,108,200},
          textString="8"),
        Text(
          extent={{152,6},{158,0}},
          textColor={28,108,200},
          textString="9"),
        Text(
          extent={{-38,18},{-32,12}},
          textColor={28,108,200},
          textString="10")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    In a sixth step, efficencies for the shafts are included. They influence the overall efficiency significantly.
  </p>

  <p>
    Further documentation is available in the 
    <a href=\"modelica://ThermoFluidStream.Idealized.Examples.JouleBrayton\">JouleBrayton</a> package.
  </p>
</html>"));
end Step6TransferEfficiency;
