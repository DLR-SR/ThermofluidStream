within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model Compressor "Compressor model with different adiabatic models (isentropic, perfect gas,...)"
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconNeglectInertance;

  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.CO2
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium"annotation(
    choicesAllMatching=true);
  parameter SI.Efficiency eta = 0.8 "Isentropic efficiency";
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-80,140},{-60,160}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-20,140},{0,160}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(Placement(transformation(extent={{-58,200},{-38,220}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressor(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{-50,140},{-30,160}})));
  Modelica.Blocks.Sources.Ramp pressureRatio(
    height=98.999,
    duration=0.9,
    offset=1.001,
    y(unit="1"))
              annotation(Placement(transformation(extent={{-140,-10},{-120,10}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-80,20},{-60,40}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-20,20},{0,40}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressorIdealGas(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IdealGasConstantGamma "p*v = R*T, gamma = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{-50,20},{-30,40}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{20,140},{40,160}})));
  .ThermofluidStream.Boundaries.Sink_m sink3(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{80,140},{100,160}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressor1(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000,
    enableFilter=true,
    TC=0.01,
    P_nom(displayUnit="kW") = 300000,
    dp_nom=5000000) annotation(Placement(transformation(extent={{50,140},{70,160}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    considerInertance=false,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{20,80},{40,100}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink4(redeclare package Medium = Medium, considerInertance=false) annotation(Placement(transformation(extent={{80,80},{100,100}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressor2(
    redeclare package Medium = Medium,
    considerInertance=false,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{50,100},{70,80}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{20,20},{40,40}})));
  .ThermofluidStream.Boundaries.Sink_m sink5(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{80,20},{100,40}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressorIdealGas1(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IdealGasConstantGamma "p*v = R*T, gamma = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000,
    TC=0.01,
    P_nom(displayUnit="kW") = 300000,
    dp_nom=5000000,
    p_out(start=100000),
    enableFilter=true) annotation(Placement(transformation(extent={{50,20},{70,40}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    considerInertance=false,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{20,-50},{40,-30}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink6(redeclare package Medium = Medium, considerInertance=false) annotation(Placement(transformation(extent={{80,-50},{100,-30}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressorIdealGas2(
    redeclare package Medium = Medium,
    considerInertance=false,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IdealGasConstantGamma "p*v = R*T, gamma = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{50,-30},{70,-50}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-80,-160},{-60,-140}})));
  .ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-20,-160},{0,-140}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressorPerfectGas(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{-50,-140},{-30,-160}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{80,-120},{100,-100}})));
  .ThermofluidStream.Boundaries.Sink_m sink7(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{140,-120},{160,-100}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressorPerfectGas1(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000,
    TC=0.01,
    P_nom(displayUnit="kW") = 300000,
    dp_nom=5000000,
    p_out(start=100000),
    enableFilter=true) annotation(Placement(transformation(extent={{110,-120},{130,-100}})));
  ThermofluidStream.Boundaries.Source source8(
    redeclare package Medium = Medium,
    considerInertance=false,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{80,-200},{100,-180}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink8(redeclare package Medium = Medium, considerInertance=false) annotation(Placement(transformation(extent={{140,-200},{160,-180}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressorPerfectGas2(
    redeclare package Medium = Medium,
    considerInertance=false,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{110,-180},{130,-200}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation(Placement(transformation(extent={{0,110},{20,130}})));
  Modelica.Blocks.Math.Gain gain1(k=-1) annotation(Placement(transformation(extent={{0,-20},{20,0}})));
  Modelica.Blocks.Math.Gain gain2(k=-1) annotation(Placement(transformation(extent={{20,-160},{40,-140}})));
equation
  connect(source.outlet, compressor.inlet)annotation(
    Line(
      points={{-60,150},{-50,150}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, compressorIdealGas.inlet) annotation(Line(
      points={{-60,30},{-50,30}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.outlet, sink.inlet)annotation(
    Line(
      points={{-30,150},{-20,150}},
      color={28,108,200},
      thickness=0.5));
  connect(compressorIdealGas.outlet, sink1.inlet) annotation(Line(
      points={{-30,30},{-20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, compressor1.inlet) annotation(Line(
      points={{40,150},{50,150}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet, compressor2.inlet) annotation(Line(
      points={{40,90},{50,90}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor1.outlet, sink3.inlet) annotation(Line(
      points={{70,150},{80,150}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor2.outlet, sink4.inlet) annotation(Line(
      points={{70,90},{80,90}},
      color={28,108,200},
      thickness=0.5));
  connect(compressorIdealGas.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{-30,18},{-30,-20},{-110,-20},{-110,0},{-119,0}},    color={0,0,127}));
  connect(compressor.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{-30,138},{-30,130},{-110,130},{-110,0},{-119,0}}, color={0,0,127}));
  connect(compressor2.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{70,102},{70,110},{-110,110},{-110,0},{-119,0}}, color={0,0,127}));
  connect(source5.outlet, compressorIdealGas1.inlet) annotation(Line(
      points={{40,30},{50,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, compressorIdealGas2.inlet) annotation(Line(
      points={{40,-40},{50,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(compressorIdealGas1.outlet, sink5.inlet) annotation(Line(
      points={{70,30},{80,30}},
      color={28,108,200},
      thickness=0.5));
  connect(compressorIdealGas2.outlet, sink6.inlet) annotation(Line(
      points={{70,-40},{80,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(compressorIdealGas2.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{70,-28},{70,-20},{-110,-20},{-110,0},{-119,0}}, color={0,0,127}));
  connect(source2.outlet,compressorPerfectGas. inlet) annotation(Line(
      points={{-60,-150},{-50,-150}},
      color={28,108,200},
      thickness=0.5));
  connect(compressorPerfectGas.outlet,sink2. inlet) annotation(Line(
      points={{-30,-150},{-20,-150}},
      color={28,108,200},
      thickness=0.5));
  connect(compressorPerfectGas.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{-30,-138},{-30,-128},{-110,-128},{-110,0},{-119,0}},   color={0,0,127}));
  connect(source7.outlet,compressorPerfectGas1. inlet) annotation(Line(
      points={{100,-110},{110,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(source8.outlet,compressorPerfectGas2. inlet) annotation(Line(
      points={{100,-190},{110,-190}},
      color={28,108,200},
      thickness=0.5));
  connect(compressorPerfectGas1.outlet,sink7. inlet) annotation(Line(
      points={{130,-110},{140,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(compressorPerfectGas2.outlet,sink8. inlet) annotation(Line(
      points={{130,-190},{140,-190}},
      color={28,108,200},
      thickness=0.5));
  connect(compressorPerfectGas2.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{130,-178},{130,-128},{-110,-128},{-110,0},{-119,0}},
                                                                                                                                            color={0,0,127}));
  connect(compressor1.P_in, gain.y) annotation(Line(points={{60,142},{60,120},{21,120}},color={255,170,85}));
  connect(compressor.P_out, gain.u) annotation(Line(points={{-40,143},{-40,120},{-2,120}},    color={255,170,85}));
  connect(compressor2.P_in, gain.y) annotation(Line(points={{60,98},{60,120},{21,120}},color={255,170,85}));
  connect(compressorIdealGas1.P_in, gain1.y) annotation(Line(points={{60,22},{60,-10},{21,-10}},color={255,170,85}));
  connect(compressorIdealGas2.P_in, gain1.y) annotation(Line(points={{60,-32},{60,-10},{21,-10}},color={255,170,85}));
  connect(compressorIdealGas.P_out, gain1.u) annotation(Line(points={{-40,23},{-40,-10},{-2,-10}},    color={255,170,85}));
  connect(compressorPerfectGas.P_out, gain2.u) annotation(Line(points={{-40,-143},{-40,-132},{13,-132},{13,-150},{18,-150}},      color={255,170,85}));
  connect(compressorPerfectGas1.P_in, gain2.y) annotation(Line(points={{120,-118},{120,-150},{41,-150}},color={255,170,85}));
  connect(compressorPerfectGas2.P_in, gain2.y) annotation(Line(points={{120,-182},{120,-150},{41,-150}},color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2})),                                            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-220},{200,220}},
        grid={2,2}),
        graphics={Text(
          extent={{-156,158},{-96,138}},
          textColor={28,108,200},
          textString="Universal"),
                  Text(
          extent={{-198,-22},{-116,-40}},
          textColor={28,108,200},
          textString="IdealGas"),
                  Text(
          extent={{-182,-162},{-100,-180}},
          textColor={28,108,200},
          textString="PerfectGas"),
        Polygon(
          points={{-200,160},{-160,160},{-160,180},{-180,180},{-180,220},{-200,220},{-200,160}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-170,212},{-90,192}},
          textColor={238,46,47},
          textString="requires considerInertance = false
see User's Guide",
          horizontalAlignment=TextAlignment.Left),
        Polygon(
          points={{98,75},{118,75},{118,85},{108,85},{108,105},{98,105},{98,75}},
          fillColor={162,29,33},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{100,-55},{120,-55},{120,-45},{110,-45},{110,-25},{100,-25},{100,-55}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{164,-212},{184,-212},{184,-202},{174,-202},{174,-182},{164,-182},{164,-212}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None)}),
    Documentation(info="<html>
  <p>
    Forward and inverse calculations of different adiabatic models (Universal, Ideal Gas, Perfect Gas) for a compressor are demonstrated:
  </p>

  <ul>
    <li>
      <code>P(m_flow, p_out)</code>
    </li>
    <li>
      <code>p_out(m_flow, P)</code>
    </li>
    <li>
      <code>m_flow(p_out, P)</code>
    </li>
  </ul>

  <p>
    The third formulation requires <code>considerInertance = false</code> if <code>p_out</code> is time-dependent.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Compressor;
