within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise3OttoEngine;
model PerfectGasAdiabaticFlow
  extends ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise3OttoEngine.BaseModel(redeclare package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir);

  parameter Medium.IsentropicExponent gamma = 1.4 "Isentropic exponent";

  ThermofluidStream.Idealized.Processes.Adiabatic compression(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=1,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=p1*(1/compressionRatio)^(-gamma)) annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
  ThermofluidStream.Idealized.Processes.Isochoric combustion(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    T_out_fixed(displayUnit="K") = T3) annotation(Placement(transformation(extent={{-30,0},{-10,20}})));
  ThermofluidStream.Idealized.Processes.Adiabatic expansion(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=1,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{10,0},{30,20}})));
  ThermofluidStream.Idealized.Processes.Isochoric gasExchange(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    T_out_fixed(displayUnit="K") = T1) annotation(Placement(transformation(extent={{50,0},{70,20}})));
  Modelica.Blocks.Sources.RealExpression outletPressure(y=Medium.pressure(combustion.outlet.state)*(compressionRatio)^(-gamma)) annotation(
    Placement(transformation(extent={{60,-30},{40,-10}})));
  Sources.LoopBreaker_m loopBreaker(
    redeclare package Medium = Medium,
    m_flow_in_par=1,
    p_out_fixed=p1,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.Temperature,
    T_out_fixed=T1) annotation(Placement(transformation(extent={{0,40},{-20,60}})));
  ThermofluidStream.Utilities.showRealValue maximumPressure(
    description="p_max",
    use_numberPort=false,
    number=combustion.outlet.state.p,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-60,-100},{-40,-80}})));
  ThermofluidStream.Utilities.showRealValue netWork(
    description="w_n",
    use_numberPort=false,
    number=shaftPower.E_flow_out/expansion.m_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-20,-100},{0,-80}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="eff",
    use_numberPort=false,
    number=shaftPower.E_flow_out/combustion.Q_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{20,-100},{40,-80}})));
  EnergyFlow.Components.Sum shaftPower(n_in=4) annotation(Placement(transformation(extent={{100,-50},{120,-30}})));
equation
  connect(compression.outlet, combustion.inlet) annotation(
    Line(
      points={{-50,10},{-30,10}},
      color={28,108,200},
      thickness=0.5));
  connect(combustion.outlet, expansion.inlet) annotation(
    Line(
      points={{-10,10},{10,10}},
      color={28,108,200},
      thickness=0.5));
  connect(expansion.outlet, gasExchange.inlet) annotation(
    Line(
      points={{30,10},{50,10}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker.outlet, compression.inlet) annotation(
    Line(
      points={{-20,50},{-80,50},{-80,10},{-70,10}},
      color={28,108,200},
      thickness=0.5));
  connect(gasExchange.outlet, loopBreaker.inlet) annotation(
    Line(
      points={{70,10},{80,10},{80,50},{0,50}},
      color={28,108,200},
      thickness=0.5));
  connect(outletPressure.y, expansion.outletSpec_prescribed) annotation(Line(points={{39,-20},{30,-20},{30,-2}}, color={0,0,127}));
  connect(compression.P_out, shaftPower.E_flow_in[1]) annotation(Line(points={{-60,3},{-60,-44},{100,-44},{100,-42.25}},
                                                                                                                  color={255,170,85}));
  connect(expansion.P_out, shaftPower.E_flow_in[2]) annotation(Line(points={{20,3},{20,-40.75},{100,-40.75}},color={255,170,85}));
  connect(combustion.P_out, shaftPower.E_flow_in[3]) annotation(Line(points={{-10,-1},{-10,-42},{100,-42},{100,-39.25}}, color={255,170,85}));
  connect(gasExchange.P_out, shaftPower.E_flow_in[4]) annotation(Line(points={{70,-1},{70,-37.75},{100,-37.75}}, color={255,170,85}));
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
    Example of an otto engine cycle.
  </p>

  <p>
    This example uses the <a href=\"modelica://ThermofluidStream.Media.myMedia.Air.SimpleAir\">SimpleAir</a> medium (ideal gas with <code>R = 287 J/(kg·K)</code> and <code>gamma = 1.40</code>).
  </p>

  <p>
    This example uses the 
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a> model, which uses the outlet pressure as the setpoint. 
    For perfect gas the outlet pressure can be calculated explicetly.
  </p> 
 
  <h4>Problem description</h4>
  
  <p>
    A four-stroke Otto engine can be idealized using the following cycle:
  </p>

  <ul>
    <li><code>1 &rarr; 2</code>: Isentropic compression (T1 = 300 K, p1 = 1.00 bar, compression ratio &phi; = 10.0)</li>
    <li><code>2 &rarr; 3</code>: Isochoric heat addition (combustion, T3 = 2200 K)</li>
    <li><code>3 &rarr; 4</code>: Isentropic expansion (V4 = V1)</li>
    <li><code>4 &rarr; 1</code>: Isochoric heat rejection (in reality achieved via gas exchange of the displaced volume)</li>
  </ul>

  <p>
    The <a href=\"modelica://ThermofluidStream.Idealized.Processes.Adiabatic\">Adiabatic</a> model should only be used to represent 
    a periodic closed-cycle process when the isentropic efficiency is equal to unity, or when the working fluid is an ideal gas with constant isentropic exponent.
    Otherwise, discrepancies arise because the isentropic efficiency is defined based on shaft work (i.e., changes in specific enthalpy) in the first case, 
    and based on net expansion work (i.e., changes in specific internal energy) in the second case.
  </p>
</html>"));
end PerfectGasAdiabaticFlow;
