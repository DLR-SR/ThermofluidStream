within ThermofluidStream.Idealized.Examples.CombinedCycle;
model Step1Simple
  extends Modelica.Icons.Example;

  replaceable package Water = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
                                                                              constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);
  replaceable package Air = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{180,80},{200,100}})));

  ThermofluidStream.Idealized.Processes.Adiabatic pump(
    redeclare package Medium = Water,
    eta_fixed=0.6,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,

    p_out_fixed=10000000) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={30,-40})));
  ThermofluidStream.Idealized.Processes.Adiabatic turbineCR(
    redeclare package Medium = Water,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,
    p_out_fixed=10000) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={130,0})));
  ThermofluidStream.Idealized.Processes.Isobaric heatExchangerWaterSide(
    redeclare package Medium = Water,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Output,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,

    T_out_fixed=633.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={12,0})));
  LoopBreaker_m loopBreaker(
    redeclare package Medium = Water,
    m_flow_in_par=1,
    p_out_fixed=10000,
    T_out_fixed=293.15) annotation (Placement(transformation(extent={{90,-50},{70,-30}})));
  ThermofluidStream.Idealized.Processes.Isobaric condenser(
    redeclare package Medium = Water,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,

    T_out_fixed=293.15) annotation (Placement(transformation(extent={{120,-50},{100,-30}})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="efficiency",
    use_numberPort=false,
    number=(-turbineCR.P - turbineJB.P - pump.P - compressor.P)/(combustion.Q_flow + Modelica.Constants.eps),
    displayVariable=false) annotation (Placement(transformation(extent={{0,60},{20,80}})));
  ThermofluidStream.Idealized.Processes.Adiabatic compressor(
    redeclare package Medium = Air,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,

    p_out_fixed=2000000) annotation (Placement(transformation(extent={{-140,30},{-120,50}})));
  ThermofluidStream.Idealized.Processes.Adiabatic turbineJB(
    redeclare package Medium = Air,
    eta_fixed=0.8,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Adiabatic.OutletPressure,
    p_out_fixed=100000) annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  ThermofluidStream.Boundaries.Source
                    airSource(
    redeclare package Medium = Air,
    p0_par=100000,
    T0_par=293.15) annotation (Placement(transformation(extent={{-180,30},{-160,50}})));
  ThermofluidStream.Idealized.Processes.Isobaric combustion(
    redeclare package Medium = Air,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Flow.Isobaric.OutletTemperature,

    T_out_fixed=1673.15) annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  Sink_m airSink(redeclare package Medium = Air, m_flow_fixed=10) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-30,-30})));
  ThermofluidStream.Idealized.Processes.Isobaric heatExchangerAirSide(
    redeclare package Medium = Air,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-30,0})));
equation
  connect(loopBreaker.inlet, condenser.outlet) annotation (Line(
      points={{90,-40},{100,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.inlet, loopBreaker.outlet)
    annotation (Line(
      points={{40,-40},{70,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.outlet, heatExchangerWaterSide.inlet)
    annotation (Line(
      points={{20,-40},{12,-40},{12,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(turbineCR.outlet, condenser.inlet) annotation (Line(
      points={{130,-10},{130,-40},{120,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerWaterSide.outlet, turbineCR.inlet)
    annotation (Line(
      points={{12,10},{12,30},{130,30},{130,10}},
      color={28,108,200},
      thickness=0.5));
  connect(compressor.outlet, combustion.inlet) annotation (Line(
      points={{-120,40},{-100,40}},
      color={28,108,200},
      thickness=0.5));
  connect(combustion.outlet, turbineJB.inlet)
    annotation (Line(
      points={{-80,40},{-60,40}},
      color={28,108,200},
      thickness=0.5));
  connect(airSource.outlet, compressor.inlet) annotation (Line(
      points={{-160,40},{-140,40}},
      color={28,108,200},
      thickness=0.5));
  connect(turbineJB.outlet, heatExchangerAirSide.inlet)
    annotation (Line(
      points={{-40,40},{-30,40},{-30,10}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerAirSide.outlet,airSink. inlet)
    annotation (Line(
      points={{-30,-10},{-30,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(heatExchangerWaterSide.Q_flow_out, heatExchangerAirSide.Q_flow_in) annotation (Line(points={{5,0},{-22,0}}, color={255,170,85}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-100},{200,100}}), graphics={
        Text(
          extent={{-154,46},{-148,40}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-114,46},{-108,40}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-74,46},{-68,40}},
          textColor={28,108,200},
          textString="3"),
        Text(
          extent={{-36,46},{-30,40}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{-30,-12},{-24,-18}},
          textColor={28,108,200},
          textString="5"),
        Text(
          extent={{54,-34},{60,-40}},
          textColor={28,108,200},
          textString="6"),
        Text(
          extent={{12,-34},{18,-40}},
          textColor={28,108,200},
          textString="7"),
        Text(
          extent={{12,30},{18,24}},
          textColor={28,108,200},
          textString="8"),
        Text(
          extent={{124,30},{130,24}},
          textColor={28,108,200},
          textString="8"),
        Text(
          extent={{124,-34},{130,-40}},
          textColor={28,108,200},
          textString="9")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    In a first step a simple combined cycle is built.<br>
  </p>

  <p>
    The overall efficiency is increasing with pressure.
  </p>

  <p>
    Further documentation is available in the 
    <a href=\"modelica://ThermoFluidStream.Idealized.Examples.CombinedCycle\">CombinedCycle</a> package.
  </p>
</html>

"));
end Step1Simple;
