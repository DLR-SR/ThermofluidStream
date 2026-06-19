within ThermofluidStream.Interfaces.MSLplug.ByCode.Tests;
model UnitTest_NoMixtureOnlyForNow_OK
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.Water.WaterIF97_R1pT
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium   annotation (
      choicesAllMatching=true);

  ThermofluidStream.Boundaries.Source source(redeclare package Medium = Medium, temperatureFromInput=true)
                                             annotation (
    Placement(visible = true, transformation(origin={-36,80},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium, p0_par=101300)
    annotation (
    Placement(visible = true, transformation(origin={70,80},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  FlowControl.MCV flowGenerator(
    redeclare package Medium = Medium, setpointFromInput=true)
    annotation (Placement(transformation(extent={{-18,90},{2,70}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin annotation (Placement(
        transformation(
        extent={{-5,5},{5,-5}},
        rotation=0,
        origin={-59,89})));
  Modelica.Blocks.Math.Gain gain(k=1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={-70,60})));
  inner DropOfCommons dropOfCommons(L=1000)
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  ThermofluidStream.Boundaries.Source source1(redeclare package Medium = Medium, temperatureFromInput=true)
                                             annotation (
    Placement(visible = true, transformation(origin={-38,50},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary sink1(redeclare package Medium = Medium,
    p=101300,
    nPorts=1)
    annotation (Placement(transformation(extent={{80,40},{60,60}})));
  InletTFStoFluidPortMSL_eq inletTFStoFluidPortMSL_eq(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{10,40},{30,60}})));
  FlowControl.MCV  flowGenerator1(
    redeclare package Medium = Medium, setpointFromInput=true)
    annotation (Placement(transformation(extent={{-18,40},{2,60}})));
  Modelica.Fluid.Sources.MassFlowSource_T flowGenerator2(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_T_in=true,
    use_X_in=false,
    nPorts=2) annotation (Placement(transformation(extent={{-28,10},{-8,30}})));
  FluidPortMSLtoOutletTFS_eq fluidPortMSLtoOutletTFS_eq(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{14,10},{34,30}})));
  ThermofluidStream.Boundaries.Sink sink2(redeclare package Medium = Medium, p0_par=101300)
     annotation (
    Placement(visible = true, transformation(origin={70,20},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression x_N2O2[2](y={0.8*exp(-time/1E4),1 - 0.8*exp(-time/1E4)}) annotation (Placement(transformation(extent={{-100,94},{-80,106}})));
  Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{34,60},{46,70}})));
  Modelica.Fluid.Sensors.Temperature temperature1(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-2,24},{10,34}})));
  Modelica.Blocks.Noise.UniformNoise mFlowScenario(
    samplePeriod=60,
    y_min=0.001,
    y_max=15) annotation (Placement(transformation(extent={{-100,56},{-80,64}})));
  Modelica.Blocks.Noise.UniformNoise temperatureScenario(
    samplePeriod=60,
    y_min=10,
    y_max=35) annotation (Placement(transformation(extent={{-100,84},{-80,94}})));
  Boundaries.Source                   source_FixedPressure(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true) annotation (Placement(visible=true, transformation(
        origin={-36,-30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
public
  InletTFStoFluidPortMSL_eq inletTFStoFluidPortMSL_eq1(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-6,-38},{10,-22}})));
  Modelica.Fluid.Pipes.StaticPipe pipe_FixedPressure(
    redeclare package Medium = Medium,
    length=1,
    diameter=0.1,
    redeclare model FlowModel = Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalTurbulentPipeFlow (dp_nominal=100, m_flow_nominal=10))
                              annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Modelica.Fluid.Sources.FixedBoundary sink_FixedPressure(
    redeclare package Medium = Medium,
    use_p=true,
    p(displayUnit="Pa"),
    nPorts=1) annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
  Modelica.Fluid.Sensors.Temperature T_FixedFlow1(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{60,-28},{72,-18}})));
  Boundaries.Source                   source_FixedPressure1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true) annotation (Placement(visible=true, transformation(
        origin={-36,-50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
public
  InletTFStoFluidPortMSL_eq inletTFStoFluidPortMSL_eq2(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{24,-58},{40,-42}})));
  Modelica.Fluid.Sources.FixedBoundary sink_FixedPressure1(
    redeclare package Medium = Medium,
    use_p=true,
    p(displayUnit="Pa"),
    nPorts=1) annotation (Placement(transformation(extent={{100,-60},{80,-40}})));
  Modelica.Fluid.Sensors.Temperature T_FixedFlow2(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{62,-48},{72,-38}})));
  Processes.FlowResistance                   flowResistance(
    redeclare package Medium = Medium,
    r=0.1,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-14,-60},{6,-40}})));
  Boundaries.Sink                   sink3(redeclare package Medium = Medium)
     annotation (
    Placement(visible = true, transformation(origin={86,-80},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary(
    redeclare package Medium = Medium,
    use_p_in=true,
    use_T_in=true,
    use_X_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{-36,-90},{-16,-70}})));
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=2) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-78,-10})));
  Modelica.Fluid.Pipes.StaticPipe pipe_FixedPressure1(
    redeclare package Medium = Medium,
    length=1,
    diameter=0.1,
    redeclare model FlowModel = Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalTurbulentPipeFlow (dp_nominal=100, m_flow_nominal=10))
                              annotation (Placement(transformation(extent={{-2,-90},{18,-70}})));
  FluidPortMSLtoOutletTFS_eq fluidPortMSLtoOutletTFS_eq1(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{32,-90},{52,-70}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=2)
                                                        annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={-60,60})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = Medium,
    use_p_in=true,
    use_T_in=true,
    use_X_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{-36,-110},{-16,-90}})));
  Boundaries.Sink                   sink4(redeclare package Medium = Medium)
     annotation (
    Placement(visible = true, transformation(origin={86,-100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  FluidPortMSLtoOutletTFS_eq fluidPortMSLtoOutletTFS_eq2(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-2,-110},{18,-90}})));
  Processes.FlowResistance                   flowResistance1(
    redeclare package Medium = Medium,
    r=0.1,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
protected
  Modelica.Blocks.Math.Add add(k1=10)
                                     annotation (Placement(transformation(extent={{-74,-38},{-66,-30}})));
  Modelica.Blocks.Sources.RealExpression pAtm(y=101325)
    annotation (Placement(transformation(
        extent={{-5.5,-5.5},{5.5,5.5}},
        rotation=0,
        origin={-86.5,-36.5})));
equation
  connect(source.outlet, flowGenerator.inlet) annotation (Line(
      points={{-26,80},{-18,80}},
      color={28,108,200},
      thickness=0.5));
  connect(flowGenerator.outlet, sink.inlet) annotation (Line(
      points={{2,80},{60,80}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowGenerator1.inlet) annotation (Line(
      points={{-28,50},{-18,50}},
      color={28,108,200},
      thickness=0.5));
  connect(inletTFStoFluidPortMSL_eq.inletTFS, flowGenerator1.outlet) annotation (Line(
      points={{11,50},{2,50}},
      color={28,108,200},
      thickness=0.5));
  connect(toKelvin.Kelvin, source1.T0_var) annotation (Line(points={{-53.5,89},{-53.5,50},{-40,50}},
                                                                                                   color={0,0,127}));
  connect(toKelvin.Kelvin, source.T0_var) annotation (Line(points={{-53.5,89},{-53.5,80},{-38,80}},
                                                                                                  color={0,0,127}));
  connect(toKelvin.Kelvin, flowGenerator2.T_in) annotation (Line(points={{-53.5,89},{-53.5,24},{-30,24}}, color={0,0,127}));
  connect(x_N2O2.y, source.xi_var) annotation (Line(points={{-79,100},{-44,100},{-44,74},{-38,74}},
                                                                                                  color={0,0,127}));
  connect(x_N2O2.y, flowGenerator2.X_in) annotation (Line(points={{-79,100},{-44,100},{-44,16},{-30,16}}, color={0,0,127}));
  connect(x_N2O2.y, source1.xi_var) annotation (Line(points={{-79,100},{-44,100},{-44,44},{-40,44}},
                                                                                                 color={0,0,127}));
  connect(mFlowScenario.y, gain.u) annotation (Line(points={{-79,60},{-74.8,60}},          color={0,0,127}));
  connect(temperatureScenario.y, toKelvin.Celsius) annotation (Line(points={{-79,89},{-65,89}},            color={0,0,127}));
  connect(source_FixedPressure.outlet, inletTFStoFluidPortMSL_eq1.inletTFS)
    annotation (Line(
      points={{-26,-30},{-5.2,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(pipe_FixedPressure.port_b,sink_FixedPressure. ports[1])
    annotation (Line(points={{40,-30},{80,-30}}, color={0,127,255}));
  connect(pAtm.y, add.u2) annotation (Line(points={{-80.45,-36.5},{-80.45,-36.4},{-74.8,-36.4}}, color={0,0,127}));
  connect(add.y,source_FixedPressure. p0_var)
    annotation (Line(points={{-65.6,-34},{-50,-34},{-50,-24},{-38,-24}}, color={0,0,127}));
  connect(pipe_FixedPressure.port_b,T_FixedFlow1. port)
    annotation (Line(points={{40,-30},{66,-30},{66,-28}}, color={0,127,255}));
  connect(source_FixedPressure1.outlet,flowResistance. inlet) annotation (Line(
      points={{-26,-50},{-14,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, inletTFStoFluidPortMSL_eq2.inletTFS) annotation (Line(
      points={{6,-50},{24.8,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(toKelvin.Kelvin, source_FixedPressure.T0_var) annotation (Line(points={{-53.5,89},{-53.5,-30},{-38,-30}}, color={0,0,127}));
  connect(toKelvin.Kelvin, source_FixedPressure1.T0_var) annotation (Line(points={{-53.5,89},{-53.5,-50},{-38,-50}}, color={0,0,127}));
  connect(add.y, source_FixedPressure1.p0_var) annotation (Line(points={{-65.6,-34},{-50,-34},{-50,-44},{-38,-44}}, color={0,0,127}));
  connect(add.y, boundary.p_in) annotation (Line(points={{-65.6,-34},{-50,-34},{-50,-72},{-38,-72}}, color={0,0,127}));
  connect(toKelvin.Kelvin, boundary.T_in) annotation (Line(points={{-53.5,89},{-53.5,-76},{-38,-76}}, color={0,0,127}));
  connect(x_N2O2.y, source_FixedPressure.xi_var) annotation (Line(points={{-79,100},{-44,100},{-44,-36},{-38,-36}}, color={0,0,127}));
  connect(x_N2O2.y, source_FixedPressure1.xi_var) annotation (Line(points={{-79,100},{-44,100},{-44,-56},{-38,-56}}, color={0,0,127}));
  connect(x_N2O2.y, boundary.X_in) annotation (Line(points={{-79,100},{-44,100},{-44,-84},{-38,-84}}, color={0,0,127}));
  connect(mFlowScenario.y, firstOrder.u) annotation (Line(points={{-79,60},{-78,60},{-78,-5.2}}, color={0,0,127}));
  connect(firstOrder.y, add.u1) annotation (Line(points={{-78,-14.4},{-78,-31.6},{-74.8,-31.6}}, color={0,0,127}));
  connect(boundary.ports[1], pipe_FixedPressure1.port_a) annotation (Line(points={{-16,-80},{-2,-80}}, color={0,127,255}));
  connect(fluidPortMSLtoOutletTFS_eq1.outletTFS, sink3.inlet) annotation (Line(
      points={{49,-80},{76,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(inletTFStoFluidPortMSL_eq.portMSL, sink1.ports[1]) annotation (Line(points={{25,50},{60,50}}, color={0,127,255}));
  connect(inletTFStoFluidPortMSL_eq.portMSL, temperature.port) annotation (Line(points={{25,50},{40,50},{40,60}}, color={0,127,255}));
  connect(inletTFStoFluidPortMSL_eq1.portMSL, pipe_FixedPressure.port_a) annotation (Line(points={{6,-30},{20,-30}}, color={0,127,255}));
  connect(inletTFStoFluidPortMSL_eq2.portMSL, T_FixedFlow2.port) annotation (Line(points={{36,-50},{67,-50},{67,-48}}, color={0,127,255}));
  connect(inletTFStoFluidPortMSL_eq2.portMSL, sink_FixedPressure1.ports[1]) annotation (Line(points={{36,-50},{80,-50}}, color={0,127,255}));
  connect(pipe_FixedPressure1.port_b, fluidPortMSLtoOutletTFS_eq1.portMSL) annotation (Line(points={{18,-80},{36.5,-80}}, color={0,127,255}));
  connect(flowGenerator2.ports[1], fluidPortMSLtoOutletTFS_eq.portMSL) annotation (Line(points={{-8,19.75},{6,19.75},{6,20},{18.5,20}}, color={0,127,255}));
  connect(flowGenerator2.ports[2], temperature1.port) annotation (Line(points={{-8,20.25},{4,20.25},{4,24}}, color={0,127,255}));
  connect(fluidPortMSLtoOutletTFS_eq.outletTFS, sink2.inlet) annotation (Line(
      points={{31,20},{60,20}},
      color={28,108,200},
      thickness=0.5));
  connect(gain.y, firstOrder1.u) annotation (Line(points={{-65.6,60},{-64.8,60}}, color={0,0,127}));
  connect(firstOrder1.y, flowGenerator2.m_flow_in) annotation (Line(points={{-55.6,60},{-50,60},{-50,28},{-28,28}}, color={0,0,127}));
  connect(firstOrder1.y, flowGenerator.setpoint_var) annotation (Line(points={{-55.6,60},{-50,60},{-50,66},{-8,66},{-8,72}}, color={0,0,127}));
  connect(firstOrder1.y, flowGenerator1.setpoint_var) annotation (Line(points={{-55.6,60},{-50,60},{-50,66},{-8,66},{-8,58}}, color={0,0,127}));
  connect(add.y, boundary1.p_in) annotation (Line(points={{-65.6,-34},{-54,-34},{-54,-92},{-38,-92}}, color={0,0,127}));
  connect(toKelvin.Kelvin, boundary1.T_in) annotation (Line(points={{-53.5,89},{-53.5,-96},{-38,-96}}, color={0,0,127}));
  connect(flowResistance1.outlet, sink4.inlet) annotation (Line(
      points={{60,-100},{76,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(fluidPortMSLtoOutletTFS_eq2.outletTFS, flowResistance1.inlet) annotation (Line(
      points={{15,-100},{40,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary1.ports[1], fluidPortMSLtoOutletTFS_eq2.portMSL) annotation (Line(points={{-16,-100},{2.5,-100}}, color={0,127,255}));
  annotation (experiment(StopTime=3600, __Dymola_Algorithm="Dassl"), Diagram(graphics={
        Text(
          extent={{-34,0},{58,-24}},
          textColor={217,67,180},
          textString="Pressure boundaries"),
        Text(
          extent={{-34,100},{50,88}},
          textColor={217,67,180},
          textString="Fixed m_flow")}));
end UnitTest_NoMixtureOnlyForNow_OK;
