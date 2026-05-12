within ThermofluidStream.Idealized.Tests.Processes.Adiabatic;
model Pump1 "Pump model with the adiabatic process"
  extends Modelica.Icons.Example;
  extends ThermofluidStream.Idealized.Utilities.IconNeglectInertance;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium"annotation(
    choicesAllMatching=true);
  parameter SI.Efficiency eta = 0.8 "Isentropic efficiency";
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{-120,-10},{-100,10}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{-60,-10},{-40,10}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(Placement(transformation(extent={{120,80},{140,100}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pump(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Sources.Ramp pressureRatio(
    height=98.999,
    duration=0.9,
    offset=1.001)
              annotation(Placement(transformation(extent={{-122,-64},{-102,-44}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{40,30},{60,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(extent={{100,30},{120,50}})));
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
    dp_nom=5000000) annotation(Placement(transformation(extent={{70,30},{90,50}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    considerInertance=false,
    p0_par=100000,
    temperatureFromInput=false,
    T0_par=293.15) annotation(Placement(transformation(extent={{38,-54},{58,-34}})));
  .ThermofluidStream.Idealized.Sources.Sink_free sink2(redeclare package Medium = Medium, considerInertance=false) annotation(Placement(transformation(extent={{98,-54},{118,-34}})));
  ThermofluidStream.Idealized.Processes.Adiabatic pump2(
    redeclare package Medium = Medium,
    considerInertance=false,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    eta_fixed=eta,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    dp_fixed=100000) annotation(Placement(transformation(extent={{68,-34},{88,-54}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation(Placement(transformation(extent={{0,-10},{20,10}})));
equation
  connect(source.outlet, pump.inlet) annotation(Line(
      points={{-100,0},{-90,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.outlet, sink.inlet) annotation(Line(
      points={{-70,0},{-60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, pump1.inlet) annotation(Line(
      points={{60,40},{70,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, pump2.inlet) annotation(Line(
      points={{58,-44},{68,-44}},
      color={28,108,200},
      thickness=0.5));
  connect(pump1.outlet, sink1.inlet) annotation(Line(
      points={{90,40},{100,40}},
      color={28,108,200},
      thickness=0.5));
  connect(pump2.outlet, sink2.inlet) annotation(Line(
      points={{88,-44},{98,-44}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{-70,-12},{-70,-54},{-101,-54}}, color={0,0,127}));
  connect(pump2.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{88,-32},{88,-20},{32,-20},{32,-54},{-101,-54}},   color={0,0,127}));
  connect(pump.P_out, gain.u) annotation(Line(points={{-80,-7},{-80,-26},{-14,-26},{-14,0},{-2,0}}, color={255,170,85}));
  connect(pump1.P_in, gain.y) annotation(Line(points={{80,32},{80,0},{21,0}}, color={255,170,85}));
  connect(pump2.P_in, gain.y) annotation(Line(points={{78,-36},{76,-36},{76,0},{21,0}}, color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{140,100}}), graphics={
        Polygon(
          points={{-140,40},{-100,40},{-100,60},{-120,60},{-120,100},{-140,100},{-140,40}},
          fillColor= {162,29,33},
          fillPattern= FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-110,90},{-30,70}},
          textColor={238,46,47},
          textString="requires considerInertance = false
see User's Guide",
          horizontalAlignment=TextAlignment.Left),
        Polygon(
          points={{114,-56},{134,-56},{134,-46},{124,-46},{124,-26},{114,-26},{114,-56}},
          fillColor={162,29,33},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}),
    Documentation(info="<html>
  <p>
   Simplification of the <a href=\"modelica://ThermoFluidStream.Idealized.Tests.Processes.Adiabatic.Pump\">Pump</a> example.
  </p>
</html>", revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Pump1;
