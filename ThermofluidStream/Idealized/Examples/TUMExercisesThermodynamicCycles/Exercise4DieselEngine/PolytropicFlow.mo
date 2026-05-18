within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise4DieselEngine;
model PolytropicFlow
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir (T_max=2000)
                                                                             constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);
  parameter Medium.AbsolutePressure p1=100000 "Pressure before compression";
  parameter Medium.Temperature T1(displayUnit="K")=300 "Temperature before compression";
  parameter Real compressionRatio = 23 "Compression ratio";
  parameter Medium.Density rho1 = Medium.density_pT(p1,T1) "Density before compression";

  parameter SI.MassFlowRate m_flow = 1 "Mass flow rate";
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{80,80},{100,100}})));

  Processes.PolytropicPerfectGas
                           compression(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
    rhoRatio_fixed=compressionRatio)
                     annotation(Placement(transformation(extent={{-70,-10},{-50,10}})));
  Processes.Isobaric combustion(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    T_out_fixed(displayUnit="K") = 1700) annotation(Placement(transformation(extent={{-30,-10},{-10,10}})));
  Processes.PolytropicPerfectGas
                           expansion(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletDensity,
    rho_out_fixed=rho1)
                     annotation(Placement(transformation(extent={{10,-10},{30,10}})));
  ThermofluidStream.Idealized.Processes.Isochoric gasExchange(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    T_out_fixed(displayUnit="K") = T1) annotation(Placement(transformation(extent={{50,-10},{70,10}})));
  Sources.LoopBreaker_m loopBreaker(
    redeclare package Medium = Medium,
    m_flow_in_par=m_flow,
    p_out_fixed=p1,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.Temperature,
    T_out_fixed=T1) annotation(Placement(transformation(extent={{10,30},{-10,50}})));
  ThermofluidStream.Utilities.showRealValue maximumPressure(
    description="p_max",
    use_numberPort=false,
    number=combustion.outlet.state.p,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-68,-90},{-48,-70}})));
  ThermofluidStream.Utilities.showRealValue netWork(
    description="w_n",
    use_numberPort=false,
    number=-shaftPower.E_flow_out/m_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-28,-90},{-8,-70}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="eff",
    use_numberPort=false,
    number=shaftPower.E_flow_out/combustion.Q_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{52,-90},{72,-70}})));
  ThermofluidStream.Utilities.showRealValue exhaustTemperature(
    description="T_4",
    use_numberPort=false,
    number=expansion.outlet.state.T,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{10,-90},{30,-70}})));
  EnergyFlow.Components.Sum shaftPower(n_in=3) annotation(Placement(transformation(extent={{70,-50},{90,-30}})));
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
      points={{-10,40},{-80,40},{-80,0},{-70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(gasExchange.outlet, loopBreaker.inlet) annotation(
    Line(
      points={{70,0},{80,0},{80,40},{10,40}},
      color={28,108,200},
      thickness=0.5));
  connect(expansion.P_out, shaftPower.E_flow_in[1]) annotation(Line(points={{20,-7},{20,-42},{70,-42}},      color={255,170,85}));
  connect(compression.P_out, shaftPower.E_flow_in[2]) annotation(Line(points={{-60,-7},{-60,-40},{70,-40}},      color={255,170,85}));
  connect(gasExchange.P_out, shaftPower.E_flow_in[3]) annotation (Line(points={{70,-11},{70,-24},{50,-24},{50,-38},{70,-38}}, color={255,170,85}));
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
    Example of an Diesel engine cycle. See <a href=\"modelica://ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise4DieselEngine.PolytropicCycle\">Exercise4DieselEngine.PolytropicCycle</a> 
    for the problem description.
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
      <code>systemSpec = Flow</code>
      (<a href=\"modelica://ThermofluidStream.Idealized.Types.SystemModel\">SystemModel</a>)
    </li>
  </ul>

  <p>
    This setup is based on the fact that the specific work of a thermodynamic cycle is given by the closed integral in the <code>p–v</code> diagram (pressure - specific volume).
    Therefore, integrating with respect to volume, <code>p*dv</code> (boundary work as typically transferred in a piston–cylinder system),
    and integrating with respect to pressure, <code>v*dp</code> (“artificial” shaft work of a dual stationary-flow process),
    yield the same net cycle work, even though the individual contributions of each process step differ.
  </p>
</html>"));
end PolytropicFlow;
