within ThermofluidStream.Topology.Tests;
model TestNonPhysical
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Water.StandardWater;

  NonPhysical.RatioControl ratioControl(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-130,50},{-110,70}})));
  NonPhysical.RTSwitch rTSwitch(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-130,0},{-110,20}})));
  NonPhysical.LeakageA leakageA(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-130,-50},{-110,-30}})));
  NonPhysical.JunctionRatio junctionRatio1(redeclare package Medium = Medium,
      invert=true)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-70,-70})));
  JunctionT2 junctionT2_1(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-70,80})));
  JunctionT2 junctionT2_3(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-70,30})));
  JunctionT2 junctionT2_5(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-70,-20})));
  SplitterT2 splitterT2_1(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-130,-100},{-110,-80}})));
  Boundaries.Source source(redeclare package Medium = Medium, pressureFromInput=
       true)
    annotation (Placement(transformation(extent={{-160,50},{-140,70}})));
  Boundaries.Source source1(redeclare package Medium = Medium,
      pressureFromInput=true)
    annotation (Placement(transformation(extent={{-160,0},{-140,20}})));
  Boundaries.Source source2(redeclare package Medium = Medium,
      pressureFromInput=true)
    annotation (Placement(transformation(extent={{-160,-50},{-140,-30}})));
  Boundaries.Source source3(redeclare package Medium = Medium,
      pressureFromInput=true)
    annotation (Placement(transformation(extent={{-160,-100},{-140,-80}})));
  Boundaries.Sink sink(redeclare package Medium = Medium, p0_par=200000)
    annotation (Placement(transformation(extent={{-20,70},{0,90}})));
  Boundaries.Sink sink1(redeclare package Medium = Medium, p0_par=200000)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Boundaries.Sink sink2(redeclare package Medium = Medium, p0_par=200000)
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Boundaries.Sink sink3(redeclare package Medium = Medium, p0_par=200000)
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  Processes.FlowResistance flowResistance(
    redeclare package Medium = Medium,
    r(displayUnit="mm") = 0.01,
    l=1,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=100,
      k2=100))
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Processes.FlowResistance flowResistance1(
    redeclare package Medium = Medium,
    r(displayUnit="mm") = 0.01,
    l=1,
    computeL=false,
    redeclare function pLoss =
      Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=100,
      k2=100))
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Processes.FlowResistance flowResistance2(
    redeclare package Medium = Medium,
    r(displayUnit="mm") = 0.01,
    l=1,
    computeL=false,
    redeclare function pLoss =
      Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=100,
      k2=100))
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
  Processes.FlowResistance flowResistance3(redeclare package Medium = Medium,
    r(displayUnit="mm") = 0.01,
    l=1,
    computeL=false,
    redeclare function pLoss =
      Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=100,
      k2=100))
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  NonPhysical.RatioControl ratioControl1(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{40,50},{60,70}})));
  NonPhysical.RTSwitch rTSwitch1(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
  NonPhysical.LeakageA leakageA1(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  NonPhysical.JunctionRatio junctionRatio2(redeclare package Medium = Medium,
      invert=true)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={100,-70})));
  JunctionT2 junctionT2_2(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={100,80})));
  JunctionT2 junctionT2_4(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={100,30})));
  JunctionT2 junctionT2_6(redeclare package Medium = Medium) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={100,-20})));
  SplitterT2 splitterT2_2(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{40,-100},{60,-80}})));
  Boundaries.Source source4(redeclare package Medium = Medium,
      pressureFromInput=true)
    annotation (Placement(transformation(extent={{10,50},{30,70}})));
  Boundaries.Source source5(redeclare package Medium = Medium,
      pressureFromInput=true)
    annotation (Placement(transformation(extent={{10,0},{30,20}})));
  Boundaries.Source source6(redeclare package Medium = Medium,
      pressureFromInput=true)
    annotation (Placement(transformation(extent={{10,-50},{30,-30}})));
  Boundaries.Source source7(redeclare package Medium = Medium,
      pressureFromInput=true)
    annotation (Placement(transformation(extent={{10,-100},{30,-80}})));
  Boundaries.Sink sink4(redeclare package Medium = Medium, p0_par=200000)
    annotation (Placement(transformation(extent={{150,70},{170,90}})));
  Boundaries.Sink sink5(redeclare package Medium = Medium, p0_par=200000)
    annotation (Placement(transformation(extent={{150,20},{170,40}})));
  Boundaries.Sink sink6(redeclare package Medium = Medium, p0_par=200000)
    annotation (Placement(transformation(extent={{150,-30},{170,-10}})));
  Boundaries.Sink sink7(redeclare package Medium = Medium, p0_par=200000)
    annotation (Placement(transformation(extent={{150,-80},{170,-60}})));
  Processes.Pump pump(redeclare package Medium = Medium,
    omega_from_input=true,
    redeclare function dp_tau_pump =
        Processes.Internal.TurboComponent.dp_tau_nominal_flow (
        parametrizeByDesignPoint=true,
        dp_D=1000,
        omega_D(displayUnit="rad/s")))
    annotation (Placement(transformation(extent={{70,50},{90,70}})));
  Processes.Pump pump2(redeclare package Medium = Medium,
    omega_from_input=true,
    redeclare function dp_tau_pump =
        Processes.Internal.TurboComponent.dp_tau_nominal_flow (
          parametrizeByDesignPoint=true, dp_D=1000))
    annotation (Placement(transformation(extent={{70,0},{90,20}})));
  Processes.Pump pump3(redeclare package Medium = Medium,
    omega_from_input=true,
    redeclare function dp_tau_pump =
        Processes.Internal.TurboComponent.dp_tau_nominal_flow (
          parametrizeByDesignPoint=true, dp_D=1000))
    annotation (Placement(transformation(extent={{70,-50},{90,-30}})));
  Processes.Pump pump1(redeclare package Medium = Medium,
    omega_from_input=true,
    redeclare function dp_tau_pump =
        Processes.Internal.TurboComponent.dp_tau_nominal_flow (
          parametrizeByDesignPoint=true, dp_D=1000))
    annotation (Placement(transformation(extent={{70,-100},{90,-80}})));
  Modelica.Blocks.Sources.TimeTable timeTable(table=[0,0.3; 10,0.3; 20,1; 30,1;
        40,0.7; 50,0.7; 60,0; 70,0; 80,0.5; 90,0.5; 100,1; 110,1; 120,0.9; 10000,
        0.9])
    annotation (Placement(transformation(extent={{-190,40},{-170,60}})));
  Modelica.Blocks.Sources.Constant const(k=100)
    annotation (Placement(transformation(extent={{186,34},{166,54}})));
  Processes.FlowResistance flowResistance4(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.01,
    l=1,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=100,
      k2=100))
    annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
  Processes.FlowResistance flowResistance5(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.01,
    l=1,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=100,
      k2=100))
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Processes.FlowResistance flowResistance6(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.01,
    l=1,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=100,
      k2=100))
    annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
  Processes.FlowResistance flowResistance7(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.01,
    l=1,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=100,
      k2=100))
    annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
  Processes.FlowResistance flowResistance8(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.01,
    l=1,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=100,
      k2=100))
    annotation (Placement(transformation(extent={{120,70},{140,90}})));
  Processes.FlowResistance flowResistance9(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.01,
    l=1,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=100,
      k2=100))
    annotation (Placement(transformation(extent={{120,20},{140,40}})));
  Processes.FlowResistance flowResistance10(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.01,
    l=1,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=100,
      k2=100))
    annotation (Placement(transformation(extent={{120,-30},{140,-10}})));
  Processes.FlowResistance flowResistance11(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.01,
    l=1,
    computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=100,
      k2=100))
    annotation (Placement(transformation(extent={{120,-80},{140,-60}})));
  inner DropOfCommons dropOfCommons(p_min(displayUnit="Pa") = 650)
    annotation (Placement(transformation(extent={{170,-100},{190,-80}})));
  Modelica.Blocks.Sources.Step step(
    height=4e3,
    offset=2e5 - 2e3,
    startTime=65)
    annotation (Placement(transformation(extent={{-190,80},{-170,100}})));
equation
  connect(source.outlet, ratioControl.inlet) annotation (Line(
      points={{-140,60},{-130,60}},
      color={28,108,200},
      thickness=0.5));
  connect(ratioControl.outletB, flowResistance.inlet) annotation (Line(
      points={{-110,60},{-100,60}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT2_1.inletB, ratioControl.outletA) annotation (Line(
      points={{-80,80},{-120,80},{-120,70}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance.outlet, junctionT2_1.inletA) annotation (Line(
      points={{-80,60},{-70,60},{-70,70}},
      color={28,108,200},
      thickness=0.5));
  connect(rTSwitch.inlet, source1.outlet) annotation (Line(
      points={{-130,10},{-140,10}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance1.inlet, rTSwitch.outletB) annotation (Line(
      points={{-100,10},{-110,10}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT2_3.inletA, flowResistance1.outlet) annotation (Line(
      points={{-70,20},{-70,10},{-80,10}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT2_3.inletB, rTSwitch.outletA) annotation (Line(
      points={{-80,30},{-120,30},{-120,20}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, leakageA.inlet) annotation (Line(
      points={{-140,-40},{-130,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(leakageA.outletB, flowResistance2.inlet) annotation (Line(
      points={{-110,-40},{-100,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(leakageA.outletA, junctionT2_5.inletB) annotation (Line(
      points={{-120,-30},{-120,-20},{-80,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance2.outlet, junctionT2_5.inletA) annotation (Line(
      points={{-80,-40},{-70,-40},{-70,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, splitterT2_1.inlet) annotation (Line(
      points={{-140,-90},{-130,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT2_1.outletA, junctionRatio1.inletB) annotation (Line(
      points={{-120,-80},{-120,-70},{-80,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT2_1.outletB, flowResistance3.inlet) annotation (Line(
      points={{-110,-90},{-100,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance3.outlet, junctionRatio1.inletA) annotation (Line(
      points={{-80,-90},{-70,-90},{-70,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet, ratioControl1.inlet) annotation (Line(
      points={{30,60},{40,60}},
      color={28,108,200},
      thickness=0.5));
  connect(ratioControl1.outletB, pump.inlet) annotation (Line(
      points={{60,60},{70,60}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT2_2.inletB, ratioControl1.outletA) annotation (Line(
      points={{90,80},{50,80},{50,70}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.outlet, junctionT2_2.inletA) annotation (Line(
      points={{90,60},{100,60},{100,70}},
      color={28,108,200},
      thickness=0.5));
  connect(rTSwitch1.inlet, source5.outlet) annotation (Line(
      points={{40,10},{30,10}},
      color={28,108,200},
      thickness=0.5));
  connect(pump2.inlet, rTSwitch1.outletB) annotation (Line(
      points={{70,10},{60,10}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT2_4.inletA, pump2.outlet) annotation (Line(
      points={{100,20},{100,10},{90,10}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT2_4.inletB, rTSwitch1.outletA) annotation (Line(
      points={{90,30},{50,30},{50,20}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, leakageA1.inlet) annotation (Line(
      points={{30,-40},{40,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(leakageA1.outletB, pump3.inlet) annotation (Line(
      points={{60,-40},{70,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(leakageA1.outletA, junctionT2_6.inletB) annotation (Line(
      points={{50,-30},{50,-20},{90,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(pump3.outlet, junctionT2_6.inletA) annotation (Line(
      points={{90,-40},{100,-40},{100,-30}},
      color={28,108,200},
      thickness=0.5));
  connect(source7.outlet, splitterT2_2.inlet) annotation (Line(
      points={{30,-90},{40,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT2_2.outletA, junctionRatio2.inletB) annotation (Line(
      points={{50,-80},{50,-70},{90,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT2_2.outletB, pump1.inlet) annotation (Line(
      points={{60,-90},{70,-90}},
      color={28,108,200},
      thickness=0.5));
  connect(pump1.outlet, junctionRatio2.inletA) annotation (Line(
      points={{90,-90},{100,-90},{100,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(timeTable.y, ratioControl.splitRatio)
    annotation (Line(points={{-169,50},{-120,50},{-120,57}},
                                                           color={0,0,127}));
  connect(ratioControl1.splitRatio, ratioControl.splitRatio) annotation (Line(
        points={{50,57},{50,50},{-120,50},{-120,57}},
                                                    color={0,0,127}));
  connect(rTSwitch.splitRatio, ratioControl.splitRatio) annotation (Line(points={{-120,7},
          {-120,-2},{-160,-2},{-160,50},{-120,50},{-120,57}}, color={0,0,127}));
  connect(rTSwitch1.splitRatio, ratioControl.splitRatio) annotation (Line(
        points={{50,7},{50,-2},{-160,-2},{-160,50},{-120,50},{-120,57}},
                                                                      color={0,0,
          127}));
  connect(leakageA.splitRatio, ratioControl.splitRatio) annotation (Line(points={{-120,
          -43},{-120,-50},{-160,-50},{-160,50},{-120,50},{-120,57}}, color={0,
          0,127}));
  connect(leakageA1.splitRatio, ratioControl.splitRatio) annotation (Line(
        points={{50,-43},{50,-50},{-160,-50},{-160,50},{-120,50},{-120,57}},
        color={0,0,127}));
  connect(junctionRatio1.splitRatio, ratioControl.splitRatio) annotation (Line(
        points={{-70,-67},{-70,-50},{-160,-50},{-160,50},{-120,50},{-120,57}},
        color={0,0,127}));
  connect(junctionRatio2.splitRatio, ratioControl.splitRatio) annotation (Line(
        points={{100,-67},{100,-62},{20,-62},{20,-50},{-160,-50},{-160,50},{
          -120,50},{-120,57}},
                         color={0,0,127}));
  connect(const.y, pump.omega_input)
    annotation (Line(points={{165,44},{80,44},{80,48}}, color={0,0,127}));
  connect(pump2.omega_input, pump.omega_input) annotation (Line(points={{80,-2},{80,-6},{140,-6},{140,44},{80,44},{80,48}},
                                                    color={0,0,127}));
  connect(pump3.omega_input, pump.omega_input) annotation (Line(points={{80,-52},{80,-58},{140,-58},{140,44},{80,44},{80,48}},
                                                        color={0,0,127}));
  connect(pump1.omega_input, pump.omega_input) annotation (Line(points={{80,-102},{80,-106},{140,-106},{140,44},{80,44},{80,48}},
                                                        color={0,0,127}));

  connect(sink.inlet, flowResistance4.outlet) annotation (Line(
      points={{-20,80},{-30,80}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance4.inlet, junctionT2_1.outlet) annotation (Line(
      points={{-50,80},{-60,80}},
      color={28,108,200},
      thickness=0.5));
  connect(sink1.inlet, flowResistance5.outlet) annotation (Line(
      points={{-20,30},{-30,30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance5.inlet, junctionT2_3.outlet) annotation (Line(
      points={{-50,30},{-60,30}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT2_5.outlet, flowResistance6.inlet) annotation (Line(
      points={{-60,-20},{-50,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance6.outlet, sink2.inlet) annotation (Line(
      points={{-30,-20},{-20,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionRatio1.outlet, flowResistance7.inlet) annotation (Line(
      points={{-60,-70},{-50,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance7.outlet, sink3.inlet) annotation (Line(
      points={{-30,-70},{-20,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(sink4.inlet, flowResistance8.outlet) annotation (Line(
      points={{150,80},{140,80}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance8.inlet, junctionT2_2.outlet) annotation (Line(
      points={{120,80},{110,80}},
      color={28,108,200},
      thickness=0.5));
  connect(sink5.inlet, flowResistance9.outlet) annotation (Line(
      points={{150,30},{140,30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance9.inlet, junctionT2_4.outlet) annotation (Line(
      points={{120,30},{110,30}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionT2_6.outlet, flowResistance10.inlet) annotation (Line(
      points={{110,-20},{120,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance10.outlet, sink6.inlet) annotation (Line(
      points={{140,-20},{150,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(junctionRatio2.outlet, flowResistance11.inlet) annotation (Line(
      points={{110,-70},{120,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(flowResistance11.outlet, sink7.inlet) annotation (Line(
      points={{140,-70},{150,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(step.y, source.p0_var) annotation (Line(points={{-169,90},{-164,90},{
          -164,66},{-152,66}}, color={0,0,127}));
  connect(source1.p0_var, source.p0_var) annotation (Line(points={{-152,16},{
          -164,16},{-164,66},{-152,66}},
                                    color={0,0,127}));
  connect(source2.p0_var, source.p0_var) annotation (Line(points={{-152,-34},{
          -164,-34},{-164,66},{-152,66}},
                                     color={0,0,127}));
  connect(source3.p0_var, source.p0_var) annotation (Line(points={{-152,-84},{
          -164,-84},{-164,66},{-152,66}},
                                     color={0,0,127}));
  connect(source4.p0_var, source.p0_var) annotation (Line(points={{18,66},{8,66},
          {8,90},{-164,90},{-164,66},{-152,66}}, color={0,0,127}));
  connect(source5.p0_var, source.p0_var) annotation (Line(points={{18,16},{8,16},
          {8,90},{-164,90},{-164,66},{-152,66}}, color={0,0,127}));
  connect(source6.p0_var, source.p0_var) annotation (Line(points={{18,-34},{8,
          -34},{8,90},{-164,90},{-164,66},{-152,66}},
                                                   color={0,0,127}));
  connect(source7.p0_var, source.p0_var) annotation (Line(points={{18,-84},{8,
          -84},{8,90},{-164,90},{-164,66},{-152,66}},
                                                   color={0,0,127}));

  annotation (
    experiment(StopTime=150),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-110},{200,110}})),
    Documentation(info="<html>
</html>"));
end TestNonPhysical;
