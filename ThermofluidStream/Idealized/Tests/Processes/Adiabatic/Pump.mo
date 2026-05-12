within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model Pump "Pump model with different adiabatic models (isentropic, perfect gas,...)"
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconInertanceNeglect;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium" annotation(
    choicesAllMatching=true);
  parameter SI.Efficiency eta = 0.8 "Isentropic efficiency";
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-140,138},{-120,158}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-80,138},{-60,158}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(Placement(transformation(extent={{180,200},{200,220}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pump(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{-110,138},{-90,158}})));
  Modelica.Blocks.Sources.Ramp pressureRatio(
    height=98.999,
    duration=0.9,
    offset=1.001)
             annotation(Placement(transformation(extent={{-200,-10},{-180,10}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-150,-10},{-130,10}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-90,-10},{-70,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pumpIncompressibleFluid_LinearWork(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IncompressibleFluid "rho = const, Version 1",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{-120,-10},{-100,10}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-150,-166},{-130,-146}})));
  .ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-90,-166},{-70,-146}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pumpIncompressibleFluid_Enthalpy(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IsothermalReference "rho = const, Version 2",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{-120,-146},{-100,-166}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{0,160},{20,180}})));
  .ThermofluidStream.Boundaries.Sink_m sink3(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{60,160},{80,180}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pump1(
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
    P_nom(displayUnit="kW") = 5000,
    dp_nom=5000000) annotation(Placement(transformation(extent={{30,160},{50,180}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    considerInertance=false,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{18,94},{38,114}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink4(redeclare package Medium = Medium, considerInertance=false) annotation(Placement(transformation(extent={{78,94},{98,114}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pump2(
    redeclare package Medium = Medium,
    considerInertance=false,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{48,114},{68,94}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation(Placement(transformation(extent={{-40,100},{-20,120}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{18,30},{38,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink5(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{78,30},{98,50}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pumpIncompressibleFluid_LinearWork1(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IncompressibleFluid "rho = const, Version 1",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000,
    enableFilter=true,
    TC=0.01,
    P_nom(displayUnit="kW") = 5000,
    dp_nom=5000000) annotation(Placement(transformation(extent={{48,30},{68,50}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    considerInertance=false,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{18,-54},{38,-34}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink6(redeclare package Medium = Medium, considerInertance=false) annotation(Placement(transformation(extent={{78,-54},{98,-34}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pumpIncompressibleFluid_LinearWork2(
    redeclare package Medium = Medium,
    considerInertance=false,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IncompressibleFluid "rho = const, Version 1",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{48,-34},{68,-54}})));
  Modelica.Blocks.Math.Gain gain1(k=-1) annotation(Placement(transformation(extent={{-40,-60},{-20,-40}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{20,-126},{40,-106}})));
  .ThermofluidStream.Boundaries.Sink_m sink7(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{80,-126},{100,-106}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pumpIncompressibleFluid_Enthalpy1(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IsothermalReference "rho = const, Version 2",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    specifyOutlet=false,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000,
    enableFilter=true,
    TC=0.01,
    P_nom(displayUnit="kW") = 5000,
    dp_nom=5000000) annotation(Placement(transformation(extent={{50,-126},{70,-106}})));
  ThermofluidStream.Boundaries.Source source8(
    redeclare package Medium = Medium,
    considerInertance=false,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{18,-210},{38,-190}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink8(redeclare package Medium = Medium, considerInertance=false) annotation(Placement(transformation(extent={{78,-210},{98,-190}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pumpIncompressibleFluid_Enthalpy2(
    redeclare package Medium = Medium,
    considerInertance=false,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IsothermalReference "rho = const, Version 2",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{48,-190},{68,-210}})));
  Modelica.Blocks.Math.Gain gain2(k=-1) annotation(Placement(transformation(extent={{-20,-166},{0,-146}})));
equation
  connect(source.outlet, pump.inlet) annotation(Line(
      points={{-120,148},{-110,148}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, pumpIncompressibleFluid_LinearWork.inlet) annotation(Line(
      points={{-130,0},{-120,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.outlet, sink.inlet) annotation(Line(
      points={{-90,148},{-80,148}},
      color={28,108,200},
      thickness=0.5));
  connect(pumpIncompressibleFluid_LinearWork.outlet, sink1.inlet) annotation(Line(
      points={{-100,0},{-90,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, pumpIncompressibleFluid_Enthalpy.inlet) annotation(Line(
      points={{-130,-156},{-120,-156}},
      color={28,108,200},
      thickness=0.5));
  connect(pumpIncompressibleFluid_Enthalpy.outlet, sink2.inlet) annotation(Line(
      points={{-100,-156},{-90,-156}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, pump1.inlet) annotation(Line(
      points={{20,170},{30,170}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet, pump2.inlet) annotation(Line(
      points={{38,104},{48,104}},
      color={28,108,200},
      thickness=0.5));
  connect(pump1.outlet, sink3.inlet) annotation(Line(
      points={{50,170},{60,170}},
      color={28,108,200},
      thickness=0.5));
  connect(pump2.outlet, sink4.inlet) annotation(Line(
      points={{68,104},{78,104}},
      color={28,108,200},
      thickness=0.5));
  connect(pumpIncompressibleFluid_LinearWork.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{-100,-12},{-100,-20},{-172,-20},{-172,0},{-179,0}}, color={0,0,127}));
  connect(pump.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{-90,136},{-90,130},{-172,130},{-172,0},{-179,0}}, color={0,0,127}));
  connect(pumpIncompressibleFluid_Enthalpy.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{-100,-144},{-100,-106},{-172,-106},{-172,0},{-179,0}}, color={0,0,127}));
  connect(pump2.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{68,116},{68,130},{-172,130},{-172,0},{-179,0}}, color={0,0,127}));
  connect(source5.outlet, pumpIncompressibleFluid_LinearWork1.inlet) annotation(Line(
      points={{38,40},{48,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, pumpIncompressibleFluid_LinearWork2.inlet) annotation(Line(
      points={{38,-44},{48,-44}},
      color={28,108,200},
      thickness=0.5));
  connect(pumpIncompressibleFluid_LinearWork1.outlet, sink5.inlet) annotation(Line(
      points={{68,40},{78,40}},
      color={28,108,200},
      thickness=0.5));
  connect(pumpIncompressibleFluid_LinearWork2.outlet, sink6.inlet) annotation(Line(
      points={{68,-44},{78,-44}},
      color={28,108,200},
      thickness=0.5));
  connect(pumpIncompressibleFluid_LinearWork2.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{68,-32},{68,-20},{-172,-20},{-172,0},{-179,0}}, color={0,0,127}));
  connect(source7.outlet, pumpIncompressibleFluid_Enthalpy1.inlet) annotation(Line(
      points={{40,-116},{50,-116}},
      color={28,108,200},
      thickness=0.5));
  connect(source8.outlet, pumpIncompressibleFluid_Enthalpy2.inlet) annotation(Line(
      points={{38,-200},{48,-200}},
      color={28,108,200},
      thickness=0.5));
  connect(pumpIncompressibleFluid_Enthalpy1.outlet, sink7.inlet) annotation(Line(
      points={{70,-116},{80,-116}},
      color={28,108,200},
      thickness=0.5));
  connect(pumpIncompressibleFluid_Enthalpy2.outlet, sink8.inlet) annotation(Line(
      points={{68,-200},{78,-200}},
      color={28,108,200},
      thickness=0.5));
  connect(pumpIncompressibleFluid_Enthalpy2.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{68,-188},{68,-180},{-172,-180},{-172,0},{-179,0}}, color={0,0,127}));
  connect(pump.P_out, gain.u) annotation(Line(points={{-100,141},{-100,110},{-42,110}}, color={255,170,85}));
  connect(pump2.P_in, gain.y) annotation(Line(points={{58,112},{60,112},{60,126},{0,126},{0,110},{-19,110}}, color={255,170,85}));
  connect(pump1.P_in, gain.y) annotation(Line(points={{40,162},{40,126},{0,126},{0,110},{-19,110}}, color={255,170,85}));
  connect(pumpIncompressibleFluid_LinearWork.P_out, gain1.u) annotation(Line(points={{-110,-7},{-110,-50},{-42,-50}}, color={255,170,85}));
  connect(pumpIncompressibleFluid_LinearWork2.P_in, gain1.y) annotation(Line(points={{58,-36},{58,-24},{-4,-24},{-4,-50},{-19,-50},{-19,-50}}, color={255,170,85}));
  connect(pumpIncompressibleFluid_LinearWork1.P_in, gain1.y) annotation(Line(points={{58,32},{58,-24},{-4,-24},{-4,-50},{-19,-50}}, color={255,170,85}));
  connect(pumpIncompressibleFluid_Enthalpy.P_out, gain2.u) annotation(Line(points={{-110,-149},{-110,-132},{-36,-132},{-36,-156},{-22,-156}}, color={255,170,85}));
  connect(pumpIncompressibleFluid_Enthalpy1.P_in, gain2.y) annotation(Line(points={{60,-124},{60,-156},{1,-156}}, color={255,170,85}));
  connect(pumpIncompressibleFluid_Enthalpy2.P_in, gain2.y) annotation(Line(points={{58,-192},{58,-156},{1,-156}}, color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-220,-220},{200,220}}),
        graphics={Text(
          extent={{-26,248},{32,228}},
          textColor={0,140,72},
          textString="fine"),
                  Text(
          extent={{-108,304},{92,264}},
          textColor={28,108,200},
          textString="Compare approach using entropy vs approach 
assuming incompressible fluid V1 vs V2 for
different media, e.g. TwoPhaseWater, ConstantPropertyLiquidWater"),
                  Text(
          extent={{-200,160},{-140,140}},
          textColor={28,108,200},
          textString="Universal"),
                  Text(
          extent={{-302,12},{-220,-6}},
          textColor={28,108,200},
          textString="IncompressibleFluid_LinearWork"),
                  Text(
          extent={{-266,-140},{-184,-158}},
          textColor={28,108,200},
          textString="IncompressibleFluid_Enthalpy"),
        Polygon(
          points={{-220,160},{-180,160},{-180,180},{-200,180},{-200,220},{-220,220},{-220,160}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-190,210},{-110,190}},
          textColor={238,46,47},
          textString="requires considerInertance = false
see User's Guide",
          horizontalAlignment=TextAlignment.Left),
        Polygon(
          points={{96,90},{116,90},{116,100},{106,100},{106,120},{96,120},{96,90}},
          fillColor={162,29,33},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{96,-58},{116,-58},{116,-48},{106,-48},{106,-28},{96,-28},{96,-58}},
          fillColor={162,29,33},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{96,-214},{116,-214},{116,-204},{106,-204},{106,-184},{96,-184},{96,-214}},
          fillColor={162,29,33},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}),
    Documentation(info="<html>
  <p>
    Forward and inverse calculations of different adiabatic models (Universal, Incompressible Fluid version 1, and Incompressible Fluid version 2) for a pump are demonstrated:
  </p>

  <ul>
    <li><code>P(m_flow, p_out)</code></li>
    <li><code>p_out(m_flow, P)</code></li>
    <li><code>m_flow(p_out, P)</code></li>
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
end Pump;
