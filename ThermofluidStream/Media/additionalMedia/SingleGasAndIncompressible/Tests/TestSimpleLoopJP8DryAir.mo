within ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.Tests;
model TestSimpleLoopJP8DryAir "Test of a simple cooling loop using JP8DryAir"
  extends Modelica.Icons.Example;

  replaceable package TertiaryMedium = ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.JP8DryAir
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  //     TertiaryMedium.BaseProperties terMedium;

  ThermofluidStream.Processes.FlowResistance flowResistance1(
    redeclare package Medium = TertiaryMedium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=1,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=1e4),
    pressureDropUnit=ThermofluidStream.Types.PressureUnit.kPa)
    annotation (Placement(transformation(extent={{60,30},{40,50}})));

  ThermofluidStream.Processes.Pump pump(
    redeclare package Medium = TertiaryMedium,
    omega_from_input=true,
    redeclare function dp_tau_pump = ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal (
          useLegacyReynolds=false)) annotation (Placement(transformation(extent={{60,-20},{80,0}})));

  ThermofluidStream.Processes.ConductionElement conductionElement(
    redeclare package Medium = TertiaryMedium,
    displayVolume=false,
    displayConduction=false) annotation (Placement(transformation(extent={{-20,0},{0,-20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heating_element
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Blocks.Sources.RealExpression heat(y=40000)
                                                    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  ThermofluidStream.Boundaries.Reservoir reservoir(redeclare package Medium = TertiaryMedium)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(
    redeclare package Medium = TertiaryMedium,
    pressureUnit="bar",
    outputTemperature=false,
    outputMassFlowRate=false,
    temperatureUnit="degC") annotation (Placement(transformation(extent={{20,40},{0,60}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=600, uMin=50)
    annotation (Placement(transformation(extent={{34,-76},{46,-64}})));
  Modelica.Blocks.Continuous.PI PI2(
    k=-5,
    T=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=300) annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
  Modelica.Blocks.Math.Feedback feedback2 annotation (Placement(transformation(extent={{-40,-60},{-20,-80}})));
  Modelica.Blocks.Sources.RealExpression refFlow_setPoint2(y=15)
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  ThermofluidStream.Sensors.DifferenceSensor_Tp differenceSensor_Tp(
    redeclare package MediumA = TertiaryMedium,
    redeclare package MediumB = TertiaryMedium,
    outputTemperature=true) annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
equation
  //   terMedium.X[2]=0.9999;
  connect(pump.outlet, flowResistance1.inlet)
    annotation (Line(
      points={{80,-10},{88,-10},{88,40},{60,40}},
      color={28,108,200},
      thickness=0.5));
  connect(conductionElement.outlet, pump.inlet)
    annotation (Line(
      points={{0,-10},{60,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(heating_element.port, conductionElement.heatPort)
    annotation (Line(points={{-20,20},{-10,20},{-10,0}}, color={191,0,0}));
  connect(heat.y, heating_element.Q_flow) annotation (Line(points={{-59,20},{-40,20}}, color={0,0,127}));
  connect(reservoir.outlet, conductionElement.inlet)
    annotation (Line(
      points={{-40,-10},{-20,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, multiSensor_Tpm2.inlet)
    annotation (Line(
      points={{40,40},{20,40}},
      color={28,108,200},
      thickness=0.5));
  connect(limiter2.u, PI2.y) annotation (Line(points={{32.8,-70},{21,-70}}, color={0,0,127}));
  connect(limiter2.y, pump.omega_input) annotation (Line(points={{46.6,-70},{70,-70},{70,-22}}, color={0,0,127}));
  connect(feedback2.y, PI2.u) annotation (Line(points={{-21,-70},{-2,-70}}, color={0,0,127}));
  connect(feedback2.u1, refFlow_setPoint2.y) annotation (Line(points={{-38,-70},{-59,-70}}, color={0,0,127}));
  connect(multiSensor_Tpm2.outlet, reservoir.inlet)
    annotation (Line(
      points={{0,40},{-86,40},{-86,-10},{-60,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensor_Tp.inletA, conductionElement.outlet)
    annotation (Line(
      points={{20,-26},{8,-26},{8,-10},{0,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensor_Tp.inletB, reservoir.outlet)
    annotation (Line(
      points={{20,-34},{-32,-34},{-32,-10},{-40,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(differenceSensor_Tp.T_out, feedback2.u2)
    annotation (Line(points={{41,-26},{52,-26},{52,-46},{-30,-46},{-30,-62}}, color={0,0,127}));
  annotation (
    Documentation(revisions="<html>
  <ul>
    <li>
      <p><img src=\"modelica://ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
        Simulation and Thermal Analysis,
        Vehicle Systems,
        SAAB Aerosystems, 2024
     </p>
    </li>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Introduced new version of <code>dp_tau_const_isentrop</code> pump function.
    </li>
    <li>
      06/2026, by Corentin Lepais (corentin.lepais@dlr.de):<br>
      Improve documentation and graphic layer. Change heat in-flow from 40W to 40000W to make sure the loop reaches the setpoint. 
    </li>
  </ul>
</html>", info="<html>
  <p>
    <code>TestSimpleLoopJP8DryAir</code> is a Modelica test model for <a href=\"modelica://ThermofluidStream.Media.additionalMedia.SingleGasAndIncompressible.JP8DryAir\">JP8DryAir</a>, a mixture of JP8, a jet propulsion fuel often used in military aircraft, and dry air.
    It simulates a simple cooling loop using JP8 and dry air as refrigerant.
  </p>
  <p>
    The loop includes a reservoir, centrifugal pump, a flow resistance, and a heating element.
    The 40 kW heating element adds thermal energy to the JP8 and dry air fluid and the pump maintained a temperature difference of 15°C across the conduction element by regulating the mass flow in the loop.
  </p>
</html>"),
    experiment(StopTime=10, __Dymola_Algorithm="Dassl"));
end TestSimpleLoopJP8DryAir;
