within ThermofluidStream.Undirected.Boundaries.Tests;
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

  inner DropOfCommons dropOfCommons(k_volume_damping=0.5)
    annotation (Placement(transformation(extent={{70,-148},{90,-128}})));
  Volume heatportVolume2(
    redeclare package Medium = Medium,
    useHeatport=false,
    useRear=false,
    V_par=0.001,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200,
    fore(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  BoundaryFore
       boundaryFore(redeclare package Medium = Medium, p0_par=130000)
    annotation (Placement(transformation(extent={{36,-10},{56,10}})));
  Volume heatportVolume1(
    redeclare package Medium = Medium,
    useHeatport=false,
    useFore=false,
    V_par=0.001,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200,
    density_derp_h_from_media=true)
    annotation (Placement(transformation(extent={{-10,-96},{10,-76}})));
  BoundaryRear
         boundaryRear(
    redeclare package Medium = Medium,
    p0_par=200000,
    fore(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-58,-96},{-38,-76}})));
  Volume heatportVolume3(
    redeclare package Medium = Medium,
    useHeatport=false,
    useRear=false,
    V_par=0.001,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200,
    density_derp_h_from_media=true,
    fore(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  Volume heatportVolume4(
    redeclare package Medium = Medium,
    useHeatport=false,
    useFore=false,
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
    useRear=false,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200,
    fore(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-30,50},{-10,70}})));
  Volume heatportVolume6(
    redeclare package Medium = Medium,
    useHeatport=false,
    useFore=false,
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
    useRear=false,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200,
    fore(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  BoundaryFore
       boundaryFore1(redeclare package Medium = Medium, p0_par=130000)
    annotation (Placement(transformation(extent={{36,-30},{56,-10}})));
  VolumeFlex
         heatportVolume8(
    redeclare package Medium = Medium,
    useHeatport=false,
    useRear=false,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200,
    fore(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-30,78},{-10,98}})));
  VolumeFlex
         heatportVolume9(
    redeclare package Medium = Medium,
    useHeatport=false,
    useFore=false,
    p_start=130000,
    T_start=313.15,
    A=2,
    U=200)
    annotation (Placement(transformation(extent={{10,78},{30,98}})));
  VolumeFlex
         heatportVolume10(
    redeclare package Medium = Medium,
    useHeatport=false,
    useFore=false,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200)
    annotation (Placement(transformation(extent={{-10,-118},{10,-98}})));
  BoundaryRear
         boundaryRear1(
    redeclare package Medium = Medium,
    p0_par=200000,
    fore(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-58,-118},{-38,-98}})));
  VolumeFlex
         heatportVolume11(
    redeclare package Medium = Medium,
    useHeatport=false,
    useRear=false,
    p_start=150000,
    T_start=313.15,
    A=2,
    U=200,
    fore(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  BoundaryFore
       boundaryFore2(redeclare package Medium = Medium, p0_par=130000)
    annotation (Placement(transformation(extent={{36,-50},{56,-30}})));
  ThermofluidStream.Undirected.Boundaries.Reservoir
         heatportVolume12(
    redeclare package Medium = Medium,
    useRear=false,
    T_start=313.15,
    height_0=0.2,
    fore(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-30,102},{-10,122}})));
  ThermofluidStream.Undirected.Boundaries.Reservoir
         heatportVolume13(
    redeclare package Medium = Medium,
    useFore=false,
    T_start=313.15,
    height_0=0.1)
    annotation (Placement(transformation(extent={{10,102},{30,122}})));
  ThermofluidStream.Undirected.Boundaries.Reservoir
         heatportVolume14(
    redeclare package Medium = Medium,
    useRear=false,
    T_start=313.15,
    height_0(displayUnit="m") = 0.2,
    fore(m_flow(start=0, fixed=true)))
    annotation (Placement(transformation(extent={{-10,-76},{10,-56}})));
  BoundaryFore
       boundaryFore3(redeclare package Medium = Medium, p0_par=101000)
    annotation (Placement(transformation(extent={{36,-76},{56,-56}})));
equation

  connect(heatportVolume13.rear, heatportVolume12.fore)
    annotation (Line(
      points={{10,112},{-10,112}},
      color={28,108,200},
      thickness=0.5));
  connect(heatportVolume9.rear, heatportVolume8.fore) annotation (Line(
      points={{10,88},{-10,88}},
      color={28,108,200},
      thickness=0.5));
  connect(heatportVolume6.rear, heatportVolume5.fore) annotation (Line(
      points={{10,60},{-10,60}},
      color={28,108,200},
      thickness=0.5));
  connect(heatportVolume3.fore, heatportVolume4.rear) annotation (Line(
      points={{-10,30},{10,30}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryFore.rear, heatportVolume2.fore) annotation (Line(
      points={{36,0},{10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(heatportVolume7.fore, boundaryFore1.rear) annotation (Line(
      points={{10,-20},{36,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(heatportVolume11.fore, boundaryFore2.rear) annotation (Line(
      points={{10,-40},{36,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(heatportVolume14.fore, boundaryFore3.rear) annotation (Line(
      points={{10,-66},{36,-66}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryRear.fore, heatportVolume1.rear) annotation (Line(
      points={{-38,-86},{-10,-86}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryRear1.fore, heatportVolume10.rear)
    annotation (Line(
      points={{-38,-108},{-10,-108}},
      color={28,108,200},
      thickness=0.5));
  annotation (experiment(
      StopTime=0.05,
   Tolerance=1e-6,
   Interval=5e-5,
      __Dymola_Algorithm="Dassl"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},{100,160}})),
        Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end VolumesDirectCoupling;
