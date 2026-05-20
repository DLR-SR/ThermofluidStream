within ThermofluidStream.Idealized.Examples.ClausiusRankine;
model Step8ClosedLoopFiltered
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{120,80},{140,100}})));

  Processes.Adiabatic pump(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.FullMedium "Based on Medium.specificEntropy()",
    eta_fixed=0.6,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Processes.Adiabatic turbine(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.FullMedium "Based on Medium.specificEntropy()",
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=100000) annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Processes.Isobaric boiler(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-10,-10},{10,10}})));
  Processes.Isobaric preheater(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-40,-10},{-20,10}})));
  Processes.Isobaric superheater(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed=473.15,
    dT_fixed=50) annotation(Placement(transformation(extent={{20,-10},{40,10}})));
  Sources.LoopBreaker_m loopBreaker(
    redeclare package Medium = Medium,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_out_fixed=100000,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.Temperature,
    T_out_fixed=293.15) annotation(Placement(transformation(extent={{0,-70},{-20,-50}})));
  Processes.Isobaric condenser(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed=293.15) annotation(Placement(transformation(extent={{40,-70},{20,-50}})));
  ThermofluidStream.Utilities.showRealValue efficiencyExtensive(
    description="efficiency extensive",
    use_numberPort=false,
    number=(-turbine.P - pump.P)/(superheater.Q_flow + boiler.Q_flow + preheater.Q_flow + Modelica.Constants.eps),
    displayVariable=false) annotation(Placement(transformation(extent={{0,60},{20,80}})));
  ThermofluidStream.Utilities.showRealValue efficiencySpecific(
    description="efficiency specific",
    use_numberPort=false,
    number=(-turbine.dh - pump.dh)/(superheater.outlet.state.h - preheater.inlet.state.h + Modelica.Constants.eps),
    displayVariable=false) annotation(Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Sources.Step massFlowRate(
    height=1,
    offset=1,
    startTime=0.5) annotation(Placement(transformation(extent={{-72,-90},{-52,-70}})));
  Modelica.Blocks.Sources.Ramp pressure(
    height=99e5,
    duration=1,
    offset=1e5) annotation(Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.RealExpression h_bubble(y=Medium.bubbleEnthalpy(Medium.setSat_p(pressure.y))) annotation(
    Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.RealExpression h_dew(y=Medium.dewEnthalpy(Medium.setSat_p(pressure.y))) annotation(
    Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0) annotation(Placement(transformation(extent={{-40,-90},{-20,-70}})));

equation
  connect(pump.outlet, preheater.inlet) annotation(
    Line(
      points={{-60,0},{-40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(preheater.outlet, boiler.inlet) annotation(Line(
      points={{-20,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(boiler.outlet, superheater.inlet) annotation(Line(
      points={{10,0},{20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(superheater.outlet, turbine.inlet) annotation(Line(
      points={{40,0},{60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker.inlet, condenser.outlet) annotation(Line(
      points={{0,-60},{20,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine.outlet, condenser.inlet) annotation(Line(
      points={{80,0},{90,0},{90,-60},{40,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker.outlet, pump.inlet) annotation(
    Line(
      points={{-20,-60},{-110,-60},{-110,0},{-80,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.outletSpec_prescribed, pressure.y) annotation(Line(points={{-60,-12},{-60,-30},{-79,-30}}, color={0,0,127}));
  connect(h_bubble.y, preheater.outletSpec_prescribed) annotation(Line(points={{-39,-30},{-20,-30},{-20,-12}}, color={0,0,127}));
  connect(h_dew.y, boiler.outletSpec_prescribed) annotation(Line(points={{1,-30},{10,-30},{10,-12}}, color={0,0,127}));
  connect(massFlowRate.y, firstOrder.u) annotation(Line(points={{-51,-80},{-42,-80}}, color={0,0,127}));
  connect(firstOrder.y, loopBreaker.m_flow_in_prescribed) annotation(Line(points={{-19,-80},{0,-80},{0,-72}}, color={0,0,127}));

  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(
        extent={{-140,-100},{140,100}}),
      graphics={
        Text(
          extent={{8,-54},{14,-60}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-54,6},{-48,0}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-18,6},{-12,0}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{12,6},{18,0}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{46,6},{52,0}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{84,6},{90,0}},
          textColor={28,108,200},
          textString="6")}),
    Documentation(
      info="<html>
  <p>
    In the 8. step a filter is applied for the mass flow rate to obtain a differentiable mass flow rate input signal.
    For this reason <code>considerInertance = true</code> becomes possible.
  </p>

  <p>
    Further documentation is available in the 
    <a href=\"modelica://ThermofluidStream.Idealized.Examples.ClausiusRankine\">ClausiusRankine</a> package.
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
end Step8ClosedLoopFiltered;
