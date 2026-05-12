within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise4DieselEngine;
model Polytropic
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir (T_max=2000)
                                                                             constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);
  parameter Medium.AbsolutePressure p1=100000 "Pressure before compression";
  parameter Medium.Temperature T1(displayUnit="K")=300 "Temperature before compression";
  parameter Real compressionRatio = 23 "Compression ratio";
  parameter Medium.Density rho1 = Medium.density_pT(p1,T1) "Density before compression";

  parameter SI.MassFlowRate m_flow = 1 "Mass flow rate";
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{-160,78},{-140,98}})));

  Processes.PolytropicPerfectGas
                           compression(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
    rhoRatio_fixed=compressionRatio)
                      annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
  Processes.Isobaric combustion(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,
    T_out_fixed(displayUnit="K") = 1700) annotation (Placement(transformation(extent={{-30,0},{-10,20}})));
  Processes.PolytropicPerfectGas
                           expansion(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletDensity,
    rho_out_fixed=rho1)
                      annotation (Placement(transformation(extent={{10,0},{30,20}})));
  ThermofluidStream.Idealized.Processes.Isochoric gasExchange(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Cycle.Isochoric.OutletTemperature,
    T_out_fixed(displayUnit="K") = T1) annotation (Placement(transformation(extent={{50,0},{70,20}})));
  Sources.LoopBreaker_m loopBreaker(
    redeclare package Medium = Medium,
    m_flow_in_par=m_flow,
    p_out_fixed=p1,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.Temperature,
    T_out_fixed=T1) annotation (Placement(transformation(extent={{0,40},{-20,60}})));
  ThermofluidStream.Utilities.showRealValue maximumPressure(
    description="p_max",
    use_numberPort=false,
    number=combustion.outlet.state.p,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{-140,-100},{-120,-80}})));
  ThermofluidStream.Utilities.showRealValue netWork(
    description="w_n",
    use_numberPort=false,
    number=-shaftPower.E_flow_out/m_flow,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="eff",
    use_numberPort=false,
    number=shaftPower.E_flow_out/combustion.Q_flow,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  ThermofluidStream.Utilities.showRealValue exhaustTemperature(
    description="T_4",
    use_numberPort=false,
    number=expansion.outlet.state.T,
    displayVariable=false,
    significantDigits=4) annotation (Placement(transformation(extent={{-62,-100},{-42,-80}})));
  EnergyFlow.Components.Sum shaftPower(n_in=3) annotation (Placement(transformation(extent={{48,-46},{60,-34}})));
equation
  connect(compression.outlet, combustion.inlet)
    annotation (Line(
      points={{-50,10},{-30,10}},
      color={28,108,200},
      thickness=0.5));
  connect(combustion.outlet, expansion.inlet)
    annotation (Line(
      points={{-10,10},{10,10}},
      color={28,108,200},
      thickness=0.5));
  connect(expansion.outlet, gasExchange.inlet)
    annotation (Line(
      points={{30,10},{50,10}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker.outlet, compression.inlet)
    annotation (Line(
      points={{-20,50},{-80,50},{-80,10},{-70,10}},
      color={28,108,200},
      thickness=0.5));
  connect(gasExchange.outlet, loopBreaker.inlet)
    annotation (Line(
      points={{70,10},{80,10},{80,50},{0,50}},
      color={28,108,200},
      thickness=0.5));
  connect(expansion.P_out, shaftPower.E_flow_in[1]) annotation (Line(points={{20,3},{20,-41.2},{48,-41.2}},   color={255,170,85}));
  connect(compression.P_out, shaftPower.E_flow_in[2]) annotation (Line(points={{-60,3},{-60,-40},{48,-40}},       color={255,170,85}));
  connect(combustion.P_out, shaftPower.E_flow_in[3]) annotation (Line(points={{-30,-1},{-30,-38.8},{48,-38.8}}, color={255,170,85}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
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
</html>", info=""));
end Polytropic;
