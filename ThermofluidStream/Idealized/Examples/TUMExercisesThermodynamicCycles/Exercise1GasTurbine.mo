within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles;
model Exercise1GasTurbine "Exercise 8.1: Gas Turbine Cycle with Intercooling and Recuperation [TUM2019]"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{-100,80},{-80,100}})));

  ThermofluidStream.Idealized.Processes.Adiabatic lowPressureCompressor(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.9,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=350000) annotation(Placement(transformation(extent={{-100,-10},{-80,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic turbine(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IdealGasConstantGamma "p*v = R*T, gamma = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.9,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=100000) annotation(Placement(transformation(extent={{100,-10},{120,10}})));
  ThermofluidStream.Boundaries.Source
                                source(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par(displayUnit="K") = 300) annotation(Placement(transformation(extent={{-140,-10},{-120,10}})));
  ThermofluidStream.Idealized.Processes.Isobaric combustion(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed(displayUnit="K") = 1400) annotation(Placement(transformation(extent={{60,-10},{80,10}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="eta",
    use_numberPort=false,
    number=losses.E_flow_out/combustion.Q_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{100,-80},{120,-60}})));
  Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=5.8) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,70})));
  ThermofluidStream.Idealized.Processes.Isobaric cooler(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed(displayUnit="K") = 320) annotation(Placement(transformation(extent={{-60,-10},{-40,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic highPressureCompressor(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.9,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=1000000) annotation(Placement(transformation(extent={{-20,-10},{0,10}})));
  ThermofluidStream.Utilities.showRealValue lowPressureCompressorOutletTemperature(
    description="T_2",
    use_numberPort=false,
    number=lowPressureCompressor.outlet.state.T,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-140,-80},{-120,-60}})));
  ThermofluidStream.Utilities.showRealValue highPressureCompressorOutletTemperature(
    description="T_4",
    use_numberPort=false,
    number=highPressureCompressor.outlet.state.T,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-100,-80},{-80,-60}})));
  ThermofluidStream.Utilities.showRealValue turbineOutletTemperature(
    description="T_7",
    use_numberPort=false,
    number=turbine.outlet.state.T,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-60,-80},{-40,-60}})));
  ThermofluidStream.Utilities.showRealValue recuperatorOutletTemperatureB(
    description="T_8",
    use_numberPort=false,
    number=recuperatorB.outlet.state.T,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-20,-80},{0,-60}})));
  ThermofluidStream.Utilities.showRealValue heatFlowRateRecuperator(
    description="Q_flow_45",
    use_numberPort=false,
    number=recuperatorA.Q_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{20,-80},{40,-60}})));
  ThermofluidStream.Utilities.showRealValue heatFlowRateCombustion(
    description="Q_flow_56",
    use_numberPort=false,
    number=combustion.Q_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{60,-80},{80,-60}})));
  Processes.Isobaric recuperatorA(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed(displayUnit="K") = 750) annotation(Placement(transformation(extent={{20,10},{40,-10}})));
  Processes.Isobaric recuperatorB(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.TemperatureDifference,

    T_out_fixed(displayUnit="K")) annotation(Placement(transformation(extent={{40,20},{20,40}})));
  EnergyFlow.Components.FixedTransferEfficiency losses(eta=0.97) annotation(Placement(transformation(extent={{160,-40},{180,-20}})));
  EnergyFlow.Components.Sum shaftPower(n_in=3) annotation(Placement(transformation(extent={{120,-40},{140,-20}})));
equation
  connect(source.outlet, lowPressureCompressor.inlet) annotation(
    Line(
      points={{-120,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(lowPressureCompressor.outlet, cooler.inlet) annotation(
    Line(
      points={{-80,0},{-60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(cooler.outlet, highPressureCompressor.inlet) annotation(
    Line(
      points={{-40,0},{-20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(combustion.outlet, turbine.inlet) annotation(
    Line(
      points={{80,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(recuperatorB.outlet, sink.inlet) annotation(Line(
      points={{20,30},{10,30},{10,60}},
      color={28,108,200},
      thickness=0.5));
  connect(recuperatorB.inlet, turbine.outlet) annotation(Line(
      points={{40,30},{134,30},{134,0},{120,0}},
      color={28,108,200},
      thickness=0.5));
  connect(recuperatorA.inlet, highPressureCompressor.outlet) annotation(Line(
      points={{20,0},{0,0}},
      color={28,108,200},
      thickness=0.5));
  connect(recuperatorA.outlet, combustion.inlet) annotation(Line(
      points={{40,0},{60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(shaftPower.E_flow_out, losses.E_flow_in) annotation(Line(points={{141.7,-30},{158,-30}},  color={255,170,85}));
  connect(turbine.P_out, shaftPower.E_flow_in[1]) annotation(Line(points={{110,-7},{110,-32},{120,-32}},     color={255,170,85}));
  connect(highPressureCompressor.P_out, shaftPower.E_flow_in[2]) annotation(Line(points={{-10,-7},{-10,-30},{120,-30}}, color={255,170,85}));
  connect(lowPressureCompressor.P_out, shaftPower.E_flow_in[3]) annotation(Line(points={{-90,-7},{-90,-28},{120,-28}},     color={255,170,85}));
  connect(recuperatorA.Q_flow_out, recuperatorB.Q_flow_in) annotation(Line(points={{30,7},{30,22}}, color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-100},{180,100}}), graphics={
        Text(
          extent={{-114,6},{-108,0}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-74,6},{-68,0}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-34,6},{-28,0}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{6,6},{12,0}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{46,6},{52,0}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{86,6},{92,0}},
          textColor={28,108,200},
          textString="6"),
        Text(
          extent={{122,6},{128,0}},
          textColor={28,108,200},
          textString="7"),
        Text(
          extent={{10,36},{16,30}},
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

  <h4>Problem Description</h4>

  <p>
    A gas turbine features a two-stage compression with intercooling and a recuperator. 
    Ambient air (<code>1.00 bar</code>, <code>300 K</code>) is first compressed in the adiabatic 
    <code>lowPressureCompressor</code> (<code>eta_is = 0.9</code>) to <code>3.50 bar</code>. 
    Subsequently, the air is cooled isobarically in the <code>cooler</code> to <code>320 K</code> 
    before entering the <code>highPressureCompressor</code>, where it is further compressed 
    (<code>eta_is = 0.9</code>) to <code>10.0 bar</code>.
  </p>

  <p>
    The compressed air is then preheated in the isobaric heat exchanger <strong>recuperatorA</strong> 
    using turbine exhaust gases, increasing its temperature to <code>750 K</code>. 
    In the isobaric <code>combustion</code> chamber, the temperature is raised further to 
    <code>1400 K</code>. The hot gas expands in the <code>turbine</code> 
    (<code>eta_is = 0.9</code>) down to ambient pressure (<code>1.00 bar</code>).
    The turbine supplies power to both compressors and the generator, with a mechanical 
    shaft efficiency of <code>eta = 0.970</code>.
  </p>

  <p>
    Downstream of the <code>turbine</code>, the exhaust gas is cooled isobarically in the heat exchanger 
    <strong>recuperatorB</strong>. The mass flow rate is assumed constant at 
    <code>5.80 kg/s</code>, neglecting the contribution of the fuel mass flow.
  </p>

  <h4>Possible Modifications</h4>

  <p>
    The following aspects can be varied for further analysis:
  </p>

  <ul>
    <li>
      The medium model:
      <ul>
        <li>
          <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.SimpleAir\">SimpleAir</a>: 
          perfect gas with constant isobaric heat capacity and isentropic exponent 
          (<code>R = 287 J/(kg.K)</code>, <code>gamma = 1.40</code>)
        </li>
        <li>
          <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.DryAirNasa\">DryAirNasa</a>: 
          ideal gas with temperature-dependent <code>cp</code> and <code>gamma</code>
        </li>
        <li>
          <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.ReferenceMoistAir\">ReferenceMoistAir</a>: 
          ideal mixture of air and water; the water mass fraction <code>X</code> must be specified 
          in the <code>source</code>
        </li>
      </ul>
    </li>

    <li>
      The adiabatic thermodynamic model 
      (<code>FullMedium</code>, <code>IdealGasConstantGamma</code>, or <code>PerfectGas</code>), 
      see 
      <a href=\"modelica://ThermoFluidStream.Idealized.UsersGuide.AdiabaticThermodynamicModels\">
        UsersGuide.AdiabaticThermodynamicModels
      </a>.
    </li>
  </ul>

  <h4>Known issues</h4>

  <ul>
    <li>
      <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.MoistAir\">MoistAir</a> cannot be used, 
      as it is restricted to temperatures below the critical point of water (<code>647 K</code>).
    </li>
    <li>
      <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.ReferenceAir\">ReferenceAir</a> 
      (e.g. <code>ReferenceAir.Air_ph</code>) fails when used with the 
      <a href=\"modelica://ThermoFluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium\">
        FullMedium
      </a> thermodynamic model, but works with the other formulations.
    </li>
  </ul>

</html>
"));
end Exercise1GasTurbine;
