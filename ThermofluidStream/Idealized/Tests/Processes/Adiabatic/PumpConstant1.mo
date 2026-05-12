within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model PumpConstant1 "Same as Pump1 but with inputs specified as parameters"
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium"
    annotation (choicesAllMatching=true);
  parameter SI.Efficiency eta = 0.8 "Isentropic efficiency";
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  .ThermofluidStream.Idealized.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation (Placement(transformation(extent={{-140,80},{-120,100}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pump(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IsothermalReference "rho = const, Version 2",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.PressureRatio,

    dp_fixed=100000,
    pr_fixed=2) annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{10,30},{30,50}})));
  .ThermofluidStream.Idealized.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{70,30},{90,50}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pump1(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IsothermalReference "rho = const, Version 2",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    specifyOutlet=false,
    enableFilter=true,
    TC=0.1,
    P_nom=250,
    dp_nom=100000) annotation (Placement(transformation(extent={{40,30},{60,50}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{10,-50},{30,-30}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink2(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{70,-50},{90,-30}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pump2(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.PressureRatio,

    dp_fixed=100000,
    pr_fixed=2) annotation (Placement(transformation(extent={{40,-30},{60,-50}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(source.outlet, pump.inlet) annotation (Line(
      points={{-80,20},{-70,20}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.outlet, sink.inlet) annotation (Line(
      points={{-50,20},{-40,20}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, pump1.inlet) annotation (Line(
      points={{30,40},{40,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, pump2.inlet) annotation (Line(
      points={{30,-40},{40,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(pump1.outlet, sink1.inlet) annotation (Line(
      points={{60,40},{70,40}},
      color={28,108,200},
      thickness=0.5));
  connect(pump2.outlet, sink2.inlet) annotation (Line(
      points={{60,-40},{70,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.P_out, gain.u) annotation (Line(points={{-60,13},{-60,0},{-12,0}},     color={255,170,85}));
  connect(pump1.P_in, gain.y) annotation (Line(points={{50,32},{50,0},{11,0}}, color={255,170,85}));
  connect(pump2.P_in, gain.y) annotation (Line(points={{50,-32},{50,0},{11,0}}, color={255,170,85}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
    Documentation(info="<html>
  <p>
   Simplification of the <a href=\"modelica://ThermoFluidStreamPlus.Idealized.Tests.Processes.Adiabatic.PumpConstant\">PumpConstant</a> example.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end PumpConstant1;
