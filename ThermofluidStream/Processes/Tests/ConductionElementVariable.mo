within ThermofluidStream.Processes.Tests;
model ConductionElementVariable
  "Test the thermal conduction of ConductionElement, could be removed"
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater constrainedby
    Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Source. Make sure it is the same as the one
the inlet the source is connected to.
</p>
</html>"));

  Boundaries.Source source(
    redeclare package Medium = Medium,
                           p0_par=200000, T0_par=293.15)
    annotation (Placement(transformation(extent={{-240,40},{-220,60}})));
  Boundaries.Sink sink(redeclare package Medium = Medium,
                       p0_par=100000) annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=0, k2=1e5) "Linear-quadratic",
    l=10,
    r=0.01)
         annotation (Placement(transformation(extent={{-200,40},{-180,60}})));

  Processes.ConductionElement conductionElement(redeclare package Medium = Medium)
                                                annotation (Placement(transformation(extent={{-140,40},{-120,60}})));
  inner DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{-20,182},{0,202}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=323.15)
    annotation (Placement(transformation(extent={{-240,-10},{-220,10}})));
  Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=200000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-240,-60},{-220,-40}})));
  Boundaries.Sink sink1(redeclare package Medium = Medium, p0_par=100000)
                                      annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=0, k2=1e5) "Linear-quadratic",
    l=10,
    r=0.01)
         annotation (Placement(transformation(extent={{-200,-60},{-180,-40}})));
  Processes.ConductionElement conductionElement1(redeclare package Medium = Medium, resistanceFromAU=false)
                                                annotation (Placement(transformation(extent={{-140,-40},{-120,-60}})));
  Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=200000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Boundaries.Sink sink2(redeclare package Medium = Medium, p0_par=100000)
                                      annotation (Placement(transformation(extent={{80,40},{100,60}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=0, k2=1e5) "Linear-quadratic",
    l=10,
    r=0.01)
         annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Processes.ConductionElement conductionElement2(
    redeclare package Medium = Medium,
    useHeatTransferPropertyInput=true,
    A=2)                                        annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Blocks.Sources.RealExpression heatTransferCoefficient(y=100)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=200000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-60}})));
  Boundaries.Sink sink3(redeclare package Medium = Medium, p0_par=100000)
                                      annotation (Placement(transformation(extent={{80,-40},{100,-60}})));
  Processes.FlowResistance flowResistance3(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=0, k2=1e5) "Linear-quadratic",
    l=10,
    r=0.01)
         annotation (Placement(transformation(extent={{-20,-40},{0,-60}})));
  Processes.ConductionElement conductionElement3(
    redeclare package Medium = Medium,
    useHeatTransferPropertyInput=true,
    resistanceFromAU=false,
    A=2)                                        annotation (Placement(transformation(extent={{40,-40},{60,-60}})));
  Modelica.Blocks.Sources.RealExpression thermalConductance(y=200)
    annotation (Placement(transformation(extent={{-20,-14},{0,-34}})));
  Boundaries.Source source4(
    redeclare package Medium = Medium,
    p0_par=200000,
    T0_par=293.15)
    annotation (Placement(transformation(extent={{120,40},{140,60}})));
  Boundaries.Sink sink4(redeclare package Medium = Medium, p0_par=100000)
                                      annotation (Placement(transformation(extent={{260,40},{280,60}})));
  Processes.FlowResistance flowResistance4(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=0, k2=1e5) "Linear-quadratic",
    l=10,
    r=0.01)
         annotation (Placement(transformation(extent={{160,40},{180,60}})));
  Processes.ConductionElement conductionElement4(
    redeclare package Medium = Medium,
    useHeatTransferPropertyInput=true,
    A=2)                                        annotation (Placement(transformation(extent={{220,40},{240,60}})));
  Modelica.Blocks.Sources.Step heatTransferCoefficient_step(
    height=100,
    offset=100,
    startTime=5) annotation (Placement(transformation(extent={{160,10},{180,30}})));
equation
  connect(source.outlet, flowResistance.inlet)
    annotation (Line(
      points={{-220,50},{-200,50}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, conductionElement.inlet)
    annotation (Line(
      points={{-180,50},{-140,50}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement.outlet, sink.inlet)
    annotation (Line(
      points={{-120,50},{-100,50}},
      color={28,108,200},
      thickness=0.5));
  connect(fixedTemperature.port, conductionElement.heatPort)
    annotation (Line(points={{-220,0},{-130,0},{-130,40}}, color={191,0,0}));
  connect(source1.outlet, flowResistance1.inlet)
    annotation (Line(
      points={{-220,-50},{-200,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, conductionElement1.inlet)
    annotation (Line(
      points={{-180,-50},{-140,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement1.outlet, sink1.inlet)
    annotation (Line(
      points={{-120,-50},{-100,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(fixedTemperature.port, conductionElement1.heatPort)
    annotation (Line(points={{-220,0},{-130,0},{-130,-40}}, color={191,0,0}));
  connect(source2.outlet, flowResistance2.inlet)
    annotation (Line(
      points={{-40,50},{-20,50}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, conductionElement2.inlet)
    annotation (Line(
      points={{0,50},{40,50}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement2.outlet, sink2.inlet)
    annotation (Line(
      points={{60,50},{80,50}},
      color={28,108,200},
      thickness=0.5));
  connect(heatTransferCoefficient.y, conductionElement2.U_var)
    annotation (Line(points={{1,30},{44,30},{44,38}}, color={0,0,127}));
  connect(source3.outlet, flowResistance3.inlet)
    annotation (Line(
      points={{-40,-50},{-20,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.outlet, conductionElement3.inlet)
    annotation (Line(
      points={{0,-50},{40,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement3.outlet, sink3.inlet)
    annotation (Line(
      points={{60,-50},{80,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConductance.y, conductionElement3.k_var)
    annotation (Line(points={{1,-24},{44,-24},{44,-38}}, color={0,0,127}));
  connect(source4.outlet, flowResistance4.inlet)
    annotation (Line(
      points={{140,50},{160,50}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.outlet, conductionElement4.inlet)
    annotation (Line(
      points={{180,50},{220,50}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement4.outlet, sink4.inlet)
    annotation (Line(
      points={{240,50},{260,50}},
      color={28,108,200},
      thickness=0.5));
  connect(heatTransferCoefficient_step.y, conductionElement4.U_var)
    annotation (Line(points={{181,20},{224,20},{224,38}}, color={0,0,127}));
  connect(conductionElement2.heatPort, fixedTemperature.port)
    annotation (Line(points={{50,40},{50,0},{-220,0}}, color={191,0,0}));
  connect(conductionElement3.heatPort, fixedTemperature.port)
    annotation (Line(points={{50,-40},{50,0},{-220,0}}, color={191,0,0}));
  connect(conductionElement4.heatPort, fixedTemperature.port)
    annotation (Line(points={{230,40},{230,0},{-220,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-300,-200},{300,200}})),
    Documentation(info="<html>
  <p>
    This test verifies the four possible ways to define the thermal conductance:
    <code>resistanceFromAU = true/false</code> and <code>useHeatTransferPropertyInput = true/false</code>.
    All four configurations produce the same result in a simple test and do not generate warnings or errors.
  </p>

  <p>
    Additionally, the test confirms that a step change in the heat transfer coefficient is handled correctly.
  </p>
</html>"));
end ConductionElementVariable;
