within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise4DieselEngine;
model SimpleAir
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation(choicesAllMatching=true);
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

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation(Placement(transformation(extent={{-160,78},{-140,98}})));

  Processes.Adiabatic compression(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    pr_fixed=compressionRatio^gamma) annotation(Placement(transformation(extent={{-70,0},{-50,20}})));
  Processes.Isobaric combustion(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    T_out_fixed(displayUnit="K") = 1700) annotation(Placement(transformation(extent={{-30,0},{-10,20}})));
  Processes.Adiabatic expansion(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    pr_fixed=compressionRatio^(-gamma)) annotation(Placement(transformation(extent={{10,0},{30,20}})));
  ThermofluidStream.Idealized.Processes.Isochoric gasExchange(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    T_out_fixed(displayUnit="K") = T1) annotation(Placement(transformation(extent={{50,0},{70,20}})));
  Sources.LoopBreaker_m loopBreaker(
    redeclare package Medium = Medium,
    m_flow_in_par=m_flow,
    p_out_fixed=p1,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.Temperature,
    T_out_fixed=T1) annotation(Placement(transformation(extent={{0,40},{-20,60}})));
  ThermofluidStream.Utilities.showRealValue maximumPressure(
    description="p_max",
    use_numberPort=false,
    number=combustion.outlet.state.p,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-140,-100},{-120,-80}})));
  ThermofluidStream.Utilities.showRealValue netWork(
    description="w_n",
    use_numberPort=false,
    number=shaftPower.E_flow_out/m_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-100,-100},{-80,-80}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="eff",
    use_numberPort=false,
    number=shaftPower.E_flow_out/combustion.Q_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-20,-100},{0,-80}})));
  ThermofluidStream.Utilities.showRealValue exhaustTemperature(
    description="T_4",
    use_numberPort=false,
    number=expansion.outlet.state.T,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-62,-100},{-42,-80}})));
  EnergyFlow.Components.Sum shaftPower(n_in=3) annotation(Placement(transformation(extent={{80,-30},{100,-10}})));
equation
  connect(compression.outlet, combustion.inlet)
    annotation(Line(
      points={{-50,10},{-30,10}},
      color={28,108,200},
      thickness=0.5));
  connect(combustion.outlet, expansion.inlet)
    annotation(Line(
      points={{-10,10},{10,10}},
      color={28,108,200},
      thickness=0.5));
  connect(expansion.outlet, gasExchange.inlet)
    annotation(Line(
      points={{30,10},{50,10}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker.outlet, compression.inlet)
    annotation(Line(
      points={{-20,50},{-80,50},{-80,10},{-70,10}},
      color={28,108,200},
      thickness=0.5));
  connect(gasExchange.outlet, loopBreaker.inlet)
    annotation(Line(
      points={{70,10},{80,10},{80,50},{0,50}},
      color={28,108,200},
      thickness=0.5));
  connect(expansion.P_out, shaftPower.E_flow_in[1]) annotation(Line(points={{20,3},{20,-22},{80,-22}},       color={255,170,85}));
  connect(compression.P_out, shaftPower.E_flow_in[2]) annotation(Line(points={{-60,3},{-60,-20},{80,-20}},       color={255,170,85}));
  connect(gasExchange.P_out, shaftPower.E_flow_in[3]) annotation(Line(points={{70,-1},{70,-18},{80,-18}}, color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-100},{180,100}}), graphics={
        Text(
          extent={{-46,16},{-40,10}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-6,16},{0,10}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{34,16},{40,10}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{-80,56},{-74,50}},
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
    Example of an Diesel engine cycle.
  </p>

  <p>
    This example uses the <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.SimpleAir\">SimpleAir</a> medium (ideal gas with <code>R = 287 J/(kg·K)</code> and <code>gamma = 1.40</code>).
  </p>

  <p>
    This example uses the 
    <a href=\"modelica://ThermoFluidStream.Idealized.Processes.AdiabaticCycle\">AdiabaticCycle</a> model, which uses the outlet density as the setpoint. 
    For perfect gas this does not yield an implicit nonlinear equations.
  </p> 

  <h4>Problem description</h4>

  <p>
    A four-stroke Diesel engine can be idealized using the following cycle:
  </p>

  <ul>
    <li><code>1 &rarr; 2</code>: Isentropic compression (T1 = 300 K, p1 = 1.00 bar, compression ratio &phi; = 23.0)</li>
    <li><code>2 &rarr; 3</code>: Isobaric heat addition (combustion, T3 = 1700 K)</li>
    <li><code>3 &rarr; 4</code>: Isentropic expansion (V4 = V1)</li>
    <li><code>4 &rarr; 1</code>: Isochoric heat rejection (in reality achieved via gas exchange of the displaced volume)</li>
  </ul>

  <p>
    For the entire cycle, air properties can be used, assuming an ideal gas with 
    <code>R = 287 J/kg·K</code> and <code>&gamma; = 1.40</code>.
  </p>

  <p>
    The <a href=\"modelica://ThermoFluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a> model should only be used to represent 
    a periodic closed-cycle process when the isentropic efficiency is equal to unity, or when the working fluid is an ideal gas with constant isentropic exponent.
    Otherwise, discrepancies arise because the isentropic efficiency is defined based on shaft work (i.e., changes in specific enthalpy) in the first case, 
    and based on net expansion work (i.e., changes in specific internal energy) in the second case.
  </p>

</html>"));
end SimpleAir;
