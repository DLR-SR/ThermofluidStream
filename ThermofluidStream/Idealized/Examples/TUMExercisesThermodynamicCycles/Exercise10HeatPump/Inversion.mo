within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise10HeatPump;
model Inversion
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconNeglectInertance;

  replaceable package Refrigerant = ThermofluidStream.Media.myMedia.R134a.R134a_ph constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);
  replaceable package Water = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
                                                                              constrainedby
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
  inner ThermofluidStream.DropOfCommons dropOfCommons(
    neglectInertance=true,                            displayInstanceNames=true, displayParameters=true)
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
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    T_out_fixed(displayUnit="K")) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,0})));
  ThermofluidStream.Idealized.Processes.Isenthalpic highPressureValve(
    redeclare package Medium = Refrigerant,
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
        origin={100,-30})));
  ThermofluidStream.Boundaries.Source
                                sourceWater(
    redeclare package Medium = Water,
    p0_par=100000,
    T0_par=293.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={130,-30})));
  Boundaries.Sink_m sinkWater(redeclare package Medium = Water, m_flow_fixed=0.2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={130,30})));
  ThermofluidStream.Idealized.Processes.Isobaric waterHeater(
    redeclare package Medium = Water,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,

    T_out_fixed(displayUnit="degC") = 317.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={130,0})));
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
  connect(highPressureCompressor.outlet, condensor.inlet)
    annotation (Line(
      points={{70,40},{80,40},{80,10}},
      color={28,108,200},
      thickness=0.5));
  connect(condensor.outlet, highPressureValve.inlet)
    annotation (Line(
      points={{80,-10},{80,-40},{50,-40}},
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
      points={{130,10},{130,20}},
      color={28,108,200},
      thickness=0.5));
  connect(sourceWater.outlet, waterHeater.inlet) annotation (Line(
      points={{130,-20},{130,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(h_dew.y, evaporator.outletSpec_prescribed) annotation (Line(points={{-99,0},{-82,0}}, color={0,0,127}));
  connect(h_dew.y, lowPressureLoopBreaker.h_out_prescribed) annotation (Line(points={{-99,0},{-90,0},{-90,24},{-82,24}}, color={0,0,127}));
  connect(h_dew1.y, highPressureLoopBreaker.h_out_prescribed) annotation (Line(points={{21,60},{26,60},{26,52}}, color={0,0,127}));
  connect(h_bubble.y, condensor.outletSpec_prescribed) annotation (Line(points={{100,-19},{100,-10},{92,-10}}, color={0,0,127}));
  connect(waterHeater.Q_flow_out, condensor.Q_flow_in) annotation (Line(points={{123,0},{88,0}}, color={255,170,85}));
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
          textString="8"),
        Polygon(
          points={{-140,40},{-100,40},{-100,60},{-120,60},{-120,100},{-140,100},{-140,40}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-110,90},{-30,70}},
          textColor={238,46,47},
          textString="requires neglectInertance = true
see User's Guide",
          horizontalAlignment=TextAlignment.Left)}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    Example  of a two-stage vapor-compression heat pump with an intermediate-pressure flash chamber to heat a residential building.
  </p>

  <p>
    This example solves for the mass flow rate and requires <code>neglectInertance = true</code>.
  </p>

  <h4>Problem description</h4>

  <p>
    The system consists of a low-pressure circuit (states <code>1</code> to <code>4</code>) and a high-pressure circuit (states <code>5</code> to <code>8</code>). 
    Both circuits are coupled via an externally adiabatic intermediate pressure <code>flashChamber</code> at <code>6 bar</code>.
  </p>

  <p>
    The working medium for this refrigeration process is <a href=\"modelica://ThermofluidStream.Media.myMedia.R134a.R134a_ph\">R134a</a>, passing through the following states and 
    processes:
  </p>

  <p>
    <strong>Low-pressure circuit:</strong> mass flow <code>ṁa</code>
    <ul>
      <li>1 &rarr; 2: adiabatic throttling of the saturated liquid to <code>p2 = 1.00 bar</code> in the <code>lowPressureValve</code></li>
      <li>2 &rarr; 3: complete, isobaric evaporation with heat uptake from the environment in the <code>evaporator</code></li>
      <li>3 &rarr; 4: adiabatic compression of dry saturated vapor to <code>p4 = 6.00bar</code> in the <code>lowPressureCompressor</code>; isentropic compressor efficiency 
      <code>0.800</code></li>
    </ul>
  </p>

  <p>
    <strong>High-pressure circuit:
    <ul>
      <li>5 &rarr; 6: adiabatic compression of dry saturated vapor to <code>p6 = 14.0 bar</code> in the <code>highPressureCompressor</code>; isentropic compressor efficiency 
      <code>0.800</code></li>
      <li>6 &rarr; 7: complete, isobaric condensation with heat transfer to the heating water in the <code>condenser</code></li>
      <li>7 &rarr; 8: adiabatic throttling to <code>p8 = 6.00bar</code> in the <code>highPressureValve</code></li>
    </ul>
  </p>

  <p>
    In the externally adiabatic <code>waterHeater</code>, the heating water mass flow (<code>200 g/s</code>, <code>cW = 4.18 kJ/(kg·K)</code>) is heated from <code>20.0 degC</code> 
    to <code>44.0 degC</code>.
  </p>

  <p>
    All state changes are considered steady-state.
  </p>
</html>"));
end Inversion;
