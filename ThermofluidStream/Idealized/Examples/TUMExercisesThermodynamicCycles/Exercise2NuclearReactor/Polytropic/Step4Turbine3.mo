within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles.Exercise2NuclearReactor.Polytropic;
model Step4Turbine3
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.He
                                                                              constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)annotation(
    Placement(transformation(extent={{-200,180},{-180,200}})));
  Processes.Isobaric reactor(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed(displayUnit="K") = 1180) annotation(Placement(transformation(
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
  Processes.PolytropicPerfectGas turbine1(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    T_out_fixed(displayUnit="K") = 1110,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.IsentropicEfficiency,
    eta_is_fixed=0.94) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,80})));
  Sources.Sink_free sink(redeclare package Medium = Medium) annotation(Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270,
        origin={0,-90})));
  EnergyFlow.Sources.FixedEnergyFlow reactorHeatFlow(E_flow(displayUnit="MW") = 6000000) annotation(Placement(transformation(extent={{-140,10},{-120,30}})));
  EnergyFlow.Components.FixedTransferEfficiency turbine1Losses(eta=0.95) annotation(Placement(transformation(extent={{30,90},{50,70}})));
  Processes.PolytropicPerfectGas
                      turbine2(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure,
    p_out_fixed=5240000,
    T_out_fixed(displayUnit="K") = 1060,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature)
                                   annotation(Placement(transformation(extent={{-10,10},{10,-10}}, rotation=270)));
  EnergyFlow.Components.FixedTransferEfficiency turbine2Losses(eta=0.95) annotation(Placement(transformation(extent={{30,10},{50,-10}})));
  Processes.PolytropicPerfectGas turbine3(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    T_out_fixed(displayUnit="K") = 844.5) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,-50})));
  EnergyFlow.Components.Sum turbine3HeatLosses(n_in=2) annotation(Placement(transformation(extent={{40,-40},{60,-20}})));
  EnergyFlow.Components.FixedTransferEfficiency turbine3ShaftLosses(eta=0.95) annotation(Placement(transformation(extent={{60,-40},{40,-60}})));
  EnergyFlow.Sources.FixedEnergyFlow generator(E_flow(displayUnit="MW") = -3015000) annotation(Placement(transformation(extent={{100,-60},{80,-40}})));
equation
  connect(source.outlet, reactor.inlet) annotation(Line(
      points={{-100,-2},{-100,10}},
      color={28,108,200},
      thickness=0.5));
  connect(reactor.outlet,turbine1. inlet) annotation(Line(
      points={{-100,30},{-100,100},{0,100},{0,90}},
      color={28,108,200},
      thickness=0.5));
  connect(reactorHeatFlow.E_flow_out, reactor.Q_flow_in) annotation(Line(points={{-119,20},{-108,20}}, color={255,170,85}));
  connect(turbine1.P_out, turbine1Losses.E_flow_in) annotation(Line(points={{7,80},{28,80}}, color={255,170,85}));
  connect(turbine1.outlet, turbine2.inlet) annotation(Line(
      points={{0,70},{0,10}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine2.P_out, turbine2Losses.E_flow_in) annotation(Line(points={{7,0},{28,0}}, color={255,170,85}));
  connect(turbine2.outlet, turbine3.inlet) annotation(Line(
      points={{0,-10},{0,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine3.outlet, sink.inlet) annotation(Line(
      points={{0,-60},{0,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine3ShaftLosses.E_flow_out, turbine3HeatLosses.E_flow_in[1]) annotation(Line(points={{39,-50},{32,-50},{32,-32},{40,-32},{40,-31.5}}, color={255,170,85}));
  connect(turbine3.P_out, turbine3HeatLosses.E_flow_in[2]) annotation(Line(points={{7,-50},{28,-50},{28,-28.5},{40,-28.5}}, color={255,170,85}));
  connect(generator.E_flow_out, turbine3ShaftLosses.E_flow_in) annotation(Line(points={{79,-50},{62,-50}}, color={255,170,85}));
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
          textString="4"),
        Text(
          extent={{-6,-64},{0,-70}},
          textColor={28,108,200},
          textString="5")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Step4Turbine3;
