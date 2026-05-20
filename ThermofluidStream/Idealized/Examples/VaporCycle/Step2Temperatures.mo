within ThermofluidStream.Idealized.Examples.VaporCycle;
model Step2Temperatures
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.R134a.R134a_ph
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);
  parameter Medium.Temperature T_Evaporator = 253.15 "Evaporator temperature";

  final parameter Medium.AbsolutePressure p_Evaporator = Medium.saturationPressure(T_Evaporator) "Evaporator pressure";
  final parameter Medium.SpecificEnthalpy h_EvaporatorOut = Medium.dewEnthalpy(Medium.setSat_T(T_Evaporator)) "Evaporator outlet specific enthalpy";

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
    p_out_fixed=p_Evaporator) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,0})));
  ThermofluidStream.Idealized.Processes.Isobaric evaporator(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,

    h_out_fixed=h_EvaporatorOut) annotation(Placement(transformation(extent={{-20,-40},{0,-20}})));
  ThermofluidStream.Idealized.Sources.LoopBreaker_m loopBreaker(
    redeclare package Medium = Medium,
    m_flow_in_par=1,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    p_out_fixed=p_Evaporator,
    h_out_fixed=h_EvaporatorOut) annotation(Placement(transformation(extent={{10,-40},{30,-20}})));
  ThermofluidStream.Utilities.showRealValue coefficientOfPerformanceSpecific(
    description="COP specific",
    use_numberPort=false,
    number=(evaporator.dh)/(compressor.dh),
    displayVariable=false) annotation(Placement(transformation(extent={{40,-80},{60,-60}})));
  ThermofluidStream.Utilities.showRealValue coefficientOfPerformanceExtensive(
    description="COP extensive",
    use_numberPort=false,
    number=(evaporator.Q_flow)/(compressor.P),
    displayVariable=false) annotation(Placement(transformation(extent={{40,-100},{60,-80}})));
  Modelica.Blocks.Sources.Ramp condensorTemperature(
    height(final unit="K") = 50,
    duration=1,
    offset(
      unit="K",
      displayUnit="degC") = 273.15)
                        annotation(Placement(transformation(extent={{120,0},{100,20}})));
  Modelica.Blocks.Sources.RealExpression condenserPressure(y=Medium.saturationPressure(condensorTemperature.y))
                                                          annotation(Placement(transformation(extent={{80,0},{60,20}})));
  Modelica.Blocks.Sources.RealExpression condenserOutletEnthalpy(y=Medium.bubbleEnthalpy(Medium.setSat_T(condensorTemperature.y)))
                                                                                  annotation(Placement(transformation(extent={{40,40},{20,60}})));

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
  connect(condenserPressure.y, compressor.outletSpec_prescribed) annotation(Line(points={{59,10},{52,10}}, color={0,0,127}));
  connect(condenserOutletEnthalpy.y, condensor.outletSpec_prescribed) annotation(Line(points={{19,50},{-10,50},{-10,42}}, color={0,0,127}));

  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
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
    In a second step, the evaporator and condenser pressure levels are calculated from prescribed temperatures.
  </p>

  <p>
    Again the coefficient of performance (COP) is not continuous due to interpolation artifacts in the Modelica medium 
    <a href=\"modelica://ThermofluidStream.Media.myMedia.R134a.R134a_ph\">R134a_ph</a>.
    These discontinuities are not physical and do not occur when using TIL R134a.
    Such non-smooth behavior can adversely affect controller performance and may significantly slow down the simulation.
  </p>

  <p>
    Further documentation is available in the 
    <a href=\"modelica://ThermofluidStream.Idealized.Examples.VaporCycle\">VaporCycle</a> package.
  </p>
</html>"));
end Step2Temperatures;
