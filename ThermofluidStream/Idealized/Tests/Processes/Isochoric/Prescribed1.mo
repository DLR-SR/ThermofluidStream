within ThermofluidStream.Idealized.Tests.Processes.Isochoric;
model Prescribed1 "Example - Isochoric process"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);
  SI.MassFlowRate m_flow = firstOrder.y "Mass flow rate";
  Medium.AbsolutePressure p_in = inletPressure.y "Inlet pressure";
  Medium.Temperature T_in = inletTemperature.y "Inlet temperature";
  SI.TemperatureDifference dT = temperatureDifference.y "Temperature difference";
  Medium.Temperature T_out = T_in + dT "Outlet temperature";
  Medium.Density rho = Medium.density(state_in) "Density";
  Medium.ThermodynamicState state_in = Medium.setState_pTX(p_in, T_in, Medium.X_default) "Inlet state";
  Medium.ThermodynamicState state_out = Medium.setState_dTX(rho, T_out, Medium.X_default) "Outlet state";
  SI.SpecificEnthalpy h_in = Medium.specificEnthalpy(state_in) "Inlet specific enthalpy";
  SI.SpecificEnthalpy h_out = Medium.specificEnthalpy(state_out) "Outlet specific enthalpy";
  SI.Pressure p_out = Medium.pressure(state_out) "Outlet pressure";
  SI.SpecificEnergy u_in = h_in - p_in/rho "Inlet specific internal energy";
  SI.SpecificEnergy u_out = h_out - p_out/rho "Outlet specific internal energy";
  SI.SpecificEnergy du = u_out - u_in "Specific internal energy difference";
  SI.HeatFlowRate Q_flow = m_flow*du "Heat flow rate";

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{140,80},{160,100}})));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-50,20},{-30,40}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{10,20},{30,40}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT1c(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                       annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{50,20},{70,40}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{110,20},{130,40}})));
  ThermofluidStream.Idealized.Processes.Isochoric T_out1c(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                       annotation (Placement(transformation(extent={{80,20},{100,40}})));
  .ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true) annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  .ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                       annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  .ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true) annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  .ThermofluidStream.Boundaries.Sink_m sink3(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{110,-40},{130,-20}})));
  ThermofluidStream.Idealized.Processes.Isochoric T_out1(
    redeclare package Medium = Medium,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                       annotation (Placement(transformation(extent={{80,-40},{100,-20}})));

  Modelica.Blocks.Sources.SawTooth inletPressure(
    amplitude=1e5,
    period=1,
    offset=1e5,
    startTime=0.1) annotation(Placement(transformation(extent={{-100,70},{-80,90}})));
  Modelica.Blocks.Sources.SawTooth inletTemperature(
    amplitude=100,
    period=1,
    offset=293.15,
    startTime=0.2) annotation(Placement(transformation(extent={{-100,30},{-80,50}})));
  Modelica.Blocks.Sources.SawTooth temperatureDifference(
    amplitude=-40,
    period=1,
    offset=20,
    startTime=0.3) annotation(Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.RealExpression outletTemperature(y=T_out) annotation(Placement(transformation(extent={{-100,-50},{-80,-30}})));
  Modelica.Blocks.Sources.SawTooth massFlowRate(
    amplitude=-2,
    period=1,
    offset=1,
    startTime=0.4) annotation(Placement(transformation(extent={{-140,-90},{-120,-70}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    k=1,
    T=0.01,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0) annotation(Placement(transformation(extent={{-100,-90},{-80,-70}})));
equation
  connect(source.outlet, dT1c.inlet) annotation (Line(
      points={{-30,30},{-20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1c.outlet, sink.inlet) annotation (Line(
      points={{0,30},{10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, T_out1c.inlet) annotation (Line(
      points={{70,30},{80,30}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out1c.outlet, sink1.inlet) annotation (Line(
      points={{100,30},{110,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, dT1.inlet) annotation (Line(
      points={{-30,-30},{-20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1.outlet,sink2. inlet) annotation (Line(
      points={{0,-30},{10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, T_out1.inlet) annotation (Line(
      points={{70,-30},{80,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out1.outlet,sink3. inlet) annotation (Line(
      points={{100,-30},{110,-30}},
      color={28,108,200},
      thickness=0.5));

  connect(inletPressure.y, source.p0_var) annotation (Line(points={{-79,80},{-50,80},{-50,36},{-42,36}}, color={0,0,127}));
  connect(source1.p0_var, inletPressure.y) annotation (Line(points={{58,36},{50,36},{50,80},{-79,80}}, color={0,0,127}));
  connect(source2.p0_var, inletPressure.y) annotation (Line(points={{-42,-24},{-50,-24},{-50,80},{-79,80}}, color={0,0,127}));
  connect(source3.p0_var, inletPressure.y) annotation (Line(points={{58,-24},{50,-24},{50,80},{-79,80}}, color={0,0,127}));
  connect(inletTemperature.y, source.T0_var) annotation (Line(points={{-79,40},{-54,40},{-54,30},{-42,30}}, color={0,0,127}));
  connect(source1.T0_var, inletTemperature.y) annotation (Line(points={{58,30},{46,30},{46,76},{-54,76},{-54,40},{-79,40}}, color={0,0,127}));
  connect(source3.T0_var, inletTemperature.y) annotation (Line(points={{58,-30},{46,-30},{46,76},{-54,76},{-54,40},{-79,40}}, color={0,0,127}));
  connect(source2.T0_var, inletTemperature.y) annotation (Line(points={{-42,-30},{-54,-30},{-54,40},{-79,40}}, color={0,0,127}));
  connect(temperatureDifference.y, dT1c.outletSpec_prescribed) annotation (Line(points={{-79,0},{-20,0},{-20,18}}, color={0,0,127}));
  connect(dT1.outletSpec_prescribed, temperatureDifference.y) annotation (Line(points={{-20,-42},{-20,-48},{-58,-48},{-58,0},{-79,0}}, color={0,0,127}));
  connect(T_out1c.outletSpec_prescribed, outletTemperature.y) annotation (Line(points={{80,18},{80,-4},{-62,-4},{-62,-40},{-79,-40}}, color={0,0,127}));
  connect(T_out1.outletSpec_prescribed, outletTemperature.y) annotation (Line(points={{80,-42},{80,-52},{-62,-52},{-62,-40},{-79,-40}}, color={0,0,127}));
  connect(massFlowRate.y, firstOrder.u) annotation (Line(points={{-119,-80},{-102,-80}}, color={0,0,127}));
  connect(firstOrder.y, sink.m_flow_prescribed) annotation (Line(points={{-79,-80},{32,-80},{32,30},{22,30}}, color={0,0,127}));
  connect(sink2.m_flow_prescribed, firstOrder.y) annotation (Line(points={{22,-30},{32,-30},{32,-80},{-79,-80}}, color={0,0,127}));
  connect(sink1.m_flow_prescribed, firstOrder.y) annotation (Line(points={{122,30},{132,30},{132,-80},{-79,-80}}, color={0,0,127}));
  connect(sink3.m_flow_prescribed, firstOrder.y) annotation (Line(points={{122,-30},{132,-30},{132,-80},{-79,-80}}, color={0,0,127}));
  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Documentation(
      info="<html>
  <p>
    This example illustrates several variants of using the 
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.Isochoric\">Isochoric</a> process defined by time-varying inputs (outlet state and mass flow rate given)
  </p>

  <p>
    <code>m_flow = 0</code> and/or <code>dT = 0</code> are supported.
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
    Diagram(coordinateSystem(extent={{-160,-100},{160,100}})));
end Prescribed1;
