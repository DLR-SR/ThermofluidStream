within ThermofluidStream.Processes.Sources.Tests;
model Test_PressureSourceIncompressible
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Source. Make sure it is the same as the one
the inlet the source is connected to.
</p>
</html>"));
  parameter SI.Efficiency eta=1     "Isentropic efficiency";
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{80,10},{100,30}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation (Placement(transformation(extent={{-100,80},
            {-80,100}})));
  Sources.AllMediaBasedOnEntropy.PressureSource pressureSource(
    redeclare package Medium = Medium,
    compressor=false,
    eta_is=eta,
    setpoint=ThermofluidStream.Processes.Internal.Types.SetpointModePressure.pr,
    setpointFromInput=true,
    dp_par=100000,
    displayEfficiency=true) annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss,
    l=10,
    r=1e-2) annotation (Placement(transformation(extent={{50,10},{70,30}})));
  Modelica.Blocks.Sources.Ramp pressureRatio(
    height=99,
    duration=0.9,
    offset=1) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Boundaries.Source                   source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Boundaries.Sink                   sink1(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{80,-30},{100,-10}})));
  IncompressibleFluid.PressureSourceIncompressibleFluid pressureSourceIncompressibleFluid(
    redeclare package Medium = Medium,
    eta_is=eta,
    Delta_rho_rel=1,
    setpoint=ThermofluidStream.Processes.Internal.Types.SetpointModePressure.pr,
    setpointFromInput=true,
    dp_par=100000,
    displayEfficiency=true) annotation (Placement(transformation(extent={{-10,-10},{10,-30}})));
  FlowResistance                             flowResistance1(
    redeclare package Medium = Medium,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss,
    l=10,
    r=1e-2) annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
equation
  connect(source.outlet, pressureSource.inlet)
    annotation (Line(
      points={{-80,20},{-10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(pressureSource.outlet, flowResistance.inlet)
    annotation (Line(
      points={{10,20},{50,20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, sink.inlet)
    annotation (Line(
      points={{70,20},{80,20}},
      color={28,108,200},
      thickness=0.5));
  connect(pressureRatio.y, pressureSource.pr_var) annotation (Line(points={{-19,0},{0,0},{0,12}}, color={0,0,127}));
  connect(source1.outlet, pressureSourceIncompressibleFluid.inlet)
    annotation (Line(
      points={{-80,-20},{-10,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(pressureSourceIncompressibleFluid.outlet, flowResistance1.inlet)
    annotation (Line(
      points={{10,-20},{50,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet, sink1.inlet)
    annotation (Line(
      points={{70,-20},{80,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(pressureSourceIncompressibleFluid.pr_var, pressureRatio.y)
    annotation (Line(points={{0,-12},{0,0},{-19,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false),
        graphics={Text(
          extent={{-100,140},{100,120}},
          textColor={28,108,200},
          textString="Compare approach using entropy vs approach 
assuming ideal gas with constant kappa for
different media, e.g. Argon and CO2")}),
    Documentation(info="<html>
<p>
Compares:
</p>
<ul>
<li><a href=\"modelica://ThermofluidStream.Processes.Sources.AllMediaBasedOnEntropy.PressureSource\">BasedOnEntropy</a> suitable for \"all\" media, especially non ideal gas/fluid</li>
<li><a href=\"modelica://ThermofluidStream.Processes.Sources.IncompressibleFluid.PressureSourceIncompressibleFluid\">IncompressibleFluid</a> assuming incompressible fluid, i.e. <code>w_t_is = dp/rho_in</code></li>
</ul>

<p>
For example for <a href=\"modelica://ThermofluidStream.Media.myMedia.Incompressible.Examples.Essotherm650\">Essotherm650</a> both models do not predict the real behavior correctly.
<a href=\"modelica://ThermofluidStream.Media.myMedia.Incompressible.Examples.Essotherm650\">Essotherm650</a> neglects the hydraulic work in its specific enthalpy definition, i.e.
<code>h = c*(T-T_0)</code> instead of <code>h = c*(T-T_0)+ (p-p_0)*v</code> and therefore <code>s_out = s_in</code> implies <code>T_out = T_in</code> implies <code>h_out = h_in</code>, which is wrong.
</p>

<p>
For <a href=\"modelica://ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater\">TwoPhaseWater</a> both work for arbitrary isentropic efficiency <code>eta_is</code> and 
 predict <code>T_out ≈ T_in</code> for isentropic efficiency <code>eta_is = 1</code>. The difference between the methods is neglectable in this case.
</p>

<p>
<a href=\"modelica://ThermofluidStream.Processes.Sources.AllMediaBasedOnEntropy.PressureSource\">BasedOnEntropy</a> is more general and should be prefered when compressibility matters,
however <a href=\"modelica://ThermofluidStream.Processes.Sources.IncompressibleFluid.PressureSourceIncompressibleFluid\">IncompressibleFluid</a> seems to be suitable for most fluids aswell and might be faster/more robust.
</p>


</html>"));
end Test_PressureSourceIncompressible;
