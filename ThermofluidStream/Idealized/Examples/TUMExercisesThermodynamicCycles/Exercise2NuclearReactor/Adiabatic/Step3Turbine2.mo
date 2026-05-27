within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Adiabatic;
model Step3Turbine2
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.He
                                                                              constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{-200,180},{-180,200}})));
  ThermofluidStream.Idealized.Processes.Isobaric reactor(
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
    T0_par(displayUnit="K") = 780) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,-12})));
  ThermofluidStream.Idealized.Processes.Adiabatic turbine1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=0.94,
    specifyOutlet=true,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_out(start=7000000)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,80})));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={30,40})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints annotation(Placement(transformation(
        extent={{-20,-12},{20,12}},
        rotation=180,
        origin={40,60})));
  Modelica.Blocks.Sources.RealExpression turbine1OutletTemperature(y(unit="K") = 1110) annotation(Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={38,60})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink(redeclare package Medium = Medium) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));
  ThermofluidStream.Idealized.Processes.Adiabatic turbine2(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    etaSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=5240000,
    eta_is(start=1),
    h_out(start=Medium.h_default)) annotation (Placement(transformation(extent={{-10,10},{10,-10}}, rotation=270)));
  ThermofluidStream.Sensors.SingleSensorSelect temperatureSensor1(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={30,-40})));
  Modelica.Blocks.Sources.RealExpression turbine2OutletTemperature(y(unit="K") = 1060) annotation(Placement(transformation(extent={{28,-30},{48,-10}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints1 annotation(Placement(transformation(extent={{60,-32},{20,-8}})));
  ThermofluidStream.Idealized.EnergyFlow.Sources.FixedEnergyFlow reactorHeatFlow(E_flow(displayUnit="MW") = 6000000) annotation (Placement(transformation(extent={{-140,10},{-120,30}})));
  ThermofluidStream.Idealized.EnergyFlow.Components.FixedTransferEfficiency turbine1Losses(eta=0.95) annotation (Placement(transformation(extent={{40,90},{60,70}})));
  ThermofluidStream.Idealized.EnergyFlow.Components.FixedTransferEfficiency turbine2Losses(eta=0.95) annotation (Placement(transformation(extent={{40,10},{60,-10}})));
equation
  connect(source.outlet, reactor.inlet) annotation(Line(
      points={{-100,-2},{-100,10}},
      color={28,108,200},
      thickness=0.5));
  connect(reactor.outlet,turbine1. inlet) annotation(Line(
      points={{-100,30},{-100,100},{0,100},{0,90}},
      color={28,108,200},
      thickness=0.5));
  connect(temperatureSensor.inlet, turbine1.outlet) annotation(Line(
      points={{20,40},{0,40},{0,70}},
      color={28,108,200},
      thickness=0.5));
  connect(inverseBlockConstraints.y1, turbine1.outletSpec_prescribed) annotation(Line(points={{19,60},{16,60},{16,70},{12,70}}, color={0,0,127}));
  connect(turbine1.outlet,turbine2. inlet) annotation(
    Line(
      points={{0,70},{0,10}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine2.outlet, temperatureSensor1.inlet) annotation(Line(
      points={{0,-10},{0,-40},{20,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine2.eta_prescribed, inverseBlockConstraints1.y1) annotation(Line(points={{12,-6},{16,-6},{16,-20},{19,-20}}, color={0,0,127}));
  connect(sink.inlet, turbine2.outlet) annotation(Line(
      points={{0,-100},{0,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine2OutletTemperature.y, inverseBlockConstraints1.u2) annotation(Line(points={{49,-20},{56,-20}}, color={0,0,127}));
  connect(temperatureSensor1.value_out, inverseBlockConstraints1.u1) annotation(Line(points={{38.2,-40},{70,-40},{70,-20},{62,-20}}, color={0,0,127}));
  connect(turbine1OutletTemperature.y, inverseBlockConstraints.u2) annotation(Line(points={{49,60},{56,60}}, color={0,0,127}));
  connect(temperatureSensor.value_out, inverseBlockConstraints.u1) annotation(Line(points={{38.2,40},{70,40},{70,60},{62,60}}, color={0,0,127}));
  connect(reactorHeatFlow.E_flow_out, reactor.Q_flow_in) annotation(Line(points={{-119,20},{-108,20}}, color={255,170,85}));
  connect(turbine1.P_out, turbine1Losses.E_flow_in) annotation(Line(points={{7,80},{38,80}}, color={255,170,85}));
  connect(turbine2.P_out, turbine2Losses.E_flow_in) annotation(Line(points={{7,0},{38,0}}, color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
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
</html>", info="<html>
  <p>
    See <a href=\"modelica://ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor\">TUMExercisesThermodynamicCycles.Exercise2NuclearReactor</a> 
    for the problem description.
  </p>
</html>"));
end Step3Turbine2;
