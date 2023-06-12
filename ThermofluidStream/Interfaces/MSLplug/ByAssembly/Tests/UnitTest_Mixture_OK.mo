within ThermofluidStream.Interfaces.MSLplug.ByAssembly.Tests;
model UnitTest_Mixture_OK
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.MixtureGases.CombustionAir
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium   annotation (
      choicesAllMatching=true);
          //ThermofluidStream.Media.myMedia.Water.WaterIF97_R1pT

  ThermofluidStream.Boundaries.Source source(redeclare package Medium = Medium, temperatureFromInput=true,
    xiFromInput=true)                        annotation (
    Placement(visible = true, transformation(origin={-50,30},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium, p0_par=101300)
    annotation (
    Placement(visible = true, transformation(origin={70,30},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  FlowControl.MCV flowGenerator(
    redeclare package Medium = Medium, setpointFromInput=true)
    annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin annotation (Placement(
        transformation(
        extent={{-4,4},{4,-4}},
        rotation=-90,
        origin={-60,38})));
  Modelica.Blocks.Math.Gain gain(k=1) annotation (Placement(transformation(
        extent={{-3,-4},{3,4}},
        rotation=-90,
        origin={-34,45})));
  inner DropOfCommons dropOfCommons(L=1000)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ThermofluidStream.Boundaries.Source source1(redeclare package Medium = Medium, temperatureFromInput=true,
    xiFromInput=true)                        annotation (
    Placement(visible = true, transformation(origin={-50,-10},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary sink1(redeclare package Medium = Medium,
    p=101300,
    nPorts=1)
    annotation (Placement(transformation(extent={{80,-20},{60,0}})));
  InletTFStoFluidPortMSL_ass inletTFStoFluidPortMSL_ass(
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  FlowControl.MCV  flowGenerator1(
    redeclare package Medium = Medium, setpointFromInput=true)
    annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
  Modelica.Fluid.Sources.MassFlowSource_T flowGenerator2(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_T_in=true,
    use_X_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  FluidPortMSLtoOutletTFS_ass fluidPortMSLtoOutletTFS_ass(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  ThermofluidStream.Boundaries.Sink sink2(redeclare package Medium = Medium, p0_par=101300)
     annotation (
    Placement(visible = true, transformation(origin={70,-50},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression x_N2O2[2](y={0.8*exp(-time/1E4),1 - 0.8*exp(-time/1E4)}) annotation (Placement(transformation(extent={{-100,88},{-80,100}})));
  Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{22,0},{34,10}})));
  Modelica.Fluid.Sensors.Temperature temperature1(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-4,-40},{8,-30}})));
  Modelica.Blocks.Noise.UniformNoise mFlowScenario(
    samplePeriod=60,
    y_min=0.001,
    y_max=15) annotation (Placement(transformation(extent={{-100,66},{-80,80}})));
  Modelica.Blocks.Noise.UniformNoise temperatureScenario(
    samplePeriod=60,
    y_min=10,
    y_max=35) annotation (Placement(transformation(extent={{-100,40},{-80,56}})));
equation
  connect(source.outlet, flowGenerator.inlet) annotation (Line(
      points={{-40,30},{-30,30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowGenerator.outlet, sink.inlet) annotation (Line(
      points={{-10,30},{60,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, flowGenerator1.inlet) annotation (Line(
      points={{-40,-10},{-30,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(inletTFStoFluidPortMSL_ass.inletTFS, flowGenerator1.outlet) annotation (Line(
      points={{1,-10},{-10,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(toKelvin.Kelvin, source1.T0_var) annotation (Line(points={{-60,33.6},{-60,-10},{-52,-10}},
                                                                                                   color={0,0,127}));
  connect(toKelvin.Kelvin, source.T0_var) annotation (Line(points={{-60,33.6},{-60,30},{-52,30}}, color={0,0,127}));
  connect(toKelvin.Kelvin, flowGenerator2.T_in) annotation (Line(points={{-60,33.6},{-60,-46},{-42,-46}}, color={0,0,127}));
  connect(gain.y, flowGenerator2.m_flow_in) annotation (Line(points={{-34,41.7},{-34,-30},{-52,-30},{-52,-42},{-40,-42}}, color={0,0,127}));
  connect(fluidPortMSLtoOutletTFS_ass.outletTFS, sink2.inlet) annotation (Line(
      points={{18.5,-50},{60,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(x_N2O2.y, source.xi_var) annotation (Line(points={{-79,94},{-56,94},{-56,24},{-52,24}}, color={0,0,127}));
  connect(x_N2O2.y, flowGenerator2.X_in) annotation (Line(points={{-79,94},{-56,94},{-56,-54},{-42,-54}}, color={0,0,127}));
  connect(x_N2O2.y, source1.xi_var) annotation (Line(points={{-79,94},{-56,94},{-56,-16},{-52,-16}},
                                                                                                 color={0,0,127}));
  connect(flowGenerator2.ports[1], fluidPortMSLtoOutletTFS_ass.inportMSL) annotation (Line(points={{-20,-50},{4.5,-50}},   color={0,127,255}));
  connect(inletTFStoFluidPortMSL_ass.outportMSL, sink1.ports[1]) annotation (Line(points={{15,-10},{60,-10}},
                                                                                                            color={0,127,255}));
  connect(inletTFStoFluidPortMSL_ass.outportMSL, temperature.port) annotation (Line(points={{15,-10},{28,-10},{28,0}},
                                                                                                                    color={0,127,255}));
  connect(temperature1.port, fluidPortMSLtoOutletTFS_ass.inportMSL) annotation (Line(points={{2,-40},{2,-50},{4.5,-50}},       color={0,127,255}));
  connect(gain.y, flowGenerator.setpoint_var) annotation (Line(points={{-34,41.7},{-20,41.7},{-20,38}}, color={0,0,127}));
  connect(gain.y, flowGenerator1.setpoint_var) annotation (Line(points={{-34,41.7},{-34,8},{-20,8},{-20,-2}}, color={0,0,127}));
  connect(mFlowScenario.y, gain.u) annotation (Line(points={{-79,73},{-34,73},{-34,48.6}}, color={0,0,127}));
  connect(temperatureScenario.y, toKelvin.Celsius) annotation (Line(points={{-79,48},{-60,48},{-60,42.8}}, color={0,0,127}));
  annotation (experiment(StopTime=172800, __Dymola_Algorithm="Dassl"));
end UnitTest_Mixture_OK;
