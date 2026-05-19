within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model Compressor "Compressor model with different adiabatic models (isentropic, perfect gas,...)"
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconInertanceNeglect;

  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.CO2
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium" annotation(
    choicesAllMatching=true);
  parameter SI.Efficiency eta = 0.8 "Isentropic efficiency";
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-100,160},{-80,180}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-40,160},{-20,180}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(Placement(transformation(extent={{160,180},{180,200}})));
  ThermofluidStream.Idealized.Processes.Adiabatic fullMedium(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation (Placement(transformation(extent={{-70,160},{-50,180}})));
  Modelica.Blocks.Sources.Ramp pressureRatio(
    height=98.999,
    duration=0.9,
    offset=1.001,
    y(unit="1"))
             annotation(Placement(transformation(extent={{-160,0},{-140,20}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-100,30},{-80,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-40,30},{-20,50}})));
  ThermofluidStream.Idealized.Processes.Adiabatic idealGasConstantGamma(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.IdealGasConstantGamma "p*v = R*T, gamma = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{0,160},{20,180}})));
  .ThermofluidStream.Boundaries.Sink_m sink3(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{60,160},{80,180}})));
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
    dp_nom=5000000) annotation (Placement(transformation(extent={{30,160},{50,180}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    considerInertance=false,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{0,100},{20,120}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink4(redeclare package Medium = Medium, considerInertance=false) annotation(Placement(transformation(extent={{60,100},{80,120}})));
  ThermofluidStream.Idealized.Processes.Adiabatic fullMedium2(
    redeclare package Medium = Medium,
    considerInertance=false,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation (Placement(transformation(extent={{30,120},{50,100}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{0,30},{20,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink5(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{60,30},{80,50}})));
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
    p_out(start=100000),
    enableFilter=true) annotation (Placement(transformation(extent={{30,30},{50,50}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{0,-40},{20,-20}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink6(redeclare package Medium = Medium)                          annotation(Placement(transformation(extent={{60,-40},{80,-20}})));
  ThermofluidStream.Idealized.Processes.Adiabatic idealGasConstantGamma2(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.IdealGasConstantGamma "p*v = R*T, gamma = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation (Placement(transformation(extent={{30,-20},{50,-40}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation(Placement(transformation(extent={{-20,130},{0,150}})));
  Modelica.Blocks.Math.Gain gain1(k=-1) annotation(Placement(transformation(extent={{-20,-10},{0,10}})));
  Boundaries.Source                   source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Boundaries.Sink_m                    sink2(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-40,-100},{-20,-80}})));
  ThermofluidStream.Idealized.Processes.Adiabatic perfetGas(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation (Placement(transformation(extent={{-70,-100},{-50,-80}})));
  Boundaries.Source                   source7(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{0,-100},{20,-80}})));
  Boundaries.Sink_m                    sink7(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{60,-100},{80,-80}})));
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
    p_out(start=100000),
    enableFilter=true) annotation (Placement(transformation(extent={{30,-100},{50,-80}})));
  Boundaries.Source                   source8(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{0,-170},{20,-150}})));
  ThermofluidStream.Idealized.Sources.Sink_free  sink8(redeclare package Medium = Medium)                          annotation(Placement(transformation(extent={{60,-170},{80,-150}})));
  ThermofluidStream.Idealized.Processes.Adiabatic perfetGas2(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.PerfectGas "p*v = R*T, cp = const",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation (Placement(transformation(extent={{30,-150},{50,-170}})));
  Modelica.Blocks.Math.Gain gain2(k=-1) annotation(Placement(transformation(extent={{-20,-140},{0,-120}})));
equation
  connect(source.outlet,fullMedium. inlet) annotation(
    Line(
      points={{-80,170},{-70,170}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, idealGasConstantGamma.inlet) annotation (Line(
      points={{-80,40},{-70,40}},
      color={28,108,200},
      thickness=0.5));
  connect(fullMedium.outlet, sink.inlet) annotation(
    Line(
      points={{-50,170},{-40,170}},
      color={28,108,200},
      thickness=0.5));
  connect(idealGasConstantGamma.outlet, sink1.inlet) annotation (Line(
      points={{-50,40},{-40,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet,fullMedium1. inlet) annotation(Line(
      points={{20,170},{30,170}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet,fullMedium2. inlet) annotation(Line(
      points={{20,110},{30,110}},
      color={28,108,200},
      thickness=0.5));
  connect(fullMedium1.outlet, sink3.inlet) annotation(Line(
      points={{50,170},{60,170}},
      color={28,108,200},
      thickness=0.5));
  connect(fullMedium2.outlet, sink4.inlet) annotation(Line(
      points={{50,110},{60,110}},
      color={28,108,200},
      thickness=0.5));
  connect(idealGasConstantGamma.outletSpec_prescribed, pressureRatio.y) annotation (Line(points={{-50,28},{-50,-10},{-130,-10},{-130,10},{-139,10}}, color={0,0,127}));
  connect(fullMedium.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{-50,158},{-50,150},{-130,150},{-130,10},{-139,10}},
                                                                                                                                        color={0,0,127}));
  connect(fullMedium2.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{50,122},{50,130},{-130,130},{-130,10},{-139,10}},
                                                                                                                                       color={0,0,127}));
  connect(source5.outlet, idealGasConstantGamma1.inlet) annotation (Line(
      points={{20,40},{30,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, idealGasConstantGamma2.inlet) annotation (Line(
      points={{20,-30},{30,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(idealGasConstantGamma1.outlet, sink5.inlet) annotation (Line(
      points={{50,40},{60,40}},
      color={28,108,200},
      thickness=0.5));
  connect(idealGasConstantGamma2.outlet, sink6.inlet) annotation (Line(
      points={{50,-30},{60,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(idealGasConstantGamma2.outletSpec_prescribed, pressureRatio.y) annotation (Line(points={{50,-18},{50,-10},{-130,-10},{-130,10},{-139,10}}, color={0,0,127}));
  connect(fullMedium1.P_in, gain.y) annotation(Line(points={{40,162},{40,140},{1,140}}, color={255,170,85}));
  connect(fullMedium.P_out, gain.u) annotation(Line(points={{-60,163},{-60,140},{-22,140}},   color={255,170,85}));
  connect(fullMedium2.P_in, gain.y) annotation(Line(points={{40,118},{40,140},{1,140}},color={255,170,85}));
  connect(idealGasConstantGamma1.P_in, gain1.y) annotation (Line(points={{40,32},{40,0},{1,0}}, color={255,170,85}));
  connect(idealGasConstantGamma2.P_in, gain1.y) annotation (Line(points={{40,-22},{40,0},{1,0}}, color={255,170,85}));
  connect(idealGasConstantGamma.P_out, gain1.u) annotation (Line(points={{-60,33},{-60,0},{-22,0}}, color={255,170,85}));
  connect(source2.outlet, perfetGas.inlet) annotation (Line(
      points={{-80,-90},{-70,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(perfetGas.outlet, sink2.inlet) annotation (Line(
      points={{-50,-90},{-40,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(perfetGas.outletSpec_prescribed, pressureRatio.y) annotation (Line(points={{-50,-102},{-50,-140},{-130,-140},{-130,10},{-139,10}}, color={0,0,127}));
  connect(source7.outlet, perfetGas1.inlet) annotation (Line(
      points={{20,-90},{30,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(source8.outlet, perfetGas2.inlet) annotation (Line(
      points={{20,-160},{30,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(perfetGas1.outlet, sink7.inlet) annotation (Line(
      points={{50,-90},{60,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(perfetGas2.outlet, sink8.inlet) annotation (Line(
      points={{50,-160},{60,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(perfetGas2.outletSpec_prescribed, pressureRatio.y) annotation (Line(points={{50,-148},{50,-140},{-130,-140},{-130,10},{-139,10}}, color={0,0,127}));
  connect(perfetGas1.P_in, gain2.y) annotation (Line(points={{40,-98},{40,-130},{1,-130}}, color={255,170,85}));
  connect(perfetGas2.P_in, gain2.y) annotation (Line(points={{40,-152},{40,-130},{1,-130}}, color={255,170,85}));
  connect(perfetGas.P_out, gain2.u) annotation (Line(points={{-60,-97},{-60,-130},{-22,-130}}, color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2})),                                            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-200},{180,200}}),
        graphics={
        Text(
          extent={{94,128},{174,108}},
          textColor={238,46,47},
          textString="requires considerInertance = false
see User's Guide",
          horizontalAlignment=TextAlignment.Left),
        Polygon(
          points={{78,95},{98,95},{98,105},{88,105},{88,125},{78,125},{78,95}},
          fillColor={162,29,33},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}),
    Documentation(info="<html>
  <p>
    Forward and inverse calculations of different adiabatic models (<code>FullMedium</code>, <code>IdealGasConstantGamma</code>, <code>PerfectGas</code>) for a compressor are demonstrated:
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
    <code>fullMedium2</code> requires <code>considerInertance = false</code> if <code>p_out</code> is time-dependent.
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
