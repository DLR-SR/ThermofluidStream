within ThermofluidStream.Idealized.Examples.JouleBrayton;
model Step1Simple
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{80,80},{100,100}})));

  Processes.Adiabatic compressor(
    redeclare package Medium = Medium,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-52,-10},{-32,10}})));
  Processes.Adiabatic turbine(
    redeclare package Medium = Medium,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=100000) annotation(Placement(transformation(extent={{30,-10},{50,10}})));
  ThermofluidStream.Boundaries.Source
                    airSource(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-92,-10},{-72,10}})));
  Processes.Isobaric combustion(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,

    T_out_fixed=1673.15) annotation(Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp outletPressure(
    height=19e5,
    duration=1,
    offset=1e5) annotation(Placement(transformation(extent={{-68,-46},{-48,-26}})));
  ThermofluidStream.Utilities.showRealValue efficiencyExtensive(
    description="efficiency extensive",
    use_numberPort=false,
    number=-(turbine.P + compressor.P)/(combustion.Q_flow),
    displayVariable=false) annotation(Placement(transformation(extent={{0,60},{20,80}})));
  ThermofluidStream.Utilities.showRealValue efficiencySpecific(
    description="efficiency specific",
    use_numberPort=false,
    number=-(turbine.dh + compressor.dh)/(combustion.dh),
    displayVariable=false) annotation(Placement(transformation(extent={{0,40},{20,60}})));
  Boundaries.Sink_m airSink(redeclare package Medium = Medium, m_flow_fixed=1) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={80,0})));
equation
  connect(combustion.outlet, turbine.inlet) annotation(
    Line(
      points={{10,0},{30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(airSource.outlet, compressor.inlet) annotation(
    Line(
      points={{-72,0},{-52,0}},
      color={28,108,200},
      thickness=0.5));
  connect(outletPressure.y, compressor.outletSpec_prescribed) annotation(Line(points={{-47,-36},{-32,-36},{-32,-12}}, color={0,0,127}));
  connect(compressor.outlet, combustion.inlet) annotation(Line(
      points={{-32,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine.outlet, airSink.inlet) annotation(Line(
      points={{50,0},{70,0}},
      color={28,108,200},
      thickness=0.5));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false),
                                           graphics={
        Text(
          extent={{-66,6},{-60,0}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-26,6},{-20,0}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{14,6},{20,0}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{54,6},{60,0}},
          textColor={28,108,200},
          textString="4")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    In a first step a simple compression-combustion-expansion cycle is built. The mass flow rate is constant (it can also be set to zero). The pressure is varied with time.<br>
  </p>

  <p>
    The overall efficiency is increasing with pressure.
  </p>

  <p>
    Further documentation is available in the 
    <a href=\"modelica://ThermofluidStream.Idealized.Examples.JouleBrayton\">JouleBrayton</a> package.
  </p>
</html>"));
end Step1Simple;
