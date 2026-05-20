within ThermofluidStream.Idealized.Components;
model Separator "Model of a phase separator for two-phase medium - Overdetermined (1 equation)"
  extends ThermofluidStream.Utilities.DropOfCommonsPlus;
  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialTwoPhaseMedium "Medium model" annotation(
    choicesAllMatching=true);

  parameter Boolean considerInertance = dropOfCommons.considerInertance "=true, if transient momentum (inertance) term is considered; disable only for advanced use" annotation(
    Dialog(tab="Advanced"), Evaluate=true, HideResult=true);
  parameter ThermofluidStream.Utilities.Units.Inertance L=dropOfCommons.L "Inertance of each component" annotation(
    Dialog(tab="Advanced", enable=considerInertance), HideResult = not considerInertance);

  parameter AssertionLevel assertionLevel=AssertionLevel.warning "Assertion level for dp_AB" annotation(
    Dialog(group="Warnings"));
  parameter Real relTol_dp_AB = 1e-3 "Relative tolerance for inlet pressure difference pA, pB" annotation(
    Dialog(group="Warnings"));
  final parameter String name = getInstanceName();

  ThermofluidStream.Interfaces.Inlet inletA(redeclare package Medium = Medium) annotation(
    Placement(transformation(extent={{120,-80},{80,-40}})));
  ThermofluidStream.Interfaces.Outlet outletLiquid(redeclare package Medium = Medium) annotation(
    Placement(transformation(extent={{-80,-80},{-120,-40}})));
  ThermofluidStream.Interfaces.Inlet inletB(redeclare package Medium = Medium) annotation(
    Placement(transformation(extent={{-120,40},{-80,80}})));
  ThermofluidStream.Interfaces.Outlet outletVapor(redeclare package Medium = Medium) annotation(
    Placement(transformation(extent={{80,40},{120,80}})));

  Medium.AbsolutePressure p = p_A "Pressure";
  Medium.AbsolutePressure p_A = Medium.pressure(inletA.state) "Pressure A";
  Medium.AbsolutePressure p_B = Medium.pressure(inletB.state) "Pressure B";
  Real dp_AB_rel "Relative difference in pressure at junction inlets";
  Real isDPWithinTol "= 1.0 if pressure difference is within tolerance, = -1.0 if tolerance is exceeded";

  ThermofluidStream.Idealized.Processes.Isobaric isobaricHeatFlowPort(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    L=L,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(
    Placement(transformation(extent={{10,-50},{-10,-70}})));
  ThermofluidStream.Idealized.Processes.Isobaric isobaricHeatFlowPort1(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(
    Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Blocks.Sources.RealExpression h_dew(y=Medium.dewEnthalpy(Medium.setSat_p(p))) annotation(
    Placement(transformation(extent={{40,30},{20,50}})));
  Modelica.Blocks.Sources.RealExpression h_bubble(y=Medium.bubbleEnthalpy(Medium.setSat_p(p))) annotation(
    Placement(transformation(extent={{-40,-50},{-20,-30}})));

equation
  dp_AB_rel = abs(p_A - p_B)/max(p_A, p_B);
  isDPWithinTol = sign(relTol_dp_AB  - dp_AB_rel);
  assert(noEvent(dp_AB_rel  <= relTol_dp_AB),
    "In \"" + name +"\" the inlet pressures differ beyond the specified tolerance.",
    assertionLevel);

  connect(inletB, isobaricHeatFlowPort1.inlet) annotation(
    Line(
      points={{-100,60},{-10,60}},
      color={28,108,200},
      thickness=0.5));
  connect(inletA, isobaricHeatFlowPort.inlet) annotation(
    Line(
      points={{100,-60},{10,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaricHeatFlowPort.outlet, outletLiquid) annotation(
    Line(
      points={{-10,-60},{-100,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(isobaricHeatFlowPort1.outlet, outletVapor) annotation(
    Line(
      points={{10,60},{100,60}},
      color={28,108,200},
      thickness=0.5));
  connect(h_bubble.y, isobaricHeatFlowPort.outletSpec_prescribed) annotation(
    Line(points={{-19,-40},{-10,-40},{-10,-48}}, color={0,0,127}));
  connect(h_dew.y, isobaricHeatFlowPort1.outletSpec_prescribed) annotation(
    Line(points={{19,40},{10,40},{10,48}}, color={0,0,127}));
  connect(isobaricHeatFlowPort.Q_flow_out, isobaricHeatFlowPort1.Q_flow_in) annotation(
    Line(points={{0,-53},{0,52}}, color={255,170,85}));

  annotation(
    Icon(
      coordinateSystem(
        preserveAspectRatio=true),
      graphics={
        Text(visible=displayInstanceName,
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Ellipse(
          extent={{-56,-28},{64,-88}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-56,76},{64,16}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-56,46},{64,-56}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-60,-20},{60,-80}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,50},{60,-50}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-60,80},{60,20}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,50},{-60,-52}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{60,50},{60,-52}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-100,60},{-70,60},{-60,54}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{60,52},{72,60},{100,60}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-100,-60},{-74,-60},{-60,-48}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{60,-48},{72,-60},{100,-60}},
          color={28,108,200},
          thickness=0.5),
       Ellipse(
          extent={{-56,-44},{52,8}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Backward),
        Ellipse(
          extent={{-98,38},{-62,2}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-96,22},{-64,18}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-78,4},{-82,36}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}),
    Documentation(
      info="<html>
  <p>
    Model of a stationary phase separator, for example used in a staged vapor cycle.
  </p>
  
  <p>
    The two mass flow rates are <strong>not</strong> independent.
    This model is locally overdetermined (one additional equation). Therefore, one of the two outlets must be connected to an underdetermined component 
    (e.g., <a href=\"modelica://ThermofluidStream.Idealized.Sources.LoopBreaker\">LoopBreaker</a> or 
    <a href=\"modelica://ThermofluidStream.Idealized.Sources.Sink_free\">Sink_free</a>) 
    to ensure that the overall system remains balanced.
  </p>
  
  <p>
    The phase seperator is no loop-breaker. 
    When the phase separator is used inside a loop, a loop-breaker must still be included to break algebraic loops.
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
end Separator;
