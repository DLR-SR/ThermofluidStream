within ThermofluidStream.Idealized.Tests.Processes.Isobaric;
model Warnings2 "Example - Isobaric process"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model" annotation(
    choicesAllMatching=true);
  parameter Medium.AbsolutePressure p=200000 "Pressure (inlet = outlet)";
  parameter Medium.Temperature T_in=293.15 "Inlet temperature";
  SI.TemperatureDifference dT=temperatureDifference.y "Temperature difference";
  parameter SI.AbsolutePressure p_inf=100000 "Ambient pressure";

  Medium.Temperature T_out = T_in + dT "Outlet temperature";

  Medium.ThermodynamicState state_in = Medium.setState_pTX(p, T_in, Medium.X_default) "Inlet state";
  Medium.ThermodynamicState state_out = Medium.setState_pTX(p, T_out, Medium.X_default) "Outlet state";

  Medium.SpecificEnthalpy h_in = Medium.specificEnthalpy(state_in) "Inlet specific enthalpy";
  Medium.SpecificEnthalpy h_out = Medium.specificEnthalpy(state_out) "Outlet specific enthalpy";
  Medium.SpecificEnthalpy dh = h_out - h_in "Specific enthalpy difference";

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in) annotation (Placement(transformation(extent={{-190,20},{-170,40}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-130,20},{-110,40}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT1(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf)       annotation(Placement(transformation(extent={{-160,20},{-140,40}})));
  EnergyFlow.Sources.PrescribedEnergyFlow
                                     energyFlowSource                annotation(Placement(transformation(extent={{-190,-10},{-170,10}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{-90,20},{-70,40}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink1(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  ThermofluidStream.Idealized.Processes.Isobaric T_out1(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf)       annotation(Placement(transformation(extent={{-60,20},{-40,40}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{10,20},{30,40}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink2(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{70,20},{90,40}})));
  ThermofluidStream.Idealized.Processes.Isobaric dh1(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.SpecificEnthalpyDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf)       annotation(Placement(transformation(extent={{40,20},{60,40}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in)  annotation(Placement(transformation(extent={{110,20},{130,40}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink3(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{170,20},{190,40}})));
  ThermofluidStream.Idealized.Processes.Isobaric h_out1(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Flow,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf)       annotation(Placement(transformation(extent={{140,20},{160,40}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in) annotation (Placement(transformation(extent={{-190,-50},{-170,-30}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink4(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-130,-50},{-110,-30}})));
  ThermofluidStream.Idealized.Processes.Isobaric dT1c(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf)       annotation(Placement(transformation(extent={{-160,-30},{-140,-50}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in) annotation (Placement(transformation(extent={{-90,-50},{-70,-30}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink5(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
  ThermofluidStream.Idealized.Processes.Isobaric T_out1c(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf)       annotation(Placement(transformation(extent={{-60,-30},{-40,-50}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in) annotation (Placement(transformation(extent={{10,-50},{30,-30}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink6(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{70,-50},{90,-30}})));
  ThermofluidStream.Idealized.Processes.Isobaric dh1c(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.SpecificEnthalpyDifference,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf)       annotation(Placement(transformation(extent={{40,-30},{60,-50}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    p0_par=p,
    T0_par=T_in) annotation (Placement(transformation(extent={{110,-50},{130,-30}})));
  ThermofluidStream.Idealized.Boundaries.Sink_free sink7(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{170,-50},{190,-30}})));
  ThermofluidStream.Idealized.Processes.Isobaric h_out1c(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    systemSpec=ThermofluidStream.Idealized.Types.SystemModel.Cycle,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    p_inf=p_inf)       annotation(Placement(transformation(extent={{140,-30},{160,-50}})));

  Modelica.Blocks.Sources.Trapezoid temperatureDifference(
    amplitude=20,
    rising=0.01,
    falling=0.01,
    period=1,
    offset=0,
    startTime=0.5) annotation (Placement(transformation(extent={{-222,30},{-202,50}})));
  Modelica.Blocks.Sources.Trapezoid heatFlowRate(
    amplitude=1e3,
    rising=0.01,
    falling=0.01,
    period=1,
    startTime=0.25) annotation (Placement(transformation(extent={{-220,-10},{-200,10}})));
  Modelica.Blocks.Sources.RealExpression outletTempature(y=T_out)
                                                                 annotation (Placement(transformation(extent={{-10,-20},{-30,0}})));
  Modelica.Blocks.Sources.RealExpression specificEnthalpyDifference(y=dh) annotation (Placement(transformation(extent={{90,-20},{70,0}})));
  Modelica.Blocks.Sources.RealExpression outletSpecificEnthalpy(y=h_out) annotation (Placement(transformation(extent={{190,-20},{170,0}})));
  inner DropOfCommons                   dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{220,80},{240,100}})));
equation
  connect(source.outlet, dT1.inlet) annotation (Line(
      points={{-170,30},{-160,30}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1.outlet, sink.inlet) annotation (Line(
      points={{-140,30},{-130,30}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out,dT1. Q_flow_in) annotation(Line(points={{-169,0},{-150,0},{-150,22}},     color={255,170,85}));
  connect(source1.outlet,T_out1. inlet) annotation(Line(
      points={{-70,30},{-60,30}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out1.outlet,sink1. inlet) annotation(Line(
      points={{-40,30},{-30,30}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out,T_out1. Q_flow_in) annotation(Line(points={{-169,0},{-50,0},{-50,22}},       color={255,170,85}));
  connect(source2.outlet,dh1. inlet) annotation(Line(
      points={{30,30},{40,30}},
      color={28,108,200},
      thickness=0.5));
  connect(dh1.outlet,sink2. inlet) annotation(Line(
      points={{60,30},{70,30}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out,dh1. Q_flow_in) annotation(Line(points={{-169,0},{50,0},{50,22}},         color={255,170,85}));
  connect(source3.outlet,h_out1. inlet) annotation(Line(
      points={{130,30},{140,30}},
      color={28,108,200},
      thickness=0.5));
  connect(h_out1.outlet,sink3. inlet) annotation(Line(
      points={{160,30},{170,30}},
      color={28,108,200},
      thickness=0.5));
  connect(energyFlowSource.E_flow_out,h_out1. Q_flow_in) annotation(Line(points={{-169,0},{150,0},{150,22}},     color={255,170,85}));
  connect(source4.outlet, dT1c.inlet) annotation (Line(
      points={{-170,-40},{-160,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(dT1c.outlet, sink4.inlet) annotation (Line(
      points={{-140,-40},{-130,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(source5.outlet, T_out1c.inlet) annotation (Line(
      points={{-70,-40},{-60,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out1c.outlet, sink5.inlet) annotation (Line(
      points={{-40,-40},{-30,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, dh1c.inlet) annotation (Line(
      points={{30,-40},{40,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(dh1c.outlet, sink6.inlet) annotation (Line(
      points={{60,-40},{70,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(source7.outlet, h_out1c.inlet) annotation (Line(
      points={{130,-40},{140,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(h_out1c.outlet, sink7.inlet) annotation (Line(
      points={{160,-40},{170,-40}},
      color={28,108,200},
      thickness=0.5));

  connect(dT1c.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{-150,-32},{-150,0},{-169,0}}, color={255,170,85}));
  connect(T_out1c.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{-50,-32},{-50,0},{-169,0}}, color={255,170,85}));
  connect(dh1c.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{50,-32},{50,0},{-169,0}}, color={255,170,85}));
  connect(h_out1c.Q_flow_in, energyFlowSource.E_flow_out) annotation (Line(points={{150,-32},{150,0},{-169,0}}, color={255,170,85}));
  connect(outletTempature.y, T_out1c.outletSpec_prescribed) annotation (Line(points={{-31,-10},{-40,-10},{-40,-28}}, color={0,0,127}));
  connect(outletTempature.y, T_out1.outletSpec_prescribed) annotation (Line(points={{-31,-10},{-40,-10},{-40,18}}, color={0,0,127}));
  connect(specificEnthalpyDifference.y, dh1c.outletSpec_prescribed) annotation (Line(points={{69,-10},{60,-10},{60,-28}}, color={0,0,127}));
  connect(specificEnthalpyDifference.y, dh1.outletSpec_prescribed) annotation (Line(points={{69,-10},{60,-10},{60,18}}, color={0,0,127}));
  connect(outletSpecificEnthalpy.y, h_out1c.outletSpec_prescribed) annotation (Line(points={{169,-10},{160,-10},{160,-28}}, color={0,0,127}));
  connect(outletSpecificEnthalpy.y, h_out1.outletSpec_prescribed) annotation (Line(points={{169,-10},{160,-10},{160,18}}, color={0,0,127}));
  connect(heatFlowRate.y, energyFlowSource.E_flow) annotation (Line(points={{-199,0},{-192,0}}, color={0,0,127}));
  connect(dT1.outletSpec_prescribed, temperatureDifference.y) annotation (Line(points={{-140,18},{-140,12},{-110,12},{-110,48},{-190,48},{-190,40},{-201,40}}, color={0,0,127}));
  connect(dT1c.outletSpec_prescribed, temperatureDifference.y) annotation (Line(points={{-140,-28},{-140,12},{-110,12},{-110,48},{-190,48},{-190,40},{-201,40}}, color={0,0,127}));
  annotation(
    experiment(
      StopTime=1,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(
        extent={{-240,-100},{240,100}}), graphics={
        Text(
          extent={{-236,74},{-184,60}},
          textColor={238,46,47},
          textString="Independent inputs"),
        Rectangle(
          extent={{-228,58},{-196,-18}},
          lineColor={238,46,47})}),
    Documentation(
      revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>",
      info="<html>
  <p>
    This example checks if warnings are issued correctly in the case of outlet state and heat flow rate given.
  </p>
</html>"));
end Warnings2;
