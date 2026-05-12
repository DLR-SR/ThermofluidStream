within ThermofluidStream.Idealized.Examples.AdiabaticProcess;
model ConstantPropertyLiquidWater
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Water.ConstantPropertyLiquidWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium" annotation(
    choicesAllMatching=true);
  parameter SI.Efficiency eta = 0.8 "Isentropic efficiency";
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=298.15) annotation(Placement(transformation(extent={{-40,50},{-20,70}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{20,50},{40,70}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(Placement(transformation(extent={{80,80},{100,100}})));
  ThermofluidStream.Idealized.Processes.Adiabatic fullMedium(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Blocks.Sources.Ramp pressureDifference(
    height=100e5,
    duration=1,
    offset=0) annotation(Placement(transformation(extent={{-90,-30},{-70,-10}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-40,-10},{-20,10}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{20,-10},{40,10}})));
  ThermofluidStream.Idealized.Processes.Adiabatic incompressibleFluid(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IncompressibleFluid "rho = const, Version 1",
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{-10,-10},{10,10}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-40,-60},{-20,-40}})));
  .ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{20,-60},{40,-40}})));
  ThermofluidStream.Idealized.Processes.Adiabatic isothermalReference(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.IsothermalReference "rho = const, Version 2",
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{-10,-60},{10,-40}})));
equation
  connect(source.outlet, fullMedium.inlet) annotation(Line(
      points={{-20,60},{-10,60}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, incompressibleFluid.inlet) annotation(Line(
      points={{-20,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(fullMedium.outlet, sink.inlet) annotation(Line(
      points={{10,60},{20,60}},
      color={28,108,200},
      thickness=0.5));
  connect(incompressibleFluid.outlet, sink1.inlet) annotation(Line(
      points={{10,0},{20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(incompressibleFluid.outletSpec_prescribed, pressureDifference.y) annotation(Line(points={{10,-12},{10,-20},{-69,-20}}, color={0,0,127}));
  connect(fullMedium.outletSpec_prescribed, pressureDifference.y) annotation(Line(points={{10,48},{10,32},{-60,32},{-60,-20},{-69,-20}}, color={0,0,127}));
  connect(source2.outlet, isothermalReference.inlet) annotation(Line(
      points={{-20,-50},{-10,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(isothermalReference.outlet, sink2.inlet) annotation(Line(
      points={{10,-50},{20,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(isothermalReference.outletSpec_prescribed, pressureDifference.y) annotation(Line(points={{10,-62},{10,-70},{-60,-70},{-60,-20},{-69,-20}}, color={0,0,127}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2})),                                            Diagram(coordinateSystem(preserveAspectRatio=false,
        grid={2,2})),
    Documentation(info="<html>
  <p>
    This model evaluates different 
    <a href=\"modelica://ThermoFluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels\">AdiabaticThermodynamicModels</a>
    based on an exemplary pressurization of liquid water 
    (<a href=\"modelica://ThermofluidStream.Media.myMedia.Water.ConstantPropertyLiquidWater\">ConstantPropertyLiquidWater</a>).
  </p>

  <p>
    Simulation time represents the applied pressure difference, which increases linearly 
    from zero to <code>dp = 100 bar</code> at <code>time = 1</code>.
  </p>

  <p>
    The figure below shows the resulting power:
  </p>

  <p>
    <img src=\"modelica://ThermofluidStream/Resources/Idealized/Documentation/Examples.AdiabaticProcess.ConstantPropertyLiquidWater.svg\" width=\"500\">
  </p>

  <p>
    The <code>isothermalReference</code> (<code>h_out_is = h(p_out, T_in)</code>) and 
    <code>fullMedium</code> (<code>h_out_is = h(p_out, s_in)</code>) formulations 
    yield zero power because in the <a href=\"modelica://ThermofluidStream.Media.myMedia.Water.ConstantPropertyLiquidWater\">ConstantPropertyLiquidWater</a> medium model
    enthalpy is defined as a function of temperature only (<code>h = h0 + c*(T - T0)</code>), 
    thereby neglecting the pressure-dependent flow work term <code>dp/rho</code>. 
  </p>

  <p>
    Note a bug caused an additional offset for <code>fullMedium</code>, see
    <a href=\"https://github.com/DLR-SR/ThermofluidStream/pull/313\">
      https://github.com/DLR-SR/ThermofluidStream/pull/313
    </a>.
  </p>

  <p>
    For more details regarding the underlying assumptions, refer to: <br>
    <a href=\"modelica://ThermoFluidStream.Idealized.UsersGuide.AdiabaticThermodynamicModels\">
      ThermoFluidStream.Idealized.UsersGuide.AdiabaticThermodynamicModels
    </a>.
  </p>

</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end ConstantPropertyLiquidWater;
