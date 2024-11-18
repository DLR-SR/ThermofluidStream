within ThermofluidStream.Processes.Pipes.Tests;
model Test_Diffusor
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    annotation(choicesAllMatching = true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true,
      displayParameters=true)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium, p0_par=100000) annotation (Placement(transformation(extent={{20,-10},
            {40,10}})));
  ThermofluidStream.Processes.Pipes.Diffuser diffuser(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    m_flow_0=dropOfCommons.m_flow_reg,
    d_1=0.505,
    d_2=1.009,
    setLength=false,
    alpha_par=0.1221730476396,
    ks=0)       annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=200000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));

equation
  connect(source.outlet, diffuser.inlet) annotation (Line(
      points={{-20,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(diffuser.outlet, sink.inlet)
    annotation (Line(
      points={{10,0},{20,0}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_Diffusor;
