within ThermofluidStream.Interfaces.MSLplug.ByAssembly.Tests;
model UnitTest_Mixture_OK
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.MixtureGases.CombustionAir
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium   annotation (
      choicesAllMatching=true);
          //ThermofluidStream.Media.myMedia.Water.WaterIF97_R1pT

  ThermofluidStream.Boundaries.Source source(redeclare package Medium = Medium, temperatureFromInput=true,
    xiFromInput=true)                        annotation (
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
  ThermofluidStream.Boundaries.Source source1(redeclare package Medium = Medium, temperatureFromInput=true,
    xiFromInput=true)                        annotation (
    Placement(visible = true, transformation(origin={-38,50},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary sink1(redeclare package Medium = Medium,
    p=101300,
    nPorts=1)
    annotation (Placement(transformation(extent={{80,40},{60,60}})));
  InletTFStoFluidPortMSL_ass inletTFStoFluidPortMSL_ass(
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{12,40},{32,60}})));
  FlowControl.MCV  flowGenerator1(
    redeclare package Medium = Medium, setpointFromInput=true)
    annotation (Placement(transformation(extent={{-18,40},{2,60}})));
  Modelica.Fluid.Sources.MassFlowSource_T flowGenerator2(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_T_in=true,
    use_X_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-28,10},{-8,30}})));
  FluidPortMSLtoOutletTFS_ass fluidPortMSLtoOutletTFS_ass(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{14,10},{34,30}})));
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
    temperatureFromInput=true,
    xiFromInput=true)          annotation (Placement(visible=true, transformation(
        origin={-36,-30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
public
  InletTFStoFluidPortMSL_ass inletTFStoFluidPortMSL_ass_FixedPressure(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-6,-38},{10,-22}})));
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
    temperatureFromInput=true,
    xiFromInput=true)          annotation (Placement(visible=true, transformation(
        origin={-36,-60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
public
  InletTFStoFluidPortMSL_ass inletTFStoFluidPortMSL_ass_FixedPressure1(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{22,-68},{38,-52}})));
  Modelica.Fluid.Sources.FixedBoundary sink_FixedPressure1(
    redeclare package Medium = Medium,
    use_p=true,
    p(displayUnit="Pa"),
    nPorts=1) annotation (Placement(transformation(extent={{100,-70},{80,-50}})));
  Modelica.Fluid.Sensors.Temperature T_FixedFlow2(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{62,-58},{72,-48}})));
  Processes.FlowResistance                   flowResistance(
    redeclare package Medium = Medium,
    r=0.1,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarPressureLoss)
    annotation (Placement(transformation(extent={{-14,-70},{6,-50}})));
  Boundaries.Sink                   sink3(redeclare package Medium = Medium)
     annotation (
    Placement(visible = true, transformation(origin={90,-90},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary(
    redeclare package Medium = Medium,
    use_p_in=true,
    use_T_in=true,
    use_X_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-36,-100},{-16,-80}})));
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
                              annotation (Placement(transformation(extent={{-2,-100},{18,-80}})));
  FluidPortMSLtoOutletTFS_ass fluidPortMSLtoOutletTFS_ass1(redeclare package Medium = Medium)
                                                                                             annotation (Placement(transformation(extent={{32,-100},{52,-80}})));
protected
  Modelica.Blocks.Math.Add add(k1=100)
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
  connect(inletTFStoFluidPortMSL_ass.inletTFS, flowGenerator1.outlet) annotation (Line(
      points={{13,50},{2,50}},
      color={28,108,200},
      thickness=0.5));
  connect(toKelvin.Kelvin, source1.T0_var) annotation (Line(points={{-53.5,89},{-53.5,50},{-40,50}},
                                                                                                   color={0,0,127}));
  connect(toKelvin.Kelvin, source.T0_var) annotation (Line(points={{-53.5,89},{-53.5,80},{-38,80}},
                                                                                                  color={0,0,127}));
  connect(toKelvin.Kelvin, flowGenerator2.T_in) annotation (Line(points={{-53.5,89},{-53.5,24},{-30,24}}, color={0,0,127}));
  connect(gain.y, flowGenerator2.m_flow_in) annotation (Line(points={{-65.6,60},{-48,60},{-48,28},{-28,28}},              color={0,0,127}));
  connect(fluidPortMSLtoOutletTFS_ass.outletTFS, sink2.inlet) annotation (Line(
      points={{31,20},{60,20}},
      color={28,108,200},
      thickness=0.5));
  connect(x_N2O2.y, source.xi_var) annotation (Line(points={{-79,100},{-44,100},{-44,74},{-38,74}},
                                                                                                  color={0,0,127}));
  connect(x_N2O2.y, flowGenerator2.X_in) annotation (Line(points={{-79,100},{-44,100},{-44,16},{-30,16}}, color={0,0,127}));
  connect(x_N2O2.y, source1.xi_var) annotation (Line(points={{-79,100},{-44,100},{-44,44},{-40,44}},
                                                                                                 color={0,0,127}));
  connect(flowGenerator2.ports[1], fluidPortMSLtoOutletTFS_ass.inportMSL) annotation (Line(points={{-8,20},{6,20},{6,20},{18.5,20}},
                                                                                                                           color={0,127,255}));
  connect(inletTFStoFluidPortMSL_ass.outportMSL, sink1.ports[1]) annotation (Line(points={{27,50},{60,50}}, color={0,127,255}));
  connect(inletTFStoFluidPortMSL_ass.outportMSL, temperature.port) annotation (Line(points={{27,50},{40,50},{40,60}},
                                                                                                                    color={0,127,255}));
  connect(temperature1.port, fluidPortMSLtoOutletTFS_ass.inportMSL) annotation (Line(points={{4,24},{4,20},{18.5,20}},         color={0,127,255}));
  connect(gain.y, flowGenerator.setpoint_var) annotation (Line(points={{-65.6,60},{-8,60},{-8,72}},     color={0,0,127}));
  connect(gain.y, flowGenerator1.setpoint_var) annotation (Line(points={{-65.6,60},{-8,60},{-8,58}},          color={0,0,127}));
  connect(mFlowScenario.y, gain.u) annotation (Line(points={{-79,60},{-74.8,60}},          color={0,0,127}));
  connect(temperatureScenario.y, toKelvin.Celsius) annotation (Line(points={{-79,89},{-65,89}},            color={0,0,127}));
  connect(pipe_FixedPressure.port_a,inletTFStoFluidPortMSL_ass_FixedPressure. outportMSL) annotation (Line(points={{20,-30},{6,-30}},  color={0,127,255}));
  connect(source_FixedPressure.outlet,inletTFStoFluidPortMSL_ass_FixedPressure. inletTFS)
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
  connect(inletTFStoFluidPortMSL_ass_FixedPressure1.outportMSL,T_FixedFlow2. port) annotation (Line(points={{34,-60},{67,-60},{67,-58}}, color={0,127,255}));
  connect(inletTFStoFluidPortMSL_ass_FixedPressure1.outportMSL,sink_FixedPressure1. ports[1]) annotation (Line(points={{34,-60},{80,-60}}, color={0,127,255}));
  connect(source_FixedPressure1.outlet,flowResistance. inlet) annotation (Line(
      points={{-26,-60},{-14,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet,inletTFStoFluidPortMSL_ass_FixedPressure1. inletTFS)
    annotation (Line(
      points={{6,-60},{22.8,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(toKelvin.Kelvin, source_FixedPressure.T0_var) annotation (Line(points={{-53.5,89},{-53.5,-30},{-38,-30}}, color={0,0,127}));
  connect(toKelvin.Kelvin, source_FixedPressure1.T0_var) annotation (Line(points={{-53.5,89},{-53.5,-60},{-38,-60}}, color={0,0,127}));
  connect(add.y, source_FixedPressure1.p0_var) annotation (Line(points={{-65.6,-34},{-50,-34},{-50,-54},{-38,-54}}, color={0,0,127}));
  connect(add.y, boundary.p_in) annotation (Line(points={{-65.6,-34},{-50,-34},{-50,-82},{-38,-82}}, color={0,0,127}));
  connect(toKelvin.Kelvin, boundary.T_in) annotation (Line(points={{-53.5,89},{-53.5,-86},{-38,-86}}, color={0,0,127}));
  connect(x_N2O2.y, source_FixedPressure.xi_var) annotation (Line(points={{-79,100},{-44,100},{-44,-36},{-38,-36}}, color={0,0,127}));
  connect(x_N2O2.y, source_FixedPressure1.xi_var) annotation (Line(points={{-79,100},{-44,100},{-44,-66},{-38,-66}}, color={0,0,127}));
  connect(x_N2O2.y, boundary.X_in) annotation (Line(points={{-79,100},{-44,100},{-44,-94},{-38,-94}}, color={0,0,127}));
  connect(mFlowScenario.y, firstOrder.u) annotation (Line(points={{-79,60},{-78,60},{-78,-5.2}}, color={0,0,127}));
  connect(firstOrder.y, add.u1) annotation (Line(points={{-78,-14.4},{-78,-31.6},{-74.8,-31.6}}, color={0,0,127}));
  connect(pipe_FixedPressure1.port_b, fluidPortMSLtoOutletTFS_ass1.inportMSL) annotation (Line(points={{18,-90},{36.5,-90}}, color={0,127,255}));
  connect(boundary.ports[1], pipe_FixedPressure1.port_a) annotation (Line(points={{-16,-90},{-2,-90}}, color={0,127,255}));
  connect(fluidPortMSLtoOutletTFS_ass1.outletTFS, sink3.inlet) annotation (Line(
      points={{49,-90},{80,-90}},
      color={28,108,200},
      thickness=0.5));
  annotation (experiment(StopTime=3600, __Dymola_Algorithm="Dassl"), Diagram(graphics={
        Text(
          extent={{-34,0},{58,-24}},
          textColor={217,67,180},
          textString="Pressure boundaries"),
        Text(
          extent={{-34,100},{50,88}},
          textColor={217,67,180},
          textString="Fixed m_flow"),
        Text(
          extent={{50,-74},{60,-78}},
          textColor={255,0,0},
          textString="NOK"),
        Line(
          points={{2,-68},{20,-76},{46,-76},{64,-88}},
          color={255,0,0},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled})}));
end UnitTest_Mixture_OK;
