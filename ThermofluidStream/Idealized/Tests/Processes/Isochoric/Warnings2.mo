within ThermofluidStream.Idealized.Tests.Processes.Isochoric;
model Warnings2 "Example - Isochoric process"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);
  parameter Medium.AbsolutePressure p_in = 1e5 "Inlet pressure";
  parameter Medium.Temperature T_in = 293.15 "Inlet temperature";
  SI.TemperatureDifference dT = temperatureDifference.y "Temperature difference";
  Medium.Temperature T_out = T_in + dT "Outlet temperature";

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{80,80},{100,100}})));

  Modelica.Blocks.Sources.Trapezoid temperatureDifference(
    amplitude=10,
    rising=0.01,
    falling=0.01,
    period=1,
    offset=0,
    startTime=0.5) annotation(Placement(transformation(extent={{-100,10},{-80,30}})));
  Modelica.Blocks.Sources.RealExpression outletTemperature(y=T_out) annotation(Placement(transformation(extent={{-100,-50},{-80,-30}})));
  EnergyFlow.Sources.PrescribedEnergyFlow energyFlowSource annotation(Placement(transformation(extent={{-70,-90},{-50,-70}})));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    p0_par=p_in,
    temperatureFromInput=false,
    T0_par=T_in) annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT2c(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                       annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    p0_par=p_in,
    temperatureFromInput=false,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-70,-20},{-50,0}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink2(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  ThermofluidStream.Idealized.Processes.Isochoric T_out2c(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                       annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  ThermofluidStream.Boundaries.Source  source1(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    p0_par=p_in,
    temperatureFromInput=false,
    T0_par=T_in) annotation (Placement(transformation(extent={{30,40},{50,60}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink1(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{90,40},{110,60}})));
  ThermofluidStream.Idealized.Processes.Isochoric dT2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.TemperatureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                       annotation (Placement(transformation(extent={{60,40},{80,60}})));
  ThermofluidStream.Boundaries.Source  source3(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    p0_par=p_in,
    temperatureFromInput=false,
    T0_par=T_in) annotation (Placement(transformation(extent={{30,-20},{50,0}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink3(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{90,-20},{110,0}})));
  ThermofluidStream.Idealized.Processes.Isochoric T_out2(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isochoric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed)
                       annotation (Placement(transformation(extent={{60,-20},{80,0}})));

  Modelica.Blocks.Sources.Trapezoid
                                heatFlowRate(
    amplitude=1e3,
    rising=0.01,
    falling=0.01,
    period=1,
    startTime=0.25)
                   annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
equation

  connect(source.outlet,dT2c. inlet) annotation (Line(
      points={{-50,50},{-40,50}},
      color={28,108,200},
      thickness=0.5));
  connect(dT2c.outlet,sink. inlet) annotation (Line(
      points={{-20,50},{-10,50}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet,T_out2c. inlet) annotation (Line(
      points={{-50,-10},{-40,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out2c.outlet,sink2. inlet) annotation (Line(
      points={{-20,-10},{-10,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet,dT2. inlet) annotation (Line(
      points={{50,50},{60,50}},
      color={28,108,200},
      thickness=0.5));
  connect(dT2.outlet,sink1. inlet) annotation (Line(
      points={{80,50},{90,50}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet,T_out2. inlet) annotation (Line(
      points={{50,-10},{60,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out2.outlet,sink3. inlet) annotation (Line(
      points={{80,-10},{90,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(heatFlowRate.y, energyFlowSource.E_flow) annotation (Line(points={{-89,-80},{-72,-80}}, color={0,0,127}));
  connect(temperatureDifference.y, dT2c.outletSpec_prescribed) annotation (Line(points={{-79,20},{-40,20},{-40,38}}, color={0,0,127}));
  connect(dT2.outletSpec_prescribed, temperatureDifference.y) annotation (Line(points={{60,38},{60,20},{-79,20}}, color={0,0,127}));
  connect(T_out2c.outletSpec_prescribed, outletTemperature.y) annotation (Line(points={{-40,-22},{-40,-40},{-79,-40}}, color={0,0,127}));
  connect(T_out2.outletSpec_prescribed, outletTemperature.y) annotation (Line(points={{60,-22},{60,-40},{-79,-40}}, color={0,0,127}));
  connect(energyFlowSource.E_flow_out, dT2c.Q_flow_in) annotation (Line(points={{-49,-80},{20,-80},{20,14},{-30,14},{-30,42}}, color={255,170,85}));
  connect(energyFlowSource.E_flow_out, dT2.Q_flow_in) annotation (Line(points={{-49,-80},{20,-80},{20,14},{70,14},{70,42}}, color={255,170,85}));
  connect(energyFlowSource.E_flow_out, T_out2c.Q_flow_in) annotation (Line(points={{-49,-80},{-30,-80},{-30,-18}}, color={255,170,85}));
  connect(energyFlowSource.E_flow_out, T_out2.Q_flow_in) annotation (Line(points={{-49,-80},{70,-80},{70,-18}}, color={255,170,85}));
  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(
        extent={{-120,-100},{120,100}})),
    Documentation(
      info="<html>
  <p>
    This example checks if warnings are issued correctly in the case of outlet state and heat flow rate given.
  </p>
</html>",
      revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Warnings2;
