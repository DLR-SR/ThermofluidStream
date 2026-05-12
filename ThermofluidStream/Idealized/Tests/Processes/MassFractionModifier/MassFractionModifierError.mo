within ThermofluidStream.Idealized.Tests.Processes.MassFractionModifier;
model MassFractionModifierError "Example - MassFractionModifier"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{140,140},{160,160}})));

  Modelica.Blocks.Sources.Pulse massFlowRate(period=0.3) annotation (Placement(transformation(extent={{110,0},{90,20}})));
  Modelica.Blocks.Sources.Pulse pressure(
    amplitude=1e5,
    period=0.3,
    offset=1e5,
    startTime=0.2) annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Sources.Pulse temperature(
    amplitude=100,
    period=0.3,
    offset=273.15 + 20,
    startTime=0.1) annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    T(displayUnit="ms") = 0.01,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0) annotation (Placement(transformation(extent={{80,0},{60,20}})));
  ThermofluidStream.Idealized.Processes.MassFractionModifier composition2(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Composition.MassFractionsDifference,
    dXi_fixed={-0.1}) annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true,
    xiFromInput=true)
                   annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{30,0},{50,20}})));
  Modelica.Blocks.Sources.Pulse massFractions(
    amplitude=-0.2,
    period=0.3,
    offset=0.1,
    startTime=0.15) annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
equation
  connect(firstOrder.u, massFlowRate.y) annotation (Line(points={{82,10},{89,10}},   color={0,0,127}));
  connect(source2.outlet, composition2.inlet) annotation (Line(
      points={{-30,10},{-10,10}},
      color={28,108,200},
      thickness=0.5));
  connect(composition2.outlet, sink2.inlet) annotation (Line(
      points={{10,10},{30,10}},
      color={28,108,200},
      thickness=0.5));
  connect(sink2.m_flow_prescribed, firstOrder.y) annotation (Line(points={{42,10},{59,10}}, color={0,0,127}));
  connect(source2.p0_var, pressure.y) annotation (Line(points={{-42,16},{-48,16},{-48,50},{-59,50}}, color={0,0,127}));
  connect(source2.T0_var, temperature.y) annotation (Line(points={{-42,10},{-59,10}}, color={0,0,127}));
  connect(massFractions.y, source2.xi_var[1]) annotation (Line(points={{-59,-30},{-50,-30},{-50,4},{-42,4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-160},{160,160}}), graphics={Text(
          extent={{-160,20},{-100,0}},
          textColor={28,108,200},
          textString="Moist Air (nXi = 1)")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    Supposed to create an error (Xi_out smaller 0).
  </p>
</html>"));
end MassFractionModifierError;
