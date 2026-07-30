within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise5TurboChargedDieselEngine;
model CyclePseudoInversion "Turbocharged diesel engine"
  extends ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise5TurboChargedDieselEngine.BaseModel;

  Medium.Density rho4 = Medium.density(engineCompression.outlet.state) "Density after compression";
  SI.Volume V4 = m3/rho4 "Volume top dead center (per cylinder)";
  SI.Volume V_h = V3-V4 "Engine displacement volume (per cylinder)";
  SI.MassFlowRate m_flow = rho3*V_h*z*Modelica.Units.Conversions.to_Hz(w)/2 "Averaged mass flow rate (total)";

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{140,80},{160,100}})));

  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas engineCompression(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure,
    p_out_fixed=p4)      annotation (Placement(transformation(extent={{60,30},{40,10}})));
  ThermofluidStream.Idealized.Processes.Isobaric combustion(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    T_out_fixed(displayUnit="K") = T5)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,40})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas engineExpansion(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletDensity,
    rho_out_fixed=rho3) annotation (Placement(transformation(extent={{40,50},{60,70}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressor(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=p2) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  ThermofluidStream.Idealized.Processes.Isobaric cooler(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    T_out_fixed(displayUnit="K") = T1) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p1,
    T0_par(displayUnit="K") = T1) annotation(Placement(transformation(extent={{-120,-10},{-100,10}})));
  ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-100,-70},{-120,-50}})));
  Modelica.Blocks.Sources.RealExpression massFlowRate(y=m_flow) annotation (Placement(transformation(extent={{-150,-70},{-130,-50}})));
  ThermofluidStream.Idealized.Processes.Adiabatic turbine(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=100000) annotation (Placement(transformation(extent={{-60,-50},{-80,-70}})));
  Modelica.Blocks.Sources.RealExpression pseudoSourcePower(y(
      unit="W") = 0) annotation(Placement(transformation(extent={{-50,-50},{-30,-30}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic valve(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{60,-50},{40,-70}})));
  ThermofluidStream.Idealized.EnergyFlow.Components.Sum shaftPower(n_in=5) annotation (Placement(transformation(extent={{130,26},{150,46}})));
  ThermofluidStream.Idealized.EnergyFlow.Components.Sum pseudoSource(n_in=2) annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  ThermofluidStream.Idealized.Processes.FlowWork inletFlowWork(redeclare package Medium = Medium, boundary=ThermofluidStream.Idealized.Types.FlowWorkBoundary.Inlet) annotation (Placement(transformation(extent={{90,30},{70,10}})));
  ThermofluidStream.Idealized.Processes.FlowWork outletFlowWork(redeclare package Medium = Medium, boundary=ThermofluidStream.Idealized.Types.FlowWorkBoundary.Outlet) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={80,60})));
  Modelica.Blocks.Continuous.Integrator integrator(
    k=30,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
              annotation(Placement(transformation(extent={{10,-50},{30,-30}})));
  Modelica.Blocks.Math.Feedback feedback annotation(Placement(transformation(extent={{-20,-30},{0,-50}})));

  ThermofluidStream.Utilities.showRealValue massFlowRate1(
    description="m_flow",
    use_numberPort=false,
    number=m_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{-20,-100},{0,-80}})));
  ThermofluidStream.Utilities.showRealValue turbineWork(
    description="P_TRB",
    use_numberPort=false,
    number=-compressor.P,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{20,-100},{40,-80}})));
  ThermofluidStream.Utilities.showRealValue power(
    description="P",
    use_numberPort=false,
    number=shaftPower.E_flow_out,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{58,-100},{78,-80}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="eff",
    use_numberPort=false,
    number=shaftPower.E_flow_out/combustion.Q_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{100,-100},{120,-80}})));
equation
  connect(engineCompression.outlet, combustion.inlet) annotation(Line(
      points={{40,20},{20,20},{20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(combustion.outlet, engineExpansion.inlet) annotation(Line(
      points={{20,50},{20,60},{40,60}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.outlet, cooler.inlet) annotation(Line(
      points={{-60,0},{-40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, compressor.inlet) annotation(Line(
      points={{-100,0},{-80,0}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate.y, sink.m_flow_prescribed) annotation (Line(points={{-129,-60},{-112,-60}}, color={0,0,127}));
  connect(turbine.outlet, sink.inlet) annotation(Line(
      points={{-80,-60},{-100,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(valve.outlet, turbine.inlet) annotation(Line(
      points={{40,-60},{-60,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.P_out, pseudoSource.E_flow_in[1]) annotation(Line(points={{-70,-7},{-70,-21.5},{-60,-21.5}},     color={255,170,85}));
  connect(turbine.P_out, pseudoSource.E_flow_in[2]) annotation(Line(points={{-70,-53},{-70,-18.5},{-60,-18.5}},    color={255,170,85}));
  connect(inletFlowWork.outlet, engineCompression.inlet) annotation(Line(
      points={{70,20},{60,20}},
      color={28,108,200},
      thickness=0.5));
  connect(inletFlowWork.inlet, cooler.outlet) annotation(Line(
      points={{90,20},{100,20},{100,0},{-20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(engineExpansion.outlet, outletFlowWork.inlet) annotation(Line(
      points={{60,60},{70,60}},
      color={28,108,200},
      thickness=0.5));
  connect(inletFlowWork.P_inlet_out, shaftPower.E_flow_in[1]) annotation(Line(points={{90,31},{90,32},{130,32},{130,33.6}},
                                                                                                                          color={255,170,85}));
  connect(engineCompression.P_out, shaftPower.E_flow_in[2]) annotation(Line(points={{50,27},{50,34},{130,34},{130,34.8}},color={255,170,85}));
  connect(combustion.P_out, shaftPower.E_flow_in[3]) annotation(Line(points={{31,30},{36,30},{36,36},{130,36}},      color={255,170,85}));
  connect(engineExpansion.P_out, shaftPower.E_flow_in[4]) annotation(Line(points={{50,53},{50,38},{130,38},{130,37.2}},
                                                                                                                   color={255,170,85}));
  connect(outletFlowWork.P_outlet_out, shaftPower.E_flow_in[5]) annotation(Line(points={{90,49},{90,40},{130,40},{130,38.4}},
                                                                                                                        color={255,170,85}));
  connect(outletFlowWork.outlet, valve.inlet) annotation(Line(
      points={{90,60},{110,60},{110,-60},{60,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(integrator.y, valve.outletSpec_prescribed) annotation(Line(points={{31,-40},{40,-40},{40,-48}},
                                                                                                        color={0,0,127}));
  connect(pseudoSourcePower.y, feedback.u1) annotation(Line(points={{-29,-40},{-18,-40}}, color={0,0,127}));
  connect(pseudoSource.E_flow_out, feedback.u2) annotation(Line(points={{-38.3,-20},{-10,-20},{-10,-32}}, color={255,170,85}));
  connect(feedback.y, integrator.u) annotation(Line(points={{-1,-40},{8,-40}},    color={0,0,127}));

  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(
        extent={{-160,-100},{160,100}}),
      graphics={
        Text(
          extent={{-96,6},{-90,0}},
          textColor={28,108,200},
          textString="1"),
        Rectangle(
          extent={{0,76},{120,2}},
          lineColor={255,255,255},
          fillColor={200,200,200},
          fillPattern=FillPattern.Sphere),
        Text(
          extent={{0,76},{30,66}},
          textColor={0,0,0},
          textString="Engine"),
        Text(
          extent={{-56,6},{-50,0}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-16,6},{-10,0}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{20,26},{26,20}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{20,66},{26,60}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{62,66},{68,60}},
          textColor={28,108,200},
          textString="6"),
        Text(
          extent={{-46,-54},{-40,-60}},
          textColor={28,108,200},
          textString="7"),
        Text(
          extent={{-94,-54},{-88,-60}},
          textColor={28,108,200},
          textString="8")}),
    Documentation(
      info="<html>
  <p>
    Example of a turbocharged Diesel engine cycle. See 
    <a href=\"modelica://ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise5TurboChargedDieselEngine\">TUMExercisesThermodynamicCycles.Exercise5TurboChargedDieselEngine</a> for the problem description.
  </p>

  <p>
    This example makes use of the <code>systemSpec = Cycle</code> <a href=\"modelica://ThermofluidStream.Idealized.Types.SystemModel\">SystemModel</a> for the Diesel engine.
  </p>

  <p>
    When coupling models configured with <code>systemSpec = Cycle</code> and <code>systemSpec = Flow</code>, 
    the <a href=\"modelica://ThermofluidStream.Idealized.Processes.FlowWork\">FlowWork</a> model is required, 
    since flow work must be treated explicitly to ensure a consistent energy balance between both representations.
  </p>

  <p>
    A \"pseudo controller\" is used to avoid the implicit nonlinear equation.
  </p>
</html>",
      revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end CyclePseudoInversion;
