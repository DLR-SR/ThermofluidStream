within ThermofluidStream.Idealized.Examples.VaporCycle;
model Step4Separator
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconInertanceNeglect;

  replaceable package Medium = ThermofluidStream.Media.myMedia.R134a.R134a_ph constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  parameter Medium.Temperature T_Evaporator=253.15   "Evaporator temperature";
  parameter Medium.Temperature T_Condensor=323.15   "Condensor temperature";

  final parameter Medium.AbsolutePressure p_Evaporator = Medium.saturationPressure(T_Evaporator) "Evaporator pressure";
  final parameter Medium.AbsolutePressure p_Condensor = Medium.saturationPressure(T_Condensor) "Condensor pressure";

  Medium.AbsolutePressure p_Seperator=flashChamberPressureRamp.y "Seperator pressure";

  final parameter Medium.SpecificEnthalpy h_out_Evaporator = Medium.dewEnthalpy(Medium.setSat_T(T_Evaporator)) "Evaporator outlet specific enthalpy";
  final parameter Medium.SpecificEnthalpy h_out_Condensor = Medium.bubbleEnthalpy(Medium.setSat_T(T_Condensor)) "Condensor outlet specific enthalpy";

  Medium.SpecificEnthalpy h_SeperatorBubble = Medium.bubbleEnthalpy(Medium.setSat_p(p_Seperator)) "Specific bubble enthalpy at seperator pressure";
  Medium.SpecificEnthalpy h_SeperatorDew = Medium.dewEnthalpy(Medium.setSat_p(p_Seperator)) "Specific dew enthalpy at seperator pressure";

  ThermofluidStream.Idealized.Processes.Adiabatic compressor1(
    redeclare package Medium = Medium,
    eta_fixed=0.9,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-40})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(
    considerInertance=false,                            displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{120,100},{140,120}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic valve1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.OutletPressure,

    p_out_fixed=p_Evaporator) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,-40})));
  ThermofluidStream.Idealized.Processes.Isobaric evaporator(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,

    h_out_fixed=h_out_Evaporator) annotation(Placement(transformation(extent={{-10,-80},{10,-60}})));
  Sources.LoopBreaker loopBreaker1(
    redeclare package Medium = Medium,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    h_out_fixed=h_out_Evaporator,
    p_out_fixed=p_Evaporator,
    considerInertance=false,
    showPressure=false,
    showThermalSpecification=false) annotation(Placement(transformation(extent={{20,-80},{40,-60}})));
  ThermofluidStream.Utilities.showRealValue coefficientOfPerformance(
    description="COP",
    use_numberPort=false,
    number=(evaporator.Q_flow)/(compressor1.P + compressor2.P),
    displayVariable=false) annotation(Placement(transformation(extent={{-20,14},{40,54}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressor2(
    redeclare package Medium = Medium,
    eta_fixed=0.9,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=p_Condensor) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,40})));
  ThermofluidStream.Idealized.Processes.Isobaric condensor(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,

    h_out_fixed=h_out_Condensor) annotation(Placement(transformation(extent={{10,80},{-10,60}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic valve2(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,40})));
  ThermofluidStream.Idealized.Sources.LoopBreaker loopBreaker2(
    redeclare package Medium = Medium,
    pSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    thermalValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    considerInertance=false,
    showPressure=false,
    showThermalSpecification=false) annotation(Placement(transformation(extent={{22,-4},{42,16}})));
  Modelica.Blocks.Sources.Ramp flashChamberPressureRamp(
    height=p_Condensor - p_Evaporator,
    duration=1,
    offset=p_Evaporator) annotation(Placement(transformation(extent={{-90,-10},{-70,10}})));
  Components.Separator flashChamber(redeclare package Medium = Medium, considerInertance=false) annotation(Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.RealExpression h_SeperatorDew_(y=h_SeperatorDew) annotation(Placement(transformation(extent={{82,-22},
            {70,-10}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect vaporQual_separatorLiqOut(
    redeclare package Medium = Medium,
    digits=3,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation(
    Placement(transformation(extent={{-38,-16},{-58,4}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect vaporQual_evapOut(
    redeclare package Medium = Medium,
    digits=3,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation(
    Placement(transformation(extent={{20,-44},{40,-64}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect vaporQual_evapValveOut(
    redeclare package Medium = Medium,
    digits=3,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation(
    Placement(transformation(extent={{-40,-80},{-60,-60}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect vaporQual_evapCmpOut(
    redeclare package Medium = Medium,
    digits=3,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation(
    Placement(transformation(extent={{70,4},{90,-16}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect vaporQual_condValveOut(
    redeclare package Medium = Medium,
    digits=3,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation(
    Placement(transformation(extent={{-16,30},{4,10}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect vaporQual_condOut(
    redeclare package Medium = Medium,
    digits=3,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation(
    Placement(transformation(extent={{-44,80},{-64,60}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect vaporQual_condCmpOut(
    redeclare package Medium = Medium,
    digits=3,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation(
    Placement(transformation(extent={{64,80},{84,60}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect vaporQual_separatorVapOut(
    redeclare package Medium = Medium,
    digits=3,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation(
    Placement(transformation(extent={{20,32},{40,12}})));
  EnergyFlow.Sources.FixedEnergyFlow energyFlowSource(E_flow(displayUnit="kW") = 10000) annotation(Placement(transformation(extent={{-40,-110},{-20,-90}})));
equation
  connect(valve1.outlet, evaporator.inlet) annotation(Line(
      points={{-30,-50},{-30,-70},{-10,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker1.outlet, compressor1.inlet) annotation(Line(
      points={{40,-70},{50,-70},{50,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(evaporator.outlet, loopBreaker1.inlet) annotation(Line(
      points={{10,-70},{20,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor2.outlet, condensor.inlet) annotation(Line(
      points={{50,50},{50,70},{10,70}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker2.outlet,compressor2. inlet) annotation(
    Line(
      points={{42,6},{50,6},{50,30}},
      color={28,108,200},
      thickness=0.5));
  connect(condensor.outlet, valve2.inlet) annotation(Line(
      points={{-10,70},{-30,70},{-30,50}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor1.outlet, flashChamber.inletA) annotation(Line(
      points={{50,-30},{50,-6},{10,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(valve1.inlet, flashChamber.outletLiquid) annotation(Line(
      points={{-30,-30},{-30,-6},{-10,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(valve2.outlet, flashChamber.inletB) annotation(Line(
      points={{-30,30},{-30,6},{-10,6}},
      color={28,108,200},
      thickness=0.5));
  connect(flashChamber.outletVapor, loopBreaker2.inlet) annotation(Line(
      points={{10,6},{22,6}},
      color={28,108,200},
      thickness=0.5));
  connect(flashChamberPressureRamp.y, valve2.outletSpec_prescribed) annotation(Line(points={{-69,0},{-60,0},{-60,30},{-42,30}}, color={0,0,127}));
  connect(loopBreaker2.p_out_prescribed, flashChamberPressureRamp.y) annotation(Line(points={{42,-6},{42,-24},{-60,-24},{-60,0},{-69,0}}, color={0,0,127}));
  connect(compressor1.outletSpec_prescribed, flashChamberPressureRamp.y) annotation(Line(points={{62,-30},{70,-30},{70,-24},{-60,-24},{-60,0},{-69,0}}, color={0,0,127}));
  connect(h_SeperatorDew_.y, loopBreaker2.h_out_prescribed) annotation(Line(points={{69.4,-16},{34,-16},{34,-6}}, color={0,0,127}));
  connect(vaporQual_separatorLiqOut.inlet, flashChamber.outletLiquid) annotation(Line(
      points={{-38,-6},{-10,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(vaporQual_evapValveOut.inlet, valve1.outlet) annotation(
    Line(
      points={{-40,-70},{-30,-70},{-30,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(vaporQual_evapOut.inlet, evaporator.outlet) annotation(
    Line(
      points={{20,-54},{14,-54},{14,-70},{10,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(vaporQual_evapCmpOut.inlet, compressor1.outlet) annotation(
    Line(
      points={{70,-6},{50,-6},{50,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(vaporQual_condValveOut.inlet, valve2.outlet) annotation(
    Line(
      points={{-16,20},{-30,20},{-30,30}},
      color={28,108,200},
      thickness=0.5));
  connect(vaporQual_condOut.inlet, condensor.outlet) annotation(
    Line(
      points={{-44,70},{-10,70}},
      color={28,108,200},
      thickness=0.5));
  connect(vaporQual_condCmpOut.inlet, compressor2.outlet) annotation(
    Line(
      points={{64,70},{50,70},{50,50}},
      color={28,108,200},
      thickness=0.5));
  connect(vaporQual_separatorVapOut.inlet, flashChamber.outletVapor) annotation(Line(
      points={{20,22},{16,22},{16,6},{10,6}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out, evaporator.Q_flow_in) annotation(Line(points={{-19,-100},{0,-100},{0,-78}}, color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},{140,120}}),
        graphics={
        Text(
          extent={{44,-54},{50,-60}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{44,-6},{50,-12}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-30,-6},{-24,-12}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-30,-54},{-24,-60}},
          textColor={28,108,200},
          textString="4"),
        Line(
          points={{-30,40},{-30,6},{50,6},{50,40}},
          color={122,200,161},
          thickness=8),
        Line(
          points={{-30,40},{-30,70},{50,70},{50,40}},
          color={243,203,196},
          thickness=8),
        Polygon(
          points={{-4,6},{-4,-2},{0,-6},{4,-2},{4,6},{0,2},{-4,6}},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid,
          origin={-30,24},
          rotation=360,
          lineColor={0,140,72}),
        Polygon(
          points={{-4,6},{-4,-2},{0,-6},{4,-2},{4,6},{0,2},{-4,6}},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid,
          origin={-18,6},
          rotation=90,
          lineColor={0,140,72}),
        Polygon(
          points={{-4,6},{-4,-2},{0,-6},{4,-2},{4,6},{0,2},{-4,6}},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid,
          origin={50,20},
          rotation=180,
          lineColor={0,140,72}),
        Polygon(
          points={{6,-4},{-2,-4},{-6,-8.88178e-16},{-2,4},{6,4},{2,0},{6,-4}},
          fillColor={233,147,133},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={50,56},
          rotation=270,
          lineColor={233,147,133}),
        Polygon(
          points={{6,-4},{-2,-4},{-6,-8.88178e-16},{-2,4},{6,4},{2,0},{6,-4}},
          fillColor={233,147,133},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={18,70},
          rotation=360,
          lineColor={233,147,133}),
        Polygon(
          points={{6,-4},{-2,-4},{-6,-8.88178e-16},{-2,4},{6,4},{2,0},{6,-4}},
          fillColor={233,147,133},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={-30,58},
          rotation=90,
          lineColor={233,147,133}),
        Line(
          points={{-30,-38},{-30,-6},{50,-6},{50,-40}},
          color={122,200,161},
          thickness=8),
        Polygon(
          points={{-4,6},{-4,-2},{0,-6},{4,-2},{4,6},{0,2},{-4,6}},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid,
          origin={-30,-16},
          rotation=360,
          lineColor={0,140,72}),
        Polygon(
          points={{-4,6},{-4,-2},{0,-6},{4,-2},{4,6},{0,2},{-4,6}},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid,
          origin={50,-24},
          rotation=180,
          lineColor={0,140,72}),
        Polygon(
          points={{-4,6},{-4,-2},{0,-6},{4,-2},{4,6},{0,2},{-4,6}},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid,
          origin={20,-6},
          rotation=270,
          lineColor={0,140,72}),
        Line(
          points={{23,-134},{-7,-134},{-7,-54},{23,-54}},
          color={170,170,255},
          thickness=8,
          origin={-84,-63},
          rotation=90),
        Polygon(
          points={{-4,6},{-4,-2},{0,-6},{4,-2},{4,6},{0,2},{-4,6}},
          fillColor={106,106,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={106,106,255},
          origin={-30,-56},
          rotation=360),
        Polygon(
          points={{-4,6},{-4,-2},{0,-6},{4,-2},{4,6},{0,2},{-4,6}},
          fillColor={106,106,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={106,106,255},
          origin={-18,-70},
          rotation=90),
        Polygon(
          points={{-4,6},{-4,-2},{0,-6},{4,-2},{4,6},{0,2},{-4,6}},
          fillColor={106,106,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={106,106,255},
          origin={50,-58},
          rotation=180),
        Polygon(
          points={{-140,60},{-100,60},{-100,80},{-120,80},{-120,120},{-140,120},{-140,60}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-110,110},{-30,90}},
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
    In a forth step, the intermediate heat exchanger is replaced by a <code>flashChamber</code> operating at an intermediate pressure level.
    The evaporator and condenser temperature and the cooling heat flow rate are set. The flashChamber pressure level is varied linearly over time between the lower and higher pressure level
    and the coefficient of performance (COP) is evaluated.
  </p>

  <p>
    The COP is not continuous due to interpolation artifacts in the Modelica medium 
    <a href=\"modelica://ThermofluidStream.Media.myMedia.R134a.R134a_ph\">R134a_ph</a>.
    These discontinuities are not physical and do not occur when using TIL R134a.
    Such non-smooth behavior can adversely affect controller performance and may significantly slow down the simulation.
  </p>

  <p>
    Since the flashChamber pressure is varying with time the inverse calculation of the mass flow rate in the upper loop 
    based on the mass flow rate in the lower loop requires <code>considerInertance = false</code>, also see 
    <a href=\"modelica://ThermoFluidStream.Idealized.UsersGuide.neglectInertance\">UsersGuide.neglectInertance</a>.
  </p>

  <p>
    Further documentation is available in the
    <a href=\"modelica://ThermoFluidStream.Idealized.Examples.VaporCycle\">VaporCycle</a> package.
  </p>
</html>"));
end Step4Separator;
