within ThermofluidStream.Processes.Tests;
model CentrifugalPump1 "Tester for CentrifugalPump"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    annotation(choicesAllMatching = true);
  parameter Real w_n=0.2 "Normalized speed";
  parameter SI.Temperature T=293.15
                             "Temperature";
  parameter SI.Pressure p=100000
                          "Pressue";
  final parameter Medium.ThermodynamicState state = Medium.setState_pT(p,T);
  final parameter SI.Density rho = Medium.density(state);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T)    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Utilities.Sink_m sink(redeclare package Medium = Medium, massFlowFromInput=true) annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  ThermofluidStream.Processes.CentrifugalPump coefficients(
    redeclare package Medium = Medium,
    dataFromMeasurements=false,
    redeclare ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients.Wilo.Stratos25slash1to4 coefficients(rho_ref=rho),
    redeclare ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.Wilo.Stratos25slash1to4 measurements,
    pumpMode=ThermofluidStream.Processes.Internal.Types.PumpMode.speedControlled,
    setpointFromInput=true,
    P_reg=0.01,
    phi(fixed=true)) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.RealExpression rotationalSpeed(y=w_n*coefficients.coefficients.w_ref) annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.Ramp massFlowRamp(height=coefficients.coefficients.V_flow_peak*coefficients.coefficients.V_0n*rho*w_n, duration=1) annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T)    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  Utilities.Sink_m sink1(redeclare package Medium = Medium, massFlowFromInput=true) annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  ThermofluidStream.Processes.CentrifugalPump measurements(
    redeclare package Medium = Medium,
    dataFromMeasurements=true,
    redeclare ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients.Wilo.Stratos25slash1to4 coefficients(rho_ref=rho),
    redeclare ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.Wilo.Stratos25slash1to4 measurements(rho_ref=rho),
    pumpMode=ThermofluidStream.Processes.Internal.Types.PumpMode.speedControlled,
    setpointFromInput=true,
    P_reg=0.01,
    phi(fixed=true)) annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
equation
  connect(source.outlet, coefficients.inlet) annotation (Line(
      points={{-20,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(coefficients.outlet, sink.inlet) annotation (Line(
      points={{10,0},{20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRamp.y, sink.m_flow_var) annotation (Line(points={{59,-30},{50.5,-30},{50.5,0},{32,0}},
                                                                                    color={0,0,127}));
  connect(source1.outlet, measurements.inlet) annotation (Line(
      points={{-20,-60},{-10,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(measurements.outlet, sink1.inlet) annotation (Line(
      points={{10,-60},{20,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(massFlowRamp.y, sink1.m_flow_var) annotation (Line(points={{59,-30},{50.5,-30},{50.5,-60},{32,-60}}, color={0,0,127}));
  connect(rotationalSpeed.y, coefficients.setpoint_var) annotation (Line(points={{-79,-30},{0,-30},{0,-8}}, color={0,0,127}));
  connect(measurements.setpoint_var, rotationalSpeed.y) annotation (Line(points={{0,-68},{0,-85},{-68.5,-85},{-68.5,-30},{-79,-30}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(extent={{-100,-80},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Text(
          extent={{-38,58},{40,40}},
          textColor={28,108,200},
          textString="Use the same pump (coefficients, measurements)")}),
    experiment(StopTime=1),
        Documentation(info="", revisions=""));
end CentrifugalPump1;
