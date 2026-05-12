within ThermofluidStream.Idealized.Examples.ClausiusRankine;
model Step2SaturatedVapor
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
                                                                              constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));

  Processes.Adiabatic pump(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    eta_fixed=0.6,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,
    outletValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Processes.Adiabatic turbine(
    redeclare package Medium = Medium,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,
    p_out_fixed=100000) annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Processes.Isobaric preheaterAndBoiler(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Idealized.Utilities.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  ThermofluidStream.Boundaries.Source waterSource(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  ThermofluidStream.Boundaries.Sink waterSink(redeclare package Medium = Medium, p0_par=90000)
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k2=
            0.1e5),
    l=10,
    r=1) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="efficiency",
    use_numberPort=false,
    number=(-turbine.P - pump.P)/(preheaterAndBoiler.Q_flow + Modelica.Constants.eps),
    displayVariable=false) annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Sources.Ramp outletPressure(
    height=99e5,
    duration=1,
    offset=1e5) annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.RealExpression h_dew(y=Medium.dewEnthalpy(Medium.setSat_p(outletPressure.y))) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-30})));
equation
  connect(pump.outlet, preheaterAndBoiler.inlet) annotation (Line(
      points={{-30,0},{-20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(preheaterAndBoiler.outlet, turbine.inlet) annotation (Line(
      points={{0,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(waterSource.outlet, pump.inlet)
    annotation (Line(
      points={{-60,0},{-50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(waterSink.inlet, flowResistance.outlet)
    annotation (Line(
      points={{70,0},{60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine.outlet, flowResistance.inlet)
    annotation (Line(
      points={{30,0},{40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(outletPressure.y, pump.outletSpec_prescribed) annotation (Line(points={{-39,-30},{-30,-30},{-30,-12}}, color={0,0,127}));
  connect(h_dew.y, preheaterAndBoiler.outletSpec_prescribed) annotation (Line(points={{0,-19},{0,-12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false),
        graphics={
        Text(
          extent={{-58,6},{-52,0}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-28,6},{-22,0}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{2,6},{8,0}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{32,6},{38,0}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{62,6},{68,0}},
          textColor={28,108,200},
          textString="5")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    In the second step it is shown how saturated vapor state can be set and the pump pressure is varied lineraly with time.
  </p>

  <p>
    Further documentation is available in the 
    <a href=\"modelica://ThermoFluidStream.Idealized.Examples.ClausiusRankine\">ClausiusRankine</a> package.
  </p>
</html>"));
end Step2SaturatedVapor;
