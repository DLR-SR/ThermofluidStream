within ThermofluidStream.Idealized.Examples.ClausiusRankine;
model Step5Sink_free
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{140,80},{160,100}})));

  Processes.Adiabatic pump(
    redeclare package Medium = Medium,
    eta_fixed=0.6,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-110,-10},{-90,10}})));
  Processes.Adiabatic turbine(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.FullMedium "Based on Medium.specificEntropy()",
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=100000) annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Processes.Isobaric boiler(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-30,-10},{-10,10}})));
  ThermofluidStream.Boundaries.Source
                    waterSource(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-150,-10},{-130,10}})));
  Modelica.Blocks.Sources.RealExpression h_dew(y=Medium.dewEnthalpy(Medium.setSat_p(outletPressure.y))) annotation(Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Processes.Isobaric preheater(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-70,-10},{-50,10}})));
  Processes.Isobaric superheater(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.TemperatureDifference,

    dT_fixed=50) annotation(Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Sources.RealExpression h_bubble(y=Medium.bubbleEnthalpy(Medium.setSat_p(outletPressure.y))) annotation(Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Blocks.Sources.Ramp outletPressure(
    height=99e5,
    duration=1,
    offset=1e5) annotation(Placement(transformation(extent={{-130,-40},{-110,-20}})));
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
  Sources.MassFlowRate massFlowRate(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Sources.Sink_free waterSink(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{130,-10},{150,10}})));

equation
  connect(waterSource.outlet, pump.inlet) annotation(
    Line(
      points={{-130,0},{-110,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.outlet, preheater.inlet) annotation(
    Line(
      points={{-90,0},{-70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(preheater.outlet, boiler.inlet) annotation(Line(
      points={{-50,0},{-30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(boiler.outlet, superheater.inlet) annotation(Line(
      points={{-10,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(superheater.outlet, turbine.inlet) annotation(Line(
      points={{30,0},{50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.outletSpec_prescribed, outletPressure.y) annotation(Line(points={{-90,-12},{-90,-30},{-109,-30}},color={0,0,127}));
  connect(h_dew.y, boiler.outletSpec_prescribed) annotation(Line(points={{-19,-30},{-10,-30},{-10,-12}},
                                                                                                    color={0,0,127}));
  connect(h_bubble.y, preheater.outletSpec_prescribed) annotation(Line(points={{-59,-30},{-50,-30},{-50,-12}}, color={0,0,127}));
  connect(turbine.outlet, massFlowRate.inlet) annotation (Line(
      points={{70,0},{90,0}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRate.outlet, waterSink.inlet) annotation (Line(
      points={{110,0},{130,0}},
      color={28,108,200},
      thickness=0.5));

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
          extent={{-124,6},{-118,0}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-84,6},{-78,0}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-44,6},{-38,0}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-4,6},{2,0}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{36,6},{42,0}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{76,6},{82,0}},
          textColor={28,108,200},
          textString="6"),
        Text(
          extent={{116,6},{122,0}},
          textColor={28,108,200},
          textString="7")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    In the fifth step, the mass flow rate sink is split into a <code>massFlowRate</code> component and a free sink.
  </p>

  <p>
    The <a href=\"modelica://ThermofluidStream.Idealized.Sources.Sink_free\">Sink_free</a> model is locally underdetermined by one equation (it lacks the definition of the mass flow rate), which is indicated by a minus sign.<br> 
    The <a href=\"modelica://ThermofluidStream.Idealized.Sources.MassFlowRate\">MassFlowRate</a> model is overdetermined by one equation, which is indicated by a plus sign.<br>
    Combining both models yields a balanced model. See also <a href=\"modelica://ThermofluidStream.Idealized.UsersGuide.BalancedModels\">UsersGuide.BalancedModels</a>.
  </p>

  <p>
    The position of the <code>massFlowRate</code> component within the loop is arbitrary.
  </p>

  <p>
    Further documentation is available in the
    <a href=\"modelica://ThermofluidStream.Idealized.Examples.ClausiusRankine\">ClausiusRankine</a> package.
  </p>
</html>"));
end Step5Sink_free;
