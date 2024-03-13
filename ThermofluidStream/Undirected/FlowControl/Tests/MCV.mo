within ThermofluidStream.Undirected.FlowControl.Tests;
model MCV "Test for undirected MCV"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.SimpleAir
    constrainedby Media.myMedia.Interfaces.PartialMedium
    "Medium package"
      annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Test.
</p>
</html>"));

  inner DropOfCommons dropOfCommons(assertionLevel=
        AssertionLevel.warning) annotation (Placement(transformation(extent={{100,0},
            {120,20}})));
  Boundaries.BoundaryRear boundaryRear2(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    T0_par(displayUnit="K") = 300,
    p0_par=200000) annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  Boundaries.BoundaryFore boundaryFore(
    redeclare package Medium = Medium,
    p0_par=100000)
    annotation (Placement(transformation(extent={{60,30},{80,50}})));
  ThermofluidStream.Undirected.FlowControl.MCV
                                    mCV(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.mass_flow,
    setpointFromInput=true,
    massFlow_set_par=0.1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{0,30},{20,
            50}})));

  Boundaries.BoundaryRear boundaryRear3(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300,
    p0_par=200000) annotation (Placement(transformation(extent={{-30,0},{-10,20}})));
  Boundaries.BoundaryFore boundaryFore2(
    redeclare package Medium = Medium,
    p0_par=100000)
    annotation (Placement(transformation(extent={{60,0},{80,20}})));
  ThermofluidStream.Undirected.FlowControl.MCV
                                    mCV1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.volume_flow,
    massFlow_set_par=0.1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{0,0},{20,
            20}})));

  Modelica.Blocks.Sources.Pulse pulse1(
    amplitude=2e5,
    period=2.5,
    offset=0.5e5,
    startTime=0)
    annotation (Placement(transformation(extent={{-70,6},{-50,26}})));
  Boundaries.BoundaryFore boundaryFore6(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300,
    p0_par=200000) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-20,-20})));

  Boundaries.BoundaryRear boundaryRear1(
    redeclare package Medium = Medium,
    p0_par=100000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,-20})));
  ThermofluidStream.Undirected.FlowControl.MCV mCV2(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.volume_flow,
    massFlow_set_par=0.1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=180,
        origin={10,-20})));

  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=2e5,
    rising=0.5,
    width=0.75,
    falling=0.5,
    period=2.5,
    offset=0.5e5,
    startTime=0)
    annotation (Placement(transformation(extent={{-70,-36},{-50,-16}})));
  Boundaries.BoundaryFore boundaryFore8(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par(displayUnit="K") = 300,
    p0_par=200000) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-20,-50})));

  Boundaries.BoundaryRear boundaryRear5(
    redeclare package Medium = Medium,
    p0_par=100000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,-50})));
  ThermofluidStream.Undirected.FlowControl.MCV
                                    mCV3(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.mass_flow,
    massFlow_set_par=0.1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=180,
        origin={10,-50})));

  Modelica.Blocks.Sources.Pulse pulse3(
    amplitude=2e5,
    period=2.5,
    offset=0.5e5,
    startTime=0)
    annotation (Placement(transformation(extent={{-70,-66},{-50,-46}})));
  Boundaries.BoundaryFore boundaryFore7(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    T0_par(displayUnit="K") = 300,
    p0_par=100000) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-20,-80})));

  Boundaries.BoundaryRear boundaryRear4(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    T0_par=573.15,
    p0_par=100000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,-80})));
  ThermofluidStream.Undirected.FlowControl.MCV
                                    mCV4(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.mass_flow,
    massFlow_set_par=0.1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=180,
        origin={10,-80})));

  Modelica.Blocks.Sources.Trapezoid
                                trapezoid1(
    amplitude=2e5,
    rising=0.5,
    width=1.5,
    falling=0.5,
    period=2.5,
    offset=0.5e5,
    startTime=0)
    annotation (Placement(transformation(extent={{112,-96},{92,-76}})));
  Boundaries.BoundaryRear boundaryRear(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    T0_par(displayUnit="K") = 300,
    p0_par=200000) annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
  Boundaries.BoundaryFore boundaryFore1(
    redeclare package Medium = Medium,
    p0_par=100000)
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
  ThermofluidStream.Undirected.FlowControl.MCV
                                    mCV5(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.volume_flow,
    setpointFromInput=true,
    massFlow_set_par=0.1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{0,70},{20,
            90}})));

  Modelica.Blocks.Sources.Pulse pulse5(
    amplitude=0.2,
    period=2.5,
    offset=0.1,
    startTime=0)
    annotation (Placement(transformation(extent={{-70,50},{-50,70}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid2(
    amplitude=5,
    rising=0.5,
    width=0.75,
    falling=0.5,
    period=2.5,
    offset=1,
    startTime=0)
    annotation (Placement(transformation(extent={{-70,90},{-50,110}})));
  Processes.FlowResistance flowResistance5(
    redeclare package Medium = Medium,
    r=0.1,
    l=10,
    L_value=0.01,
    computeL=false,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{28,70},{48,90}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    r=0.1,
    l=10,
    L_value=0.01,
    computeL=false,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{30,30},{50,50}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    r=0.1,
    l=10,
    L_value=0.01,
    computeL=false,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{28,0},{48,20}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    r=0.1,
    l=10,
    L_value=0.01,
    computeL=false,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,-20})));
  Processes.FlowResistance flowResistance3(
    redeclare package Medium = Medium,
    r=0.1,
    l=10,
    L_value=0.01,
    computeL=false,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,-50})));
  Processes.FlowResistance flowResistance4(
    redeclare package Medium = Medium,
    r=0.1,
    l=10,
    L_value=0.01,
    computeL=false,
    redeclare function pLoss =
        ThermofluidStream.Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,-80})));
  Boundaries.BoundaryRear boundaryRear6(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    T0_par(displayUnit="K") = 300,
    p0_par=200000) annotation (Placement(transformation(extent={{-32,158},{-12,
            178}})));
  ThermofluidStream.Undirected.FlowControl.MCV mCV6(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.mass_flow,
    setpointFromInput=false,
    massFlow_set_par=1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{-2,158},
            {18,178}})));

  Boundaries.BoundaryFore boundaryFore3(
    redeclare package Medium = Medium,
    p0_par=200000)
    annotation (Placement(transformation(extent={{30,158},{50,178}})));
  Boundaries.BoundaryRear boundaryRear7(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    T0_par(displayUnit="K") = 300,
    p0_par=500000) annotation (Placement(transformation(extent={{-32,116},{-12,
            136}})));
  Boundaries.BoundaryFore boundaryFore4(
    redeclare package Medium = Medium,
    p0_par=0.001)
    annotation (Placement(transformation(extent={{30,116},{50,136}})));
  ThermofluidStream.Undirected.FlowControl.MCV
                                    mCV7(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.mass_flow,
    setpointFromInput=false,
    massFlow_set_par=1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{-2,116},
            {18,136}})));

  Boundaries.BoundaryFore boundaryFore10(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    T0_par(displayUnit="K") = 300,
    p0_par=200000) annotation (Placement(transformation(extent={{-10,-10},{10,
            10}},
        rotation=180,
        origin={64,168})));
  ThermofluidStream.Undirected.FlowControl.MCV
                                    mCV8(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.mass_flow,
    setpointFromInput=false,
    massFlow_set_par=1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=180,
        origin={94,168})));

  Boundaries.BoundaryRear boundaryRear8(
    redeclare package Medium = Medium,
    p0_par=200000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={126,168})));
  Boundaries.BoundaryFore boundaryFore11(
    redeclare package Medium = Medium,
    pressureFromInput=false,
    T0_par(displayUnit="K") = 300,
    p0_par=500000) annotation (Placement(transformation(extent={{-10,-10},{10,
            10}},
        rotation=180,
        origin={64,126})));
  Boundaries.BoundaryRear boundaryRear9(
    redeclare package Medium = Medium,
    p0_par=0.001)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={126,126})));
  ThermofluidStream.Undirected.FlowControl.MCV
                                    mCV9(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.mass_flow,
    setpointFromInput=false,
    massFlow_set_par=1,
    volumeFlow_set_par=1) annotation (Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=180,
        origin={94,126})));

equation

  connect(pulse1.y, boundaryRear3.p0_var) annotation (Line(points={{-49,16},{-22,16}},
                                  color={0,0,127}));
  connect(trapezoid.y, boundaryFore6.p0_var) annotation (Line(points={{-49,-26},{-22,-26}},
                                          color={0,0,127}));
  connect(pulse3.y, boundaryFore8.p0_var) annotation (Line(points={{-49,-56},{-22,-56}},
                                     color={0,0,127}));
  connect(pulse5.y,mCV. setpoint_var) annotation (Line(points={{-49,60},{10,60},
          {10,48}}, color={0,0,127}));
  connect(trapezoid2.y,mCV5. setpoint_var) annotation (Line(points={{-49,100},{10,
          100},{10,88}}, color={0,0,127}));
  connect(boundaryRear.fore, mCV5.rear) annotation (Line(
      points={{-10,80},{0,80}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryRear2.fore, mCV.rear) annotation (Line(
      points={{-10,40},{0,40}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryRear3.fore, mCV1.rear) annotation (Line(
      points={{-10,10},{0,10}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryFore6.rear, mCV2.fore) annotation (Line(
      points={{-10,-20},{-1.77636e-15,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryFore8.rear, mCV3.fore) annotation (Line(
      points={{-10,-50},{-1.77636e-15,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryFore7.rear, mCV4.fore) annotation (Line(
      points={{-10,-80},{0,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV5.fore, flowResistance5.rear) annotation (Line(
      points={{20,80},{28,80}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance5.fore, boundaryFore1.rear) annotation (Line(
      points={{48,80},{60,80}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.fore, flowResistance.rear) annotation (Line(
      points={{20,40},{30,40}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.fore, boundaryFore.rear) annotation (Line(
      points={{50,40},{60,40}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV1.fore, flowResistance1.rear) annotation (Line(
      points={{20,10},{28,10}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.fore, boundaryFore2.rear) annotation (Line(
      points={{48,10},{60,10}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV2.rear, flowResistance2.fore) annotation (Line(
      points={{20,-20},{30,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.rear, boundaryRear1.fore) annotation (Line(
      points={{50,-20},{60,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV3.rear, flowResistance3.fore) annotation (Line(
      points={{20,-50},{30,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.rear, boundaryRear5.fore) annotation (Line(
      points={{50,-50},{60,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV4.rear, flowResistance4.fore) annotation (Line(
      points={{20,-80},{30,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.rear, boundaryRear4.fore) annotation (Line(
      points={{50,-80},{60,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(trapezoid1.y, boundaryRear4.p0_var) annotation (Line(points={{91,-86},{72,-86}},
                                       color={0,0,127}));
  connect(boundaryRear6.fore, mCV6.rear) annotation (Line(
      points={{-12,168},{-2,168}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryRear7.fore, mCV7.rear) annotation (Line(
      points={{-12,126},{-2,126}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV6.fore, boundaryFore3.rear) annotation (Line(
      points={{18,168},{30,168}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV7.fore, boundaryFore4.rear) annotation (Line(
      points={{18,126},{30,126}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryFore10.rear, mCV8.fore) annotation (Line(
      points={{74,168},{84,168}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryFore11.rear, mCV9.fore) annotation (Line(
      points={{74,126},{84,126}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV8.rear, boundaryRear8.fore) annotation (Line(
      points={{104,168},{116,168}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryRear9.fore, mCV9.rear) annotation (Line(
      points={{116,126},{104,126}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    experiment(StopTime=10, Tolerance=1e-6, Interval=0.001, __Dymola_Algorithm="Dassl"),
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end MCV;
