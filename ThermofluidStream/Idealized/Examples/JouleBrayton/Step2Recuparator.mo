within ThermofluidStream.Idealized.Examples.JouleBrayton;
model Step2Recuparator
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{80,80},{100,100}})));

  Processes.Adiabatic compressor(
    redeclare package Medium = Medium,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-52,-16},{-32,4}})));
  Processes.Adiabatic turbine(
    redeclare package Medium = Medium,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=100000) annotation(Placement(transformation(extent={{68,-16},{88,4}})));
  ThermofluidStream.Boundaries.Source
                    airSource(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-92,-16},{-72,4}})));
  Processes.Isobaric combustion(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed=1673.15) annotation(Placement(transformation(extent={{28,-16},{48,4}})));
  Modelica.Blocks.Sources.Ramp outletPressure(
    height=19e5,
    duration=1,
    offset=1e5) annotation(Placement(transformation(extent={{-68,-52},{-48,-32}})));
  ThermofluidStream.Utilities.showRealValue efficiencyExtensive(
    description="efficiency extensive",
    use_numberPort=false,
    number=-(turbine.P + compressor.P)/(combustion.Q_flow),
    displayVariable=false) annotation(Placement(transformation(extent={{0,60},{20,80}})));
  ThermofluidStream.Utilities.showRealValue efficiencySpecific(
    description="efficiency specific",
    use_numberPort=false,
    number=-(turbine.dh + compressor.dh)/(combustion.dh),
    displayVariable=false) annotation(Placement(transformation(extent={{0,40},{20,60}})));
  ThermofluidStream.HeatExchangers.CounterFlowNTU recuperator(
    redeclare package MediumA = Medium,
    redeclare package MediumB = Medium,
    A=10,
    k_NTU=200,
    TC=0.01)   annotation(Placement(transformation(extent={{-10,-10},{10,10}})));
  Boundaries.Sink_m airSink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,40})));
equation
  connect(combustion.outlet, turbine.inlet) annotation(
    Line(
      points={{48,-6},{68,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.outlet, recuperator.inletA) annotation(
    Line(
      points={{-32,-6},{-10,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(recuperator.outletA, combustion.inlet) annotation(
    Line(
      points={{10,-6},{28,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(airSink.inlet, recuperator.outletB) annotation(
    Line(
      points={{-30,30},{-30,6},{-10,6}},
      color={28,108,200},
      thickness=0.5));
  connect(recuperator.inletB, turbine.outlet) annotation(
    Line(
      points={{10,6},{96,6},{96,-6},{88,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(airSource.outlet, compressor.inlet) annotation(
    Line(
      points={{-72,-6},{-52,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(outletPressure.y, compressor.outletSpec_prescribed) annotation(Line(points={{-47,-42},{-32,-42},{-32,-18}}, color={0,0,127}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false),
                                           graphics={
        Text(
          extent={{-66,0},{-60,-6}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-24,0},{-18,-6}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{18,0},{24,-6}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{54,0},{60,-6}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{90,0},{96,-6}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{-30,12},{-24,6}},
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
    In a second step a recuperator is added which increases the efficiency.<br>
  </p>

  <p>
    There exists an optimum pressure ratio with maximum overall efficiency.
  </p>

  <p>
    Note, that the recuperator requires a time constant that can interfere with the pressure ramp.
  </p>

  <p>
    Further documentation is available in the 
    <a href=\"modelica://ThermofluidStream.Idealized.Examples.JouleBrayton\">JouleBrayton</a> package.
  </p>
</html>"));
end Step2Recuparator;
