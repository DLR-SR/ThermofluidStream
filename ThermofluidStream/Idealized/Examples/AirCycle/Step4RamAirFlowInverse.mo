within ThermofluidStream.Idealized.Examples.AirCycle;
model Step4RamAirFlowInverse
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconNeglectInertance;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
                            annotation(
    Placement(transformation(extent={{80,80},{100,100}})));

  ThermofluidStream.Boundaries.Source airSource(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.Ramp pressure(
    height=2e5,
    duration=1,
    offset=1e5 + 1)
                annotation(Placement(transformation(extent={{-80,-50},{-60,-30}})));
  ThermofluidStream.Utilities.showRealValue coefficientOfPerformance(
    description="COP",
    use_numberPort=false,
    number=(inletSpecificEnthalpy.value - outletSpecificEnthalpy.value)/(compressor.dh + turbine.dh),
    displayVariable=false) "Warning: COP goes to infinity  for compressor.eta= turbine.eta = 1 and dp = 0 (no error of the model). " annotation(Placement(transformation(extent={{0,-60},{20,-40}})));
  Boundaries.Sink_m airSink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{70,-10},{90,10}})));
  ThermofluidStream.Boundaries.Source
                                coolingAirSource(
    redeclare package Medium = Medium,
    neglectInertance=true,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{50,40},{30,60}})));
  Sources.Sink_free coolingAirSink(redeclare package Medium = Medium,
      neglectInertance=true) annotation(
    Placement(transformation(extent={{-30,40},{-50,60}})));
  Processes.Isobaric heatExchangerSideA(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed=293.15) annotation(Placement(transformation(extent={{-10,10},{10,-10}})));
  Processes.Isobaric heatExchangerSideB(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.TemperatureDifference,
    dT_fixed=10) annotation(Placement(transformation(extent={{10,40},{-10,60}})));
  Processes.Adiabatic compressor(
    redeclare package Medium = Medium,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-52,-10},{-32,10}})));
  Processes.Adiabatic turbine(
    redeclare package Medium = Medium,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=100000) annotation(Placement(transformation(extent={{30,-10},{50,10}})));
  ThermofluidStream.Sensors.SingleSensorSelect inletSpecificEnthalpy(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg,
    outputValue=false) annotation(Placement(transformation(extent={{-70,10},{-50,30}})));
  ThermofluidStream.Sensors.SingleSensorSelect outletSpecificEnthalpy(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg,
    outputValue=false) annotation(Placement(transformation(extent={{62,12},{82,32}})));
equation
  connect(airSource.outlet, compressor.inlet) annotation(Line(
      points={{-80,0},{-52,0}},
      color={28,108,200},
      thickness=0.5));
  connect(coolingAirSink.inlet, heatExchangerSideB.outlet) annotation(Line(
      points={{-30,50},{-10,50}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerSideB.inlet, coolingAirSource.outlet) annotation(Line(
      points={{10,50},{30,50}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.outlet, heatExchangerSideA.inlet) annotation(Line(
      points={{-32,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerSideA.outlet, turbine.inlet) annotation(Line(
      points={{10,0},{30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine.outlet, airSink.inlet) annotation(Line(
      points={{50,0},{70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pressure.y, compressor.outletSpec_prescribed) annotation(Line(points={{-59,-40},{-32,-40},{-32,-12}}, color={0,0,127}));
  connect(inletSpecificEnthalpy.inlet, airSource.outlet) annotation(Line(
      points={{-70,20},{-76,20},{-76,0},{-80,0}},
      color={28,108,200},
      thickness=0.5));
  connect(outletSpecificEnthalpy.inlet, turbine.outlet) annotation(Line(
      points={{62,22},{56,22},{56,0},{50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerSideA.Q_flow_out, heatExchangerSideB.Q_flow_in) annotation(Line(points={{0,7},{0,42}}, color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{120,120}}),
        graphics={
        Text(
          extent={{-74,6},{-68,0}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-26,6},{-20,0}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{14,6},{20,0}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{60,6},{66,0}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{20,56},{26,50}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{-20,56},{-14,50}},
          textColor={28,108,200},
          textString="6"),
        Polygon(
          points={{-120,60},{-80,60},{-80,80},{-100,80},{-100,120},{-120,120},{-120,60}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-90,110},{-10,90}},
          textColor={238,46,47},
          textString="requires neglectInertance = true
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
    In a fourth step, the ram air mass flow rate is determined based on the specified temperature difference at <code>heatExchangerSideB</code>.
  </p>

  <p>
    Since the compressor outlet pressure is varying with time this inverse calculation requires <code>neglectInertance = true</code>, also see 
    <a href=\"modelica://ThermoFluidStream.Idealized.UsersGuide.neglectInertance\">UsersGuide.neglectInertance</a>.
  </p>

  <p>
    Further documentation is available in the 
    <a href=\"modelica://ThermoFluidStream.Idealized.Examples.AirCycle\">AirCycle</a> package.
  </p>
</html>"));
end Step4RamAirFlowInverse;
