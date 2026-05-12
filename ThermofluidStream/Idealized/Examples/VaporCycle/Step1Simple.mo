within ThermofluidStream.Idealized.Examples.VaporCycle;
model Step1Simple
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.R134a.R134a_ph constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  ThermofluidStream.Idealized.Processes.Adiabatic compressor(
    redeclare package Medium = Medium,
    eta_fixed=0.9,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,0})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{82,80},{102,100}})));
  ThermofluidStream.Idealized.Processes.Isobaric condensor(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{10,40},{-10,20}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic valve(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.OutletPressure,
    p_out_fixed=100000) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,0})));
  ThermofluidStream.Idealized.Processes.Isobaric evaporator(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-20,-40},{0,-20}})));
  ThermofluidStream.Idealized.Sources.LoopBreaker_m loopBreaker(
    redeclare package Medium = Medium,
    m_flow_in_par=1,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    thermalValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_out_fixed=100000) annotation(Placement(transformation(extent={{10,-40},{30,-20}})));
  Modelica.Blocks.Sources.RealExpression h_dew(y=Medium.dewEnthalpy(Medium.setSat_p(1e5))) annotation(
    Placement(transformation(extent={{-40,-70},{-20,-50}})));
  ThermofluidStream.Utilities.showRealValue coefficientOfPerformanceSpecific(
    description="COP specific",
    use_numberPort=false,
    number=(evaporator.dh)/(compressor.dh),
    displayVariable=false) annotation(Placement(transformation(extent={{40,-80},{60,-60}})));
  Modelica.Blocks.Sources.RealExpression h_bubble(y=Medium.bubbleEnthalpy(Medium.setSat_p(condensorPressure.y))) annotation(
    Placement(transformation(extent={{40,40},{20,60}})));
  ThermofluidStream.Utilities.showRealValue coefficientOfPerformanceExtensive(
    description="COP extensive",
    use_numberPort=false,
    number=(evaporator.Q_flow)/(compressor.P),
    displayVariable=false) annotation(Placement(transformation(extent={{40,-100},{60,-80}})));
  Modelica.Blocks.Sources.Ramp condensorPressure(
    height=18e5,
    duration=1,
    offset=2e5) annotation(Placement(transformation(extent={{80,0},{60,20}})));
equation
  connect(compressor.outlet, condensor.inlet) annotation(
    Line(
      points={{40,10},{40,30},{10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(valve.outlet, evaporator.inlet) annotation(
    Line(
      points={{-30,-10},{-30,-30},{-20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker.outlet, compressor.inlet) annotation(
    Line(
      points={{30,-30},{40,-30},{40,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(condensor.outlet, valve.inlet) annotation(
    Line(
      points={{-10,30},{-30,30},{-30,10}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outlet, loopBreaker.inlet) annotation(
    Line(
      points={{0,-30},{10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(condensor.outletSpec_prescribed, h_bubble.y) annotation(Line(points={{-10,42},{-10,50},{19,50}}, color={0,0,127}));
  connect(h_dew.y, evaporator.outletSpec_prescribed) annotation(Line(points={{-19,-60},
          {0,-60},{0,-42}},                                                                      color={0,0,127}));
  connect(h_dew.y, loopBreaker.h_out_prescribed) annotation(Line(points={{-19,-60},{22,-60},{22,-42}}, color={0,0,127}));
  connect(compressor.outletSpec_prescribed, condensorPressure.y) annotation(Line(points={{52,10},{59,10}}, color={0,0,127}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false),
        graphics={
        Text(
          extent={{34,-24},{40,-30}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{34,30},{40,24}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-30,30},{-24,24}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-30,-24},{-24,-30}},
          textColor={28,108,200},
          textString="4")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    In a first step, a simple vapor compression cycle is established.
    The evaporator outlet is assumed to be saturated vapor, while the condenser outlet is assumed to be saturated liquid.
    The mass flow rate and the low-pressure level are kept constant, whereas the high-pressure level is varied linearly over time.
    The coefficient of performance (COP) is evaluated both on a specific basis and using extensive quantities.
  </p>

  <p>
    The COP is not continuous due to interpolation artifacts in the Modelica medium 
    <a href=\"modelica://ThermofluidStream.Media.myMedia.R134a.R134a_ph\">R134a_ph</a>.
    These discontinuities are not physical and do not occur when using TIL R134a.
    Such non-smooth behavior can adversely affect controller performance and may significantly slow down the simulation.
  </p>

  <p>
    Further documentation is available in the 
    <a href=\"modelica://ThermoFluidStream.Idealized.Examples.VaporCycle\">VaporCycle</a> package.
  </p>
</html>"));
end Step1Simple;
