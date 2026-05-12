within ThermofluidStream.Idealized.Examples.JouleBrayton;
model Step3Staged
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{140,80},{160,100}})));

  Processes.Adiabatic lowPressureCompressor(
    redeclare package Medium = Medium,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed,
    pr_fixed=2,
    p_out_fixed=200000) annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Processes.Adiabatic highPressureTurbine(
    redeclare package Medium = Medium,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  ThermofluidStream.Boundaries.Source
                    airSource(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation (Placement(transformation(extent={{-156,-10},{-136,10}})));
  Processes.Isobaric firstCombustion(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,

    T_out_fixed=1673.15) annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Sources.Ramp intermediatePressure(
    height=18.98e5,
    duration=1,
    offset=1.01e5)
                annotation (Placement(transformation(extent={{-150,-50},{-130,-30}})));
  ThermofluidStream.Utilities.showRealValue efficiencySpecific(
    description="efficiency specific",
    use_numberPort=false,
    number=(-highPressureTurbine.dh - lowPressureTurbine.dh - highPressureCompressor.dh - lowPressureCompressor.dh)/(
        firstCombustion.dh + secondCombustion.dh),
    displayVariable=false) annotation (Placement(transformation(extent={{0,40},{20,60}})));
  ThermofluidStream.HeatExchangers.CounterFlowNTU recuperator(
    redeclare package MediumA = Medium,
    redeclare package MediumB = Medium,
    A=10,
    k_NTU=200) annotation (Placement(transformation(extent={{-30,-4},{-10,16}})));
  Sink_m airSink(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-38,44})));
  Processes.Isobaric cooler(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,

    T_out_fixed=293.15) annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Processes.Adiabatic highPressureCompressor(
    redeclare package Medium = Medium,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,

    p_out_fixed=2000000) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Processes.Isobaric secondCombustion(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,

    T_out_fixed=1673.15) annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Processes.Adiabatic lowPressureTurbine(
    redeclare package Medium = Medium,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,

    p_out_fixed=100000) annotation (Placement(transformation(extent={{130,-10},{150,10}})));
equation
  connect(airSource.outlet, lowPressureCompressor.inlet)
    annotation (Line(
      points={{-136,0},{-120,0}},
      color={28,108,200},
      thickness=0.5));
  connect(airSink.inlet, recuperator.outletB)
    annotation (Line(
      points={{-38,34},{-38,12},{-30,12}},
      color={28,108,200},
      thickness=0.5));
  connect(lowPressureCompressor.outlet, cooler.inlet)
    annotation (Line(
      points={{-100,0},{-90,0}},
      color={28,108,200},
      thickness=0.5));
  connect(cooler.outlet, highPressureCompressor.inlet)
    annotation (Line(
      points={{-70,0},{-60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(recuperator.outletA, firstCombustion.inlet)
    annotation (Line(
      points={{-10,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(highPressureCompressor.outlet, recuperator.inletA)
    annotation (Line(
      points={{-40,0},{-30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(firstCombustion.outlet, highPressureTurbine.inlet)
    annotation (Line(
      points={{30,0},{50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(highPressureTurbine.outlet, secondCombustion.inlet)
    annotation (Line(
      points={{70,0},{90,0}},
      color={28,108,200},
      thickness=0.5));
  connect(secondCombustion.outlet, lowPressureTurbine.inlet)
    annotation (Line(
      points={{110,0},{130,0}},
      color={28,108,200},
      thickness=0.5));
  connect(lowPressureTurbine.outlet, recuperator.inletB) annotation (Line(
      points={{150,0},{158,0},{158,18},{-4,18},{-4,12},{-10,12}},
      color={28,108,200},
      thickness=0.5));
  connect(intermediatePressure.y, lowPressureCompressor.outletSpec_prescribed) annotation (Line(points={{-129,-40},{-100,-40},{-100,-12}}, color={0,0,127}));
  connect(highPressureTurbine.outletSpec_prescribed, intermediatePressure.y) annotation (Line(points={{70,-12},{70,-40},{-129,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-100},{160,100}}), graphics={
        Text(
          extent={{-132,6},{-126,0}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-98,6},{-92,0}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-68,6},{-62,0}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-38,6},{-32,0}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{-4,6},{2,0}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{36,6},{42,0}},
          textColor={28,108,200},
          textString="6"),
        Text(
          extent={{76,6},{82,0}},
          textColor={28,108,200},
          textString="7"),
        Text(
          extent={{116,6},{122,0}},
          textColor={28,108,200},
          textString="8"),
        Text(
          extent={{152,6},{158,0}},
          textColor={28,108,200},
          textString="9"),
        Text(
          extent={{-38,18},{-32,12}},
          textColor={28,108,200},
          textString="10")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    In a third step the compression is splitted into 2 stages with an intercooler and the expansion is likewise splitted into 2 stages with a second combusion. With this efficiency can be increased.
  </p>

  <p>
    The optimum pressure ratio is smaller compared to the configuration with 1 stage only.
  </p>

  <p>
    Further documentation is available in the 
    <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Examples.JouleBrayton\">JouleBrayton</a> package.
  </p>
</html>"));
end Step3Staged;
