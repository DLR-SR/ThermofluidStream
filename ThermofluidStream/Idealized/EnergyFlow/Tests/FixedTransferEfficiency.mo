within ThermofluidStream.Idealized.EnergyFlow.Tests;
model FixedTransferEfficiency
  extends Modelica.Icons.Example;

  Components.FixedTransferEfficiency transfer annotation(Placement(transformation(extent={{-8,-8},{8,8}})));
  Modelica.Blocks.Sources.SawTooth sawTooth(
    amplitude=1e6,
    period=0.3,
    offset=-0.3e6,
    startTime=0.2) annotation(Placement(transformation(extent={{-60,-10},{-40,10}})));
  Components.FixedTransferEfficiency transfer1(outputDissipation=true) annotation(Placement(transformation(extent={{-8,-28},{8,-12}})));
  Components.FixedTransferEfficiency transfer2(eta=0,    outputDissipation=true) annotation(Placement(transformation(extent={{-8,-48},{8,-32}})));
  Modelica.Blocks.Sources.SawTooth sawTooth1(
    amplitude=1e6,
    period=0.3,
    offset=0,
    startTime=0.2) annotation(Placement(transformation(extent={{-60,-50},{-40,-30}})));

equation
  connect(sawTooth.y, transfer.E_flow_in) annotation(Line(points={{-39,0},{-9.6,0}}, color={0,0,127}));
  connect(transfer1.E_flow_in, sawTooth.y) annotation(Line(points={{-9.6,-20},{-20,-20},{-20,0},{-39,0}}, color={255,170,85}));
  connect(sawTooth1.y, transfer2.E_flow_in) annotation(Line(points={{-39,-40},{-9.6,-40}}, color={0,0,127}));

  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Documentation(
      info="<html>
  <p>
    Test model for the <a href=\"modelica://ThermofluidStream.Idealized.EnergyFlow.Components.FixedTransferEfficiency\">EnergyFlow.Components.FixedTransferEfficiency</a> model.
  </p>
</html>",
    revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end FixedTransferEfficiency;
