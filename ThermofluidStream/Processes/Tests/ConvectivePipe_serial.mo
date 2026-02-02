within ThermofluidStream.Processes.Tests;
model ConvectivePipe_serial

  extends Modelica.Icons.Example;

replaceable package Medium = Media.myMedia.Water.ConstantPropertyLiquidWater
    constrainedby Media.myMedia.Interfaces.PartialMedium annotation(choicesAllMatching = true);

  ThermalConvectionPipe thermalConvection(
    redeclare package Medium = Medium,
    r=0.005,
    l=1)
    annotation (Placement(transformation(extent={{-30,10},{-10,-10}})));
  Boundaries.Source source(
    redeclare package Medium = Medium,
    temperatureFromInput=false,
    T0_par=293.15,
    p0_par=100100)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Boundaries.Sink sink(redeclare package Medium = Medium,
      p0_par=100000)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow=2000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,70})));
  FlowResistance flowResistance(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e4))
    annotation (Placement(transformation(extent={{-84,-10},{-64,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=100, T(fixed=true))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,34})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm(
    redeclare package Medium = Medium,
    digits=3,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{54,0},{74,20}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm1(
    redeclare package Medium = Medium,
    digits=3,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-58,0},{-38,20}})));
  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{78,-96},{98,-76}})));
    /*
  Utilities.showRealValue showRealValue(
    use_numberPort=false,
    description="Re",
    number=thermalConvection.Re_D,
    significantDigits=1)
    annotation (Placement(transformation(extent={{-28,-8},{-8,-28}})));
  Utilities.showRealValue showRealValue1(
    use_numberPort=false,
    description="v_m",
    number=thermalConvection.v_m)
    annotation (Placement(transformation(extent={{10,-8},{30,-28}})));
    */
  Utilities.showRealValue showRealValue2(
    use_numberPort=false,
    description="HP.T",
    number=thermalConvection.heatPort.T - 273.15)
    annotation (Placement(transformation(extent={{-38,30},{-18,10}})));
  Modelica.Blocks.Sources.Step step(
    height=10,
    offset=10 + 273.15,
    startTime=500)
    annotation (Placement(transformation(extent={{-96,36},{-76,56}})));
  ThermalConvectionPipe thermalConvection1(
    redeclare package Medium = Medium,
    r=0.005,
    l=1)
    annotation (Placement(transformation(extent={{26,10},{46,-10}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm2(
    redeclare package Medium = Medium,
    digits=3,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=
        2000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={36,70})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(C=100, T(fixed=true))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={46,34})));
  Utilities.showRealValue showRealValue3(
    use_numberPort=false,
    description="HP.T",
    number=thermalConvection1.heatPort.T - 273.15)
    annotation (Placement(transformation(extent={{34,28},{54,8}})));
equation
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{-90,0},{-84,0}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConvection.heatPort, heatCapacitor.port)
    annotation (Line(points={{-20,10},{-20,34}},
                                             color={191,0,0}));
  connect(fixedHeatFlow.port, heatCapacitor.port) annotation (Line(points={{-20,60},
          {-20,34}}, color={191,0,0}));
  connect(sink.inlet, multiSensor_Tpm.outlet) annotation (Line(
      points={{90,0},{74,0}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, multiSensor_Tpm1.inlet) annotation (Line(
      points={{-64,0},{-58,0}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConvection.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{-30,0},{-38,0}},
      color={28,108,200},
      thickness=0.5));
  connect(multiSensor_Tpm.inlet, thermalConvection1.outlet) annotation (Line(
      points={{54,0},{46,0}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConvection.outlet, multiSensor_Tpm2.inlet) annotation (Line(
      points={{-10,0},{0,0}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConvection1.inlet, multiSensor_Tpm2.outlet) annotation (Line(
      points={{26,0},{20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(fixedHeatFlow1.port, heatCapacitor1.port)
    annotation (Line(points={{36,60},{36,34}}, color={191,0,0}));
  connect(heatCapacitor1.port, thermalConvection1.heatPort)
    annotation (Line(points={{36,34},{36,10}}, color={191,0,0}));
    annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1000, Tolerance=1e-6, Interval=1),
        Documentation(info="<html>
        <p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end ConvectivePipe_serial;
