within ThermofluidStream.Examples;
model VenturiPump "Pumping of liquid water using the venturi effect"

  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Water.StandardWater constrainedby Media.myMedia.Interfaces.PartialMedium
    annotation(choicesAllMatching=true);

  parameter SI.Area A_in_hp=0.0002 "Cross-section area of high pressure inlet boundary";
  parameter SI.Area A_in_lp=0.001 "Cross-section area of low pressure inlet boundary";
  parameter SI.Area A_out=0.003 "Cross-section area of outlet boundary";

  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.01,
    l=0.25,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-30,-70},{-10,-50}})));
  Boundaries.Source source2_1(
    redeclare package Medium = Medium,
    T0_par=293.15,
    p0_par=150000)
    annotation (Placement(transformation(extent={{-120,-70},{-100,-50}})));
  Boundaries.Sink sink2_1(
    redeclare package Medium = Medium,
    p0_par=110000)
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Sensors.SingleFlowSensor singleFlowSensor(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps)
    annotation (Placement(transformation(extent={{-90,-70},{-70,-50}})));
  Sensors.SingleFlowSensor singleFlowSensor1(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps)
    annotation (Placement(transformation(extent={{70,-70},{90,-50}})));
  Boundaries.Source source2_2(
    redeclare package Medium = Medium,
    T0_par=293.15,
    p0_par=100000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,80})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.01,
    l=0.1,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss (
      material=ThermofluidStream.Processes.Internal.Material.steel))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-10})));
  FlowControl.CheckValve checkValve(redeclare package Medium = Medium) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-40})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow(
    redeclare package Medium = Medium,
    A_par=A_in_hp)
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow(
    redeclare package Medium = Medium,
    A_par=A_out)
    annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow2(
    redeclare package Medium = Medium,
    A_par=A_in_lp)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,20})));
  Topology.DynamicJunctionN dynamicJunctionN2_1(
    redeclare package Medium = Medium,
    N=2,
    A={A_in_hp,A_in_lp},
    A_out=A_out)
    annotation (Placement(transformation(extent={{10,-70},{30,-50}})));
  Sensors.SingleFlowSensor singleFlowSensor8(
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,50})));
  inner DropOfCommons dropOfCommons(p_min(displayUnit="Pa") = 612,
      displayInstanceNames=true)
    annotation (Placement(transformation(extent={{-90,12},{-70,32}})));
  ThermofluidStream.Utilities.Icons.DLRLogo dLRLogo annotation (Placement(transformation(extent={{82,62},{118,98}})));
equation
  connect(flowResistance1.outlet, checkValve.inlet) annotation (Line(
      points={{0,-20},{0,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, dynamicJunctionN2_1.inlets[1])
    annotation (Line(
      points={{-10,-60},{-2,-60},{-2,-60.5},{10,-60.5}},
      color={28,108,200},
      thickness=0.5));
  connect(checkValve.outlet, dynamicJunctionN2_1.inlets[2])
    annotation (Line(
      points={{0,-50},{0,-59.5},{10,-59.5}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicJunctionN2_1.outlet, dynamicPressureOutflow.inlet)
    annotation (Line(
      points={{30,-60},{40,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(dynamicPressureInflow.inlet, singleFlowSensor.outlet)
    annotation (Line(
      points={{-60,-60},{-70,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.inlet, dynamicPressureInflow.outlet)
    annotation (Line(
      points={{-30,-60},{-40,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.inlet, dynamicPressureInflow2.outlet)
    annotation (Line(
      points={{0,0},{0,10}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor8.inlet, source2_2.outlet) annotation (Line(
      points={{0,60},{0,66},{0,70}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor1.inlet, dynamicPressureOutflow.outlet)
    annotation (Line(
      points={{70,-60},{60,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(source2_1.outlet, singleFlowSensor.inlet) annotation (Line(
      points={{-100,-60},{-90,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(sink2_1.inlet, singleFlowSensor1.outlet) annotation (Line(
      points={{100,-60},{90,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor8.outlet, dynamicPressureInflow2.inlet)
    annotation (Line(
      points={{0,40},{0,36},{0,30}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{120,100}})),
    experiment(
      StopTime=1,
      Tolerance=1e-6,
      Interval=1e-3,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p><br>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end VenturiPump;
