within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles;
model Exercise9TwoStageSteamTurbine "Exercise 8.9: Two-Stage Steam Turbine with Extraction for District Heating [TUM2019]"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
                                                                              constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation(choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation(Placement(transformation(extent={{80,80},{100,100}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pump2(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=5800000) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-20})));
  ThermofluidStream.Idealized.Processes.Adiabatic lowPressureTurbine(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=5000) annotation(Placement(transformation(extent={{50,50},{70,70}})));
  ThermofluidStream.Idealized.Processes.Isobaric steamBoiler(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    specifyOutlet=true,

    T_out_fixed(displayUnit="K") = 723) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,40})));
  ThermofluidStream.Idealized.Processes.Isobaric condensor(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{10,-120},{-10,-100}})));
  Modelica.Blocks.Sources.RealExpression h_bubble(y=Medium.bubbleEnthalpy(Medium.setSat_p(0.05e5)))
    annotation(Placement(transformation(extent={{-50,-140},{-30,-120}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pump1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=5800000) annotation(Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-80,-20})));
  Topology.JunctionT2 mixer(displayInstanceName=true, redeclare package Medium = Medium) annotation(Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-80,10})));
  ThermofluidStream.Idealized.Processes.Adiabatic highPressureTurbine(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=0.710,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=300000) annotation(Placement(transformation(extent={{-30,50},{-10,70}})));
  ThermofluidStream.Topology.SplitterT2
                                     splitter(displayInstanceName=false, redeclare package Medium = Medium) annotation(Placement(transformation(extent={{10,70},{30,50}})));
  Sources.LoopBreaker loopBreaker(
    redeclare package Medium = Medium,
    p_out_fixed(displayUnit="bar") = 5800000,
    T_out_fixed(displayUnit="K") = 723)
                     annotation(Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-60,60})));
  ThermofluidStream.Idealized.Processes.Isobaric heatingNetwork(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed(displayUnit="K") = 323) annotation(Placement(transformation(extent={{10,-90},{-10,-70}})));
  ThermofluidStream.Utilities.showRealValue heatFlowRateHeatingNetwork(
    description="Q_67",
    use_numberPort=false,
    number=heatingNetwork.Q_flow_out,
    displayVariable=false) annotation(Placement(transformation(extent={{-80,-160},{-60,-140}})));
  ThermofluidStream.Utilities.showRealValue efficiency1(
    description="efficiency",
    use_numberPort=false,
    number=(-powerHighPressureTurbine.E_flow - powerLowPressureTurbine.E_flow - pump1.P - pump2.P)/steamBoiler.Q_flow,
    displayVariable=false) annotation(Placement(transformation(extent={{-40,-160},{-20,-140}})));
  EnergyFlow.Sources.FixedEnergyFlow powerHighPressureTurbine(E_flow(displayUnit="kW") = -800000) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-10})));
  EnergyFlow.Components.FixedTransferEfficiency lossesHPTShaft(eta=0.92) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,30})));
  EnergyFlow.Sources.FixedEnergyFlow powerLowPressureTurbine(E_flow(displayUnit="kW") = -200000) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-10})));
  EnergyFlow.Components.FixedTransferEfficiency lossesLPTShaft(eta=0.92) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,30})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="efficiency (incl. heating network)",
    use_numberPort=false,
    number=(-powerHighPressureTurbine.E_flow - powerLowPressureTurbine.E_flow - pump1.P - pump2.P + heatingNetwork.Q_flow_out)/steamBoiler.Q_flow,
    displayVariable=false) annotation(Placement(transformation(extent={{0,-160},{20,-140}})));
equation
  connect(mixer.outlet, steamBoiler.inlet) annotation(Line(
      points={{-80,20},{-80,30}},
      color={28,108,200},
      thickness=0.5));
  connect(lowPressureTurbine.outlet, condensor.inlet)
    annotation(Line(
      points={{70,60},{80,60},{80,-110},{10,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(pump1.outlet, mixer.inletB) annotation(Line(
      points={{-80,-10},{-80,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pump2.outlet, mixer.inletA) annotation(Line(
      points={{-50,-10},{-50,10},{-70,10}},
      color={28,108,200},
      thickness=0.5));
  connect(heatingNetwork.outlet, pump2.inlet)
    annotation(Line(
      points={{-10,-80},{-50,-80},{-50,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(condensor.outlet, pump1.inlet)
    annotation(Line(
      points={{-10,-110},{-80,-110},{-80,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker.outlet, highPressureTurbine.inlet)
    annotation(Line(
      points={{-50,60},{-30,60}},
      color={28,108,200},
      thickness=0.5));
  connect(steamBoiler.outlet, loopBreaker.inlet) annotation(Line(
      points={{-80,50},{-80,60},{-70,60}},
      color={28,108,200},
      thickness=0.5));
  connect(h_bubble.y, condensor.outletSpec_prescribed) annotation(Line(points={{-29,-130},{-10,-130},{-10,-122}}, color={0,0,127}));
  connect(highPressureTurbine.outlet, splitter.inlet) annotation(Line(
      points={{-10,60},{10,60}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter.outletB, lowPressureTurbine.inlet) annotation(Line(
      points={{30,60},{50,60}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter.outletA, heatingNetwork.inlet) annotation(Line(
      points={{20,50},{20,-80},{10,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(powerHighPressureTurbine.E_flow_out, lossesHPTShaft.E_flow_in) annotation(Line(points={{-20,1},{-20,18}}, color={255,170,85}));
  connect(lossesHPTShaft.E_flow_out, highPressureTurbine.P_in) annotation(Line(points={{-20,41},{-20,52}}, color={255,170,85}));
  connect(lossesLPTShaft.E_flow_out, lowPressureTurbine.P_in) annotation(Line(points={{60,41},{60,52}}, color={255,170,85}));
  connect(powerLowPressureTurbine.E_flow_out, lossesLPTShaft.E_flow_in) annotation(Line(points={{60,1},{60,18}}, color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-160},{100,100}}), graphics={
        Text(
          extent={{-80,60},{-74,54}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{2,60},{8,54}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{74,60},{80,54}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-80,-104},{-74,-110}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{74,-104},{80,-110}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-86,-2},{-80,-8}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{-50,-74},{-44,-80}},
          textColor={28,108,200},
          textString="6"),
        Text(
          extent={{-56,10},{-50,4}},
          textColor={28,108,200},
          textString="7"),
        Text(
          extent={{-80,28},{-74,22}},
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
    Example  of steam Rankine combined heat and power (CHP) cycle with a two-stage turbine and an extraction branch for district heating.
  </p>

  <h4>Problem description</h4>

  <p>
    A <code>steamBoiler</code> supplies steam at <code>p1 = 58.0 bar</code> and <code>T1 = 723 K</code>. 
    In the adiabatic <code>highPressureTurbine</code>, which delivers a power output of 
    <code>800 kW</code>, the steam expands to <code>p2 = 3.00 bar</code> with an isentropic efficiency 
    of <code>0.710</code>.
  </p>

  <p>
    Part of the steam is directed to a <code>heatingNetwork</code>, while the remainder expands 
    in the adiabatic <code>lowPressureTurbine</code> to <code>p3 = 50.0 mbar</code>. The <code>lowPressureTurbine</code>
    delivers <code>200 kW</code> at an isentropic efficiency of <code>0.800</code>. 
    The mechanical efficiencies of the turbine shafts are <code>0.920</code>.
  </p>

  <p>
    After the <code>lowPressureTurbine</code>, the water is completely condensed in the 
    <code>condenser</code>. In the <code>heatingNetwork</code>, the steam condenses and the condensate is 
    subcooled to <code>T6 = 323 K</code>. The two mass flows are then pumped by the reversible adiabatic 
    feedwater pumps <strong>pump1</strong> and <strong>pump2</strong> to the boiler pressure 
    <code>p7 = p8 = p1</code> and returned to the cycle via the <code>mixer</code>.
  </p>

  <p>
    The <code>steamBoiler</code>, <code>condenser</code>, <code>heatingNetwork</code>, 
    and <code>mixer</code> operate isobarically. Kinetic and potential energies can be neglected, 
    and liquid water may be treated as incompressible.
  </p>
</html>
"));
end Exercise9TwoStageSteamTurbine;
