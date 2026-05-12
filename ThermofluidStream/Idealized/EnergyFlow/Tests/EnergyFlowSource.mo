within ThermofluidStream.Idealized.EnergyFlow.Tests;
model EnergyFlowSource
  extends Modelica.Icons.Example;
  Sources.FixedEnergyFlow energyFlowSource(E_flow(displayUnit="MW") = 1000000) annotation(Placement(transformation(extent={{-20,20},{0,40}})));
  Sources.PrescribedEnergyFlow energyFlowSource1 annotation(Placement(transformation(extent={{-20,-30},{0,-10}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=1e6,
    f=1,
    offset=0)   annotation(Placement(transformation(extent={{-80,-30},{-60,-10}})));
  Modelica.Blocks.Math.Gain gain(k=3) annotation(Placement(transformation(extent={{20,-30},{40,-10}})));
  Sources.FixedEnergyFlow energyFlowSource2(E_flow(displayUnit="MW") = -1000000)
                                                                               annotation(Placement(transformation(extent={{20,20},{40,40}})));
  Sources.FixedEnergyFlow energyFlowSource3(E_flow=0)                          annotation(Placement(transformation(extent={{-60,20},{-40,40}})));
equation
  connect(sine.y, energyFlowSource1.E_flow) annotation(Line(points={{-59,-20},{-22,-20}}, color={0,0,127}));
  connect(energyFlowSource1.E_flow_out, gain.u) annotation(Line(points={{1,-20},{18,-20}}, color={255,170,85}));
  annotation(Documentation(info="<html>
  <p>
    Test model for energy flow <code>Sources</code>.
  </p>
</html>"));
end EnergyFlowSource;
