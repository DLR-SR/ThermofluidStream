within ThermofluidStream.Boundaries.Tests;
model VolumesDirectCoupling "Test Volumes"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Water.StandardWater
    constrainedby Media.myMedia.Interfaces.PartialMedium
    "Medium package"
    annotation (choicesAllMatching=true, Documentation(info="<html>
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

  inner DropOfCommons dropOfCommons(
    k_volume_damping=0.5,
    assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{70,-148},{90,-128}})));
  Volume heatportVolume2(
    redeclare package Medium = Medium,
    useHeatport=false,
    useInlet=false,
    V_par=0.001,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200,
    outlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Sink sink4(redeclare package Medium = Medium, p0_par=130000)
    annotation (Placement(transformation(extent={{36,-10},{56,10}})));
  Volume heatportVolume1(
    redeclare package Medium = Medium,
    useHeatport=false,
    useInlet=true,
    useOutlet=false,
    V_par=0.001,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200,
    density_derp_h_from_media=true)
    annotation (Placement(transformation(extent={{-10,-96},{10,-76}})));
  Source source(redeclare package Medium = Medium,
    p0_par=200000,
    outlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-58,-96},{-38,-76}})));
  Volume heatportVolume3(
    redeclare package Medium = Medium,
    useHeatport=false,
    useInlet=false,
    V_par=0.001,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200,
    density_derp_h_from_media=true,
    outlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  Volume heatportVolume4(
    redeclare package Medium = Medium,
    useHeatport=false,
    useInlet=true,
    useOutlet=false,
    V_par=0.001,
    p_start=130000,
    T_start=313.15,
    A=2,
    U=200)
    annotation (Placement(transformation(extent={{10,20},{30,40}})));
  VolumeFlex
         heatportVolume5(
    redeclare package Medium = Medium,
    useHeatport=false,
    useInlet=false,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200,
    outlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-30,50},{-10,70}})));
  Volume heatportVolume6(
    redeclare package Medium = Medium,
    useHeatport=false,
    useInlet=true,
    useOutlet=false,
    V_par=0.001,
    p_start=130000,
    T_start=313.15,
    A=2,
    U=200)
    annotation (Placement(transformation(extent={{10,50},{30,70}})));
  VolumeFlex
         heatportVolume7(
    redeclare package Medium = Medium,
    useHeatport=false,
    useInlet=false,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200,
    outlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Sink sink1(redeclare package Medium = Medium, p0_par=130000)
    annotation (Placement(transformation(extent={{36,-30},{56,-10}})));
  VolumeFlex
         heatportVolume8(
    redeclare package Medium = Medium,
    useHeatport=false,
    useInlet=false,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200,
    outlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-30,78},{-10,98}})));
  VolumeFlex
         heatportVolume9(
    redeclare package Medium = Medium,
    useHeatport=false,
    useInlet=true,
    useOutlet=false,
    p_start=130000,
    T_start=313.15,
    A=2,
    U=200)
    annotation (Placement(transformation(extent={{10,78},{30,98}})));
  VolumeFlex
         heatportVolume10(
    redeclare package Medium = Medium,
    useHeatport=false,
    useInlet=true,
    useOutlet=false,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200)
    annotation (Placement(transformation(extent={{-10,-118},{10,-98}})));
  Source source1(redeclare package Medium = Medium,
    p0_par=200000,
    outlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-58,-118},{-38,-98}})));
  VolumeFlex
         heatportVolume11(
    redeclare package Medium = Medium,
    useHeatport=false,
    useInlet=false,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200,
    outlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Sink sink2(redeclare package Medium = Medium, p0_par=130000)
    annotation (Placement(transformation(extent={{36,-50},{56,-30}})));
  ThermofluidStream.Boundaries.Reservoir
         heatportVolume12(
    redeclare package Medium = Medium,
    useInlet=false,
    T_start=313.15,
    height_0=0.2,
    outlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-30,102},{-10,122}})));
  ThermofluidStream.Boundaries.Reservoir
         heatportVolume13(
    redeclare package Medium = Medium,
    useInlet=true,
    useOutlet=false,
    T_start=313.15,
    height_0=0.1)
    annotation (Placement(transformation(extent={{10,102},{30,122}})));
  ThermofluidStream.Boundaries.Reservoir
         heatportVolume14(
    redeclare package Medium = Medium,
    useInlet=false,
    T_start=313.15,
    height_0=0.2,
    outlet(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-10,-76},{10,-56}})));
  Sink sink3(redeclare package Medium = Medium, p0_par=101000)
    annotation (Placement(transformation(extent={{36,-76},{56,-56}})));
equation

  connect(heatportVolume2.outlet, sink4.inlet) annotation (Line(
      points={{10,0},{36,0}},
      color={28,108,200},
      thickness=0.5));
  connect(source.outlet, heatportVolume1.inlet) annotation (Line(
      points={{-38,-86},{-10,-86}},
      color={28,108,200},
      thickness=0.5));
  connect(heatportVolume4.inlet, heatportVolume3.outlet) annotation (Line(
      points={{10,30},{-10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(heatportVolume6.inlet, heatportVolume5.outlet) annotation (Line(
      points={{10,60},{-10,60}},
      color={28,108,200},
      thickness=0.5));
  connect(heatportVolume7.outlet, sink1.inlet) annotation (Line(
      points={{10,-20},{36,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(heatportVolume9.inlet, heatportVolume8.outlet) annotation (Line(
      points={{10,88},{-10,88}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, heatportVolume10.inlet) annotation (Line(
      points={{-38,-108},{-10,-108}},
      color={28,108,200},
      thickness=0.5));
  connect(heatportVolume11.outlet, sink2.inlet) annotation (Line(
      points={{10,-40},{36,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(heatportVolume13.inlet, heatportVolume12.outlet)
    annotation (Line(
      points={{10,112},{-10,112}},
      color={28,108,200},
      thickness=0.5));
  connect(heatportVolume14.outlet, sink3.inlet) annotation (Line(
      points={{10,-66},{36,-66}},
      color={28,108,200},
      thickness=0.5));
  annotation (experiment(
      StopTime=0.05,
      Interval=5e-06,
      Tolerance=1e-07,
      __Dymola_Algorithm="Dassl"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},{100,160}})),
        Documentation(info="<html>
<p>This test uses deceased tolerance and saves more points (smaller output interval) because of the different time-scales and relative stiff equation system.</p>
<p><br>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end VolumesDirectCoupling;
