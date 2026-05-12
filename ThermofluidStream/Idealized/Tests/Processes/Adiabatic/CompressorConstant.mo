within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model CompressorConstant "Compressor model with different adiabatic models (isentropic, perfect gas,...)"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.CO2
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium"annotation(
    choicesAllMatching=true);
  parameter SI.Efficiency eta = 0.8 "Isentropic efficiency";
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-100,90},{-80,110}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-40,90},{-20,110}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(Placement(transformation(extent={{-120,160},{-100,180}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressor(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,

    dp_fixed=100000,
    pr_fixed=2) annotation(Placement(transformation(extent={{-70,110},{-50,90}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-100,-30},{-80,-10}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-40,-30},{-20,-10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressorIdealGas(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IdealGasConstantGamma "p*v = R*T, gamma = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,

    dp_fixed=100000,
    pr_fixed=2) annotation(Placement(transformation(extent={{-70,-10},{-50,-30}})));
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
    TC=0.3,
    P_nom(displayUnit="kW") = 50000,
    dp_nom=100000) annotation(Placement(transformation(extent={{50,140},{70,160}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{20,80},{40,100}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink4(redeclare package Medium = Medium, considerInertance=false) annotation(Placement(transformation(extent={{80,80},{100,100}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressor2(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,

    dp_fixed=100000,
    pr_fixed=2) annotation(Placement(transformation(extent={{50,100},{70,80}})));
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
    enableFilter=true,
    TC=0.3,
    P_nom(displayUnit="kW") = 50000,
    dp_nom=100000) annotation(Placement(transformation(extent={{50,20},{70,40}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{20,-40},{40,-20}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink6(redeclare package Medium = Medium, considerInertance=false) annotation(Placement(transformation(extent={{80,-40},{100,-20}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressorIdealGas2(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IdealGasConstantGamma "p*v = R*T, gamma = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,

    dp_fixed=100000,
    pr_fixed=2) annotation(Placement(transformation(extent={{50,-20},{70,-40}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-100,-150},{-80,-130}})));
  .ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-40,-150},{-20,-130}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressorPerfectGas(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,

    dp_fixed=100000,
    pr_fixed=2) annotation(Placement(transformation(extent={{-70,-130},{-50,-150}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{20,-100},{40,-80}})));
  .ThermofluidStream.Boundaries.Sink_m sink7(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{80,-100},{100,-80}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressorPerfectGas1(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000,
    TC=0.3,
    P_nom(displayUnit="kW") = 50000,
    dp_nom=100000) annotation(Placement(transformation(extent={{50,-100},{70,-80}})));
  ThermofluidStream.Boundaries.Source source8(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{20,-160},{40,-140}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink8(redeclare package Medium = Medium, considerInertance=false) annotation(Placement(transformation(extent={{80,-160},{100,-140}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressorPerfectGas2(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,

    dp_fixed=100000,
    pr_fixed=2) annotation(Placement(transformation(extent={{50,-140},{70,-160}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation(Placement(transformation(extent={{-10,110},{10,130}})));
  Modelica.Blocks.Math.Gain gain1(k=-1) annotation(Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Gain gain2(k=-1) annotation(Placement(transformation(extent={{-10,-130},{10,-110}})));
equation
  connect(source.outlet, compressor.inlet)annotation(
    Line(
      points={{-80,100},{-70,100}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, compressorIdealGas.inlet) annotation(Line(
      points={{-80,-20},{-70,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.outlet, sink.inlet)annotation(
    Line(
      points={{-50,100},{-40,100}},
      color={28,108,200},
      thickness=0.5));
  connect(compressorIdealGas.outlet, sink1.inlet) annotation(Line(
      points={{-50,-20},{-40,-20}},
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
  connect(source5.outlet, compressorIdealGas1.inlet) annotation(Line(
      points={{40,30},{50,30}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, compressorIdealGas2.inlet) annotation(Line(
      points={{40,-30},{50,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(compressorIdealGas1.outlet, sink5.inlet) annotation(Line(
      points={{70,30},{80,30}},
      color={28,108,200},
      thickness=0.5));
  connect(compressorIdealGas2.outlet, sink6.inlet) annotation(Line(
      points={{70,-30},{80,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet,compressorPerfectGas. inlet) annotation(Line(
      points={{-80,-140},{-70,-140}},
      color={28,108,200},
      thickness=0.5));
  connect(compressorPerfectGas.outlet,sink2. inlet) annotation(Line(
      points={{-50,-140},{-40,-140}},
      color={28,108,200},
      thickness=0.5));
  connect(source7.outlet,compressorPerfectGas1. inlet) annotation(Line(
      points={{40,-90},{50,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(source8.outlet,compressorPerfectGas2. inlet) annotation(Line(
      points={{40,-150},{50,-150}},
      color={28,108,200},
      thickness=0.5));
  connect(compressorPerfectGas1.outlet,sink7. inlet) annotation(Line(
      points={{70,-90},{80,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(compressorPerfectGas2.outlet,sink8. inlet) annotation(Line(
      points={{70,-150},{80,-150}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor1.P_in, gain.y) annotation(Line(points={{60,142},{60,120},{11,120}},                      color={255,170,85}));
  connect(compressor.P_out, gain.u) annotation(Line(points={{-60,107},{-60,120},{-12,120}},   color={255,170,85}));
  connect(compressor2.P_in, gain.y) annotation(Line(points={{60,98},{60,120},{11,120}},                       color={255,170,85}));
  connect(compressorIdealGas1.P_in, gain1.y) annotation(Line(points={{60,22},{60,0},{11,0}},                          color={255,170,85}));
  connect(compressorIdealGas2.P_in, gain1.y) annotation(Line(points={{60,-22},{60,0},{11,0}},                        color={255,170,85}));
  connect(compressorIdealGas.P_out, gain1.u) annotation(Line(points={{-60,-13},{-60,0},{-12,0}},      color={255,170,85}));
  connect(compressorPerfectGas.P_out, gain2.u) annotation(Line(points={{-60,-133},{-60,-120},{-12,-120}},                         color={255,170,85}));
  connect(compressorPerfectGas1.P_in, gain2.y) annotation(Line(points={{60,-98},{60,-120},{11,-120}},   color={255,170,85}));
  connect(compressorPerfectGas2.P_in, gain2.y) annotation(Line(points={{60,-142},{60,-120},{11,-120}},  color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false,
        extent={{-100,-100},{100,100}})), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-180},{120,180}}),
        graphics={Text(
          extent={{-90,146},{-30,126}},
          textColor={28,108,200},
          textString="Universal"),
                  Text(
          extent={{-98,36},{-16,18}},
          textColor={28,108,200},
          textString="IdealGas"),
                  Text(
          extent={{-88,-80},{-8,-100}},
          textColor={28,108,200},
          textString="PerfectGas")}),
    Documentation(info="<html>
  <p>
    Modification of the 
    <a href=\"modelica://ThermoFluidStream.Idealized.Tests.Processes.Adiabatic.Compressor\">Compressor</a> example
    using a constant pressure ratio instead of a time-dependent one.<br>
    In this case, <code>considerInertance = false</code> is not required, since the pressure ratio remains constant.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end CompressorConstant;
