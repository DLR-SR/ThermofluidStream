within ThermofluidStream.Idealized.Examples.ClausiusRankine;
model Step1OpenLoop
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation(choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(
     displayInstanceNames=true, displayParameters=true)
    annotation(Placement(transformation(extent={{80,80},{100,100}})));

  Processes.Adiabatic pump(
    redeclare package Medium = Medium,
    eta_fixed=0.6,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=300000) annotation(Placement(transformation(extent={{-50,-10},{-30,10}})));
  Processes.Adiabatic turbine(
    redeclare package Medium = Medium,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=100000) annotation(Placement(transformation(extent={{10,-10},{30,10}})));
  Processes.Isobaric steamGenerator(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    T_out_fixed=423.15) annotation(Placement(transformation(extent={{-20,-10},{0,10}})));
  ThermofluidStream.Boundaries.Source waterSource(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15) annotation(Placement(transformation(extent={{-80,-10},{-60,10}})));
  ThermofluidStream.Boundaries.Sink waterSink(redeclare package Medium = Medium, p0_par=90000)
    annotation(Placement(transformation(extent={{70,-10},{90,10}})));
  ThermofluidStream.Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k2=
            0.1e5),
    l=10,
    r=1) annotation(Placement(transformation(extent={{40,-10},{60,10}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="efficiency",
    use_numberPort=false,
    number=(-turbine.P - pump.P)/(steamGenerator.Q_flow + Modelica.Constants.eps),
    displayVariable=false) annotation(Placement(transformation(extent={{0,40},{20,60}})));
equation
  connect(pump.outlet, steamGenerator.inlet) annotation(Line(
      points={{-30,0},{-20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(steamGenerator.outlet, turbine.inlet) annotation(Line(
      points={{0,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(waterSource.outlet, pump.inlet)
    annotation(Line(
      points={{-60,0},{-50,0}},
      color={28,108,200},
      thickness=0.5));
  connect(waterSink.inlet, flowResistance.outlet)
    annotation(Line(
      points={{70,0},{60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine.outlet, flowResistance.inlet)
    annotation(Line(
      points={{30,0},{40,0}},
      color={28,108,200},
      thickness=0.5));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false),
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
    In the first step an artificial <code>flowResistance</code> of 
    <code>dp = 0.1 bar * m_flow^2/(kg/s)^2</code> is used to obtain a steady state mass flow rate of <code>1 kg/s</code> due to the 
    pressure difference of <code>0.1 bar</code> between <code>turbine</code> and <code>sink</code>. (TFS library trick).
  </p>

  <p>
    Further documentation is available in the 
    <a href=\"modelica://ThermoFluidStream.Idealized.Examples.ClausiusRankine\">ClausiusRankine</a> package.
  </p>
</html>"));
end Step1OpenLoop;
