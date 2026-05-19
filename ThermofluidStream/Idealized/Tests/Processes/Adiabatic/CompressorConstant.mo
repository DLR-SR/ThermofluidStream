within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model CompressorConstant "Compressor model with different adiabatic models (FullMedium, IdealGasConstantGamma, PerfectGas)"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.CO2
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium" annotation(
    choicesAllMatching=true);
  parameter SI.Efficiency eta = 0.8 "Isentropic efficiency";
  parameter Real pRatio=2 "Pressure ratio (pRatio = p_out/p_in)";
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-140,160},{-120,180}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-80,160},{-60,180}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(Placement(transformation(extent={{140,180},{160,200}})));
  ThermofluidStream.Idealized.Processes.Adiabatic fullMedium(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    pr_fixed=pRatio,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dp_fixed=100000) annotation (Placement(transformation(extent={{-110,160},{-90,180}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-140,30},{-120,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-80,30},{-60,50}})));
  ThermofluidStream.Idealized.Processes.Adiabatic idealGasConstantGamma(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.IdealGasConstantGamma "p*v = R*T, gamma = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    pr_fixed=pRatio,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dp_fixed=100000) annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-40,160},{-20,180}})));
  .ThermofluidStream.Boundaries.Sink_m sink3(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{20,160},{40,180}})));
  ThermofluidStream.Idealized.Processes.Adiabatic fullMedium1(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000,
    enableFilter=true,
    TC=0.01,
    P_nom(displayUnit="kW") = 300000,
    dp_nom=5000000) annotation (Placement(transformation(extent={{-10,160},{10,180}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-40,100},{-20,120}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink4(redeclare package Medium = Medium)                          annotation(Placement(transformation(extent={{20,100},{40,120}})));
  ThermofluidStream.Idealized.Processes.Adiabatic fullMedium2(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    pr_fixed=pRatio,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dp_fixed=100000) annotation (Placement(transformation(extent={{-10,120},{10,100}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-40,30},{-20,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink5(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{20,30},{40,50}})));
  ThermofluidStream.Idealized.Processes.Adiabatic idealGasConstantGamma1(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.IdealGasConstantGamma "p*v = R*T, gamma = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000,
    TC=0.01,
    P_nom(displayUnit="kW") = 300000,
    dp_nom=5000000,
    enableFilter=true) annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-40,-40},{-20,-20}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink6(redeclare package Medium = Medium)                          annotation(Placement(transformation(extent={{20,-40},{40,-20}})));
  ThermofluidStream.Idealized.Processes.Adiabatic idealGasConstantGamma2(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.IdealGasConstantGamma "p*v = R*T, gamma = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    pr_fixed=pRatio,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dp_fixed=100000) annotation (Placement(transformation(extent={{-10,-20},{10,-40}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation(Placement(transformation(extent={{-60,130},{-40,150}})));
  Modelica.Blocks.Math.Gain gain1(k=-1) annotation(Placement(transformation(extent={{-60,-10},{-40,10}})));
  Boundaries.Source                   source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-140,-100},{-120,-80}})));
  Boundaries.Sink_m                    sink2(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-80,-100},{-60,-80}})));
  ThermofluidStream.Idealized.Processes.Adiabatic perfetGas(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    pr_fixed=pRatio,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dp_fixed=100000) annotation (Placement(transformation(extent={{-110,-100},{-90,-80}})));
  Boundaries.Source                   source7(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-40,-100},{-20,-80}})));
  Boundaries.Sink_m                    sink7(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{20,-100},{40,-80}})));
  ThermofluidStream.Idealized.Processes.Adiabatic perfetGas1(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000,
    TC=0.01,
    P_nom(displayUnit="kW") = 300000,
    dp_nom=5000000,
    enableFilter=true) annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));
  Boundaries.Source                   source8(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-40,-170},{-20,-150}})));
  ThermofluidStream.Idealized.Sources.Sink_free  sink8(redeclare package Medium = Medium)                          annotation(Placement(transformation(extent={{20,-170},{40,-150}})));
  ThermofluidStream.Idealized.Processes.Adiabatic perfetGas2(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    pr_fixed=pRatio,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Fixed,
    dp_fixed=100000) annotation (Placement(transformation(extent={{-10,-150},{10,-170}})));
  Modelica.Blocks.Math.Gain gain2(k=-1) annotation(Placement(transformation(extent={{-60,-140},{-40,-120}})));

  Boundaries.Source                   source9(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{60,160},{80,180}})));
  Boundaries.Sink_m                    sink9(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{120,160},{140,180}})));
  ThermofluidStream.Idealized.Processes.Adiabatic fullMedium3(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000,
    enableFilter=false,
    TC=0.01,
    P_nom(displayUnit="kW") = 300000,
    dp_nom=5000000) annotation (Placement(transformation(extent={{90,160},{110,180}})));
  Boundaries.Source                   source10(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{60,30},{80,50}})));
  Boundaries.Sink_m                    sink10(redeclare package Medium = Medium, m_flow_fixed=1)
                                                                                                annotation(Placement(transformation(extent={{120,30},{140,50}})));
  ThermofluidStream.Idealized.Processes.Adiabatic idealGasConstantGamma3(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.IdealGasConstantGamma "p*v = R*T, gamma = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000,
    TC=0.01,
    P_nom(displayUnit="kW") = 300000,
    dp_nom=5000000,
    enableFilter=false)
                       annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Boundaries.Source                   source11(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{60,-100},{80,-80}})));
  Boundaries.Sink_m                    sink11(redeclare package Medium = Medium, m_flow_fixed=1)
                                                                                                annotation(Placement(transformation(extent={{120,-100},{140,-80}})));
  ThermofluidStream.Idealized.Processes.Adiabatic perfetGas3(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000,
    TC=0.01,
    P_nom(displayUnit="kW") = 300000,
    dp_nom=5000000,
    enableFilter=false)
                       annotation (Placement(transformation(extent={{90,-100},{110,-80}})));
equation
  connect(source.outlet,fullMedium. inlet) annotation(
    Line(
      points={{-120,170},{-110,170}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, idealGasConstantGamma.inlet) annotation (Line(
      points={{-120,40},{-110,40}},
      color={28,108,200},
      thickness=0.5));
  connect(fullMedium.outlet, sink.inlet) annotation(
    Line(
      points={{-90,170},{-80,170}},
      color={28,108,200},
      thickness=0.5));
  connect(idealGasConstantGamma.outlet, sink1.inlet) annotation (Line(
      points={{-90,40},{-80,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet,fullMedium1. inlet) annotation(Line(
      points={{-20,170},{-10,170}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet,fullMedium2. inlet) annotation(Line(
      points={{-20,110},{-10,110}},
      color={28,108,200},
      thickness=0.5));
  connect(fullMedium1.outlet, sink3.inlet) annotation(Line(
      points={{10,170},{20,170}},
      color={28,108,200},
      thickness=0.5));
  connect(fullMedium2.outlet, sink4.inlet) annotation(Line(
      points={{10,110},{20,110}},
      color={28,108,200},
      thickness=0.5));
  connect(source5.outlet, idealGasConstantGamma1.inlet) annotation (Line(
      points={{-20,40},{-10,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, idealGasConstantGamma2.inlet) annotation (Line(
      points={{-20,-30},{-10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(idealGasConstantGamma1.outlet, sink5.inlet) annotation (Line(
      points={{10,40},{20,40}},
      color={28,108,200},
      thickness=0.5));
  connect(idealGasConstantGamma2.outlet, sink6.inlet) annotation (Line(
      points={{10,-30},{20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(fullMedium1.P_in, gain.y) annotation(Line(points={{0,162},{0,140},{-39,140}}, color={255,170,85}));
  connect(fullMedium.P_out, gain.u) annotation(Line(points={{-100,163},{-100,140},{-62,140}}, color={255,170,85}));
  connect(fullMedium2.P_in, gain.y) annotation(Line(points={{0,118},{0,140},{-39,140}},color={255,170,85}));
  connect(idealGasConstantGamma1.P_in, gain1.y) annotation (Line(points={{0,32},{0,0},{-39,0}}, color={255,170,85}));
  connect(idealGasConstantGamma2.P_in, gain1.y) annotation (Line(points={{0,-22},{0,0},{-39,0}}, color={255,170,85}));
  connect(idealGasConstantGamma.P_out, gain1.u) annotation (Line(points={{-100,33},{-100,0},{-62,0}},
                                                                                                    color={255,170,85}));
  connect(source2.outlet, perfetGas.inlet) annotation (Line(
      points={{-120,-90},{-110,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(perfetGas.outlet, sink2.inlet) annotation (Line(
      points={{-90,-90},{-80,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(source7.outlet, perfetGas1.inlet) annotation (Line(
      points={{-20,-90},{-10,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(source8.outlet, perfetGas2.inlet) annotation (Line(
      points={{-20,-160},{-10,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(perfetGas1.outlet, sink7.inlet) annotation (Line(
      points={{10,-90},{20,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(perfetGas2.outlet, sink8.inlet) annotation (Line(
      points={{10,-160},{20,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(perfetGas1.P_in, gain2.y) annotation (Line(points={{0,-98},{0,-130},{-39,-130}}, color={255,170,85}));
  connect(perfetGas2.P_in, gain2.y) annotation (Line(points={{0,-152},{0,-130},{-39,-130}}, color={255,170,85}));
  connect(perfetGas.P_out, gain2.u) annotation (Line(points={{-100,-97},{-100,-130},{-62,-130}},
                                                                                               color={255,170,85}));
  connect(source9.outlet,fullMedium3. inlet) annotation(Line(
      points={{80,170},{90,170}},
      color={28,108,200},
      thickness=0.5));
  connect(fullMedium3.outlet,sink9. inlet) annotation(Line(
      points={{110,170},{120,170}},
      color={28,108,200},
      thickness=0.5));
  connect(fullMedium3.P_in, gain.y) annotation(Line(points={{100,162},{100,140},{-39,140}},
                                                                                        color={255,170,85}));
  connect(source10.outlet, idealGasConstantGamma3.inlet) annotation (Line(
      points={{80,40},{90,40}},
      color={28,108,200},
      thickness=0.5));
  connect(idealGasConstantGamma3.outlet, sink10.inlet) annotation (Line(
      points={{110,40},{120,40}},
      color={28,108,200},
      thickness=0.5));
  connect(idealGasConstantGamma3.P_in, gain1.y) annotation (Line(points={{100,32},{100,0},{-39,0}},
                                                                                                color={255,170,85}));
  connect(source11.outlet, perfetGas3.inlet) annotation (Line(
      points={{80,-90},{90,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(perfetGas3.outlet, sink11.inlet) annotation (Line(
      points={{110,-90},{120,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(perfetGas3.P_in, gain2.y) annotation (Line(points={{100,-98},{100,-130},{-39,-130}},
                                                                                           color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2})),                                            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-200},{160,200}})),
    Documentation(info="<html>
  <p>
    Modification of the 
    <a href=\"modelica://ThermofluidStream.Idealized.Tests.Processes.Adiabatic.Compressor\">Compressor</a> example
    using a constant pressure ratio instead of a time-dependent one.<br>
    In this case, <code>considerInertance = false</code> is not required.
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
