within ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.Examples;
model TestSimpleLoopWithStaticHeadJP8DryAir

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
        (   k=1e4))
       annotation (Placement(transformation(extent={{20,0},{0,20}})));

     ThermofluidStream.Processes.Pump pump(redeclare package Medium =
           TertiaryMedium,
       omega_from_input=true,
       redeclare function dp_tau_pump =
        ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal)
       annotation (Placement(transformation(extent={{92,-90},{112,-70}})));

     ThermofluidStream.Processes.ConductionElement conductionElement(redeclare
      package Medium =    TertiaryMedium)
       annotation (Placement(transformation(extent={{40,-90},{60,-70}})));
     Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heating_element
       annotation (Placement(transformation(extent={{32,-56},{52,-36}})));
     Modelica.Blocks.Sources.RealExpression heat(y=40)
       annotation (Placement(transformation(extent={{-8,-58},{12,-38}})));
     ThermofluidStream.Boundaries.Reservoir reservoir(redeclare package Medium
      =    TertiaryMedium)
       annotation (Placement(transformation(extent={{-112,-90},{-92,-70}})));
     ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm3(
       redeclare package Medium = TertiaryMedium,
       outputTemperature=true,
       outputMassFlowRate=false,
       temperatureUnit="degC")
       annotation (Placement(transformation(extent={{-28,10},{-52,-14}})));
     inner ThermofluidStream.DropOfCommons dropOfCommons
       annotation (Placement(transformation(extent={{-174,-50},{-154,-30}})));
     Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=600, uMin=50)
       annotation (Placement(transformation(extent={{34,-156},{46,-144}})));
     Modelica.Blocks.Continuous.PI PI2(
       k=-5,
       T=0.1,
       initType=Modelica.Blocks.Types.Init.InitialOutput,
       y_start=300)
       annotation (Placement(transformation(extent={{0,-160},{20,-140}})));
     Modelica.Blocks.Math.Feedback feedback2
       annotation (Placement(transformation(extent={{-36,-140},{-16,-160}})));
     Modelica.Blocks.Sources.RealExpression refFlow_setPoint2(y=15)
       annotation (Placement(transformation(extent={{-70,-160},{-50,-140}})));
     ThermofluidStream.Sensors.DifferenceSensor_Tp differenceSensor_Tp(
     redeclare package MediumA = TertiaryMedium,
     redeclare package MediumB = TertiaryMedium,
         outputTemperature=true)
       annotation (Placement(transformation(extent={{66,-104},{86,-124}})));
     Modelica.Blocks.Math.Gain gain(k=-1)
       annotation (Placement(transformation(extent={{-8,-132},{-18,-122}})));
     inner ThermofluidStream.Boundaries.AccelerationBoundary acceleration(
       setFromInputs=false,
       ax=9*sin(0.1*time),
       ay=0) annotation (Placement(transformation(extent={{-180,-22},{-160,-2}})));
     ThermofluidStream.Processes.StaticHead staticHead(
       redeclare package Medium = TertiaryMedium,
       fromPosition={0,0,0},
       toPosition={3,0,2}) annotation (Placement(transformation(
           extent={{-11,-11},{11,11}},
           rotation=90,
           origin={181,-21})));
     ThermofluidStream.Processes.StaticHead staticHead1(
       redeclare package Medium = TertiaryMedium,
       fromPosition={3,0,2},
       toPosition={1,0,1}) annotation (Placement(transformation(
           extent={{10,-10},{-10,10}},
           rotation=90,
           origin={-120,-10})));
     ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(
       redeclare package Medium = TertiaryMedium,
       outputTemperature=true,
       outputMassFlowRate=false,
       temperatureUnit="degC")
       annotation (Placement(transformation(extent={{140,-80},{162,-102}})));
     ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm4(
       redeclare package Medium = TertiaryMedium,
       outputTemperature=true,
       outputMassFlowRate=false,
       temperatureUnit="degC")
       annotation (Placement(transformation(extent={{-10.5,10.5},{10.5,-10.5}},
           rotation=-90,
           origin={-129.5,-49.5})));
     ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(
       redeclare package Medium = TertiaryMedium,
       outputTemperature=true,
       outputMassFlowRate=false,
       temperatureUnit="degC")
       annotation (Placement(transformation(extent={{90,10},{70,-10}})));
     ThermofluidStream.Processes.StaticHead staticHead2(
       redeclare package Medium = TertiaryMedium,
       fromPosition={1,0,1},
       toPosition={0,0,0},
       displayPositions=false) annotation (Placement(transformation(
           extent={{10.5,12.5},{-10.5,-12.5}},
           rotation=180,
           origin={-67.5,-79.5})));
     ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm5(
       redeclare package Medium = TertiaryMedium,
       outputTemperature=true,
       outputMassFlowRate=false,
       temperatureUnit="degC")
       annotation (Placement(transformation(extent={{-34,-80},{-10,-104}})));
equation

     connect(heating_element.port,conductionElement. heatPort) annotation (Line(
           points={{52,-46},{52,-90},{50,-90}},                         color={191,
             0,0}));
     connect(heat.y,heating_element. Q_flow) annotation (Line(points={{13,-48},{
             13,-46},{32,-46}}, color={0,0,127}));
     connect(flowResistance1.outlet,multiSensor_Tpm3. inlet) annotation (Line(
         points={{0,10},{-28,10}},
         color={28,108,200},
         thickness=0.5));
     connect(limiter2.u,PI2. y)
       annotation (Line(points={{32.8,-150},{21,-150}},   color={0,0,127}));
     connect(limiter2.y, pump.omega_input) annotation (Line(points={{46.6,-150},{
             102,-150},{102,-92}},                  color={0,0,127}));
     connect(feedback2.y, PI2.u)
       annotation (Line(points={{-17,-150},{-2,-150}},color={0,0,127}));
     connect(feedback2.u1, refFlow_setPoint2.y)
       annotation (Line(points={{-34,-150},{-49,-150}}, color={0,0,127}));
     connect(differenceSensor_Tp.inletA, conductionElement.inlet) annotation (Line(
         points={{66,-120},{32,-120},{32,-80},{40,-80}},
         color={28,108,200},
         thickness=0.5));
     connect(differenceSensor_Tp.inletB, conductionElement.outlet) annotation (
         Line(
         points={{66,-108},{66,-88},{72,-88},{72,-80},{60,-80}},
         color={28,108,200},
         thickness=0.5));
     connect(differenceSensor_Tp.T_out, gain.u) annotation (Line(points={{84,-118},
             {94,-118},{94,-128},{-7,-128},{-7,-127}},
                                            color={0,0,127}));
     connect(feedback2.u2, gain.y) annotation (Line(points={{-26,-142},{-26,-127},
             {-18.5,-127}}, color={0,0,127}));
     connect(multiSensor_Tpm3.outlet, staticHead1.inlet) annotation (Line(
         points={{-52,10},{-120,10},{-120,0}},
         color={28,108,200},
         thickness=0.5));
     connect(staticHead.outlet, multiSensor_Tpm2.inlet) annotation (Line(
         points={{181,-10},{181,10},{90,10}},
         color={28,108,200},
         thickness=0.5));
     connect(multiSensor_Tpm2.outlet, flowResistance1.inlet) annotation (Line(
         points={{70,10},{20,10}},
         color={28,108,200},
         thickness=0.5));
     connect(pump.outlet, multiSensor_Tpm1.inlet) annotation (Line(
         points={{112,-80},{140,-80}},
         color={28,108,200},
         thickness=0.5));
     connect(multiSensor_Tpm1.outlet, staticHead.inlet) annotation (Line(
         points={{162,-80},{181,-80},{181,-32}},
         color={28,108,200},
         thickness=0.5));
     connect(staticHead1.outlet, multiSensor_Tpm4.inlet) annotation (Line(
         points={{-120,-20},{-120,-39},{-119,-39}},
         color={28,108,200},
         thickness=0.5));
     connect(multiSensor_Tpm4.outlet, reservoir.inlet) annotation (Line(
         points={{-119,-60},{-119.5,-60},{-119.5,-80},{-112,-80}},
         color={28,108,200},
         thickness=0.5));
     connect(reservoir.outlet, staticHead2.inlet) annotation (Line(
         points={{-92,-80},{-80,-80},{-80,-79.5},{-78,-79.5}},
         color={28,108,200},
         thickness=0.5));
     connect(conductionElement.outlet, pump.inlet) annotation (Line(
         points={{60,-80},{92,-80}},
         color={28,108,200},
         thickness=0.5));
     connect(staticHead2.outlet, multiSensor_Tpm5.inlet) annotation (Line(
         points={{-57,-79.5},{-34,-79.5},{-34,-80}},
         color={28,108,200},
         thickness=0.5));
     connect(multiSensor_Tpm5.outlet, conductionElement.inlet) annotation (Line(
         points={{-10,-80},{40,-80}},
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
               100}})),
       experiment(StopTime=30, __Dymola_Algorithm="Dassl"),Documentation(revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"));
end TestSimpleLoopWithStaticHeadJP8DryAir;
