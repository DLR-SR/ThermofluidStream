within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model Warnings2 "Example - adiabatic process"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.SimpleAir  constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
      choicesAllMatching=true);
  parameter Medium.AbsolutePressure p_in=100000 "Inlet pressure";
  parameter Medium.Temperature T_in=293.15 "Inlet temperature";
  SI.PressureDifference dp=pressureDifference.y "Pressure difference";
  parameter SI.Efficiency eta_is=0.8 "Isentropic efficiency";

  Medium.AbsolutePressure p_out= p_in + dp "Outlet pressure";
  Real pRatio = p_out/p_in "Pressure ratio";

  inner ThermofluidStream.DropOfCommons dropOfCommons annotation(
    Placement(transformation(extent={{80,80},{100,100}})));





  .ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{0,50},{20,70}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free
                                       sink(redeclare package Medium = Medium)                      annotation (Placement(transformation(extent={{60,50},{80,70}})));
  ThermofluidStream.Idealized.Processes.Adiabatic dp1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    eta_fixed=eta_is)  annotation (Placement(transformation(extent={{30,50},{50,70}})));

  ThermofluidStream.Boundaries.Source  source1(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{0,0},{20,20}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free
                                       sink1(redeclare package Medium = Medium)                     annotation (Placement(transformation(extent={{60,0},{80,20}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pRatio1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    eta_fixed=eta_is) annotation (Placement(transformation(extent={{30,0},{50,20}})));
  ThermofluidStream.Boundaries.Source  source2(
    redeclare package Medium = Medium,
    p0_par=p_in,
    T0_par=T_in) annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free
                                       sink2(redeclare package Medium = Medium)                     annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pOut1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    eta_fixed=eta_is) annotation (Placement(transformation(extent={{30,-50},{50,-30}})));
  EnergyFlow.Sources.PrescribedEnergyFlow
                                     energyFlowSource                annotation(Placement(transformation(extent={{-40,-70},{-20,-50}})));
  Modelica.Blocks.Sources.Trapezoid pressureDifference(
    amplitude=1e5,
    rising=0.01,
    falling=0.01,
    period=1,
    offset=0,
    startTime=0.5) annotation (Placement(transformation(extent={{-50,26},{-30,46}})));
  Modelica.Blocks.Sources.Trapezoid power(
    amplitude=1e3,
    rising=0.01,
    falling=0.01,
    period=1,
    startTime=0.25) annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Modelica.Blocks.Sources.RealExpression outletPressure(y=p_out) annotation (Placement(transformation(extent={{-50,-100},{-30,-80}})));
  Modelica.Blocks.Sources.RealExpression pressureRatio(y=pRatio) annotation (Placement(transformation(extent={{-50,-24},{-30,-4}})));
equation
  connect(source.outlet,dp1. inlet) annotation (Line(
      points={{20,60},{30,60}},
      color={28,108,200},
      thickness=0.5));
  connect(dp1.outlet, sink.inlet) annotation (Line(
      points={{50,60},{60,60}},
      color={28,108,200},
      thickness=0.5));

  connect(source1.outlet, pRatio1.inlet) annotation (Line(
      points={{20,10},{30,10}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio1.outlet, sink1.inlet) annotation (Line(
      points={{50,10},{60,10}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, pOut1.inlet) annotation (Line(
      points={{20,-40},{30,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(pOut1.outlet, sink2.inlet) annotation (Line(
      points={{50,-40},{60,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(dp1.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{40,52},{40,40},{-10,40},{-10,-60},{-19,-60}},
                                                                                                                     color={255,170,85}));
  connect(pRatio1.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{40,2},{40,-10},{-10,-10},{-10,-60},{-19,-60}},
                                                                                                                           color={255,170,85}));
  connect(pOut1.P_in, energyFlowSource.E_flow_out) annotation (Line(points={{40,-48},{40,-60},{-19,-60}},                 color={255,170,85}));
  connect(power.y, energyFlowSource.E_flow) annotation (Line(points={{-59,-60},{-42,-60}}, color={0,0,127}));
  connect(dp1.outletSpec_prescribed, pressureDifference.y) annotation (Line(points={{50,48},{50,36},{-29,36}}, color={0,0,127}));
  connect(pRatio1.outletSpec_prescribed, pressureRatio.y) annotation (Line(points={{50,-2},{50,-14},{-29,-14}}, color={0,0,127}));
  connect(pOut1.outletSpec_prescribed, outletPressure.y) annotation (Line(points={{50,-52},{50,-90},{-29,-90}}, color={0,0,127}));
  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Documentation(
      info="<html>
  <p>
    This example checks if warnings are issued correctly in the case of outlet state and power given (FullMedium model).
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
