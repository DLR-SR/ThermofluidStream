within ThermofluidStream.Idealized.Examples.JouleBrayton;
model Step6TransferEfficiency
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{180,80},{200,100}})));

  Processes.Adiabatic lowPressureCompressor(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    pRatio_fixed=2,
    p_out_fixed=200000) annotation(Placement(transformation(extent={{-140,-10},{-120,10}})));
  Processes.Adiabatic highPressureTurbine(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    enableFilter=true,
    TC=0.01,
    P_nom(displayUnit="kW") = 500000,
    dp_nom=2000000,
    eta_fixed=0.8,
    specifyOutlet=false,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{30,-10},{50,10}})));
  ThermofluidStream.Boundaries.Source
                    airSource(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-176,-10},{-156,10}})));
  Processes.Isobaric firstCombustion(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed=1673.15) annotation(Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp outletPressure(
    height=19e5,
    duration=1,
    offset=1.0e5)
               annotation(Placement(transformation(extent={{-170,-46},{-150,-26}})));
  ThermofluidStream.HeatExchangers.CounterFlowNTU recuperator(
    redeclare package MediumA = Medium,
    redeclare package MediumB = Medium,
    A=10,
    k_NTU=200,
    TC=0.01)   annotation(Placement(transformation(extent={{-50,-4},{-30,16}})));
  Boundaries.Sink_m airSink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-58,44})));
  Processes.Isobaric cooler(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed=293.15) annotation(Placement(transformation(extent={{-110,-10},{-90,10}})));
  Processes.Adiabatic highPressureCompressor(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=2000000) annotation(Placement(transformation(extent={{-80,-10},{-60,10}})));
  Processes.Isobaric secondCombustion(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed=1673.15) annotation(Placement(transformation(extent={{70,-10},{90,10}})));
  Processes.Adiabatic lowPressureTurbine(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=100000) annotation(Placement(transformation(extent={{110,-10},{130,10}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="efficiency",
    use_numberPort=false,
    number=generatorPower.E_flow_out/(firstCombustion.Q_flow + secondCombustion.Q_flow),
    displayVariable=false) annotation(Placement(transformation(extent={{-20,60},{0,80}})));
  EnergyFlow.Components.FixedTransferEfficiency highPressureShaft(eta=0.95) annotation(Placement(transformation(extent={{-30,-30},{-10,-10}})));
  EnergyFlow.Components.FixedTransferEfficiency lowPressureShaft(eta=0.95) annotation(Placement(transformation(extent={{0,-50},{20,-30}})));
  EnergyFlow.Components.FixedTransferEfficiency generatorPower(eta=0.99) annotation(Placement(transformation(extent={{160,-40},{180,-20}})));
  EnergyFlow.Components.Sum lowPressurePower(n_in=2) annotation(Placement(transformation(extent={{130,-40},{150,-20}})));

equation
  connect(airSource.outlet, lowPressureCompressor.inlet) annotation(
    Line(
      points={{-156,0},{-140,0}},
      color={28,108,200},
      thickness=0.5));
  connect(airSink.inlet, recuperator.outletB) annotation(
    Line(
      points={{-58,34},{-58,12},{-50,12}},
      color={28,108,200},
      thickness=0.5));
  connect(lowPressureCompressor.outlet, cooler.inlet) annotation(
    Line(
      points={{-120,0},{-110,0}},
      color={28,108,200},
      thickness=0.5));
  connect(cooler.outlet, highPressureCompressor.inlet) annotation(
    Line(
      points={{-90,0},{-80,0}},
      color={28,108,200},
      thickness=0.5));
  connect(recuperator.outletA, firstCombustion.inlet) annotation(
    Line(
      points={{-30,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(highPressureCompressor.outlet, recuperator.inletA) annotation(
    Line(
      points={{-60,0},{-50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(firstCombustion.outlet, highPressureTurbine.inlet) annotation(
    Line(
      points={{10,0},{30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(highPressureTurbine.outlet, secondCombustion.inlet) annotation(
    Line(
      points={{50,0},{70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(secondCombustion.outlet, lowPressureTurbine.inlet) annotation(
    Line(
      points={{90,0},{110,0}},
      color={28,108,200},
      thickness=0.5));
  connect(lowPressureTurbine.outlet, recuperator.inletB) annotation(Line(
      points={{130,0},{138,0},{138,18},{-24,18},{-24,12},{-30,12}},
      color={28,108,200},
      thickness=0.5));
  connect(lowPressureTurbine.P_out, lowPressurePower.E_flow_in[1]) annotation(Line(points={{120,-7},{120,-28},{130,-28},{130,-31.5}},
                                                                                                                                 color={255,170,85}));
  connect(lowPressureShaft.E_flow_out, lowPressurePower.E_flow_in[2]) annotation(Line(points={{21,-40},{120,-40},{120,-32},{130,-32},{130,-28.5}},
                                                                                                                                   color={255,170,85}));
  connect(lowPressurePower.E_flow_out, generatorPower.E_flow_in) annotation(Line(points={{151.7,-30},{158,-30}},    color={255,170,85}));
  connect(outletPressure.y, lowPressureCompressor.outletSpec_prescribed) annotation(Line(points={{-149,-36},{-120,-36},{-120,-12}}, color={0,0,127}));
  connect(highPressureShaft.E_flow_out, highPressureTurbine.P_in) annotation(Line(points={{-9,-20},{40,-20},{40,-8}}, color={255,170,85}));
  connect(highPressureShaft.E_flow_in, highPressureCompressor.P_out) annotation(Line(points={{-32,-20},{-70,-20},{-70,-7}}, color={255,170,85}));
  connect(lowPressureShaft.E_flow_in, lowPressureCompressor.P_out) annotation(Line(points={{-2,-40},{-130,-40},{-130,-7}}, color={255,170,85}));

  annotation(
    experiment(
      StartTime=-1,
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(extent={{-200,-100},{200,100}}),
      graphics={
        Text(
          extent={{-152,6},{-146,0}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-118,6},{-112,0}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-88,6},{-82,0}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-58,6},{-52,0}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{-24,6},{-18,0}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{16,6},{22,0}},
          textColor={28,108,200},
          textString="6"),
        Text(
          extent={{56,6},{62,0}},
          textColor={28,108,200},
          textString="7"),
        Text(
          extent={{96,6},{102,0}},
          textColor={28,108,200},
          textString="8"),
        Text(
          extent={{132,6},{138,0}},
          textColor={28,108,200},
          textString="9"),
        Text(
          extent={{-58,18},{-52,12}},
          textColor={28,108,200},
          textString="10")}),
    Documentation(info="<html>
  <p>
    In a sixth step, efficencies for the shafts are included. They influence the overall efficiency significantly.
  </p>

  <p>
    Further documentation is available in the 
    <a href=\"modelica://ThermofluidStream.Idealized.Examples.JouleBrayton\">JouleBrayton</a> package.
  </p>
</html>",
      revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Step6TransferEfficiency;
