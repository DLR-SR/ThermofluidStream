within ThermofluidStream.Idealized.Tests.Volume;
model Reservoir
  extends Modelica.Icons.Example;
  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium" annotation(
      choicesAllMatching=true);

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=200000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-80,-10},{-60,10}})));
  ThermofluidStream.Boundaries.Reservoir reservoir(
    redeclare package Medium = Medium,
    useOutlet=false,
    T_start=293.15,
    enableFreeInlet=true,
    height_0(displayUnit="m") = 1) annotation(Placement(transformation(extent={{20,-10},{40,10}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(Placement(transformation(extent={{80,80},{100,100}})));
  ThermofluidStream.Idealized.Processes.Isenthalpic isenthalpic(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isenthalpic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-50,-10},{-30,10}})));
  ThermofluidStream.Idealized.Boundaries.MassFlowRate massFlowRate(redeclare package Medium = Medium, m_flow_fixed=1) annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Sources.RealExpression reservoirPressure(y=reservoir.medium.p) annotation(Placement(transformation(extent={{-60,-40},{-40,-20}})));

equation
  connect(source.outlet, isenthalpic.inlet) annotation(Line(
      points={{-60,0},{-50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(reservoir.inlet, massFlowRate.outlet) annotation(Line(
      points={{20,0},{0,0}},
      color={28,108,200},
      thickness=0.5));
  connect(isenthalpic.outlet, massFlowRate.inlet) annotation(Line(
      points={{-30,0},{-20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(reservoirPressure.y, isenthalpic.outletSpec_prescribed) annotation(Line(points={{-39,-30},{-30,-30},{-30,-12}}, color={0,0,127}));

  annotation(
    experiment(
      StopTime=100,
      Interval=0.1,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Documentation(
      info="<html> 
  <p> 
    This model represents a continuously filled reservoir. 
    At some point, the system may become non-physical, as the valve would need to raise the pressure, which is indicated by a warning. 
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
end Reservoir;
