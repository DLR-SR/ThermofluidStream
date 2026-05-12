within ThermofluidStream.Idealized.Tests.Processes.Isochoric;
model Prescribed "Example - Isochoric process"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

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

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{140,140},{160,160}})));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                   annotation (Placement(transformation(extent={{-40,120},{-20,140}})));
  Sink_m sink(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{20,120},{40,140}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Cycle.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-10,120},{10,140}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                   annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Sink_m sink1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  ThermofluidStream.Idealized.Processes.Isochoric T_out1(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Cycle.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                   annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink2(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{20,70},{40,90}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Cycle.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  EnergyFlow.Sources.PrescribedEnergyFlow
                                     energyFlowSource                annotation (Placement(transformation(extent={{120,-20},{100,0}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                   annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  ThermofluidStream.Idealized.Sources.Sink_free sink3(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  ThermofluidStream.Idealized.Processes.Isochoric T_out2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Cycle.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                   annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Sink_m sink4(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{20,20},{40,40}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT3(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Cycle.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Modelica.Blocks.Sources.SawTooth inletPressure(
    amplitude=1e5,
    period=1,
    offset=1e5,
    startTime=0.1) annotation (Placement(transformation(extent={{-140,126},{-120,146}})));
  Modelica.Blocks.Sources.SawTooth inletTemperature(
    amplitude=100,
    period=1,
    offset=293.15,
    startTime=0.2) annotation (Placement(transformation(extent={{-140,70},{-120,90}})));
  Modelica.Blocks.Sources.SawTooth massFlowRate(
    amplitude=4,
    period=1,
    offset=1,
    startTime=0.4) annotation (Placement(transformation(extent={{160,20},{140,40}})));
  Modelica.Blocks.Sources.SawTooth temperatureDifference(
    amplitude=-40,
    period=1,
    offset=20,
    startTime=0.3) annotation (Placement(transformation(extent={{-140,16},{-120,36}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    k=1,
    T=0.01,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1) annotation (Placement(transformation(extent={{120,20},{100,40}})));
  Modelica.Blocks.Sources.RealExpression heatFlowRate(y=Q_flow) annotation (Placement(transformation(extent={{160,-20},{140,0}})));
  Modelica.Blocks.Sources.RealExpression outletTemperature(y=T_out) annotation (Placement(transformation(extent={{-140,-50},{-120,-30}})));
equation
  connect(source.outlet,dT1. inlet) annotation (Line(
      points={{-20,130},{-10,130}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1.outlet, sink.inlet) annotation (Line(
      points={{10,130},{20,130}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, T_out1.inlet) annotation (Line(
      points={{-20,-20},{-10,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out1.outlet, sink1.inlet) annotation (Line(
      points={{10,-20},{20,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, dT2.inlet) annotation (Line(
      points={{-20,80},{-10,80}},
      color={28,108,200},
      thickness=0.5));
  connect(dT2.outlet, sink2.inlet) annotation (Line(
      points={{10,80},{20,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, T_out2.inlet) annotation (Line(
      points={{-20,-70},{-10,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out2.outlet, sink3.inlet) annotation (Line(
      points={{10,-70},{20,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet, dT3.inlet) annotation (Line(
      points={{-20,30},{-10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(dT3.outlet, sink4.inlet) annotation (Line(
      points={{10,30},{20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source.p0_var, inletPressure.y) annotation (Line(points={{-32,136},{-119,136}}, color={0,0,127}));
  connect(source2.p0_var, inletPressure.y) annotation (Line(points={{-32,86},{-100,86},{-100,136},{-119,136}}, color={0,0,127}));
  connect(source4.p0_var, inletPressure.y) annotation (Line(points={{-32,36},{-100,36},{-100,136},{-119,136}}, color={0,0,127}));
  connect(source1.p0_var, inletPressure.y) annotation (Line(points={{-32,-14},{-100,-14},{-100,136},{-119,136}}, color={0,0,127}));
  connect(source3.p0_var, inletPressure.y) annotation (Line(points={{-32,-64},{-100,-64},{-100,136},{-119,136}}, color={0,0,127}));
  connect(inletTemperature.y, source2.T0_var) annotation (Line(points={{-119,80},{-32,80}}, color={0,0,127}));
  connect(source.T0_var, inletTemperature.y) annotation (Line(points={{-32,130},{-104,130},{-104,80},{-119,80}}, color={0,0,127}));
  connect(source4.T0_var, inletTemperature.y) annotation (Line(points={{-32,30},{-104,30},{-104,80},{-119,80}}, color={0,0,127}));
  connect(source1.T0_var, inletTemperature.y) annotation (Line(points={{-32,-20},{-104,-20},{-104,80},{-119,80}}, color={0,0,127}));
  connect(source3.T0_var, inletTemperature.y) annotation (Line(points={{-32,-70},{-104,-70},{-104,80},{-119,80}}, color={0,0,127}));
  connect(dT2.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{0,72},{0,54},{72,54},{72,-10},{99,-10}}, color={255,170,85}));
  connect(dT3.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{0,22},{0,8},{72,8},{72,-10},{99,-10}}, color={255,170,85}));
  connect(T_out2.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{0,-78},{0,-92},{72,-92},{72,-10},{99,-10}}, color={255,170,85}));
  connect(dT1.outletSpec_prescribed, temperatureDifference.y) annotation (Line(points={{10,118},{10,108},{-96,108},{-96,26},{-119,26}}, color={0,0,127}));
  connect(dT2.outletSpec_prescribed, temperatureDifference.y) annotation (Line(points={{10,68},{10,58},{-96,58},{-96,26},{-119,26}}, color={0,0,127}));
  connect(massFlowRate.y, firstOrder.u) annotation (Line(points={{139,30},{122,30}}, color={0,0,127}));
  connect(sink.m_flow_prescribed, firstOrder.y) annotation (Line(points={{32,130},{80,130},{80,30},{99,30}}, color={0,0,127}));
  connect(sink4.m_flow_prescribed, firstOrder.y) annotation (Line(points={{32,30},{99,30}}, color={0,0,127}));
  connect(sink1.m_flow_prescribed, firstOrder.y) annotation (Line(points={{32,-20},{80,-20},{80,30},{99,30}}, color={0,0,127}));
  connect(energyFlowSource.E_flow, heatFlowRate.y) annotation (Line(points={{122,-10},{139,-10}}, color={0,0,127}));
  connect(T_out1.outletSpec_prescribed, outletTemperature.y) annotation (Line(points={{10,-32},{10,-40},{-119,-40}}, color={0,0,127}));
  connect(T_out2.outletSpec_prescribed, outletTemperature.y) annotation (Line(points={{10,-82},{10,-88},{-108,-88},{-108,-40},{-119,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-160},{160,160}})),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    This example illustrates several variants of using the 
    <a href=\"modelica://ThermoFluidStream.Idealized.Processes.Isochoric\">Isochoric</a> process defined by prescribed inputs.
  </p>
</html>"));
end Prescribed;
