within ThermofluidStream.Idealized.Examples.AirCycle;
model Step8BootStrapCycleFilter
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{120,80},{140,100}})));

  ThermofluidStream.Idealized.Processes.Adiabatic compressor(
    redeclare package Medium = Medium,
    eta_fixed=0.9,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,

    p_out_fixed=150000) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  ThermofluidStream.Boundaries.Source airSource(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation (Placement(transformation(extent={{-116,-10},{-96,10}})));
  ThermofluidStream.Idealized.Processes.Isobaric cooler(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,

    T_out_fixed=293.15) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  ThermofluidStream.Utilities.showRealValue coefficientOfPerformance(
    description="COP",
    use_numberPort=false,
    number=(-cooler.Q_flow - cooler2.Q_flow)/(compressor.P + Modelica.Constants.eps),
    displayVariable=false) annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Sink_m airSink(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic valve(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isenthalpic.OutletPressure,
    p_out_fixed=100000) annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  Sources.MassFlowRate massFlowRateSource(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  Modelica.Blocks.Sources.Ramp massFlowRate(
    height=1,
    duration=1,
    offset=1,
    startTime=0)
              annotation (Placement(transformation(extent={{142,-10},{122,10}})));
  Modelica.Blocks.Sources.Ramp massFlowRateValve(
    height=2,
    duration=1,
    offset=0,
    startTime=0)
              annotation (Placement(transformation(extent={{-40,-56},{-20,-36}})));
  Topology.JunctionT1 junctionT1_1(displayInstanceName=false, redeclare package Medium = Medium) annotation (Placement(transformation(extent={{60,10},{80,-10}})));
  ThermofluidStream.Topology.SplitterT1 splitter(displayInstanceName=false, redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  ThermofluidStream.Idealized.Processes.Isobaric cooler2(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.TemperatureDifference,

    dT_fixed=-50) annotation (Placement(transformation(extent={{20,50},{40,70}})));
  ThermofluidStream.Idealized.Processes.Adiabatic turbine(
    displayInstanceName=true,
    displayParameters=true,
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.7,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,

    p_out_fixed=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,30})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressor1(
    displayInstanceName=true,
    displayParameters=true,
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    enableFilter=true,
    TC=0.1,
    P_nom(displayUnit="kW") = 30000,
    dp_nom=50000,
    eta_fixed=0.7,
    specifyOutlet=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,30})));
equation
  connect(compressor.outlet, cooler.inlet)
    annotation (Line(
      points={{-60,0},{-40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(airSource.outlet, compressor.inlet)
    annotation (Line(
      points={{-96,0},{-80,0}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateSource.outlet, valve.inlet)
    annotation (Line(
      points={{30,-30},{40,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRateValve.y, massFlowRateSource.m_flow_prescribed)
    annotation (Line(points={{-19,-46},{20,-46},{20,-38}}, color={0,0,127}));
  connect(valve.outlet, junctionT1_1.inletA)
    annotation (Line(
      points={{60,-30},{70,-30},{70,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT1_1.outlet,airSink. inlet)
    annotation (Line(
      points={{80,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(cooler.outlet, splitter.inlet)
    annotation (Line(
      points={{-20,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter.outletB, massFlowRateSource.inlet)
    annotation (Line(
      points={{0,-10},{0,-30},{10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine.outlet, junctionT1_1.inletB)
    annotation (Line(
      points={{70,20},{70,10}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor1.inlet, splitter.outletA)
    annotation (Line(
      points={{0,20},{0,10}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor1.outlet, cooler2.inlet)
    annotation (Line(
      points={{0,40},{0,60},{20,60}},
      color={28,108,200},
      thickness=0.5));
  connect(cooler2.outlet, turbine.inlet)
    annotation (Line(
      points={{40,60},{70,60},{70,40}},
      color={28,108,200},
      thickness=0.5));
  connect(airSink.m_flow_prescribed, massFlowRate.y) annotation (Line(points={{112,0},{121,0}}, color={0,0,127}));
  connect(turbine.P_out, compressor1.P_in) annotation (Line(points={{63,30},{8,30}}, color={255,170,85}));
  annotation (experiment(startTime = -1), Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-140,-100},{140,100}}), graphics={
        Text(
          extent={{-92,6},{-86,0}},
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
          extent={{0,60},{6,54}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{64,60},{70,54}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{64,20},{70,14}},
          textColor={28,108,200},
          textString="6"),
        Text(
          extent={{64,-24},{70,-30}},
          textColor={28,108,200},
          textString="7"),
        Text(
          extent={{86,6},{92,0}},
          textColor={28,108,200},
          textString="8")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    In an eighth step, a filter is added for the compressor outlet pressure to avoid forming an implicit nonlinear equation.
    The introduced state also requires appropriate start values. Additionally, the time integration may be implicit 
    and could solve nonlinear equations as well.
  </p>
  
  <p>
    The filter time constant should be chosen sufficiently small to avoid interfering with the pressure ramp.
  </p>

  <p>
    Further documentation is available in the 
    <a href=\"modelica://ThermoFluidStream.Idealized.Examples.AirCycle\">AirCycle</a> package.
  </p>
</html>"));
end Step8BootStrapCycleFilter;
