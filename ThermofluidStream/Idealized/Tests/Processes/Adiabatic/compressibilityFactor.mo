within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model compressibilityFactor "Test model to check compressibility factor"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium" annotation(
      choicesAllMatching=true);
  parameter Real Tr = 1.1 "Reduced temperature";
  constant Medium.Temperature T_crit = 647.096 "Critical temperature";
  final parameter Medium.Temperature T=Tr*T_crit "Temperature";
  constant Medium.AbsolutePressure p_crit = 22.064e6 "Critical pressure";
  constant SI.AbsolutePressure p_min = 1e5 "Minimum pressure (for T > T_crit)";
  final parameter Medium.AbsolutePressure p_sat = if Tr < 1 then Medium.saturationPressure(T) else p_min "Saturation pressure";
  final parameter Real pr_sat = p_sat/p_crit "Reduced saturation pressure";

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=false,
    T0_par=T)     annotation(Placement(transformation(extent={{-20,10},{0,30}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{40,10},{60,30}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(Placement(transformation(extent={{80,80},{100,100}})));
  ThermofluidStream.Idealized.Processes.Adiabatic idealGas(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.IdealGasConstantGamma "p*v = R*T, gamma = const",
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    showEfficiency=false,
    showPowerDirection=false) annotation (Placement(transformation(extent={{10,10},{30,30}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=false,
    T0_par=T)     annotation(Placement(transformation(extent={{-20,-30},{0,-10}})));
  ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{40,-30},{60,-10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic perfectGas(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.PerfectGas "p*v = R*T, gamma, cp = const",
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    showEfficiency=false,
    showPowerDirection=false) annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  Modelica.Blocks.Sources.Ramp reducedPressure(
    height=min(7, 0.9e8/p_crit),
    duration=1,
    offset=pr_sat) annotation(Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Math.Gain pressure(k=p_crit) annotation(Placement(transformation(extent={{-50,-10},{-30,10}})));

equation
  connect(source.outlet, idealGas.inlet) annotation(Line(
      points={{0,20},{10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(idealGas.outlet, sink.inlet) annotation(Line(
      points={{30,20},{40,20}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, perfectGas.inlet) annotation(Line(
      points={{0,-20},{10,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(perfectGas.outlet, sink1.inlet) annotation(Line(
      points={{30,-20},{40,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(reducedPressure.y, pressure.u) annotation(Line(points={{-59,0},{-52,0}},     color={0,0,127}));
  connect(pressure.y, source.p0_var) annotation(Line(points={{-29,0},{-20.5,0},{-20.5,26},{-12,26}},
                                                                                  color={0,0,127}));
  connect(pressure.y, source1.p0_var) annotation(Line(points={{-29,0},{-20.5,0},{-20.5,-14},{-12,-14}},            color={0,0,127}));

  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      graphics={Text(
          extent={{-98,282},{102,262}},
          textColor={28,108,200},
          textString="Compare approach using entropy vs approach 
assuming ideal gas (p*v = R*T) with gamma = const vs approach assuming perfect gas (p*v = R*T, cp = const). Check different media, e.g. Argon and CO2"),
        Text(
          extent={{-26,248},{32,228}},
          textColor={0,140,72},
          textString="fine")}),
    Documentation(
      info="<html>
  <p>
    Applies a ramp in reduced pressure for constant reduced temperature to check the compressibility factors <code>Z_in, Z_out</code> and the corresponding warning
    in <a href=\"modelica://ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.BaseClasses.PartialIdealGas\">AdiabaticModels.BaseClasses.PartialIdealGas</a>. 
    The inlet and outlet states are equal. 
  </p>
</html>",
      revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end compressibilityFactor;
