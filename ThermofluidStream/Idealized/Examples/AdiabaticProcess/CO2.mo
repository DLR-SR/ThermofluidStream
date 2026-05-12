within ThermofluidStream.Idealized.Examples.AdiabaticProcess;
model CO2
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.IdealGases.SingleGases.CO2
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium"
    annotation(choicesAllMatching=true);
  parameter SI.Pressure p_in=100000 "Fixed inlet pressure";
  parameter SI.Temperature T_in=293.15 "Fixed inlet temperature";
  parameter SI.Efficiency eta = 0.8 "Isentropic efficiency";

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p_in,
    temperatureFromInput=false,
    T0_par=T_in)   annotation(Placement(transformation(extent={{-40,40},{-20,60}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{20,40},{40,60}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(Placement(transformation(extent={{-142,110},{-122,130}})));
  ThermofluidStream.Idealized.Processes.Adiabatic idealGasConstGamma(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IdealGasConstantGamma,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Sources.Ramp pressureRatio(
    height=1,
    duration=1,
    offset=1) annotation(Placement(transformation(extent={{-140,-10},{-120,10}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=p_in,
    temperatureFromInput=false,
    T0_par=T_in)   annotation(Placement(transformation(extent={{60,40},{80,60}})));
  ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{120,40},{140,60}})));
  ThermofluidStream.Idealized.Processes.Adiabatic perfectGas(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.PerfectGas "p*v = R*T, gamma, cp = const",
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{90,40},{110,60}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=p_in,
    temperatureFromInput=false,
    T0_par=T_in)   annotation(Placement(transformation(extent={{-40,-60},{-20,-40}})));
  ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{20,-60},{40,-40}})));
  ThermofluidStream.Idealized.Processes.Adiabatic incompressibleFluid(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IncompressibleFluid "rho = const, Version 1",
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{-10,-40},{10,-60}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=p_in,
    temperatureFromInput=false,
    T0_par=T_in)   annotation(Placement(transformation(extent={{60,-60},{80,-40}})));
  ThermofluidStream.Boundaries.Sink_m sink3(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{120,-60},{140,-40}})));
  ThermofluidStream.Idealized.Processes.Adiabatic isothermalReference(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IsothermalReference "rho = const, Version 2",
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{90,-40},{110,-60}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    p0_par=p_in,
    temperatureFromInput=false,
    T0_par=T_in) annotation(Placement(transformation(extent={{-140,40},{-120,60}})));
  Boundaries.Sink_m sink4(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-80,40},{-60,60}})));
  Processes.Adiabatic fullMedium(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{-110,40},{-90,60}})));

equation
  connect(source.outlet, idealGasConstGamma.inlet) annotation(Line(
      points={{-20,50},{-10,50}},
      color={28,108,200},
      thickness=0.5));
  connect(idealGasConstGamma.outlet, sink.inlet) annotation(Line(
      points={{10,50},{20,50}},
      color={28,108,200},
      thickness=0.5));
  connect(idealGasConstGamma.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{10,38},{10,0},{-119,0}}, color={0,0,127}));
  connect(source1.outlet, perfectGas.inlet) annotation(Line(
      points={{80,50},{90,50}},
      color={28,108,200},
      thickness=0.5));
  connect(perfectGas.outlet, sink1.inlet) annotation(Line(
      points={{110,50},{120,50}},
      color={28,108,200},
      thickness=0.5));
  connect(perfectGas.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{110,38},{110,0},{-119,0}}, color={0,0,127}));
  connect(source2.outlet, incompressibleFluid.inlet) annotation(Line(
      points={{-20,-50},{-10,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(incompressibleFluid.outlet, sink2.inlet) annotation(Line(
      points={{10,-50},{20,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(incompressibleFluid.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{10,-38},{10,0},{-119,0}}, color={0,0,127}));
  connect(source3.outlet, isothermalReference.inlet) annotation(Line(
      points={{80,-50},{90,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(isothermalReference.outlet, sink3.inlet) annotation(Line(
      points={{110,-50},{120,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(isothermalReference.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{110,-38},{110,0},{-119,0}}, color={0,0,127}));
  connect(source4.outlet, fullMedium.inlet) annotation(Line(
      points={{-120,50},{-110,50}},
      color={28,108,200},
      thickness=0.5));
  connect(fullMedium.outlet, sink4.inlet) annotation(Line(
      points={{-90,50},{-80,50}},
      color={28,108,200},
      thickness=0.5));
  connect(fullMedium.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{-90,38},{-90,0},{-119,0}}, color={0,0,127}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{160,100}}),
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
    This model compares different 
    <a href=\"modelica://ThermoFluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels\">AdiabaticThermodynamicModels</a> 
    using an exemplary compression of an ideal gas with temperature-dependent specific heat capacity and isentropic exponent
    (<a href=\"modelica://ThermofluidStream.Media.myMedia.IdealGases.SingleGases.CO2\">IdealGases.SingleGases.CO2</a>).
  </p>

  <p>
    Simulation time serves as a proxy for the pressure ratio, which starts at one and increases linearly 
    to <code>pr = 2</code> at <code>time = 1</code>.
  </p>

  <p>
    The following figure displays the resulting power, which is directly linked to the temperature difference:
  </p>

  <p>
    <img src=\"modelica://ThermofluidStream/Resources/Idealized/Documentation/Examples.AdiabaticProcess.CO2.png\" width=\"500\">
  </p>

  <p>
    The <code>fullMedium</code> model serves as the reference. Among the approximations, the constant isentropic 
    exponent (<code>idealGasConstGamma</code>) is the least restrictive, followed by constant isobaric heat 
    capacity (<code>perfectGas</code>) and constant density (<code>incompressibleFluid</code>). 
    Note that the second incompressible version, <code>isothermalReference</code>, is not suitable for 
    ideal gases. For pressure ratios close to <code>pr=1</code>, all models are valid and consistent, except for <code>isothermalReference</code>.
  </p>

  <p>
    For further information regarding the underlying assumptions, please refer to: 
    <br>
    <a href=\"modelica://ThermoFluidStream.Idealized.UsersGuide.AdiabaticThermodynamicModels\">ThermoFluidStream.Idealized.UsersGuide.AdiabaticThermodynamicModels</a>.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end CO2;
