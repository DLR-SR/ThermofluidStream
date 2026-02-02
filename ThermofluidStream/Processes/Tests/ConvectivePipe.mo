within ThermofluidStream.Processes.Tests;
model ConvectivePipe
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Water.ConstantPropertyLiquidWater
    constrainedby Media.myMedia.Interfaces.PartialMedium
    annotation(choicesAllMatching = true);

  ThermalConvectionPipe thermalConvection(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.003,
    l=6.65)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}})));
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
        origin={0,70})));
  FlowResistance flowResistance(
    redeclare package Medium = Medium,
    r=0.05,
    l=1,
    redeclare function pLoss = Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e4))
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=0.0001, T(fixed=true))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={12,34})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm(
    redeclare package Medium = Medium,
    digits=3,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm1(
    redeclare package Medium = Medium,
    digits=3,
    temperatureUnit="degC")
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
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
    annotation (Placement(transformation(extent={{-20,30},{0,10}})));
  Modelica.Blocks.Sources.Step step(
    height=10,
    offset=10 + 273.15,
    startTime=500)
    annotation (Placement(transformation(extent={{-132,8},{-112,28}})));
equation
  connect(source.outlet, flowResistance.inlet) annotation (Line(
      points={{-90,0},{-70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConvection.heatPort, heatCapacitor.port)
    annotation (Line(points={{0,10},{0,34},{2,34}},
                                             color={191,0,0}));
  connect(fixedHeatFlow.port, heatCapacitor.port) annotation (Line(points={{
          -1.77636e-15,60},{0,60},{0,34},{2,34}}, color={191,0,0}));
  connect(thermalConvection.outlet, multiSensor_Tpm.inlet) annotation (Line(
      points={{10,0},{40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, multiSensor_Tpm.outlet) annotation (Line(
      points={{90,0},{60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, multiSensor_Tpm1.inlet) annotation (Line(
      points={{-50,0},{-40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConvection.inlet, multiSensor_Tpm1.outlet) annotation (Line(
      points={{-10,0},{-20,0}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1000, Tolerance=1e-6, Interval=1),
        Documentation(info="<html>
        <p>Owner: <a href=\"mailto:niels.weber@dlr.de\">Niels Weber</a></p>
</html>"));
end ConvectivePipe;
