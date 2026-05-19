within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise4DieselEngine;
model AdiabaticPerfectGas
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);
  parameter Medium.AbsolutePressure p1=100000 "Pressure before compression";
  parameter Medium.Temperature T1(displayUnit="K")=300 "Temperature before compression";
  parameter Real compressionRatio = 23 "Compression ratio";

  parameter SI.MassFlowRate m_flow = 1 "Mass flow rate";

  final parameter Medium.Density d1 = Medium.density_pT(p1,T1)  "Density before compression";
  final parameter Medium.Density d2 = d1*compressionRatio "Density after compression";

  final parameter SI.SpecificVolume v1 = 1/d1 "Specific volume before compression";
  final parameter SI.SpecificVolume v2 = 1/d2 "Specific volume after compression";

  parameter Medium.IsentropicExponent gamma = 1.4 "Isentropic exponent";
  final parameter Medium.AbsolutePressure p2 = p1*(1/compressionRatio)^(-gamma) "Pressure after compression";

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{80,80},{100,100}})));

  Processes.Adiabatic compression(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    pRatio_fixed=compressionRatio^gamma) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Processes.Isobaric combustion(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    T_out_fixed(displayUnit="K") = 1700) annotation(Placement(transformation(extent={{-30,-10},{-10,10}})));
  Processes.Adiabatic expansion(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    pRatio_fixed=compressionRatio^(-gamma)) annotation (Placement(transformation(extent={{10,-10},{30,10}})));
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
    significantDigits=4) annotation(Placement(transformation(extent={{-78,-90},{-58,-70}})));
  ThermofluidStream.Utilities.showRealValue netWork(
    description="w_n",
    use_numberPort=false,
    number=shaftPower.E_flow_out/m_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-38,-90},{-18,-70}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="eff",
    use_numberPort=false,
    number=shaftPower.E_flow_out/combustion.Q_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{42,-90},{62,-70}})));
  ThermofluidStream.Utilities.showRealValue exhaustTemperature(
    description="T_4",
    use_numberPort=false,
    number=expansion.outlet.state.T,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{0,-90},{20,-70}})));
  EnergyFlow.Components.Sum shaftPower(n_in=3) annotation(Placement(transformation(extent={{70,-40},{90,-20}})));
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
  connect(expansion.P_out, shaftPower.E_flow_in[1]) annotation(Line(points={{20,-7},{20,-32},{70,-32}},      color={255,170,85}));
  connect(compression.P_out, shaftPower.E_flow_in[2]) annotation(Line(points={{-60,-7},{-60,-30},{70,-30}},      color={255,170,85}));
  connect(gasExchange.P_out, shaftPower.E_flow_in[3]) annotation (Line(points={{70,-11},{70,-20},{60,-20},{60,-28},{70,-28}}, color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false, grid={2,2}),
                                           graphics={
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
       <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a> process model (which is only available for <code>systemSpec = Flow</code>)
    </li>
  </ul>
  
  <p>
    The <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a> model defines isentropic efficiency based on shaft work (i.e., changes in specific enthalpy), 
    whereas for a closed-cycle process the isentropic efficiency is commonly defined based on the net expansion work (i.e., changes in specific internal energy).
    In general both definitions are not equivalent and discrepancies can arise. 
    The results will however be identical when the isentropic efficiency is equal to unity, or when the working fluid is an ideal gas with constant isentropic exponent.
  </p>

  <p>
    This setup is based on the fact that the specific work of a thermodynamic cycle is given by the closed integral in the <code>p–v</code> diagram (pressure - specific volume).
    Therefore, integrating with respect to volume, <code>p*dv</code> (boundary work as typically transferred in a piston–cylinder system),
    and integrating with respect to pressure, <code>v*dp</code> (“artificial” shaft work of a dual stationary-flow process),
    yield the same net cycle work, even though the individual contributions of each process step differ.
  </p>
</html>"));
end AdiabaticPerfectGas;
