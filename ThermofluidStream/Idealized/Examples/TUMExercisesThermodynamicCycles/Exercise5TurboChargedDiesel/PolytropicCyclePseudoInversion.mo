within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise5TurboChargedDiesel;
model PolytropicCyclePseudoInversion "Turbocharged diesel engine"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  parameter SI.AngularVelocity w(displayUnit="rpm") = 209.43951023932 "Engine speed";
  parameter Integer z = 6 "Number of cylinders";
  parameter SI.Volume V3(displayUnit="ml") = 0.0025 "Volume bottom dead center (per cylinder)";

  parameter Medium.Temperature T1(displayUnit="K") = 300 "Environmental temperature";
  parameter Medium.AbsolutePressure p1 = 100000 "Environmental pressure";
  parameter Medium.AbsolutePressure p2 = 123000 "Compressor outlet pressure";

  final parameter Medium.ThermodynamicState state3 = Medium.setState_pT(p2,T1) "Engine inlet state";
  final parameter Medium.Density rho3 = Medium.density(state3) "Density before compression";
  final parameter SI.Mass m3 = rho3*V3 "Mass bottom dead center (per cylinder)";

  Medium.Density rho4 = Medium.density(engineCompression.outlet.state) "Density after compression";
  SI.Volume V4 = m3/rho4 "Volume top dead center (per cylinder)";
  SI.Volume V_h = V3-V4 "Engine displacement volume";
  SI.MassFlowRate m_flow = rho3*V_h*z*Modelica.Units.Conversions.to_Hz(w)/2 "Averaged mass flow rate";

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{220,60},{240,80}})));

  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas engineCompression(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure,
    p_out_fixed=8062000) annotation (Placement(transformation(extent={{20,-10},{0,-30}})));
  ThermofluidStream.Idealized.Processes.Isobaric combustion(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    T_out_fixed(displayUnit="K") = 1700) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,0})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas engineExpansion(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletDensity,
    rho_out_fixed=rho3) annotation (Placement(transformation(extent={{0,10},{20,30}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressor(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=p2) annotation (Placement(transformation(extent={{-120,-46},{-100,-26}})));
  ThermofluidStream.Idealized.Processes.Isobaric cooler(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    T_out_fixed(displayUnit="K") = T1) annotation (Placement(transformation(extent={{-80,-46},{-60,-26}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p1,
    T0_par(displayUnit="K") = T1) annotation(Placement(transformation(extent={{-160,-46},{-140,-26}})));
  ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-140,-110},{-160,-90}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=m_flow) annotation(Placement(transformation(extent={{-200,-110},{-180,-90}})));
  ThermofluidStream.Idealized.Processes.Adiabatic turbine(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=100000) annotation (Placement(transformation(extent={{-100,-90},{-120,-110}})));
  Modelica.Blocks.Sources.RealExpression pseudoSourcePower(y(
      unit="W") = 0) annotation(Placement(transformation(extent={{-90,-90},{-70,-70}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic valve(
    redeclare package Medium = Medium,
    enforcePressureDrop=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{20,-90},{0,-110}})));
  ThermofluidStream.Utilities.showRealValue massFlowRate(
    description="m_flow",
    use_numberPort=false,
    number=m_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{0,-160},{20,-140}})));
  ThermofluidStream.Utilities.showRealValue turbineWork(
    description="P_TRB",
    use_numberPort=false,
    number=-compressor.P,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{40,-160},{60,-140}})));
  ThermofluidStream.Utilities.showRealValue power(
    description="P",
    use_numberPort=false,
    number=shaftPower.E_flow_out,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{78,-160},{98,-140}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="eff",
    use_numberPort=false,
    number=shaftPower.E_flow_out/combustion.Q_flow,
    displayVariable=false,
    significantDigits=4) annotation(Placement(transformation(extent={{120,-160},{140,-140}})));
  ThermofluidStream.Idealized.EnergyFlow.Components.Sum shaftPower(n_in=5) annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  ThermofluidStream.Idealized.EnergyFlow.Components.Sum pseudoSource(n_in=2) annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
  ThermofluidStream.Idealized.Processes.FlowWork inletFlowWork(redeclare package Medium = Medium, boundary=ThermofluidStream.Idealized.Types.FlowWorkBoundary.Inlet) annotation (Placement(transformation(extent={{50,-10},{30,-30}})));
  ThermofluidStream.Idealized.Processes.FlowWork outletFlowWork(redeclare package Medium = Medium, boundary=ThermofluidStream.Idealized.Types.FlowWorkBoundary.Outlet) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={40,20})));
  Modelica.Blocks.Continuous.Integrator integrator(
    k=30,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1e5)
              annotation(Placement(transformation(extent={{-30,-90},{-10,-70}})));
  Modelica.Blocks.Math.Feedback feedback annotation(Placement(transformation(extent={{-58,-70},{-38,-90}})));
equation
  connect(engineCompression.outlet, combustion.inlet) annotation(Line(
      points={{0,-20},{-20,-20},{-20,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(combustion.outlet, engineExpansion.inlet) annotation(Line(
      points={{-20,10},{-20,20},{0,20}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.outlet, cooler.inlet) annotation(Line(
      points={{-100,-36},{-80,-36}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, compressor.inlet) annotation(Line(
      points={{-140,-36},{-120,-36}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression.y, sink.m_flow_prescribed) annotation(Line(points={{-179,-100},{-152,-100}},color={0,0,127}));
  connect(turbine.outlet, sink.inlet) annotation(Line(
      points={{-120,-100},{-140,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(valve.outlet, turbine.inlet) annotation(Line(
      points={{0,-100},{-100,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.P_out, pseudoSource.E_flow_in[1]) annotation(Line(points={{-110,-43},{-110,-61.5},{-100,-61.5}}, color={255,170,85}));
  connect(turbine.P_out, pseudoSource.E_flow_in[2]) annotation(Line(points={{-110,-93},{-110,-58.5},{-100,-58.5}}, color={255,170,85}));
  connect(inletFlowWork.outlet, engineCompression.inlet) annotation(Line(
      points={{30,-20},{20,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(inletFlowWork.inlet, cooler.outlet) annotation(Line(
      points={{50,-20},{60,-20},{60,-36},{-60,-36}},
      color={28,108,200},
      thickness=0.5));
  connect(engineExpansion.outlet, outletFlowWork.inlet) annotation(Line(
      points={{20,20},{30,20}},
      color={28,108,200},
      thickness=0.5));
  connect(inletFlowWork.P_inlet_out, shaftPower.E_flow_in[1]) annotation(Line(points={{50,-9},{50,-4},{90,-4},{90,-2.4}}, color={255,170,85}));
  connect(engineCompression.P_out, shaftPower.E_flow_in[2]) annotation(Line(points={{10,-13},{10,-2},{90,-2},{90,-1.2}}, color={255,170,85}));
  connect(combustion.P_out, shaftPower.E_flow_in[3]) annotation(Line(points={{-9,-10},{-4,-10},{-4,0},{90,0},{90,0}},color={255,170,85}));
  connect(engineExpansion.P_out, shaftPower.E_flow_in[4]) annotation(Line(points={{10,13},{10,2},{90,2},{90,1.2}}, color={255,170,85}));
  connect(outletFlowWork.P_outlet_out, shaftPower.E_flow_in[5]) annotation(Line(points={{50,9},{50,4},{90,4},{90,2.4}}, color={255,170,85}));
  connect(outletFlowWork.outlet, valve.inlet) annotation(Line(
      points={{50,20},{70,20},{70,-100},{20,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(integrator.y, valve.outletSpec_prescribed) annotation(Line(points={{-9,-80},{0,-80},{0,-88}}, color={0,0,127}));
  connect(pseudoSourcePower.y, feedback.u1) annotation(Line(points={{-69,-80},{-56,-80}}, color={0,0,127}));
  connect(pseudoSource.E_flow_out, feedback.u2) annotation(Line(points={{-78.3,-60},{-48,-60},{-48,-72}}, color={255,170,85}));
  connect(feedback.y, integrator.u) annotation(Line(points={{-39,-80},{-32,-80}}, color={0,0,127}));
  annotation(Diagram(coordinateSystem(extent={{-220,-160},{240,100}}),
                      graphics={
        Text(
          extent={{-136,-30},{-130,-36}},
          textColor={28,108,200},
          textString="1"),
        Rectangle(
          extent={{-40,40},{80,-34}},
          lineColor={255,255,255},
          fillColor={200,200,200},
          fillPattern=FillPattern.Sphere),
        Text(
          extent={{-40,40},{-10,30}},
          textColor={0,0,0},
          textString="Engine"),
        Text(
          extent={{-96,-30},{-90,-36}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-56,-30},{-50,-36}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-20,-14},{-14,-20}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{-18,26},{-12,20}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{22,26},{28,20}},
          textColor={28,108,200},
          textString="6"),
        Text(
          extent={{-86,-94},{-80,-100}},
          textColor={28,108,200},
          textString="7"),
        Text(
          extent={{-134,-94},{-128,-100}},
          textColor={28,108,200},
          textString="8")}), Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    Example of a turbocharged Diesel engine cycle. See 
    <a href=\"modelica://ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise5TurboChargedDiesel\">TUMExercisesThermodynamicCycles.Exercise5TurboChargedDiesel</a> for the problem description.
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
</html>"));
end PolytropicCyclePseudoInversion;
