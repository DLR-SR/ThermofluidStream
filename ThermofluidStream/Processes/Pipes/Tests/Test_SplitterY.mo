within ThermofluidStream.Processes.Pipes.Tests;
model Test_SplitterY
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    annotation(choicesAllMatching = true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  ThermofluidStream.Boundaries.Sink sink1(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  ThermofluidStream.Processes.Pipes.SplitterY splitterY(
    redeclare package Medium = Medium,
    d_branching=0.05,
    Y_type1=true,
    d_in=0.1,
    alpha=0.5235987755983) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium, p0_par=100000) annotation (Placement(transformation(extent={{52,20},
            {72,40}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=110000,
    T0_par=293.15) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss,
    l=1,
    r=1e-2) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  FlowResistance                             flowResistance1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=0,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss,
    l=1,
    r=1e-2) annotation (Placement(transformation(extent={{20,20},{40,40}})));
equation
  connect(splitterY.inlet, flowResistance.outlet) annotation (Line(
      points={{-10,0},{-20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{-60,0},{-40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterY.outlet_straight, sink1.inlet) annotation (Line(
      points={{10,0},{20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterY.outlet_branching, flowResistance1.inlet) annotation (Line(
      points={{6.6,8.6},{6.6,24},{6,24},{6,30},{20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, sink.inlet)
    annotation (Line(
      points={{40,30},{52,30}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_SplitterY;
