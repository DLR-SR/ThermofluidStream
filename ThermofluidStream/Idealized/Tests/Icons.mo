within ThermofluidStream.Idealized.Tests;
model Icons
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa
    constrainedby Media.myMedia.Interfaces.PartialMedium annotation (
      choicesAllMatching=true);

  ThermofluidStream.Idealized.Processes.Isochoric isochoric(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium)                                     annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  ThermofluidStream.Idealized.Processes.Isochoric isochoric1(
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    redeclare package Medium = Medium,
    iconType=ThermofluidStream.Idealized.Types.Icons.HeatTransfer.Cooling) annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Sources.CombiTimeTable temperatureDifferenceStep(
    table=[0.0,-10; 0.3,0.0; 0.6,10],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    offset={0},
    startTime=0) annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  ThermofluidStream.Boundaries.Sink_m
                                    sink(redeclare package Medium = Medium, m_flow_fixed=1)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  inner DropOfCommons dropOfCommons annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation
  connect(source6.outlet, isochoric.inlet) annotation (Line(
      points={{-50,0},{-30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(isochoric.outlet, isochoric1.inlet) annotation (Line(
      points={{-10,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(isochoric1.outlet, sink.inlet) annotation (Line(
      points={{30,0},{50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(temperatureDifferenceStep.y[1], isochoric.outletSpec_prescribed) annotation (Line(points={{-39,-40},{-10,-40},{-10,-12}}, color={0,0,127}));
  connect(temperatureDifferenceStep.y[1], isochoric1.outletSpec_prescribed) annotation (Line(points={{-39,-40},{30,-40},{30,-12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, grid={2,2})),
    experiment(StopTime=2, __Dymola_Algorithm="Dassl"));
end Icons;
