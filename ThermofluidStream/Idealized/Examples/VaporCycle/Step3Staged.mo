within ThermofluidStream.Idealized.Examples.VaporCycle;
model Step3Staged
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconInertanceNeglectOpenModelica;

  replaceable package Medium = ThermofluidStream.Media.myMedia.R134a.R134a_ph
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);

  parameter Medium.Temperature T_Evaporator1 = 253.15 "Evaporator 1 temperature";
  parameter Medium.Temperature T_Condensor2 = 323.15 "Condensor 2 temperature";
  parameter SI.TemperatureDifference dT_Intermediate = 10 "Temperature difference of intermediate heat exchanger";

  final parameter Medium.Temperature T_Condensor1 = 1/2*(T_Evaporator1 + T_Condensor2) + 1/2*dT_Intermediate "Condensor 1 temperature";
  final parameter Medium.Temperature T_Evaporator2 = T_Condensor1 - dT_Intermediate "Evaporator 2 temperature";

  final parameter Medium.AbsolutePressure p_Evaporator1 = Medium.saturationPressure(T_Evaporator1) "Evaporator 1 pressure";
  final parameter Medium.AbsolutePressure p_Condensor1 = Medium.saturationPressure(T_Condensor1) "Condensor 1 pressure";
  final parameter Medium.AbsolutePressure p_Evaporator2 = Medium.saturationPressure(T_Evaporator2) "Evaporator 2 pressure";
  final parameter Medium.AbsolutePressure p_Condensor2 = Medium.saturationPressure(T_Condensor2) "Condensor 2 pressure";

  final parameter Medium.SpecificEnthalpy h_out_Evaporator1 = Medium.dewEnthalpy(Medium.setSat_T(T_Evaporator1)) "Evaporator 1 outlet specific enthalpy";
  final parameter Medium.SpecificEnthalpy h_out_Condensor1 = Medium.bubbleEnthalpy(Medium.setSat_T(T_Condensor1)) "Condensor 1 outlet specific enthalpy";
  final parameter Medium.SpecificEnthalpy h_out_Evaporator2 = Medium.dewEnthalpy(Medium.setSat_T(T_Evaporator2)) "Evaporator 2 outlet specific enthalpy";
  final parameter Medium.SpecificEnthalpy h_out_Condensor2 = Medium.bubbleEnthalpy(Medium.setSat_T(T_Condensor2)) "Condensor 2 outlet specific enthalpy";

  ThermofluidStream.Idealized.Processes.Adiabatic compressor1(
    redeclare package Medium = Medium,
    eta_fixed=0.9,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=p_Condensor1) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,-44})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true, considerInertance = false) annotation(
    Placement(transformation(extent={{80,0},{100,20}})));
  ThermofluidStream.Idealized.Processes.Isobaric condensor1(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    h_out_fixed=h_out_Condensor1,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy) annotation(Placement(transformation(extent={{-10,-10},{-30,-30}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic valve1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.OutletPressure,
    p_out_fixed=p_Evaporator1) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,-44})));
  ThermofluidStream.Idealized.Processes.Isobaric evaporator1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,

    h_out_fixed=h_out_Evaporator1) annotation(Placement(transformation(extent={{-30,-80},{-10,-60}})));
  ThermofluidStream.Idealized.Boundaries.LoopBreaker_m loopBreaker1(
    redeclare package Medium = Medium,
    m_flow_in_par=1,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    h_out_fixed=h_out_Evaporator1,
    p_out_fixed=p_Evaporator1) annotation (Placement(transformation(extent={{10,-80},{30,-60}})));
  ThermofluidStream.Utilities.showRealValue coefficientOfPerformance(
    description="COP",
    use_numberPort=false,
    number=(evaporator1.Q_flow)/(compressor1.P + compressor2.P),
    displayVariable=false) annotation(Placement(transformation(extent={{-80,20},{-60,40}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressor2(
    redeclare package Medium = Medium,
    eta_fixed=0.9,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=p_Condensor2) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,48})));
  ThermofluidStream.Idealized.Processes.Isobaric condensor2(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,

    h_out_fixed=h_out_Condensor2) annotation(Placement(transformation(extent={{10,80},{-10,60}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic valve2(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.OutletPressure,
    p_out_fixed=p_Evaporator2) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,46})));
  ThermofluidStream.Idealized.Processes.Isobaric evaporator2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    h_out_fixed=h_out_Evaporator2,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy) annotation(Placement(transformation(extent={{-30,10},{-10,30}})));
  ThermofluidStream.Idealized.Boundaries.LoopBreaker loopBreaker2(
    redeclare package Medium = Medium,
    p_out_fixed=p_Evaporator2,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    h_out_fixed=h_out_Evaporator2) annotation (Placement(transformation(extent={{10,10},{30,30}})));

equation
  connect(compressor1.outlet, condensor1.inlet) annotation(
    Line(points = {{40, -34}, {40, -20}, {-10, -20}}, color = {28, 108, 200}, thickness = 0.5));
  connect(valve1.outlet, evaporator1.inlet) annotation(
    Line(points = {{-40, -54}, {-40, -70}, {-30, -70}}, color = {28, 108, 200}, thickness = 0.5));
  connect(loopBreaker1.outlet, compressor1.inlet) annotation(
    Line(points = {{30, -70}, {40, -70}, {40, -54}}, color = {28, 108, 200}, thickness = 0.5));
  connect(condensor1.outlet, valve1.inlet) annotation(
    Line(points = {{-30, -20}, {-40, -20}, {-40, -34}}, color = {28, 108, 200}, thickness = 0.5));
  connect(evaporator1.outlet, loopBreaker1.inlet) annotation(
    Line(points = {{-10, -70}, {10, -70}}, color = {28, 108, 200}, thickness = 0.5));
  connect(compressor2.outlet, condensor2.inlet) annotation(
    Line(points = {{40, 58}, {40, 70}, {10, 70}}, color = {28, 108, 200}, thickness = 0.5));
  connect(valve2.outlet, evaporator2.inlet) annotation(
    Line(points = {{-40, 36}, {-40, 20}, {-30, 20}}, color = {28, 108, 200}, thickness = 0.5));
  connect(loopBreaker2.outlet, compressor2.inlet) annotation(
    Line(points = {{30, 20}, {40, 20}, {40, 38}}, color = {28, 108, 200}, thickness = 0.5));
  connect(condensor2.outlet, valve2.inlet) annotation(
    Line(points = {{-10, 70}, {-40, 70}, {-40, 56}}, color = {28, 108, 200}, thickness = 0.5));
  connect(evaporator2.outlet, loopBreaker2.inlet) annotation(
    Line(points = {{-10, 20}, {10, 20}}, color = {28, 108, 200}, thickness = 0.5));
  connect(condensor1.Q_flow_out, evaporator2.Q_flow_in) annotation(Line(points={{-20,-13},{-20,12}}, color={255,170,85}));

  annotation(
    Diagram(coordinateSystem(extent={{-120,-100},{120,120}}),
      graphics={
        Text(
          extent={{34,-64},{40,-70}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{34,-20},{40,-26}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-40,-20},{-34,-26}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-40,-64},{-34,-70}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{34,26},{40,20}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{34,70},{40,64}},
          textColor={28,108,200},
          textString="6"),
        Text(
          extent={{-40,70},{-34,64}},
          textColor={28,108,200},
          textString="7"),
        Text(
          extent={{-40,26},{-34,20}},
          textColor={28,108,200},
          textString="8"),
        Polygon(
          points={{-120,60},{-80,60},{-80,80},{-100,80},{-100,120},{-120,120},{-120,60}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-90,110},{-10,90}},
          textColor={244,125,35},
          horizontalAlignment=TextAlignment.Left,
          textString="requires considerInertance = false in OpenModelica
see User's Guide")}),
    Documentation(
      info="<html>
  <p>
    In a third step, a second stage is added. The stages are thermally coupled by an intermediate heat exchanger.
  </p>

  <p>
    The orange energy flow connector represents the heat transfer between <code>condenser1</code> of the lower
    cycle and <code>evaporator2</code> of the upper cycle, see <a href=\"modelica://ThermofluidStream.Idealized.UsersGuide.EnergyFlow\">UsersGuide.EnergyFlow</a>. 
  </p>

  <ul>
    <li>
      This configuration corresponds to the classic cascade heat exchanger:
      <ul>
        <li>
          The lower (low-temperature) stage rejects heat in <code>condenser1</code>.
        </li>
        <li>
          The upper (high-temperature) stage absorbs this heat in
          <code>evaporator2</code> and subsequently rejects it to the ambient in
          <code>condenser2</code>.
        </li>
      </ul>
    </li>
  </ul>

  <p>
    Index reduction requires <code>considerInertance = false</code> in Open Modelica,
    see <a href=\"modelica://ThermofluidStream.Idealized.UsersGuide.InertanceNeglect\">UsersGuide.InertanceNeglect</a>.
  </p>

  <p>
    Further documentation is available in the
    <a href=\"modelica://ThermofluidStream.Idealized.Examples.VaporCycle\">VaporCycle</a> package.
  </p>
</html>",
      revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"),
    Icon(coordinateSystem(extent={{-120,-100},{120,120}})));
end Step3Staged;
