within ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.Examples;
model TestSimpleLoopJP8DryAir

      replaceable package SecondaryMedium =
        ThermofluidStream.Media.XRGMedia.CO2_ph constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
      annotation(choicesAllMatching=true);

    replaceable package RefrigerantMedium =
      ThermofluidStream.Media.XRGMedia.CO2_ph  constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
      annotation(choicesAllMatching=true);

    replaceable package TertiaryMedium =
      ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.JP8DryAir
                                                                                        constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
      annotation(choicesAllMatching=true);
  //     TertiaryMedium.BaseProperties terMedium;

    ThermofluidStream.Processes.FlowResistance flowResistance1(
      redeclare package Medium = TertiaryMedium,
      initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
      r=0.05,
      l=1,
      redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss
        (  k=1e4))
      annotation (Placement(transformation(extent={{110,-10},{90,10}})));

    ThermofluidStream.Processes.Pump pump(redeclare package Medium =
          TertiaryMedium,
      omega_from_input=true,
      redeclare function dp_tau_pump =
        ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal)
      annotation (Placement(transformation(extent={{88,-80},{108,-60}})));

    ThermofluidStream.Processes.ConductionElement conductionElement(redeclare
      package Medium =   TertiaryMedium)
      annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heating_element
      annotation (Placement(transformation(extent={{-6,-58},{14,-38}})));
    Modelica.Blocks.Sources.RealExpression heat(y=40)
      annotation (Placement(transformation(extent={{-46,-60},{-26,-40}})));
    ThermofluidStream.Boundaries.Reservoir reservoir(redeclare package Medium
      =   TertiaryMedium)
      annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
    ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(
      redeclare package Medium = TertiaryMedium,
      outputTemperature=true,
      outputMassFlowRate=false,
      temperatureUnit="degC")
      annotation (Placement(transformation(extent={{62,0},{36,-26}})));
    inner ThermofluidStream.DropOfCommons dropOfCommons
      annotation (Placement(transformation(extent={{-102,-60},{-82,-40}})));
    Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=600, uMin=50)
      annotation (Placement(transformation(extent={{38,-146},{50,-134}})));
    Modelica.Blocks.Continuous.PI PI2(
      k=-5,
      T=0.1,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=300)
      annotation (Placement(transformation(extent={{4,-150},{24,-130}})));
    Modelica.Blocks.Math.Feedback feedback2
      annotation (Placement(transformation(extent={{-32,-130},{-12,-150}})));
    Modelica.Blocks.Sources.RealExpression refFlow_setPoint2(y=15)
      annotation (Placement(transformation(extent={{-66,-150},{-46,-130}})));
    ThermofluidStream.Sensors.DifferenceSensor_Tp differenceSensor_Tp(
    redeclare package MediumA = TertiaryMedium,
    redeclare package MediumB = TertiaryMedium,
        outputTemperature=true)
      annotation (Placement(transformation(extent={{28,-80},{48,-100}})));
    Modelica.Blocks.Math.Gain gain(k=-1)
      annotation (Placement(transformation(extent={{-4,-116},{-14,-106}})));
equation
  //   terMedium.X[2]=0.9999;
    connect(pump.outlet,flowResistance1. inlet) annotation (Line(
        points={{108,-70},{142,-70},{142,0},{110,0}},
        color={28,108,200},
        thickness=0.5));
    connect(conductionElement.outlet,pump. inlet) annotation (Line(
        points={{20,-70},{88,-70}},
        color={28,108,200},
        thickness=0.5));
    connect(heating_element.port,conductionElement. heatPort) annotation (Line(
          points={{14,-48},{14,-80},{10,-80}},                         color={191,
            0,0}));
    connect(heat.y,heating_element. Q_flow) annotation (Line(points={{-25,-50},{-25,
            -48},{-6,-48}},    color={0,0,127}));
    connect(reservoir.outlet,conductionElement. inlet) annotation (Line(
        points={{-30,-70},{0,-70}},
        color={28,108,200},
        thickness=0.5));
    connect(flowResistance1.outlet, multiSensor_Tpm2.inlet) annotation (Line(
        points={{90,0},{62,0}},
        color={28,108,200},
        thickness=0.5));
    connect(limiter2.u,PI2. y)
      annotation (Line(points={{36.8,-140},{25,-140}},   color={0,0,127}));
    connect(limiter2.y, pump.omega_input) annotation (Line(points={{50.6,-140},{
            98,-140},{98,-82}},                    color={0,0,127}));
    connect(feedback2.y, PI2.u)
      annotation (Line(points={{-13,-140},{2,-140}}, color={0,0,127}));
    connect(feedback2.u1, refFlow_setPoint2.y)
      annotation (Line(points={{-30,-140},{-45,-140}}, color={0,0,127}));
    connect(differenceSensor_Tp.inletA, conductionElement.inlet) annotation (Line(
        points={{28,-96},{-4,-96},{-4,-70},{0,-70}},
        color={28,108,200},
        thickness=0.5));
    connect(differenceSensor_Tp.inletB, conductionElement.outlet) annotation (
        Line(
        points={{28,-84},{26,-84},{26,-70},{20,-70}},
        color={28,108,200},
        thickness=0.5));
    connect(differenceSensor_Tp.T_out, gain.u) annotation (Line(points={{46,-94},
            {56,-94},{56,-111},{-3,-111}}, color={0,0,127}));
    connect(feedback2.u2, gain.y) annotation (Line(points={{-22,-132},{-22,-111},
            {-14.5,-111}}, color={0,0,127}));
    connect(multiSensor_Tpm2.outlet, reservoir.inlet) annotation (Line(
        points={{36,0},{-60,0},{-60,-70},{-50,-70}},
        color={28,108,200},
        thickness=0.5));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-180},{260,100}}),
          graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent={{-82,-178},{192,98}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points={{-18,74},{170,-46},{-18,-158},{-18,74}})}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-180},{260,
              100}})),Documentation( revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"));
end TestSimpleLoopJP8DryAir;
