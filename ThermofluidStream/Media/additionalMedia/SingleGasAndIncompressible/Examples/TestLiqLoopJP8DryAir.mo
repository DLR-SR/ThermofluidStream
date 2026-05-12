within ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.Examples;
model TestLiqLoopJP8DryAir

      replaceable package SecondaryMedium =
        ThermofluidStream.Media.XRGMedia.CO2_ph constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
      annotation(choicesAllMatching=true);

    replaceable package RefrigerantMedium =
      ThermofluidStream.Media.XRGMedia.CO2_ph  constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
      annotation(choicesAllMatching=true);

    replaceable package TertiaryMedium =
     ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.JP8DryAir       constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
      annotation(choicesAllMatching=true);

    ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(
      redeclare package Medium = TertiaryMedium,
      outputTemperature=true,
      outputMassFlowRate=true,
      temperatureUnit="degC")
      annotation (Placement(transformation(extent={{-14,8},{-38,-16}})));
    ThermofluidStream.HeatExchangers.DiscretizedCounterFlowHEX evaporator(
      redeclare package MediumA = TertiaryMedium,
      redeclare package MediumB = SecondaryMedium,
      redeclare model ConductionElementA =
          ThermofluidStream.HeatExchangers.Internal.ConductionElementHEX,
      redeclare model ConductionElementB =
        ThermofluidStream.HeatExchangers.Internal.ConductionElementHEX_twoPhase,
      initializeMassFlow=false,
      nCells=10,
      A=15,
      V_Hex(displayUnit="m3"),
      k_wall=50) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={14,14})));

    ThermofluidStream.Processes.FlowResistance flowResistance1(
      redeclare package Medium = TertiaryMedium,
      initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
      r=0.05,
      l=1,
      redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss
        (  k=1e4))
      annotation (Placement(transformation(extent={{114,-4},{94,16}})));

    ThermofluidStream.Processes.Pump pump(redeclare package Medium =
          TertiaryMedium,
      omega_from_input=true,
      redeclare function dp_tau_pump =
        ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal(useLegacyReynolds = false))
      annotation (Placement(transformation(extent={{100,-80},{120,-60}})));

    ThermofluidStream.Processes.ConductionElement conductionElement(redeclare
      package Medium =   TertiaryMedium)
      annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heating_element
      annotation (Placement(transformation(extent={{-6,-58},{14,-38}})));
    Modelica.Blocks.Sources.RealExpression heat(y=40000)
      annotation (Placement(transformation(extent={{-46,-60},{-26,-40}})));
    ThermofluidStream.Boundaries.Reservoir reservoir(redeclare package Medium
      =   TertiaryMedium)
      annotation (Placement(transformation(extent={{-52,-80},{-32,-60}})));
    ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(
      redeclare package Medium = TertiaryMedium,
      outputTemperature=true,
      outputMassFlowRate=false,
      temperatureUnit="degC")
      annotation (Placement(transformation(extent={{74,6},{50,-18}})));
    ThermofluidStream.Boundaries.Source
                      source1(redeclare package Medium = SecondaryMedium,
      temperatureFromInput=false,
      T0_par=283.15,
      p0_par(displayUnit="Pa") = (SecondaryMedium.saturationPressure(263.15)))
      annotation (Placement(transformation(extent={{-132,34},{-112,54}})));
    ThermofluidStream.Boundaries.Sink
                    sink1(redeclare package Medium = SecondaryMedium,
        pressureFromInput=true)
      annotation (Placement(transformation(extent={{76,16},{96,36}})));
    ThermofluidStream.Processes.FlowResistance
                             flowResistance2(
      redeclare package Medium = SecondaryMedium,
      initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
      r=0.05,
      l=1,
      redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss
        (  k=1e4))
      annotation (Placement(transformation(extent={{-84,34},{-64,54}})));

    ThermofluidStream.Sensors.MultiSensor_Tpm
                            multiSensor_Tpm3(
      redeclare package Medium = SecondaryMedium,
      outputTemperature=true,
      outputMassFlowRate=true,
      temperatureUnit="degC")
      annotation (Placement(transformation(extent={{44,26},{64,46}})));
    Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=7e5, uMin=100)
      annotation (Placement(transformation(extent={{144,20},{132,32}})));
    Modelica.Blocks.Continuous.PI PI1(
      k=1000,
      T=0.1,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=1e5)
      annotation (Placement(transformation(extent={{170,16},{150,36}})));
    Modelica.Blocks.Math.Feedback feedback1
      annotation (Placement(transformation(extent={{198,16},{178,36}})));
    Modelica.Blocks.Sources.RealExpression refFlow_setPoint1(y=30)
      annotation (Placement(transformation(extent={{224,16},{204,36}})));
    ThermofluidStream.Sensors.MultiSensor_Tpm
                            multiSensor_Tpm4(
      redeclare package Medium = SecondaryMedium,
      outputMassFlowRate=true,
      temperatureUnit="degC")
      annotation (Placement(transformation(extent={{-46,44},{-22,22}})));
    inner ThermofluidStream.DropOfCommons dropOfCommons
      annotation (Placement(transformation(extent={{-102,-60},{-82,-40}})));
    Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=600, uMin=50)
      annotation (Placement(transformation(extent={{38,-140},{50,-128}})));
    Modelica.Blocks.Continuous.PI PI2(
      k=-5,
      T=0.1,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=300)
      annotation (Placement(transformation(extent={{4,-144},{24,-124}})));
    Modelica.Blocks.Math.Feedback feedback2
      annotation (Placement(transformation(extent={{-32,-124},{-12,-144}})));
    Modelica.Blocks.Sources.RealExpression refFlow_setPoint2(y=15)
      annotation (Placement(transformation(extent={{-66,-144},{-46,-124}})));
    ThermofluidStream.Sensors.DifferenceSensor_Tp differenceSensor_Tp(
    redeclare package MediumA = TertiaryMedium,
    redeclare package MediumB = TertiaryMedium,
        outputTemperature=true)
      annotation (Placement(transformation(extent={{34,-80},{54,-100}})));
    Modelica.Blocks.Math.Gain gain(k=-1)
      annotation (Placement(transformation(extent={{-4,-116},{-14,-106}})));
    Modelica.Blocks.Sources.RealExpression inlet_temp(y=283.15)
      annotation (Placement(transformation(extent={{-164,34},{-144,54}})));
equation

    connect(pump.outlet,flowResistance1. inlet) annotation (Line(
        points={{120,-70},{142,-70},{142,6},{114,6}},
        color={28,108,200},
        thickness=0.5));
    connect(conductionElement.outlet,pump. inlet) annotation (Line(
        points={{20,-70},{100,-70}},
        color={28,108,200},
        thickness=0.5));
    connect(heating_element.port,conductionElement. heatPort) annotation (Line(
          points={{14,-48},{14,-80},{10,-80}},                         color={191,
            0,0}));
    connect(heat.y,heating_element. Q_flow) annotation (Line(points={{-25,-50},{-25,
            -48},{-6,-48}},    color={0,0,127}));
    connect(reservoir.outlet,conductionElement. inlet) annotation (Line(
        points={{-32,-70},{0,-70}},
        color={28,108,200},
        thickness=0.5));
    connect(multiSensor_Tpm1.outlet,reservoir. inlet) annotation (Line(
        points={{-38,8},{-68,8},{-68,-70},{-52,-70}},
        color={28,108,200},
        thickness=0.5));
    connect(flowResistance1.outlet, multiSensor_Tpm2.inlet) annotation (Line(
        points={{94,6},{74,6}},
        color={28,108,200},
        thickness=0.5));
    connect(evaporator.outletA, multiSensor_Tpm1.inlet) annotation (Line(
        points={{4,8},{-14,8}},
        color={28,108,200},
        thickness=0.5));
    connect(multiSensor_Tpm2.outlet, evaporator.inletA) annotation (Line(
        points={{50,6},{28,6},{28,8},{24,8}},
        color={28,108,200},
        thickness=0.5));
    connect(source1.outlet,flowResistance2. inlet) annotation (Line(
        points={{-112,44},{-84,44}},
        color={28,108,200},
        thickness=0.5));
    connect(sink1.inlet,multiSensor_Tpm3. outlet) annotation (Line(
        points={{76,26},{64,26}},
        color={28,108,200},
        thickness=0.5));
    connect(limiter1.y,sink1. p0_var)
      annotation (Line(points={{131.4,26},{88,26}},    color={0,0,127}));
    connect(limiter1.u,PI1. y)
      annotation (Line(points={{145.2,26},{149,26}},     color={0,0,127}));
    connect(PI1.u,feedback1. y)
      annotation (Line(points={{172,26},{179,26}},     color={0,0,127}));
    connect(feedback1.u1,refFlow_setPoint1. y)
      annotation (Line(points={{196,26},{203,26}},     color={0,0,127}));
    connect(flowResistance2.outlet,multiSensor_Tpm4. inlet) annotation (Line(
        points={{-64,44},{-46,44}},
        color={28,108,200},
        thickness=0.5));
    connect(evaporator.outletB, multiSensor_Tpm3.inlet) annotation (Line(
        points={{24,20},{32,20},{32,26},{44,26}},
        color={28,108,200},
        thickness=0.5));
    connect(multiSensor_Tpm4.outlet, evaporator.inletB) annotation (Line(
        points={{-22,44},{-14,44},{-14,20},{4,20}},
        color={28,108,200},
        thickness=0.5));
    connect(limiter2.u,PI2. y)
      annotation (Line(points={{36.8,-134},{25,-134}},   color={0,0,127}));
    connect(limiter2.y, pump.omega_input) annotation (Line(points={{50.6,-134},{
            110,-134},{110,-82}},                  color={0,0,127}));
    connect(multiSensor_Tpm1.T_out, feedback1.u2) annotation (Line(points={{-35.84,
            -11.2},{-44,-11.2},{-44,-26},{188,-26},{188,18}},
                                                     color={0,0,127}));
    connect(feedback2.y, PI2.u)
      annotation (Line(points={{-13,-134},{2,-134}}, color={0,0,127}));
    connect(feedback2.u1, refFlow_setPoint2.y)
      annotation (Line(points={{-30,-134},{-45,-134}}, color={0,0,127}));
    connect(differenceSensor_Tp.inletA, conductionElement.inlet) annotation (Line(
        points={{34,-96},{-4,-96},{-4,-70},{0,-70}},
        color={28,108,200},
        thickness=0.5));
    connect(differenceSensor_Tp.inletB, conductionElement.outlet) annotation (
        Line(
        points={{34,-84},{26,-84},{26,-70},{20,-70}},
        color={28,108,200},
        thickness=0.5));
    connect(differenceSensor_Tp.T_out, gain.u) annotation (Line(points={{52,-94},
            {56,-94},{56,-111},{-3,-111}}, color={0,0,127}));
    connect(feedback2.u2, gain.y) annotation (Line(points={{-22,-126},{-22,-111},
            {-14.5,-111}}, color={0,0,127}));
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
</html>", info="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Introduced new version of <code>dp_tau_const_isentrop</code> pump function.
    </li>
  </ul>
</html>"));
end TestLiqLoopJP8DryAir;
