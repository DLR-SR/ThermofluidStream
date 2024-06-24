within TILMediaWrapper;
package Tests
  extends Modelica.Icons.ExamplesPackage;

  model TestVLEFFluidWrapper
    extends Modelica.Icons.Example;

    replaceable package Medium = VLEFluidWrapper.Methanol
      constrainedby TILMediaWrapper.VLEFluidWrapper.PartialModels.VLEFluid_ph
        annotation(choicesAllMatching=true);

    ThermofluidStream.Boundaries.VolumeFlex volumeFlex(
      redeclare package Medium = Medium,
      useHeatport=true,
      useInlet=true,
      useOutlet=false,
      A=200,
      U=2000,
      p_start=50000,
      T_start(displayUnit="K") = 400,
      use_hstart=false,
      h_start=1e4) annotation (Placement(transformation(extent={{16,50},{36,30}})));

    ThermofluidStream.Boundaries.Sink sink2(
      redeclare package Medium = Medium,
      pressureFromInput=false,
      p0_par=100000) annotation (Placement(transformation(extent={{22,-10},{42,10}})));
    ThermofluidStream.Boundaries.Source source(
      redeclare package Medium = Medium,
      setEnthalpy=false,
      temperatureFromInput=true,
      p0_par=110000,
      h0_par=1000) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
    ThermofluidStream.Processes.FlowResistance flowResistance(
      redeclare package Medium = Medium,
      initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
      r(displayUnit="mm") = 0.01,
      l=10,
      redeclare function pLoss =
          ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (                       k=100, k2=100))
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Sources.Ramp ramp(
      height=300,
      duration=1,
      offset=13.5)
                 annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));

    inner ThermofluidStream.DropOfCommons dropOfCommons(assertionLevel=AssertionLevel.warning)
      annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));

    ThermofluidStream.Boundaries.Source source1(
      redeclare package Medium = Medium,
      setEnthalpy=false,
      pressureFromInput=true,
      temperatureFromInput=false,
      T0_par=293.15,
      p0_par=110000,
      h0_par=1000) annotation (Placement(transformation(extent={{-42,30},{-22,50}})));
    Modelica.Blocks.Sources.Ramp ramp1(
      height=30e5,
      duration=1,
      offset=0.5e5)
                 annotation (Placement(transformation(extent={{-72,36},{-52,56}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T(displayUnit="K") = 400)
      annotation (Placement(transformation(extent={{-28,60},{-8,80}})));
    ThermofluidStream.Processes.FlowResistance flowResistance1(
      redeclare package Medium = Medium,
      initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
      r(displayUnit="mm") = 0.01,
      l=10,
      redeclare function pLoss =
          ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (                       k=1000, k2=1000))
      annotation (Placement(transformation(extent={{-12,30},{8,50}})));
    ThermofluidStream.Boundaries.PhaseSeparator phaseSeparator(
      redeclare package Medium = Medium,
      useHeatport=true,
      A=200,
      U=2000,
      p_start=50000,
      pipe_low=0.5,
      pipe_high=0.6) annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));

    ThermofluidStream.Boundaries.TerminalSource terminalSource(redeclare package
                Medium =                                                                  Medium)
      annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
    ThermofluidStream.Boundaries.TerminalSink terminalSink(redeclare package
        Medium =                                                                      Medium)
      annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T(displayUnit="K") = 350)
      annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  equation
    connect(sink2.inlet, flowResistance.outlet) annotation (Line(
        points={{22,0},{10,0}},
        color={28,108,200},
        thickness=0.5));
    connect(flowResistance.inlet, source.outlet) annotation (Line(
        points={{-10,0},{-20,0}},
        color={28,108,200},
        thickness=0.5));
    connect(ramp.y, source.T0_var) annotation (Line(points={{-49,0},{-32,0}},   color={0,0,127}));
    connect(ramp1.y, source1.p0_var) annotation (Line(points={{-51,46},{-42,46},{-42,46},{-34,46}}, color={0,0,127}));
    connect(fixedTemperature.port, volumeFlex.heatPort) annotation (Line(points={{-8,70},{26,70},{26,48}},
                                                                                                         color={191,0,0}));
    connect(source1.outlet, flowResistance1.inlet) annotation (Line(
        points={{-22,40},{-12,40}},
        color={28,108,200},
        thickness=0.5));
    connect(flowResistance1.outlet, volumeFlex.inlet) annotation (Line(
        points={{8,40},{16,40}},
        color={28,108,200},
        thickness=0.5));

    connect(phaseSeparator.inlet, terminalSource.outlet)
      annotation (Line(
        points={{-10,-50},{-20,-50}},
        color={28,108,200},
        thickness=0.5));
    connect(phaseSeparator.outlet, terminalSink.inlet) annotation (Line(
        points={{10,-50},{20,-50}},
        color={28,108,200},
        thickness=0.5));
    connect(fixedTemperature1.port, phaseSeparator.heatPort) annotation (Line(points={{-20,-80},{0,-80},{0,-58}}, color={191,0,0}));
    annotation (
      experiment(
        StopTime=1,
        Interval=0.001,
        Tolerance=1e-05,
        __Dymola_Algorithm="Dassl"));
  end TestVLEFFluidWrapper;
end Tests;
