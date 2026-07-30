within ThermofluidStream.Idealized.EnergyFlow.Tests;
model Sum
  extends Modelica.Icons.Example;

  Sources.FixedEnergyFlow energyFlowSource(E_flow(displayUnit="MW") = 0) annotation(
    Placement(transformation(extent={{-40,80},{-20,100}})));
  Components.Sum sum1(n_in=2) annotation(
    Placement(transformation(extent={{20,80},{40,100}})));
  Sources.FixedEnergyFlow energyFlowSource1(E_flow(displayUnit="MW") = 0) annotation(
    Placement(transformation(extent={{-40,60},{-20,80}})));
  Sources.FixedEnergyFlow energyFlowSource2(E_flow(displayUnit="MW") = 0) annotation(
    Placement(transformation(extent={{-40,20},{-20,40}})));
  Components.Sum sum2(n_in=2) annotation(
    Placement(transformation(extent={{20,20},{40,40}})));
  Sources.PrescribedEnergyFlow energyFlowSource4 annotation(
    Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.Constant const(k=0) annotation(
    Placement(transformation(extent={{-80,0},{-60,20}})));
  Sources.FixedEnergyFlow energyFlowSource3(E_flow(displayUnit="MW") = 0) annotation(
    Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Components.Sum sum3(n_in=2) annotation(
    Placement(transformation(extent={{20,-40},{40,-20}})));
  Sources.PrescribedEnergyFlow energyFlowSource5 annotation(
    Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Blocks.Sources.Sine sine(f=1, startTime=1/3) annotation(
    Placement(transformation(extent={{-80,-60},{-60,-40}})));

equation
  connect(energyFlowSource.E_flow_out, sum1.E_flow_in[1]) annotation(
    Line(points={{-19,90},{20,90},{20,88.5}}, color={255,170,85}));
  connect(energyFlowSource1.E_flow_out, sum1.E_flow_in[2]) annotation(
    Line(points={{-19,70},{6,70},{6,91.5},{20,91.5}}, color={255,170,85}));
  connect(energyFlowSource2.E_flow_out, sum2.E_flow_in[1]) annotation(
    Line(points={{-19,30},{20,30},{20,28.5}}, color={255,170,85}));
  connect(const.y, energyFlowSource4.E_flow) annotation(
    Line(points={{-59,10},{-42,10}}, color={0,0,127}));
  connect(energyFlowSource4.E_flow_out, sum2.E_flow_in[2]) annotation(
    Line(points={{-19,10},{20,10},{20,31.5}}, color={255,170,85}));
  connect(energyFlowSource3.E_flow_out, sum3.E_flow_in[1]) annotation(
    Line(points={{-19,-30},{20,-30},{20,-31.5}}, color={255,170,85}));
  connect(sine.y, energyFlowSource5.E_flow) annotation(
    Line(points={{-59,-50},{-42,-50}}, color={0,0,127}));
  connect(energyFlowSource5.E_flow_out, sum3.E_flow_in[2]) annotation(
    Line(points={{-19,-50},{20,-50},{20,-28.5}}, color={255,170,85}));

  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Documentation(
      info="<html>
  <p>
    Test model for the <a href=\"modelica://ThermofluidStream.Idealized.EnergyFlow.Components.Sum\">EnergyFlow.Components.Sum</a> model.
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
end Sum;
