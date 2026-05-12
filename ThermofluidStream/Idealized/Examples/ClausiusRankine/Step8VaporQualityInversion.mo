within ThermofluidStream.Idealized.Examples.ClausiusRankine;
model Step8VaporQualityInversion
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
                                                                              constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{120,80},{140,100}})));

  Processes.Adiabatic pump(
    redeclare package Medium = Medium,
    eta_fixed=0.6,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Processes.Adiabatic turbine(
    redeclare package Medium = Medium,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,
    p_out_fixed=100000) annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Processes.Isobaric boiler(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Processes.Isobaric preheater(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Processes.Isobaric superheater(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{20,10},{40,-10}})));
  LoopBreaker_m loopBreaker(
    redeclare package Medium = Medium,
    m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_out_fixed=100000,
    T_out_fixed=293.15) annotation (Placement(transformation(extent={{0,-70},{-20,-50}})));
  Processes.Isobaric condenser(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,

    T_out_fixed=293.15) annotation (Placement(transformation(extent={{40,-70},{20,-50}})));
  ThermofluidStream.Utilities.showRealValue efficiencyExtensive(
    description="efficiency extensive",
    use_numberPort=false,
    number=(-turbine.P - pump.P)/(superheater.Q_flow + boiler.Q_flow + preheater.Q_flow + Modelica.Constants.eps),
    displayVariable=false) annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  ThermofluidStream.Utilities.showRealValue efficiencySpecific(
    description="efficiency specific",
    use_numberPort=false,
    number=(-turbine.dh - pump.dh)/(superheater.outlet.state.h - preheater.inlet.state.h + Modelica.Constants.eps),
    displayVariable=false) annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Sources.Step massFlowRate(
    height=1,
    offset=1,
    startTime=0.5) annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Modelica.Blocks.Sources.Ramp outletPressure(
    height=90e5,
    duration=1,
    offset=10e5) annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.RealExpression h_bubble(y=Medium.bubbleEnthalpy(Medium.setSat_p(outletPressure.y))) annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.RealExpression h_dew(y=Medium.dewEnthalpy(Medium.setSat_p(outletPressure.y))) annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect vaporQualitySensor(
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg,
    outputValue=true) annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints
    annotation (Placement(transformation(extent={{60,38},{100,62}})));
  Modelica.Blocks.Sources.RealExpression vaporQualitySetpoint(y=0.95)
    annotation (Placement(transformation(extent={{30,40},{50,60}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0) annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
equation
  connect(pump.outlet, preheater.inlet)
    annotation (Line(
      points={{-60,0},{-40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(preheater.outlet, boiler.inlet) annotation (Line(
      points={{-20,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(boiler.outlet, superheater.inlet) annotation (Line(
      points={{10,0},{20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(superheater.outlet, turbine.inlet) annotation (Line(
      points={{40,0},{60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker.inlet, condenser.outlet) annotation (Line(
      points={{0,-60},{20,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine.outlet, condenser.inlet) annotation (Line(
      points={{80,0},{90,0},{90,-60},{40,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker.outlet, pump.inlet)
    annotation (Line(
      points={{-20,-60},{-110,-60},{-110,0},{-80,0}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine.outlet, vaporQualitySensor.inlet)
    annotation (Line(
      points={{80,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(vaporQualitySensor.value_out, inverseBlockConstraints.u2)
    annotation (Line(points={{118,0},{124,0},{124,22},{74,22},{74,50},{64,50}}, color={0,0,127}));
  connect(vaporQualitySetpoint.y, inverseBlockConstraints.u1)
    annotation (Line(points={{51,50},{58,50}}, color={0,0,127}));
  connect(outletPressure.y, pump.outletSpec_prescribed) annotation (Line(points={{-79,-30},{-60,-30},{-60,-12}}, color={0,0,127}));
  connect(h_bubble.y, preheater.outletSpec_prescribed) annotation (Line(points={{-39,-30},{-20,-30},{-20,-12}}, color={0,0,127}));
  connect(h_dew.y, boiler.outletSpec_prescribed) annotation (Line(points={{1,-30},{10,-30},{10,-12}}, color={0,0,127}));
  connect(superheater.outletSpec_prescribed, inverseBlockConstraints.y2) annotation (Line(points={{40,12},{40,24},{90,24},{90,50},{97,50}}, color={0,0,127}));
  connect(massFlowRate.y, firstOrder.u) annotation (Line(points={{-59,-80},{-52,-80}}, color={0,0,127}));
  connect(firstOrder.y, loopBreaker.m_flow_in_prescribed) annotation (Line(points={{-29,-80},{0,-80},{0,-72}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-140,-100},{140,100}}), graphics={
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
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    In the 8. step the superheating temperature difference is determined (depending on the pump pressure) to obtain a vapor quality of <code>0.95</code> at the turbine outlet. 
    This yields implicit nonlinear equations, requiring suitable start values to be solvable.
  </p>

  <p>
    Further documentation is available in the 
    <a href=\"modelica://ThermoFluidStream.Idealized.Examples.ClausiusRankine\">ClausiusRankine</a> package.
  </p>
</html>"));
end Step8VaporQualityInversion;
