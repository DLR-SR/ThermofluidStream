within ThermofluidStream.Idealized.Examples.ClausiusRankine;
model Step4Sink_m
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{120,80},{140,100}})));

  Processes.Adiabatic pump(
    redeclare package Medium = Medium,
    eta_fixed=0.6,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-100,-10},{-80,10}})));
  Processes.Adiabatic turbine(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.FullMedium "Based on Medium.specificEntropy()",
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=100000) annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Processes.Isobaric boiler(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-20,-10},{0,10}})));
  ThermofluidStream.Boundaries.Source
                    waterSource(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-140,-10},{-120,10}})));
  .ThermofluidStream.Boundaries.Sink_m waterSink(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Sources.RealExpression h_dew(y=Medium.dewEnthalpy(Medium.setSat_p(outletPressure.y))) annotation(Placement(transformation(extent={{-30,-40},{-10,-20}})));
  Processes.Isobaric preheater(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-60,-10},{-40,10}})));
  Processes.Isobaric superheater(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.TemperatureDifference,

    dT_fixed=50) annotation(Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.RealExpression h_bubble(y=Medium.bubbleEnthalpy(Medium.setSat_p(outletPressure.y))) annotation(Placement(transformation(extent={{-70,-40},{-50,-20}})));
  Modelica.Blocks.Sources.Ramp outletPressure(
    height=99e5,
    duration=1,
    offset=1e5) annotation(Placement(transformation(extent={{-120,-40},{-100,-20}})));
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

equation
  connect(waterSource.outlet, pump.inlet) annotation(
    Line(
      points={{-120,0},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.outlet, preheater.inlet) annotation(
    Line(
      points={{-80,0},{-60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(preheater.outlet, boiler.inlet) annotation(Line(
      points={{-40,0},{-20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(boiler.outlet, superheater.inlet) annotation(Line(
      points={{0,0},{20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(superheater.outlet, turbine.inlet) annotation(Line(
      points={{40,0},{60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine.outlet,waterSink. inlet) annotation(
    Line(
      points={{80,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.outletSpec_prescribed, outletPressure.y) annotation(Line(points={{-80,-12},{-80,-30},{-99,-30}}, color={0,0,127}));
  connect(h_dew.y, boiler.outletSpec_prescribed) annotation(Line(points={{-9,-30},{0,-30},{0,-12}}, color={0,0,127}));
  connect(h_bubble.y, preheater.outletSpec_prescribed) annotation(Line(points={{-49,-30},{-40,-30},{-40,-12}}, color={0,0,127}));

  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(extent={{-140,-100},{140,100}}),
      graphics={
        Text(
          extent={{-114,6},{-108,0}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-74,6},{-68,0}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-34,6},{-28,0}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{6,6},{12,0}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{46,6},{52,0}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{86,6},{92,0}},
          textColor={28,108,200},
          textString="6")}),
    Documentation(
      info="<html>
  <p>
    In the forth step the flow resistance trick is replaced by a mass flow rate sink.
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
end Step4Sink_m;
