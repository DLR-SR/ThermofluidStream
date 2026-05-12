within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise8TwoStageRefrigerationCycle;
model NeglectInertance
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconNeglectInertance;

  replaceable package Medium = ThermofluidStream.Media.myMedia.R134a.R134a_ph constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);
  parameter SI.Mass m = 75 "Mass to be cooled" annotation(
    Dialog(group="Cooling requirement"));
  parameter SI.SpecificHeatCapacity c = 2e3 "Specific heat capacity" annotation(
    Dialog(group="Cooling requirement"));
  parameter SI.TemperatureDifference dT = 40 "Temperature difference" annotation(
    Dialog(group="Cooling requirement"));
  parameter SI.Time duration(displayUnit="min")=900 "Time" annotation(
    Dialog(group="Cooling requirement"));

  ThermofluidStream.Idealized.Processes.Adiabatic lowPressureCompressor(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.9,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=600000) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={18,-40})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(
    considerInertance=false,                            displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{80,80},{100,100}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic lowPressureValve(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.OutletPressure,
    p_out_fixed=100000) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-40})));
  ThermofluidStream.Idealized.Processes.Isobaric evaporator(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-50,-80},{-30,-60}})));
  Sources.LoopBreaker loopBreaker(
    redeclare package Medium = Medium,
    p_out_fixed=100000,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    thermalValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-20,-80},{0,-60}})));
  Modelica.Blocks.Sources.RealExpression h_dew(y=Medium.dewEnthalpy(Medium.setSat_p(1e5))) annotation(
    Placement(transformation(extent={{-70,-126},{-50,-106}})));
  ThermofluidStream.Idealized.Processes.Adiabatic highPressureCompressor(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    etaSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=1400000,
    eta_is(start=1),
    outlet(state(phase(start=1))),
    h_out(start=450e3)) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,40})));
  ThermofluidStream.Idealized.Processes.Isobaric condensor(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    T_out_fixed(displayUnit="K") = 300) annotation(Placement(transformation(extent={{-18,80},{-38,60}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic highPressureValve(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.OutletPressure,

    p_out_fixed=600000) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,42})));
  ThermofluidStream.Idealized.Components.Separator flashChamber(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-40,-10},{-20,10}})));
  Sources.LoopBreaker loopBreaker1(
    redeclare package Medium = Medium,

    p_out_fixed=600000,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    thermalValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-12,-4},{8,16}})));
  Modelica.Blocks.Sources.RealExpression h_dew1(y=Medium.dewEnthalpy(Medium.setSat_p(6e5))) annotation(
    Placement(transformation(extent={{42,-30},{22,-10}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect vaporQuality(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation(
    Placement(transformation(extent={{-78,-4},{-98,16}})));
  ThermofluidStream.Utilities.showRealValue lowPressureCompressorOutletTemperature(
    description="T_2",
    use_numberPort=false,
    number=lowPressureCompressor.outlet.state.T,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-90,-160},{-70,-140}})));
  ThermofluidStream.Utilities.showRealValue valveOutletVaporQuality(
    description="x_7",
    use_numberPort=false,
    number=vaporQuality.value,
    displayVariable=false) annotation(Placement(transformation(extent={{-50,-160},{-30,-140}})));
  ThermofluidStream.Utilities.showRealValue LowPressureCompressorPower(
    description="P_LPCMP",
    use_numberPort=false,
    number=lowPressureCompressor.P,
    displayVariable=false,
    significantDigits=3) annotation(Placement(transformation(extent={{-10,-160},{10,-140}})));
  ThermofluidStream.Utilities.showRealValue ElectricPower(
    description="P_el",
    use_numberPort=false,
    number=-losses.E_flow_out,
    displayVariable=false,
    significantDigits=3) annotation(Placement(transformation(extent={{30,-160},{50,-140}})));
  ThermofluidStream.Utilities.showRealValue showRealValue5(
    description="e_K",
    use_numberPort=false,
    number=evaporator.Q_flow/losses.E_flow_out,
    displayVariable=false,
    significantDigits=3) annotation(Placement(transformation(extent={{70,-160},{90,-140}})));
  Modelica.Blocks.Sources.RealExpression h_bubble(y=Medium.bubbleEnthalpy(Medium.setSat_p(14e5))) annotation(Placement(transformation(extent={{0,80},{-20,100}})));
  EnergyFlow.Sources.FixedEnergyFlow heatFlow(E_flow(displayUnit="MW") = m*c*dT/duration) annotation(Placement(transformation(extent={{-80,-100},{-60,-80}})));
  EnergyFlow.Components.FixedTransferEfficiency losses(eta=0.95) annotation(Placement(transformation(extent={{90,-10},{110,10}})));
  EnergyFlow.Components.Sum shaftPower(n_in=2) annotation(Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints annotation(
    Placement(transformation(extent={{92,34},{52,58}})));
  Modelica.Blocks.Sources.RealExpression temperature(y(
      unit="K",
      displayUnit="K") = 335) annotation(Placement(transformation(extent={{60,36},{80,56}})));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true,
    inlet(state(phase(start=1)))) annotation(Placement(transformation(extent={{32,60},{52,80}})));
equation
  connect(lowPressureValve.outlet, evaporator.inlet) annotation(Line(
      points={{-70,-50},{-70,-70},{-50,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker.outlet, lowPressureCompressor.inlet) annotation(
    Line(
      points={{0,-70},{18,-70},{18,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outlet, loopBreaker.inlet) annotation(
    Line(
      points={{-30,-70},{-20,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(highPressureCompressor.outlet, condensor.inlet) annotation(
    Line(
      points={{20,50},{20,70},{-18,70}},
      color={28,108,200},
      thickness=0.5));
  connect(condensor.outlet, highPressureValve.inlet) annotation(Line(
      points={{-38,70},{-70,70},{-70,52}},
      color={28,108,200},
      thickness=0.5));
  connect(lowPressureCompressor.outlet, flashChamber.inletA) annotation(Line(
      points={{18,-30},{18,-6},{-20,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(flashChamber.outletLiquid, lowPressureValve.inlet) annotation(Line(
      points={{-40,-6},{-70,-6},{-70,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flashChamber.inletB, highPressureValve.outlet) annotation(Line(
      points={{-40,6},{-70,6},{-70,32}},
      color={28,108,200},
      thickness=0.5));
  connect(flashChamber.outletVapor, loopBreaker1.inlet) annotation(Line(
      points={{-20,6},{-12,6}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker1.outlet, highPressureCompressor.inlet) annotation(
    Line(
      points={{8,6},{20,6},{20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(highPressureValve.outlet, vaporQuality.inlet) annotation(Line(
      points={{-70,32},{-70,6},{-78,6}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outletSpec_prescribed, h_dew.y) annotation(Line(points={{-30,-82},{-30,-116},{-49,-116}}, color={0,0,127}));
  connect(loopBreaker.h_out_prescribed, h_dew.y) annotation(Line(points={{-8,-82},{-8,-116},{-49,-116}}, color={0,0,127}));
  connect(h_dew1.y, loopBreaker1.h_out_prescribed) annotation(Line(points={{21,-20},{0,-20},{0,-6}}, color={0,0,127}));
  connect(h_bubble.y, condensor.outletSpec_prescribed) annotation(Line(points={{-21,90},{-38,90},{-38,82}}, color={0,0,127}));
  connect(heatFlow.E_flow_out, evaporator.Q_flow_in) annotation(Line(points={{-59,-90},{-40,-90},{-40,-78}}, color={255,170,85}));
  connect(shaftPower.E_flow_out, losses.E_flow_in) annotation(Line(points={{81.7,0},{88,0}},  color={255,170,85}));
  connect(highPressureCompressor.P_out, shaftPower.E_flow_in[1]) annotation(Line(points={{27,40},{40,40},{40,4},{60,4},{60,-1.5}},color={255,170,85}));
  connect(lowPressureCompressor.P_out, shaftPower.E_flow_in[2]) annotation(Line(points={{25,-40},{46,-40},{46,-2},{60,-2},{60,1.5}},
                                                                                                                                 color={255,170,85}));
  connect(highPressureCompressor.eta_prescribed, inverseBlockConstraints.y1) annotation(Line(points={{32,46},{51,46}}, color={0,0,127}));
  connect(temperatureSensor.inlet, condensor.inlet) annotation(Line(
      points={{32,70},{-18,70}},
      color={28,108,200},
      thickness=0.5));
  connect(temperatureSensor.value_out, inverseBlockConstraints.u1) annotation(Line(points={{50.2,70},{98,70},{98,46},{94,46}}, color={0,0,127}));
  connect(temperature.y, inverseBlockConstraints.u2) annotation(Line(points={{81,46},{88,46}}, color={0,0,127}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-180},{120,140}}),
                                     graphics={
        Text(
          extent={{12,-64},{18,-70}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{12,-6},{18,-12}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-70,-6},{-64,-12}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-70,-64},{-64,-70}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{14,12},{20,6}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{14,70},{20,64}},
          textColor={28,108,200},
          textString="6"),
        Text(
          extent={{-70,70},{-64,64}},
          textColor={28,108,200},
          textString="7"),
        Text(
          extent={{-70,12},{-64,6}},
          textColor={28,108,200},
          textString="8"),
        Polygon(
          points={{-140,80},{-100,80},{-100,100},{-120,100},{-120,140},{-140,140},{-140,80}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-110,130},{-30,110}},
          textColor={238,46,47},
          textString="requires considerInertance = false
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
    Examples of a two stage vapor cycle.
  </p>

  <p>
    This example uses the 
    <a href=\"modelica://Modelica.Blocks.Math.InverseBlockConstraints\">InverseBlockConstraints</a> model
    resulting in implicit nonlinear equations. These equations require suitable start values to be solvable.
  </p>

  <h4>Problem description</h4>

  <p>
    A refrigeration system with two-stage compression operates as follows: The adiabatic <code>lowPressureCompressor</code>
    draws dry saturated vapor (<a href=\"modelica://ThermofluidStream.Media.myMedia.R134a.R134a_ph\">R134a</a>) from the 
    <code>evaporator</code> at <code>1.00 bar</code> and compresses it with an isentropic efficiency 
    of <code>eta_is = 0.900</code> to <code>6.00 bar</code>.
  </p>

  <p>
    The superheated vapor at state <code>2</code> is fed to the intermediate pressure <code>flashChamber</code>. 
    Saturated vapor (state <code>5</code>) is drawn from the <code>flashChamber</code> and compressed in the <code>highPressureCompressor</code> to <code>14.0 bar</code>, 
    reaching a superheated temperature of <code>335 K</code>.
  </p>

  <p>
    After isobaric condensation and subsequent isobaric subcooling to <code>T7 = 300 K</code> in the 
    <code>condenser</code>, the refrigerant is expanded adiabatically in the <code>highPressureValve</code> 
    to the intermediate pressure and returned to the <code>flashChamber</code>.
  </p>

  <p>
    Saturated liquid (state <code>3</code>) is withdrawn from the <code>flashChamber</code>, throttled adiabatically in the <code>lowPressureValve</code> to 
    the evaporator pressure and completely evaporated in the <code>evaporator</code>, closing the loop. 
  </p>
  <p>
    The system is sized to cool <code>75.0 kg</code> (specific heat capacity <code>2 kJ/(kg.K)</code>) in <code>15 min</code> by <code>40 K</code>.
  </p>
  <p>
    The mechanic efficiencies of the compressors are <code>0.95</code>.
  </p>

</html>"));
end NeglectInertance;
