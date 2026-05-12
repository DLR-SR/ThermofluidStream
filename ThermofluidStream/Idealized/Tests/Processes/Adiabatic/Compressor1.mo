within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model Compressor1 "Forward and inverse calculation compressor test model"
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconNeglectInertance;

  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.CO2
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium"
    annotation (choicesAllMatching=true);
  parameter SI.Efficiency eta = 0.8 "Isentropic efficiency";
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  .ThermofluidStream.Idealized.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressor(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.Ramp pressureRatio(
    height=98.999,
    duration=0.9,
    offset=1.001)
              annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{18,40},{38,60}})));
  .ThermofluidStream.Idealized.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{80,40},{100,60}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressor1(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000,
    enableFilter=true,
    TC=0.01,
    P_nom(displayUnit="kW") = 300000,
    dp_nom=5000000) annotation (Placement(transformation(extent={{50,40},{70,60}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    neglectInertance=true,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink2(redeclare package Medium = Medium, neglectInertance=true) annotation (Placement(transformation(extent={{80,-80},{100,-60}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressor2(
    redeclare package Medium = Medium,
    neglectInertance=true,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation (Placement(transformation(extent={{50,-60},{70,-80}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(extent={{0,-36},{20,-16}})));
equation
  connect(source.outlet, compressor.inlet)
    annotation (Line(
      points={{-70,0},{-60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.outlet, sink.inlet)
    annotation (Line(
      points={{-40,0},{-30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, compressor1.inlet) annotation (Line(
      points={{38,50},{50,50}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, compressor2.inlet) annotation (Line(
      points={{40,-70},{50,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor1.outlet, sink1.inlet) annotation (Line(
      points={{70,50},{80,50}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor2.outlet, sink2.inlet) annotation (Line(
      points={{70,-70},{80,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.outletSpec_prescribed, pressureRatio.y) annotation (Line(points={{-40,-12},{-40,-40},{-59,-40}}, color={0,0,127}));
  connect(compressor2.outletSpec_prescribed, pressureRatio.y) annotation (Line(points={{70,-58},{70,-40},{-59,-40}}, color={0,0,127}));
  connect(compressor.P_out, gain.u) annotation (Line(points={{-50,-7},{-50,-26},{-2,-26}}, color={255,170,85}));
  connect(compressor1.P_in, gain.y) annotation (Line(points={{60,42},{60,-26},{21,-26}}, color={255,170,85}));
  connect(compressor2.P_in, gain.y) annotation (Line(points={{60,-62},{60,-26},{21,-26}}, color={255,170,85}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false),
        graphics={Text(
          extent={{-98,282},{102,262}},
          textColor={28,108,200},
          textString="Compare approach using entropy vs approach 
assuming ideal gas (p*v = R*T) with gamma = const vs approach assuming perfect gas (p*v = R*T, cp = const). Check different media, e.g. Argon and CO2"), Text(
          extent={{-26,248},{32,228}},
          textColor={0,140,72},
          textString="fine"),
        Polygon(
          points={{-100,40},{-60,40},{-60,60},{-80,60},{-80,100},{-100,100},{-100,40}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-70,90},{10,70}},
          textColor={238,46,47},
          textString="requires neglectInertance = true
see User's Guide",
          horizontalAlignment=TextAlignment.Left)}),
    Documentation(info="<html>
  <p>
   Simplification of the <a href=\"modelica://ThermoFluidStream.Idealized.Tests.Processes.Adiabatic.Compressor\">Compressor</a> example.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Compressor1;
