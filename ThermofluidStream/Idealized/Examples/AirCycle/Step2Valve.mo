within ThermofluidStream.Idealized.Examples.AirCycle;
model Step2Valve
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));

  ThermofluidStream.Idealized.Processes.Adiabatic compressor(
    redeclare package Medium = Medium,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Processes.Isenthalpic valve(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isenthalpic.OutletPressure,
    p_out_fixed=100000) annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  ThermofluidStream.Boundaries.Source airSource(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  ThermofluidStream.Idealized.Processes.Isobaric cooler(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,

    T_out_fixed=293.15) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp pressure(
    height=2e5,
    duration=1,
    offset=1e5 + 1)
                annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
  ThermofluidStream.Utilities.showRealValue coefficientOfPerformanceSpecific(
    description="COP",
    use_numberPort=false,
    number=(Medium.specificEnthalpy(airSink.inlet.state) - Medium.specificEnthalpy(airSource.outlet.state))/(compressor.dh),
    displayVariable=false) "=0 (for a valve)"
                           annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Sink_m airSink(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{70,-10},{90,10}})));
equation
  connect(compressor.outlet, cooler.inlet)
    annotation (Line(
      points={{-30,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(cooler.outlet, valve.inlet)
    annotation (Line(
      points={{10,0},{30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(airSource.outlet, compressor.inlet)
    annotation (Line(
      points={{-70,0},{-50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(valve.outlet, airSink.inlet)
    annotation (Line(
      points={{50,0},{70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.outletSpec_prescribed, pressure.y) annotation (Line(points={{-30,-12},{-30,-40},{-49,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false),
                                           graphics={Text(
          extent={{-60,60},{40,40}},
          textColor={28,108,200},
          textString="This \"cooling cycle\" does not achieve any cooling."),
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
    In a second step, the turbine is replaced by an isenthalpic valve. For an ideal gas, the temperature difference across the valve is zero. Therefore, no cooling is achieved and the cycle is not meaningful from a thermodynamic perspective.
  </p>

  <p>
    Further documentation is available in the 
    <a href=\"modelica://ThermoFluidStream.Idealized.Examples.AirCycle\">AirCycle</a> package.
  </p>
</html>"));
end Step2Valve;
