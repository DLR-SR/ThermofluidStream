within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise10HeatPump;
model PseudoInversion
  extends Modelica.Icons.Example;

  replaceable package Refrigerant = ThermofluidStream.Media.myMedia.R134a.R134a_ph constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);
  replaceable package Water = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

  ThermofluidStream.Idealized.Processes.Adiabatic lowPressureCompressor(
    redeclare package Medium = Refrigerant,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,

    p_out_fixed=600000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,40})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{140,80},{160,100}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic lowPressureValve(
    redeclare package Medium = Refrigerant,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isenthalpic.OutletPressure,
    p_out_fixed=100000) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-40,-40})));
  ThermofluidStream.Idealized.Processes.Isobaric evaporator(
    redeclare package Medium = Refrigerant,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-70,-10})));
  Modelica.Blocks.Sources.RealExpression h_dew(y=Refrigerant.dewEnthalpy(Refrigerant.setSat_p(1e5)))
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic highPressureCompressor(
    redeclare package Medium = Refrigerant,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,

    p_out_fixed=1400000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={60,40})));
  ThermofluidStream.Idealized.Processes.Isobaric condensor(
    redeclare package Medium = Refrigerant,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    T_out_fixed(displayUnit="K")) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,-20})));
  ThermofluidStream.Idealized.Processes.Isenthalpic highPressureValve(
    redeclare package Medium = Refrigerant,
    enforcePressureDrop=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isenthalpic.OutletPressure,

    p_out_fixed=600000) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={40,-40})));
  Components.Separator flashChamber(redeclare package Medium = Refrigerant)
                                                                       annotation (Placement(transformation(extent={{10,-10},{-10,10}}, rotation=270)));
  Sources.LoopBreaker highPressureLoopBreaker(
    redeclare package Medium = Refrigerant,

    p_out_fixed=600000,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    thermalValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={24,40})));
  Modelica.Blocks.Sources.RealExpression h_dew1(y=Refrigerant.dewEnthalpy(Refrigerant.setSat_p(6e5)))
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Sources.LoopBreaker lowPressureLoopBreaker(
    redeclare package Medium = Refrigerant,
    p_out_fixed=100000,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    thermalValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-70,22})));
  Modelica.Blocks.Sources.RealExpression h_bubble(y=Refrigerant.bubbleEnthalpy(Refrigerant.setSat_p(14e5)))
                                                                                                  annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={100,-50})));
  ThermofluidStream.Boundaries.Source
                                sourceWater(
    redeclare package Medium = Water,
    p0_par=100000,
    T0_par=293.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={150,-76})));
  Boundaries.Sink_m sinkWater(redeclare package Medium = Water, m_flow_fixed=0.2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={150,-16})));
  ThermofluidStream.Idealized.Processes.Isobaric waterHeater(
    redeclare package Medium = Water,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,

    T_out_fixed(displayUnit="degC") = 317.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={150,-46})));
  ThermofluidStream.Utilities.showRealValue heatFlowRateHeatPump(
    description="Q_flow_67",
    use_numberPort=false,
    number=waterHeater.Q_flow,
    displayVariable=false,
    significantDigits=3) annotation (Placement(transformation(extent={{-140,-100},{-120,-80}})));
  ThermofluidStream.Utilities.showRealValue specificWorkLowPressureCompressor(
    description="w_t_34",
    use_numberPort=false,
    number=lowPressureCompressor.dh,
    displayVariable=false,
    significantDigits=3) annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  ThermofluidStream.Utilities.showRealValue VaporQualityLowPressureValve(
    description="x_2",
    use_numberPort=false,
    number=Refrigerant.vapourQuality(lowPressureValve.outlet.state),
    displayVariable=false,
    significantDigits=3) annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
  ThermofluidStream.Utilities.showRealValue HighPressureCompressorOutletTemperature(
    description="T_6",
    use_numberPort=false,
    number=highPressureCompressor.outlet.state.T,
    displayVariable=false,
    significantDigits=3) annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  ThermofluidStream.Utilities.showRealValue HighPressureCircuitMassFlowRate(
    description="m_flow_58",
    use_numberPort=false,
    number=highPressureCompressor.inlet.m_flow,
    displayVariable=false,
    significantDigits=3) annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
  ThermofluidStream.Utilities.showRealValue LowPressureCircuitMassFlowRate(
    description="m_flow_14",
    use_numberPort=false,
    number=lowPressureCompressor.inlet.m_flow,
    displayVariable=false,
    significantDigits=3) annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
  ThermofluidStream.Utilities.showRealValue COP(
    description="COP",
    use_numberPort=false,
    number=waterHeater.Q_flow/(lowPressureCompressor.P + highPressureCompressor.P),
    displayVariable=false,
    significantDigits=3) annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
  Modelica.Blocks.Continuous.Integrator integrator(
    k=-10,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.1) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={104,18})));
  Sources.MassFlowRate massFlowRate(redeclare package Medium = Refrigerant, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,18})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{140,8},{120,28}})));
equation
  connect(evaporator.inlet, lowPressureValve.outlet)
    annotation (Line(
      points={{-70,-20},{-70,-40},{-50,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outlet, lowPressureLoopBreaker.inlet)
    annotation (Line(
      points={{-70,0},{-70,12}},
      color={28,108,200},
      thickness=0.5));
  connect(lowPressureLoopBreaker.outlet, lowPressureCompressor.inlet)
    annotation (Line(
      points={{-70,32},{-70,40},{-50,40}},
      color={28,108,200},
      thickness=0.5));
  connect(flashChamber.outletLiquid, lowPressureValve.inlet) annotation (Line(
      points={{-6,-10},{-6,-40},{-30,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(lowPressureCompressor.outlet, flashChamber.inletA) annotation (Line(
      points={{-30,40},{-6,40},{-6,10}},
      color={28,108,200},
      thickness=0.5));
  connect(condensor.outlet, highPressureValve.inlet)
    annotation (Line(
      points={{80,-30},{80,-40},{50,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(highPressureValve.outlet, flashChamber.inletB) annotation (Line(
      points={{30,-40},{6,-40},{6,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(highPressureLoopBreaker.outlet, highPressureCompressor.inlet)
    annotation (Line(
      points={{34,40},{50,40}},
      color={28,108,200},
      thickness=0.5));
  connect(highPressureLoopBreaker.inlet, flashChamber.outletVapor) annotation (Line(
      points={{14,40},{6,40},{6,10}},
      color={28,108,200},
      thickness=0.5));
  connect(waterHeater.outlet, sinkWater.inlet) annotation (Line(
      points={{150,-36},{150,-26}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceWater.outlet, waterHeater.inlet) annotation (Line(
      points={{150,-66},{150,-56}},
      color={28,108,200},
      thickness=0.5));
  connect(h_dew.y, evaporator.outletSpec_prescribed) annotation (Line(points={{-99,0},{-82,0}}, color={0,0,127}));
  connect(h_dew.y, lowPressureLoopBreaker.h_out_prescribed) annotation (Line(points={{-99,0},{-90,0},{-90,24},{-82,24}}, color={0,0,127}));
  connect(h_dew1.y, highPressureLoopBreaker.h_out_prescribed) annotation (Line(points={{21,60},{26,60},{26,52}}, color={0,0,127}));
  connect(h_bubble.y, condensor.outletSpec_prescribed) annotation (Line(points={{100,-39},{100,-30},{92,-30}}, color={0,0,127}));
  connect(highPressureCompressor.outlet, massFlowRate.inlet) annotation (Line(
      points={{70,40},{80,40},{80,28}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate.outlet, condensor.inlet) annotation (Line(
      points={{80,8},{80,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(integrator.y, massFlowRate.m_flow_prescribed) annotation (Line(points={{93,18},{88,18}}, color={0,0,127}));
  connect(integrator.u, add.y) annotation (Line(points={{116,18},{119,18}}, color={0,0,127}));
  connect(waterHeater.Q_flow_out, add.u1) annotation (Line(points={{143,-46},{130,-46},{130,-6},{152,-6},{152,24},{142,24}}, color={255,170,85}));
  connect(condensor.Q_flow_out, add.u2) annotation (Line(points={{87,-20},{126,-20},{126,-4},{148,-4},{148,12},{142,12}}, color={255,170,85}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false, extent={
            {-140,-100},{160,100}}), graphics={
        Text(
          extent={{-12,-34},{-6,-40}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-70,-34},{-64,-40}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-70,40},{-64,34}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-12,40},{-6,34}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{6,40},{12,34}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{74,-34},{80,-40}},
          textColor={28,108,200},
          textString="7"),
        Text(
          extent={{74,40},{80,34}},
          textColor={28,108,200},
          textString="6"),
        Text(
          extent={{6,-34},{12,-40}},
          textColor={28,108,200},
          textString="8")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    Example  of a two-stage vapor-compression heat pump with an intermediate-pressure flash chamber to heat a residential building. The setup of this example is identical to
    <a href=\"modelica://ThermoFluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise10HeatPump.Inversion\">Exercise10HeatPump.Inversion</a> (see for problem description).
  </p>

  <p>
    This example uses <code>pseudoInversion</code> \"controllers\" instead of explicit determination of mass flow rates. 
    With this <code>neglectInertance</code> is not required.
  </p>
</html>"));
end PseudoInversion;
