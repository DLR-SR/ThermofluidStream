within ThermofluidStream.Boundaries.Tests;
model Volumes "Test Volumes"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.SimpleAir
    constrainedby Media.myMedia.Interfaces.PartialMedium
    "Medium package" annotation (Documentation(info="<html>
<p>
Medium package used in the Test.
</p>
</html>"));

  package MediumMix = Media.myMedia.IdealGases.MixtureGases.CombustionAir
    "Medium package"
    annotation (Documentation(info="<html>
<p>
Medium package used in the Test of the MixVolumes.
</p>
</html>"));


  inner DropOfCommons dropOfCommons(assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{70,-170},{90,-150}})));
  Source source(redeclare package Medium = Medium,
    p0_par=200000,
    outlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-70,-60},{-50,-40}})));
  Sink sink(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{50,-60},{70,-40}})));
  VolumeFlex flexVolume1(
    redeclare package Medium = Medium,
    p_start=100000,
    T_start=293.15,
    V_ref(displayUnit="m3") = 1,
    outlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{10,-60},{30,-40}})));
  Volume volume(
    redeclare package Medium = Medium,
    p_start=150000,
    T_start=313.15,
    outlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-30,-60},{-10,-40}})));
  Source source1(redeclare package Medium = Medium, p0_par=200000)
    annotation (Placement(transformation(extent={{-70,-90},{-50,-70}})));
  Sink sink1(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
  Volume heatportVolume(
    redeclare package Medium = Medium,
    useHeatport=true,
    use_hstart=true,
    h_start=15081,
    V_par=1,
    p_start=150000,
    A=2,
    U=200)
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T(
        displayUnit="K") = 500)
    annotation (Placement(transformation(extent={{-48,-120},{-28,-100}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.01,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.wood))
    annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.01,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.wood))
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  VolumeMix volumeMix(
    redeclare package Medium = MediumMix,
                      N=2, V_par(displayUnit="l") = 0.001)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Source source2(redeclare package Medium = MediumMix, p0_par=200000)
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Source source3(redeclare package Medium = MediumMix, p0_par=200000)
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  Sink sink2(redeclare package Medium = MediumMix, p0_par=100000)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = MediumMix,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.01,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.wood))
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Processes.FlowResistance flowResistance3(
    redeclare package Medium = MediumMix,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.01,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.wood))
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Processes.FlowResistance flowResistance4(
    redeclare package Medium = MediumMix,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.01,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.wood))
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  VolumeMix volumeMix1(
    redeclare package Medium = MediumMix,
    N=2,
    Xi_0={0.1337,1 - 0.1337},
    V_par(displayUnit="l") = 0.1)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Source source4(
    redeclare package Medium = MediumMix,
    p0_par=200000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{-70,80},{-50,100}})));
  Source source5(
    redeclare package Medium = MediumMix,
    p0_par=200000,
    Xi0_par={0,1})
    annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  Sink sink3(redeclare package Medium = MediumMix, p0_par=100000)
    annotation (Placement(transformation(extent={{50,60},{70,80}})));
  Processes.FlowResistance flowResistance5(
    redeclare package Medium = MediumMix,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e5))
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  Processes.FlowResistance flowResistance6(
    redeclare package Medium = MediumMix,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=2e5))
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Processes.FlowResistance flowResistance8(
    redeclare package Medium = MediumMix,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e1))
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Volume heatportVolume1(
    redeclare package Medium = Medium,
    useHeatport=false,
    useOutlet=false,
    V_par=1,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200)
    annotation (Placement(transformation(extent={{-8,-160},{12,-140}})));
  Volume heatportVolume2(
    redeclare package Medium = Medium,
    useHeatport=false,
    useInlet=false,
    V_par=1,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200)
    annotation (Placement(transformation(extent={{-10,-200},{10,-180}})));
  Source source6(redeclare package Medium = Medium, p0_par=180000)
    annotation (Placement(transformation(extent={{-70,-160},{-50,-140}})));
  Sink sink4(redeclare package Medium = Medium, p0_par=130000)
    annotation (Placement(transformation(extent={{50,-200},{70,-180}})));
  Processes.FlowResistance flowResistance7(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.wood))
    annotation (Placement(transformation(extent={{-40,-160},{-20,-140}})));
  Processes.FlowResistance flowResistance9(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.wood))
    annotation (Placement(transformation(extent={{20,-200},{40,-180}})));
  Volume heatportVolume3(
    redeclare package Medium = Medium,
    useHeatport=true,
    useInlet=false,
    useOutlet=false,
    V_par=1,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,-110})));
  VolumeMix volumeMix2(
    redeclare package Medium = MediumMix,
    N=0,
    useHeatport=true,
    V_par(displayUnit="l") = 0.001)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,-140})));
  Source source7(redeclare package Medium = Medium, p0_par=100000)
    annotation (Placement(transformation(extent={{-70,110},{-50,130}})));
  Sink sink5(redeclare package Medium = Medium, p0_par=200000)
    annotation (Placement(transformation(extent={{50,110},{70,130}})));
  Volume volume1(
    redeclare package Medium = Medium,
    p_start=150000,
    T_start=313.15,
    k_volume_damping=0)
    annotation (Placement(transformation(extent={{-12,110},{8,130}})));
  Processes.FlowResistance flowResistance10(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.01,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e5))
    annotation (Placement(transformation(extent={{20,110},{40,130}})));
  Processes.FlowResistance flowResistance11(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.01,
    l=1,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e5))
    annotation (Placement(transformation(extent={{-40,110},{-20,130}})));
  VolumeMix volumeMix3(
    redeclare package Medium = MediumMix,
    N=2,
    Xi_0={0.1337,1 - 0.1337},
    V_par(displayUnit="l") = 0.1)
    annotation (Placement(transformation(extent={{-8,160},{12,180}})));
  Source source8(
    redeclare package Medium = MediumMix,
    p0_par=200000,
    Xi0_par={1,0})
    annotation (Placement(transformation(extent={{-70,180},{-50,200}})));
  Source source9(
    redeclare package Medium = MediumMix,
    p0_par=100000,
    Xi0_par={0,1})
    annotation (Placement(transformation(extent={{-70,140},{-50,160}})));
  Sink sink6(redeclare package Medium = MediumMix, p0_par=300000)
    annotation (Placement(transformation(extent={{50,160},{70,180}})));
  Processes.FlowResistance flowResistance12(
    redeclare package Medium = MediumMix,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e5))
    annotation (Placement(transformation(extent={{-40,180},{-20,200}})));
  Processes.FlowResistance flowResistance13(
    redeclare package Medium = MediumMix,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=2e5))
    annotation (Placement(transformation(extent={{-40,140},{-20,160}})));
  Processes.FlowResistance flowResistance14(
    redeclare package Medium = MediumMix,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=1e1))
    annotation (Placement(transformation(extent={{20,160},{40,180}})));
equation
  connect(volume.inlet, source.outlet) annotation (Line(
      points={{-30,-50},{-50,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(volume.outlet, flexVolume1.inlet) annotation (Line(
      points={{-10,-50},{10,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(flexVolume1.outlet, sink.inlet) annotation (Line(
      points={{30,-50},{50,-50}},
      color={28,108,200},
      thickness=0.5));

  connect(fixedTemperature.port,heatportVolume. heatPort)
    annotation (Line(points={{-28,-110},{0,-110},{0,-88}}, color={191,0,0}));
  connect(heatportVolume.outlet,flowResistance. inlet) annotation (Line(
      points={{10,-80},{20,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet,sink1. inlet) annotation (Line(
      points={{40,-80},{50,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.inlet,source1. outlet) annotation (Line(
      points={{-40,-80},{-50,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.outlet,heatportVolume. inlet) annotation (Line(
      points={{-20,-80},{-10,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, flowResistance2.inlet) annotation (Line(
      points={{-50,20},{-40,20}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, flowResistance3.inlet) annotation (Line(
      points={{-50,-20},{-40,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(volumeMix.outlet, flowResistance4.inlet) annotation (Line(
      points={{10,0},{20,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sink2.inlet, flowResistance4.outlet) annotation (Line(
      points={{50,0},{40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.outlet, volumeMix.inlet[1]) annotation (Line(
      points={{-20,-20},{-16,-20},{-16,-0.5},{-10,-0.5}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, volumeMix.inlet[2]) annotation (Line(
      points={{-20,20},{-16,20},{-16,0.5},{-10,0.5}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet,flowResistance5. inlet) annotation (Line(
      points={{-50,90},{-40,90}},
      color={28,108,200},
      thickness=0.5));
  connect(source5.outlet,flowResistance6. inlet) annotation (Line(
      points={{-50,50},{-40,50}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance6.outlet, volumeMix1.inlet[1]) annotation (Line(
      points={{-20,50},{-16,50},{-16,69.5},{-10,69.5}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance5.outlet, volumeMix1.inlet[2]) annotation (Line(
      points={{-20,90},{-16,90},{-16,70.5},{-10,70.5}},
      color={28,108,200},
      thickness=0.5));
  connect(sink3.inlet, flowResistance8.outlet) annotation (Line(
      points={{50,70},{40,70}},
      color={28,108,200},
      thickness=0.5));
  connect(volumeMix1.outlet, flowResistance8.inlet) annotation (Line(
      points={{10,70},{20,70}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, flowResistance7.inlet) annotation (Line(
      points={{-50,-150},{-40,-150}},
      color={28,108,200},
      thickness=0.5));
  connect(heatportVolume1.inlet, flowResistance7.outlet)
    annotation (Line(
      points={{-8,-150},{-20,-150}},
      color={28,108,200},
      thickness=0.5));
  connect(heatportVolume2.outlet, flowResistance9.inlet)
    annotation (Line(
      points={{10,-190},{20,-190}},
      color={28,108,200},
      thickness=0.5));
  connect(sink4.inlet, flowResistance9.outlet) annotation (Line(
      points={{50,-190},{40,-190}},
      color={28,108,200},
      thickness=0.5));
  connect(heatportVolume3.heatPort, heatportVolume.heatPort) annotation (Line(points={{42,-110},{0,-110},{0,-88}},
                                                                                                                 color={191,0,0}));
  connect(volumeMix2.heatPort, heatportVolume.heatPort) annotation (Line(points={{42,-140},{28,-140},{28,-110},{0,-110},{0,-88}},
                                                                                                                              color={191,0,0}));
  connect(volume1.outlet, flowResistance10.inlet) annotation (Line(
      points={{8,120},{20,120}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance10.outlet, sink5.inlet) annotation (Line(
      points={{40,120},{50,120}},
      color={28,108,200},
      thickness=0.5));
  connect(volume1.inlet, flowResistance11.outlet) annotation (Line(
      points={{-12,120},{-20,120}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance11.inlet, source7.outlet) annotation (Line(
      points={{-40,120},{-50,120}},
      color={28,108,200},
      thickness=0.5));
  connect(source8.outlet, flowResistance12.inlet) annotation (Line(
      points={{-50,190},{-40,190}},
      color={28,108,200},
      thickness=0.5));
  connect(source9.outlet, flowResistance13.inlet) annotation (Line(
      points={{-50,150},{-40,150}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance13.outlet, volumeMix3.inlet[1])
    annotation (Line(
      points={{-20,150},{-14,150},{-14,169.5},{-8,169.5}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance12.outlet, volumeMix3.inlet[2])
    annotation (Line(
      points={{-20,190},{-14,190},{-14,170.5},{-8,170.5}},
      color={28,108,200},
      thickness=0.5));
  connect(sink6.inlet, flowResistance14.outlet) annotation (Line(
      points={{50,170},{40,170}},
      color={28,108,200},
      thickness=0.5));
  connect(volumeMix3.outlet, flowResistance14.inlet) annotation (Line(
      points={{12,170},{20,170}},
      color={28,108,200},
      thickness=0.5));
  annotation (experiment(StopTime=1, Tolerance=1e-6, Interval=0.001),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-200},{100,200}})),
        Documentation(info="<html>
<p>This test purposely violates the asserts for reversed mass-flows to test the behavior of volumes for prolonged reversed massflow for some of the volumes. The assert is set to warning.</p>
<p><br>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end Volumes;
