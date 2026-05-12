within ThermofluidStream.Idealized.Examples.ClausiusRankine;
model Step5Sink_free
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconInertanceNeglect;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
                                                                              constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(
    L=0,
    considerInertance=false,                            displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{120,80},{140,100}})));

  Processes.Adiabatic pump(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    eta_fixed=0.6,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-70,-10},{-50,10}})));
  Processes.Adiabatic turbine(
    redeclare package Medium = Medium,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=100000) annotation(Placement(transformation(extent={{80,-10},{100,10}})));
  Processes.Isobaric boiler(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{0,-10},{20,10}})));
  ThermofluidStream.Boundaries.Source
                   waterSource(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-140,-10},{-120,10}})));
  Sources.Sink_free waterSink(redeclare package Medium = Medium) annotation(
    Placement(transformation(extent={{120,-10},{140,10}})));
  Modelica.Blocks.Sources.RealExpression h_dew(y=Medium.dewEnthalpy(Medium.setSat_p(outletPressure.y))) annotation(Placement(transformation(extent={{-14,-40},{6,-20}})));
  Processes.Isobaric preheater(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-40,-10},{-20,10}})));
  Processes.Isobaric superheater(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.TemperatureDifference,

    dT_fixed=50,
    T_out_fixed=473.15) annotation(Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Sources.RealExpression h_bubble(y=Medium.bubbleEnthalpy(Medium.setSat_p(outletPressure.y))) annotation(Placement(transformation(extent={{-54,-40},{-34,-20}})));
  Sources.MassFlowRate massFlowRateSource(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.Step massFlowRateStep(
    height=1,
    offset=1,
    startTime=0.5) annotation(Placement(transformation(extent={{-120,-40},{-100,-20}})));
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
  Modelica.Blocks.Sources.Ramp outletPressure(
    height=99e5,
    duration=1,
    offset=1e5) annotation(Placement(transformation(extent={{-120,-80},{-100,-60}})));
equation
  connect(pump.outlet, preheater.inlet) annotation(
    Line(
      points={{-50,0},{-40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(preheater.outlet, boiler.inlet) annotation(Line(
      points={{-20,0},{0,0}},
      color={28,108,200},
      thickness=0.5));
  connect(boiler.outlet, superheater.inlet) annotation(Line(
      points={{20,0},{40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(superheater.outlet, turbine.inlet) annotation(Line(
      points={{60,0},{80,0}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine.outlet,waterSink. inlet) annotation(
    Line(
      points={{100,0},{120,0}},
      color={28,108,200},
      thickness=0.5));
  connect(waterSource.outlet, massFlowRateSource.inlet) annotation(
    Line(
      points={{-120,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateSource.outlet, pump.inlet) annotation(
    Line(
      points={{-80,0},{-70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateStep.y, massFlowRateSource.m_flow_prescribed) annotation(Line(points={{-99,-30},{-90,-30},{-90,-8}}, color={0,0,127}));
  connect(pump.outletSpec_prescribed, outletPressure.y) annotation(Line(points={{-50,-12},{-50,-70},{-99,-70}}, color={0,0,127}));
  connect(h_bubble.y, preheater.outletSpec_prescribed) annotation(Line(points={{-33,-30},{-20,-30},{-20,-12}}, color={0,0,127}));
  connect(h_dew.y, boiler.outletSpec_prescribed) annotation(Line(points={{7,-30},{20,-30},{20,-12}}, color={0,0,127}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-140,-100},{140,100}}), graphics={
        Text(
          extent={{-114,6},{-108,0}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-78,6},{-72,0}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-48,6},{-42,0}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-14,6},{-8,0}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{26,6},{32,0}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{66,6},{72,0}},
          textColor={28,108,200},
          textString="6"),
        Text(
          extent={{106,6},{112,0}},
          textColor={28,108,200},
          textString="7"),
        Polygon(
          points={{-140,40},{-100,40},{-100,60},{-120,60},{-120,100},{-140,100},{-140,40}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-110,90},{-30,70}},
          textColor={238,46,47},
          textString="requires considerInertance = false
see User's Guide",
          horizontalAlignment=TextAlignment.Left)}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    In the fifth step the mass flow rate sink is replaced by a free sink and a mass flow rate flow set component.
  </p>

  <p>
    Furthermore, since the mass flow rate setpoint is non differentiable, <code>considerInertance = false</code> is required, see 
    <a href=\"modelica://ThermoFluidStream.Idealized.UsersGuide.InertanceNeglect\">UsersGuide.InertanceNeglect</a>.
  </p>

  <p>
    Further documentation is available in the 
    <a href=\"modelica://ThermoFluidStream.Idealized.Examples.ClausiusRankine\">ClausiusRankine</a> package.
  </p>
</html>"));
end Step5Sink_free;
