within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model CompressorConstant1 "Compressor model with the adiabatic process"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.CO2
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium" annotation(
    choicesAllMatching=true);
  parameter SI.Efficiency eta = 0.8 "Isentropic efficiency";
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-90,-10},{-70,10}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-30,-10},{-10,10}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(Placement(transformation(extent={{80,80},{100,100}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressor(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,

    dp_fixed=100000,
    pr_fixed=2) annotation(Placement(transformation(extent={{-60,-10},{-40,10}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{18,40},{38,60}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{80,40},{100,60}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressor1(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    enableFilter=true,
    TC=0.1,
    P_nom(displayUnit="kW") = 50000,
    dp_nom=100000,

    dp_fixed=100000,
    pr_fixed=2) annotation(Placement(transformation(extent={{50,40},{70,60}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{20,-80},{40,-60}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink2(redeclare package Medium = Medium, considerInertance=false) annotation(Placement(transformation(extent={{80,-80},{100,-60}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressor2(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,

    dp_fixed=100000,
    pr_fixed=2) annotation(Placement(transformation(extent={{50,-60},{70,-80}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation(Placement(transformation(extent={{0,-40},{20,-20}})));
equation
  connect(source.outlet, compressor.inlet) annotation(
    Line(
      points={{-70,0},{-60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.outlet, sink.inlet) annotation(
    Line(
      points={{-40,0},{-30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, compressor1.inlet) annotation(Line(
      points={{38,50},{50,50}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, compressor2.inlet) annotation(Line(
      points={{40,-70},{50,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor1.outlet, sink1.inlet) annotation(Line(
      points={{70,50},{80,50}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor2.outlet, sink2.inlet) annotation(Line(
      points={{70,-70},{80,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.P_out, gain.u) annotation(Line(points={{-50,-7},{-50,-30},{-2,-30}}, color={255,170,85}));
  connect(compressor1.P_in, gain.y) annotation(Line(points={{60,42},{60,-30},{21,-30}}, color={255,170,85}));
  connect(compressor2.P_in, gain.y) annotation(Line(points={{60,-62},{60,-30},{21,-30}}, color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false),
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
   Simplification of the <a href=\"modelica://ThermofluidStream.Idealized.Tests.Processes.Adiabatic.CompressorConstant\">CompressorConstant</a> example.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end CompressorConstant1;
