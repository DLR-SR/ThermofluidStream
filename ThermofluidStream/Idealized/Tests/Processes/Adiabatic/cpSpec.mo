within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model cpSpec "Test model to check cp specification"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.CO2
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium" annotation(
    choicesAllMatching=true);
  parameter SI.Efficiency eta = 0.8 "Isentropic efficiency";
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-90,40},{-70,60}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-30,40},{-10,60}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(Placement(transformation(extent={{-142,110},{-122,130}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pefectGasState(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.PerfectGas (gammaSpec=ThermofluidStream.Types.ValueSpecification2.Fixed),
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Sources.LogFrequencySweep
                               pressureRatio(
    wMin=1,
    wMax=2,
    duration=1)
             annotation(Placement(transformation(extent={{-80,-10},{-60,10}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{10,40},{30,60}})));
  ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{70,40},{90,60}})));
  ThermofluidStream.Idealized.Processes.Adiabatic perfectGasFixed(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.PerfectGas (gammaSpec=ThermofluidStream.Types.ValueSpecification2.Fixed, cpSpec=ThermofluidStream.Types.ValueSpecification2.Fixed),
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{40,40},{60,60}})));
equation
  connect(source.outlet, pefectGasState.inlet) annotation(Line(
      points={{-70,50},{-60,50}},
      color={28,108,200},
      thickness=0.5));
  connect(pefectGasState.outlet, sink.inlet) annotation(Line(
      points={{-40,50},{-30,50}},
      color={28,108,200},
      thickness=0.5));
  connect(pefectGasState.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{-40,38},{-40,0},{-59,0}}, color={0,0,127}));
  connect(source1.outlet, perfectGasFixed.inlet) annotation(Line(
      points={{30,50},{40,50}},
      color={28,108,200},
      thickness=0.5));
  connect(perfectGasFixed.outlet, sink1.inlet) annotation(Line(
      points={{60,50},{70,50}},
      color={28,108,200},
      thickness=0.5));
  connect(pressureRatio.y, perfectGasFixed.outletSpec_prescribed) annotation(Line(points={{-59,0},{60,0},{60,38}}, color={0,0,127}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false, grid={2,2}),
        graphics={Text(
          extent={{-98,282},{102,262}},
          textColor={28,108,200},
          textString="Compare approach using entropy vs approach 
assuming ideal gas (p*v = R*T) with gamma = const vs approach assuming perfect gas (p*v = R*T, cp = const). Check different media, e.g. Argon and CO2"), Text(
          extent={{-26,248},{32,228}},
          textColor={0,140,72},
          textString="fine")}),
    Documentation(info="<html>
  <p>
    Checks <code>cpSpec</code> (<code>ValueSpecification.Fixed</code> vs <code>ValueSpecification.State</code>) for 
    <a href=\"modelica://ThermoFluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.PerfectGas\">AdiabaticModels.PerfectGas</a>.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end cpSpec;
