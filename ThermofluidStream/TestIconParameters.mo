within ThermofluidStream;
model TestIconParameters
  extends Modelica.Icons.Example;
  inner DropOfCommons                   dropOfCommons(displayInstanceNames=true, displayParameters=false)
                                                                                  annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Boundaries.Source                   source(
    displayParameters=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Boundaries.Sink                   sink(displayParameters=true, p0_par=100000)
                                         annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Boundaries.Source                   source1(
    displayParameters=true,
    displayTemperature=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Boundaries.Source                   source2(
    displayParameters=true,
    displayPressure=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Boundaries.Source                   source3(
    displayParameters=true,
    pressureFromInput=true,
    T0_par=293.15)                           annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Boundaries.Source                   source4(
    displayParameters=true,
    pressureFromInput=false,
    temperatureFromInput=true,
    p0_par=100000)                           annotation (Placement(transformation(extent={{80,40},{100,60}})));
  Boundaries.Source                   source5(
    displayParameters=true,
    setEnthalpy=true,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=true,
    p0_par=100000)                           annotation (Placement(transformation(extent={{120,40},{140,60}})));
  Boundaries.Source source_default(displayParameters=true) annotation (Placement(transformation(extent={{-120,40},{-100,60}})));
  Boundaries.Sink sink_default(displayParameters=true) annotation (Placement(transformation(extent={{-120,0},{-100,20}})));
  Boundaries.Sink                   sink2(displayParameters=true, pressureFromInput=true)
                                         annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow(displayParameters=true) annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow1(
    displayParameters=true,
    areaFromInput=true,
    velocityFromInput=true,
    assumeConstantDensity=false) annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow(displayParameters=true) annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow1(
    displayParameters=true,
    areaFromInput=true,
    velocityFromInput=true) annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Topology.SplitterT1 splitterT1_1 annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end TestIconParameters;
