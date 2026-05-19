within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model PumpConstant "Pump model with different adiabatic models (FullMedium, IncompressibleFluid, IsothermalReference)"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium" annotation(
    choicesAllMatching=true);
  parameter SI.Efficiency eta = 0.8 "Isentropic efficiency";
  parameter Real pRatio=2 "Pressure ratio (pRatio = p_out/p_in)";
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-150,160},{-130,180}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-90,160},{-70,180}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(Placement(transformation(extent={{140,180},{160,200}})));
  ThermofluidStream.Idealized.Processes.Adiabatic fullMedium(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    pRatio_fixed=pRatio,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    dp_fixed=100000) annotation (Placement(transformation(extent={{-120,160},{-100,180}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-150,30},{-130,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-90,30},{-70,50}})));
  ThermofluidStream.Idealized.Processes.Adiabatic incompressibleFluid(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.IncompressibleFluid "rho = const: h_out_is = dp/rho_in + h_in",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    pRatio_fixed=pRatio,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    dp_fixed=100000) annotation (Placement(transformation(extent={{-120,30},{-100,50}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-50,160},{-30,180}})));
  .ThermofluidStream.Boundaries.Sink_m sink3(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{10,160},{30,180}})));
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
    P_nom(displayUnit="kW") = 10000,
    dp_nom=5000000) annotation (Placement(transformation(extent={{-20,160},{0,180}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-50,100},{-30,120}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink4(redeclare package Medium = Medium)                          annotation(Placement(transformation(extent={{10,100},{30,120}})));
  ThermofluidStream.Idealized.Processes.Adiabatic fullMedium2(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    pRatio_fixed=pRatio,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    dp_fixed=100000) annotation (Placement(transformation(extent={{-20,120},{0,100}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-50,30},{-30,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink5(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{10,30},{30,50}})));
  ThermofluidStream.Idealized.Processes.Adiabatic incompressibleFluid1(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.IncompressibleFluid "rho = const: h_out_is = dp/rho_in + h_in",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000,
    TC=0.01,
    P_nom(displayUnit="kW") = 10000,
    dp_nom=5000000,
    p_out(start=100000),
    enableFilter=true) annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-50,-40},{-30,-20}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink6(redeclare package Medium = Medium)                          annotation(Placement(transformation(extent={{10,-40},{30,-20}})));
  ThermofluidStream.Idealized.Processes.Adiabatic incompressibleFluid2(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.IncompressibleFluid "rho = const: h_out_is = dp/rho_in + h_in",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    pRatio_fixed=pRatio,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    dp_fixed=100000) annotation (Placement(transformation(extent={{-20,-20},{0,-40}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation(Placement(transformation(extent={{-70,130},{-50,150}})));
  Modelica.Blocks.Math.Gain gain1(k=-1) annotation(Placement(transformation(extent={{-70,-10},{-50,10}})));
  Boundaries.Source                   source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-150,-100},{-130,-80}})));
  Boundaries.Sink_m                    sink2(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-90,-100},{-70,-80}})));
  ThermofluidStream.Idealized.Processes.Adiabatic isothermalReference(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.IsothermalReference "h_out_is = h(p_out, T_in)",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    pRatio_fixed=pRatio,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    dp_fixed=100000) annotation (Placement(transformation(extent={{-120,-100},{-100,-80}})));
  Boundaries.Source                   source7(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-50,-100},{-30,-80}})));
  Boundaries.Sink_m                    sink7(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{10,-100},{30,-80}})));
  ThermofluidStream.Idealized.Processes.Adiabatic isothermalReference1(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.IsothermalReference "h_out_is = h(p_out, T_in)",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000,
    TC=0.01,
    P_nom(displayUnit="kW") = 10000,
    dp_nom=5000000,
    p_out(start=100000),
    enableFilter=true) annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  Boundaries.Source                   source8(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-50,-170},{-30,-150}})));
  ThermofluidStream.Idealized.Sources.Sink_free  sink8(redeclare package Medium = Medium)                          annotation(Placement(transformation(extent={{10,-170},{30,-150}})));
  ThermofluidStream.Idealized.Processes.Adiabatic isothermalReference2(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.IsothermalReference "h_out_is = h(p_out, T_in)",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    pRatio_fixed=pRatio,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    dp_fixed=100000) annotation (Placement(transformation(extent={{-20,-150},{0,-170}})));
  Modelica.Blocks.Math.Gain gain2(k=-1) annotation(Placement(transformation(extent={{-70,-140},{-50,-120}})));
  Boundaries.Source                   source9(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{50,160},{70,180}})));
  Boundaries.Sink_m                    sink9(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{110,160},{130,180}})));
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
    P_nom(displayUnit="kW"))
                    annotation (Placement(transformation(extent={{80,160},{100,180}})));
  Boundaries.Source                   source10(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{50,30},{70,50}})));
  Boundaries.Sink_m                    sink10(redeclare package Medium = Medium, m_flow_fixed=1)
                                                                                                annotation(Placement(transformation(extent={{110,30},{130,50}})));
  ThermofluidStream.Idealized.Processes.Adiabatic incompressibleFluid3(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.IncompressibleFluid "rho = const: h_out_is = dp/rho_in + h_in",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000,
    P_nom(displayUnit="kW"),
    p_out(start=100000),
    enableFilter=false) annotation (Placement(transformation(extent={{80,30},{100,50}})));
  Boundaries.Source                   source11(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{50,-100},{70,-80}})));
  Boundaries.Sink_m                    sink11(redeclare package Medium = Medium, m_flow_fixed=1)
                                                                                                annotation(Placement(transformation(extent={{110,-100},{130,-80}})));
  ThermofluidStream.Idealized.Processes.Adiabatic isothermalReference3(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.AdiabaticThermodynamicModels.IsothermalReference "h_out_is = h(p_out, T_in)",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000,
    P_nom(displayUnit="kW"),
    p_out(start=100000),
    enableFilter=false) annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
equation
  connect(source.outlet,fullMedium. inlet) annotation(
    Line(
      points={{-130,170},{-120,170}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, incompressibleFluid.inlet) annotation (Line(
      points={{-130,40},{-120,40}},
      color={28,108,200},
      thickness=0.5));
  connect(fullMedium.outlet, sink.inlet) annotation(
    Line(
      points={{-100,170},{-90,170}},
      color={28,108,200},
      thickness=0.5));
  connect(incompressibleFluid.outlet, sink1.inlet) annotation (Line(
      points={{-100,40},{-90,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet,fullMedium1. inlet) annotation(Line(
      points={{-30,170},{-20,170}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet,fullMedium2. inlet) annotation(Line(
      points={{-30,110},{-20,110}},
      color={28,108,200},
      thickness=0.5));
  connect(fullMedium1.outlet, sink3.inlet) annotation(Line(
      points={{0,170},{10,170}},
      color={28,108,200},
      thickness=0.5));
  connect(fullMedium2.outlet, sink4.inlet) annotation(Line(
      points={{0,110},{10,110}},
      color={28,108,200},
      thickness=0.5));
  connect(source5.outlet, incompressibleFluid1.inlet) annotation (Line(
      points={{-30,40},{-20,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, incompressibleFluid2.inlet) annotation (Line(
      points={{-30,-30},{-20,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(incompressibleFluid1.outlet, sink5.inlet) annotation (Line(
      points={{0,40},{10,40}},
      color={28,108,200},
      thickness=0.5));
  connect(incompressibleFluid2.outlet, sink6.inlet) annotation (Line(
      points={{0,-30},{10,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(fullMedium1.P_in, gain.y) annotation(Line(points={{-10,162},{-10,140},{-49,140}},
                                                                                        color={255,170,85}));
  connect(fullMedium.P_out, gain.u) annotation(Line(points={{-110,163},{-110,140},{-72,140}}, color={255,170,85}));
  connect(fullMedium2.P_in, gain.y) annotation(Line(points={{-10,118},{-10,140},{-49,140}},
                                                                                       color={255,170,85}));
  connect(incompressibleFluid1.P_in, gain1.y) annotation (Line(points={{-10,32},{-10,0},{-49,0}},
                                                                                                color={255,170,85}));
  connect(incompressibleFluid2.P_in, gain1.y) annotation (Line(points={{-10,-22},{-10,0},{-49,0}},
                                                                                                 color={255,170,85}));
  connect(incompressibleFluid.P_out, gain1.u) annotation (Line(points={{-110,33},{-110,0},{-72,0}},
                                                                                                  color={255,170,85}));
  connect(source2.outlet, isothermalReference.inlet) annotation (Line(
      points={{-130,-90},{-120,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(isothermalReference.outlet, sink2.inlet) annotation (Line(
      points={{-100,-90},{-90,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(source7.outlet, isothermalReference1.inlet) annotation (Line(
      points={{-30,-90},{-20,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(source8.outlet, isothermalReference2.inlet) annotation (Line(
      points={{-30,-160},{-20,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(isothermalReference1.outlet, sink7.inlet) annotation (Line(
      points={{0,-90},{10,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(isothermalReference2.outlet, sink8.inlet) annotation (Line(
      points={{0,-160},{10,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(isothermalReference1.P_in, gain2.y) annotation (Line(points={{-10,-98},{-10,-130},{-49,-130}},
                                                                                                       color={255,170,85}));
  connect(isothermalReference2.P_in, gain2.y) annotation (Line(points={{-10,-152},{-10,-130},{-49,-130}},
                                                                                                        color={255,170,85}));
  connect(isothermalReference.P_out, gain2.u) annotation (Line(points={{-110,-97},{-110,-130},{-72,-130}},
                                                                                                         color={255,170,85}));
  connect(source9.outlet,fullMedium3. inlet) annotation(Line(
      points={{70,170},{80,170}},
      color={28,108,200},
      thickness=0.5));
  connect(fullMedium3.outlet,sink9. inlet) annotation(Line(
      points={{100,170},{110,170}},
      color={28,108,200},
      thickness=0.5));
  connect(fullMedium3.P_in, gain.y) annotation(Line(points={{90,162},{90,140},{-49,140}},
                                                                                        color={255,170,85}));
  connect(source10.outlet, incompressibleFluid3.inlet) annotation (Line(
      points={{70,40},{80,40}},
      color={28,108,200},
      thickness=0.5));
  connect(incompressibleFluid3.outlet, sink10.inlet) annotation (Line(
      points={{100,40},{110,40}},
      color={28,108,200},
      thickness=0.5));
  connect(incompressibleFluid3.P_in, gain1.y) annotation (Line(points={{90,32},{90,0},{-49,0}},   color={255,170,85}));
  connect(source11.outlet, isothermalReference3.inlet) annotation (Line(
      points={{70,-90},{80,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(isothermalReference3.outlet, sink11.inlet) annotation (Line(
      points={{100,-90},{110,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(isothermalReference3.P_in, gain2.y) annotation (Line(points={{90,-98},{90,-130},{-49,-130}},   color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2})),                                            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-200},{160,200}})),
    Documentation(info="<html>
  <p>
    Modification of the 
    <a href=\"modelica://ThermofluidStream.Idealized.Tests.Processes.Adiabatic.Pump\">Pump</a> example
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
end PumpConstant;
