within ThermofluidStream.Undirected.Boundaries.Tests;
model TestVolumes "Test for undirected Volumes"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.SimpleAir constrainedby
    Media.myMedia.Interfaces.PartialMedium "Medium package"
    annotation (Documentation(info="<html>
<p>
Medium package used in the Test.
</p>
</html>"));

  package MediumMix = Media.myMedia.IdealGases.MixtureGases.CombustionAir "Medium package"
      annotation (Documentation(info="<html>
        <p>Medium package used in the Test of the MixVolumes. </p>
        </html>"));

  inner DropOfCommons dropOfCommons
    annotation (Placement(transformation(extent={{140,-12},{160,8}})));
  VolumeFlex flexVolume1(
    redeclare package Medium = Medium,
    p_start=100000,
    T_start=293.15,
    V_ref(displayUnit="m3") = 1,
    rear(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
  Volume volume(
    redeclare package Medium = Medium,
    p_start=150000,
    T_start=313.15,
    rear(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-130,-30},{-110,-10}})));
  Volume heatportVolume(
    redeclare package Medium = Medium,
    useHeatport=true,
    V_par=1,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200)
    annotation (Placement(transformation(extent={{-110,-60},{-90,-40}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T(displayUnit="K") = 500)
    annotation (Placement(transformation(extent={{-146,-90},{-126,-70}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.01,
    l=10,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.wood))
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.01,
    l=10,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.wood))
    annotation (Placement(transformation(extent={{-140,-60},{-120,-40}})));
  ThermofluidStream.Boundaries.Source
         source(redeclare package Medium = Medium, p0_par=200000)
    annotation (Placement(transformation(extent={{-176,60},{-156,80}})));
  ThermofluidStream.Boundaries.Sink
       sink(redeclare package Medium = Medium,
    p0_par=100000,
    inlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-44,60},{-24,80}})));
  ThermofluidStream.Boundaries.VolumeFlex
             flexVolume2(
    redeclare package Medium = Medium,
    p_start=100000,
    T_start=293.15,
    V_ref(displayUnit="m3") = 1,
    inlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
  ThermofluidStream.Boundaries.Volume
         volume1(
    redeclare package Medium = Medium,
    p_start=150000,
    T_start=313.15,
    inlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-130,60},{-110,80}})));
  ThermofluidStream.Boundaries.Source
         source1(redeclare package Medium = Medium, p0_par=200000)
    annotation (Placement(transformation(extent={{-176,30},{-156,50}})));
  ThermofluidStream.Boundaries.Sink
       sink1(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{-44,30},{-24,50}})));
  ThermofluidStream.Boundaries.Volume
         heatportVolume1(
    redeclare package Medium = Medium,
    useHeatport=true,
    V_par=1,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200)
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T(displayUnit="K") = 500)
    annotation (Placement(transformation(extent={{-148,0},{-128,20}})));
  ThermofluidStream.Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.01,
    l=10,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.wood))
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  ThermofluidStream.Processes.FlowResistance flowResistance3(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.01,
    l=10,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.wood))
    annotation (Placement(transformation(extent={{-140,30},{-120,50}})));
  BoundaryFore boundary_fore(redeclare package Medium = Medium, p0_par=100000) annotation (Placement(transformation(extent={{-44,-60},{-24,-40}})));
  BoundaryFore boundary_fore1(redeclare package Medium = Medium,
    p0_par=100000,
    rear(m_flow(start=0, fixed=true))) annotation (Placement(transformation(extent={{-44,-30},{-24,-10}})));
  BoundaryRear boundary_rear(redeclare package Medium = Medium, p0_par=200000) annotation (Placement(transformation(extent={{-176,-30},{-156,-10}})));
  BoundaryRear boundary_rear1(redeclare package Medium = Medium, p0_par=200000) annotation (Placement(transformation(extent={{-176,-60},{-156,-40}})));
  ThermofluidStream.Boundaries.VolumeMix volumeMix1(
    redeclare package Medium = MediumMix,
    N=2,
    Xi_0={0.1337,1 - 0.1337},
    V_par(displayUnit="l") = 0.1)
    annotation (Placement(transformation(extent={{88,40},{108,60}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = MediumMix,
    p0_par=200000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{10,60},{30,80}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = MediumMix,
    p0_par=200000,
    Xi0_par={0,1})
    annotation (Placement(transformation(extent={{10,20},{30,40}})));
  ThermofluidStream.Boundaries.Sink sink3(
    redeclare package Medium = MediumMix,
    p0_par=100000)
    annotation (Placement(transformation(extent={{142,40},{162,60}})));
  ThermofluidStream.Processes.FlowResistance flowResistance5(
    redeclare package Medium = MediumMix,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e5))
    annotation (Placement(transformation(extent={{46,60},{66,80}})));
  ThermofluidStream.Processes.FlowResistance flowResistance6(
    redeclare package Medium = MediumMix,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=2e5))
    annotation (Placement(transformation(extent={{46,20},{66,40}})));
  VolumeMix volumeMix2(
    redeclare package Medium = MediumMix,
    N_rear=3,
    N_fore=0,
    Xi_0={0.1337,1 - 0.1337},
    V_par(displayUnit="l") = 0.1)
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  BoundaryRear boundary_rear2(
    redeclare package Medium = MediumMix,
    p0_par=200000,
    Xi0_par={1,0}) annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  BoundaryRear boundary_rear3(
    redeclare package Medium = MediumMix,
    p0_par=200000,
    Xi0_par={0,1}) annotation (Placement(transformation(extent={{10,-70},{30,-50}})));
  BoundaryRear boundary_rear4(redeclare package Medium = MediumMix, p0_par=100000)
    annotation (Placement(transformation(extent={{160,-80},{140,-60}})));
  Processes.FlowResistance flowResistance4(
    redeclare package Medium = MediumMix,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e5))
    annotation (Placement(transformation(extent={{46,-30},{66,-10}})));
  Processes.FlowResistance flowResistance7(
    redeclare package Medium = MediumMix,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=2e5))
    annotation (Placement(transformation(extent={{46,-70},{66,-50}})));
  ThermofluidStream.Processes.FlowResistance flowResistance8(
    redeclare package Medium = MediumMix,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e3))
    annotation (Placement(transformation(extent={{116,40},{136,60}})));
  Processes.FlowResistance flowResistance9(
    redeclare package Medium = MediumMix,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e3))
    annotation (Placement(transformation(extent={{120,-80},{100,-60}})));
  Volume heatportVolume2(
    redeclare package Medium = Medium,
    useHeatport=true,
    useRear=false,
    V_par=1,
    p_start=150000,
    T_start=313.15,
    A=1,
    U=200)
    annotation (Placement(transformation(extent={{-110,-100},{-90,-120}})));
  Processes.FlowResistance flowResistance10(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.05,
    l=10,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.wood))
    annotation (Placement(transformation(extent={{-80,-120},{-60,-100}})));
  BoundaryFore boundary_fore2(redeclare package Medium = Medium, p0_par=100000) annotation (Placement(transformation(extent={{-44,-120},{-24,-100}})));
  Processes.FlowResistance flowResistance11(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss = ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.wood))
    annotation (Placement(transformation(extent={{40,-120},{60,-100}})));
  BoundaryRear boundary_rear5(redeclare package Medium = Medium, p0_par=200000) annotation (Placement(transformation(extent={{10,-120},{30,-100}})));
  Volume heatportVolume3(
    redeclare package Medium = Medium,
    useHeatport=false,
    useFore=false,
    k_volume_damping=0,
    V_par=1,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200)
    annotation (Placement(transformation(extent={{70,-120},{90,-100}})));
equation
  connect(fixedTemperature.port,heatportVolume. heatPort)
    annotation (Line(points={{-126,-80},{-100,-80},{-100,-58}},
        color={191,0,0}));
  connect(volume1.inlet, source.outlet) annotation (Line(
      points={{-130,70},{-156,70}},
      color={28,108,200},
      thickness=0.5));
  connect(volume1.outlet, flexVolume2.inlet) annotation (Line(
      points={{-110,70},{-90,70}},
      color={28,108,200},
      thickness=0.5));
  connect(flexVolume2.outlet,sink. inlet) annotation (Line(
      points={{-70,70},{-44,70}},
      color={28,108,200},
      thickness=0.5));
  connect(fixedTemperature1.port, heatportVolume1.heatPort) annotation (Line(points={{-128,10},{-100,10},{-100,32}},
                                                                                                            color={191,0,0}));
  connect(heatportVolume1.outlet, flowResistance2.inlet) annotation (Line(
      points={{-90,40},{-80,40}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, sink1.inlet) annotation (Line(
      points={{-60,40},{-44,40}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.inlet,source1. outlet) annotation (Line(
      points={{-140,40},{-156,40}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.outlet, heatportVolume1.inlet) annotation (Line(
      points={{-120,40},{-110,40}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore.rear, flowResistance.fore) annotation (Line(
      points={{-44,-50},{-60,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(heatportVolume.fore, flowResistance.rear) annotation (Line(
      points={{-90,-50},{-80,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(heatportVolume.rear, flowResistance1.fore) annotation (Line(
      points={{-110,-50},{-120,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear1.fore, flowResistance1.rear) annotation (Line(
      points={{-156,-50},{-140,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear.fore, volume.rear) annotation (Line(
      points={{-156,-20},{-130,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flexVolume1.rear, volume.fore) annotation (Line(
      points={{-90,-20},{-110,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_fore1.rear, flexVolume1.fore) annotation (Line(
      points={{-44,-20},{-70,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet,flowResistance5. inlet) annotation (Line(
      points={{30,70},{46,70}},
      color={28,108,200},
      thickness=0.5));
  connect(source5.outlet,flowResistance6. inlet) annotation (Line(
      points={{30,30},{46,30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance6.outlet, volumeMix1.inlet[1]) annotation (Line(
      points={{66,30},{70,30},{70,49.5},{88,49.5}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance5.outlet, volumeMix1.inlet[2]) annotation (Line(
      points={{66,70},{70,70},{70,50.5},{88,50.5}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance7.rear, boundary_rear3.fore) annotation (Line(
      points={{46,-60},{30,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.rear, boundary_rear2.fore) annotation (Line(
      points={{46,-20},{30,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance7.fore, volumeMix2.rear[2]) annotation (Line(
      points={{66,-60},{74,-60},{74,-40},{90,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.fore, volumeMix2.rear[3]) annotation (Line(
      points={{66,-20},{80,-20},{80,-39.3333},{90,-39.3333}},
      color={28,108,200},
      thickness=0.5));
  connect(volumeMix1.outlet, flowResistance8.inlet) annotation (Line(
      points={{108,50},{116,50}},
      color={28,108,200},
      thickness=0.5));
  connect(sink3.inlet, flowResistance8.outlet) annotation (Line(
      points={{142,50},{136,50}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear4.fore, flowResistance9.rear) annotation (Line(
      points={{140,-70},{120,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance9.fore, volumeMix2.rear[1]) annotation (Line(
      points={{100,-70},{90,-70},{90,-40.6667},{90,-40.6667}},
      color={28,108,200},
      thickness=0.5));
  connect(heatportVolume2.fore, flowResistance10.rear)
    annotation (Line(
      points={{-90,-110},{-80,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance10.fore, boundary_fore2.rear)
    annotation (Line(
      points={{-60,-110},{-44,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(boundary_rear5.fore, flowResistance11.rear) annotation (Line(
      points={{30,-110},{40,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance11.fore, heatportVolume3.rear)
    annotation (Line(
      points={{60,-110},{70,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(heatportVolume2.heatPort, heatportVolume.heatPort) annotation (Line(points={{-100,-102},{-100,-58}}, color={191,0,0}));
  annotation (
  experiment(StopTime=1, Tolerance=1e-6, Interval=0.001, __Dymola_Algorithm="Dassl"),
  Documentation(info="<html>
<p>Test&nbsp;for&nbsp;undirected&nbsp;Volumes</p>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"),
    Diagram(coordinateSystem(extent={{-180,-140},{180,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end TestVolumes;
