within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.AdiabaticPseudoInversion;
model Step3Turbine2
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.He
                                                                              constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{-200,180},{-180,200}})));
  Processes.Isobaric reactor(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed(displayUnit="K") = 1180) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-100,20})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=7000000,
    T0_par(displayUnit="K") = 780) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,-12})));
  Processes.Adiabatic turbine1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.94,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,80})));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={30,30})));
  Sources.Sink_free sink(redeclare package Medium = Medium) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));
  Processes.Adiabatic turbine2(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    etaSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=5240000) annotation (Placement(transformation(extent={{-10,10},{10,-10}}, rotation=270)));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor1(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={30,-40})));
  Modelica.Blocks.Sources.RealExpression turbine2OutletTemperature(y(unit="K") = 1060) annotation (Placement(transformation(extent={{120,-32},{100,-12}})));
  EnergyFlow.Sources.FixedEnergyFlow reactorHeatFlow(E_flow(displayUnit="MW") = 6000000) annotation (Placement(transformation(extent={{-140,10},{-120,30}})));
  EnergyFlow.Components.FixedTransferEfficiency turbine1Losses(eta=0.95) annotation (Placement(transformation(extent={{40,90},{60,70}})));
  EnergyFlow.Components.FixedTransferEfficiency turbine2Losses(eta=0.95) annotation (Placement(transformation(extent={{40,10},{60,-10}})));
  Modelica.Blocks.Continuous.Integrator integrator(
    k=1e6,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=70e5)
               annotation (Placement(transformation(extent={{54,48},{34,68}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(extent={{82,48},{62,68}})));
  Modelica.Blocks.Sources.RealExpression turbine1OutletTemperature(y(unit="K") = 1110) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={98,58})));
  Modelica.Blocks.Continuous.Integrator integrator1(
    k=-0.5,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1) annotation (Placement(transformation(extent={{60,-32},{40,-12}})));
  Modelica.Blocks.Math.Feedback feedback1
                                         annotation (Placement(transformation(extent={{90,-32},{70,-12}})));
equation
  connect(source.outlet, reactor.inlet) annotation (Line(
      points={{-100,-2},{-100,10}},
      color={28,108,200},
      thickness=0.5));
  connect(reactor.outlet,turbine1. inlet) annotation (Line(
      points={{-100,30},{-100,100},{0,100},{0,90}},
      color={28,108,200},
      thickness=0.5));
  connect(temperatureSensor.inlet, turbine1.outlet) annotation (Line(
      points={{20,30},{0,30},{0,70}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine1.outlet,turbine2. inlet)
    annotation (Line(
      points={{0,70},{0,10}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine2.outlet, temperatureSensor1.inlet) annotation (Line(
      points={{0,-10},{0,-40},{20,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, turbine2.outlet) annotation (Line(
      points={{0,-100},{0,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(reactorHeatFlow.E_flow_out, reactor.Q_flow_in) annotation (Line(points={{-119,20},{-108,20}}, color={255,170,85}));
  connect(turbine1.P_out, turbine1Losses.E_flow_in) annotation (Line(points={{7,80},{38,80}}, color={255,170,85}));
  connect(turbine2.P_out, turbine2Losses.E_flow_in) annotation (Line(points={{7,0},{38,0}}, color={255,170,85}));
  connect(integrator.y, turbine1.outletSpec_prescribed) annotation (Line(points={{33,58},{24,58},{24,70},{12,70}}, color={0,0,127}));
  connect(feedback.y, integrator.u) annotation (Line(points={{63,58},{56,58}}, color={0,0,127}));
  connect(temperatureSensor.value_out, feedback.u2) annotation (Line(points={{38.2,30},{72,30},{72,50}}, color={0,0,127}));
  connect(turbine1OutletTemperature.y, feedback.u1) annotation (Line(points={{87,58},{80,58}}, color={0,0,127}));
  connect(integrator1.u, feedback1.y) annotation (Line(points={{62,-22},{71,-22}}, color={0,0,127}));
  connect(feedback1.u1, turbine2OutletTemperature.y) annotation (Line(points={{88,-22},{99,-22}}, color={0,0,127}));
  connect(temperatureSensor1.value_out, feedback1.u2) annotation (Line(points={{38.2,-40},{80,-40},{80,-30}}, color={0,0,127}));
  connect(integrator1.y, turbine2.eta_prescribed) annotation (Line(points={{39,-22},{26,-22},{26,-6},{12,-6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-200},{200,200}}), graphics={
        Text(
          extent={{-100,6},{-94,0}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-100,40},{-94,34}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-6,70},{0,64}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-6,-14},{0,-20}},
          textColor={28,108,200},
          textString="4")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Step3Turbine2;
