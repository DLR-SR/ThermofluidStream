within ThermofluidStream;
model TestIcons
  extends Modelica.Icons.Example;
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true)  annotation (Placement(transformation(extent={{-540,500},{-520,520}})));
  ThermofluidStream.Processes.FlowResistance flowResistance annotation (Placement(transformation(extent={{-60,100},{-40,120}})));
  ThermofluidStream.Processes.TransportDelay transportDelay annotation (Placement(transformation(extent={{-20,100},{0,120}})));
  ThermofluidStream.Processes.Pump pump3(displayInstanceName=false)
                                         annotation (Placement(transformation(extent={{20,100},{40,120}})));
  ThermofluidStream.Processes.Pump pump4(omega_from_input=true) annotation (Placement(transformation(extent={{60,100},{80,120}})));
  ThermofluidStream.Processes.Pump pump5(
    omega_from_input=true,
    enableOutput=true,
    outputQuantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    enableAccessHeatPort=true) annotation (Placement(transformation(extent={{100,100},{120,120}})));
  ThermofluidStream.Processes.Compressor compressor annotation (Placement(transformation(extent={{20,60},{40,80}})));
  ThermofluidStream.Processes.Compressor compressor1(omega_from_input=true, enableOutput=false) annotation (Placement(transformation(extent={{60,60},{80,80}})));
  ThermofluidStream.Processes.Compressor compressor2(
    omega_from_input=false,
    enableOutput=true,
    outputQuantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    enableAccessHeatPort=true) annotation (Placement(transformation(extent={{100,60},{120,80}})));
  ThermofluidStream.Processes.Turbine turbine annotation (Placement(transformation(extent={{20,20},{40,40}})));
  ThermofluidStream.Processes.Turbine turbine1(omega_from_input=true) annotation (Placement(transformation(extent={{60,20},{80,40}})));
  ThermofluidStream.Processes.Turbine turbine2(
    omega_from_input=true,
    enableOutput=true,
    outputQuantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    enableAccessHeatPort=false) annotation (Placement(transformation(extent={{100,20},{120,40}})));
  ThermofluidStream.Processes.Fan fan annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  ThermofluidStream.Processes.Fan fan1(omega_from_input=true) annotation (Placement(transformation(extent={{60,-20},{80,0}})));
  ThermofluidStream.Processes.Fan fan2(
    omega_from_input=false,
    enableOutput=false,
    outputQuantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    enableAccessHeatPort=true) annotation (Placement(transformation(extent={{100,-20},{120,0}})));
  ThermofluidStream.Processes.ThermalConvectionPipe thermalConvectionPipe annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  ThermofluidStream.Processes.ConductionElement conductionElement annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  ThermofluidStream.Processes.Nozzle nozzle annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  ThermofluidStream.HeatExchangers.CounterFlowNTU counterFlowNTU annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-270,-170})));
  ThermofluidStream.HeatExchangers.CrossFlowNTU crossFlowNTU(displayInstanceName=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-230,-170})));
  ThermofluidStream.HeatExchangers.CrossFlowNTU crossFlowNTU1(displayInstanceName=false)
                                                                                       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-190,-170})));
  ThermofluidStream.Topology.SplitterT1 splitterT1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-510,110})));
  ThermofluidStream.Topology.SplitterT2 splitterT2 annotation (Placement(transformation(extent={{-520,60},{-500,80}})));
  ThermofluidStream.Topology.JunctionT2 junctionT2 annotation (Placement(transformation(extent={{-520,-20},{-500,0}})));
  ThermofluidStream.Topology.SplitterX splitterX(displayInstanceName=true)
                                                 annotation (Placement(transformation(extent={{-260,100},{-240,120}})));
  ThermofluidStream.Topology.JunctionX1 junctionX1 annotation (Placement(transformation(extent={{-260,60},{-240,80}})));
  ThermofluidStream.Topology.JunctionX2 junctionX2 annotation (Placement(transformation(extent={{-260,20},{-240,40}})));
  ThermofluidStream.Topology.JunctionX3 junctionX3 annotation (Placement(transformation(extent={{-260,-20},{-240,0}})));
  ThermofluidStream.Topology.JunctionT1 junctionT1 annotation (Placement(transformation(extent={{-520,20},{-500,40}})));
  ThermofluidStream.Topology.SplitterN splitterN annotation (Placement(transformation(extent={{-520,-80},{-500,-60}})));
  ThermofluidStream.Topology.JunctionN junctionN annotation (Placement(transformation(extent={{-480,-80},{-460,-60}})));
  ThermofluidStream.Topology.JunctionNM junctionNM annotation (Placement(transformation(extent={{-440,-80},{-420,-60}})));
  ThermofluidStream.Topology.DynamicJunctionNM dynamicJunctionNM annotation (Placement(transformation(extent={{-320,-80},{-300,-60}})));
  ThermofluidStream.Topology.DynamicJunctionN dynamicJunctionN annotation (Placement(transformation(extent={{-360,-80},{-340,-60}})));
  ThermofluidStream.Topology.DynamicSplitterN dynamicSplitterN annotation (Placement(transformation(extent={{-400,-80},{-380,-60}})));
  ThermofluidStream.Topology.NonPhysical.RatioControl ratioControl annotation (Placement(transformation(extent={{-280,-80},{-260,-60}})));
  ThermofluidStream.Topology.NonPhysical.RTSwitch rTSwitch annotation (Placement(transformation(extent={{-240,-80},{-220,-60}})));
  ThermofluidStream.Topology.NonPhysical.LeakageA leakageA annotation (Placement(transformation(extent={{-200,-80},{-180,-60}})));
  ThermofluidStream.Topology.NonPhysical.JunctionRatio junctionRatio1 annotation (Placement(transformation(extent={{-160,-80},{-140,-60}})));
  ThermofluidStream.Boundaries.Source source annotation (Placement(transformation(extent={{-38,260},{-18,280}})));
  ThermofluidStream.Boundaries.Sink sink annotation (Placement(transformation(extent={{2,260},{22,280}})));
  ThermofluidStream.Boundaries.TerminalSource terminalSource annotation (Placement(transformation(extent={{42,260},{62,280}})));
  ThermofluidStream.Boundaries.TerminalSink terminalSink annotation (Placement(transformation(extent={{82,260},{102,280}})));
  ThermofluidStream.Boundaries.DynamicPressureInflow dynamicPressureInflow(areaFromInput=true, velocityFromInput=true) annotation (Placement(transformation(extent={{122,260},{142,280}})));
  ThermofluidStream.Boundaries.DynamicPressureOutflow dynamicPressureOutflow(areaFromInput=true, velocityFromInput=true) annotation (Placement(transformation(extent={{162,260},{182,280}})));
  ThermofluidStream.Boundaries.Volume volume annotation (Placement(transformation(extent={{-38,220},{-18,240}})));
  ThermofluidStream.Boundaries.VolumeFlex volumeFlex annotation (Placement(transformation(extent={{2,220},{22,240}})));
  ThermofluidStream.Boundaries.VolumeMix volumeMix annotation (Placement(transformation(extent={{42,220},{62,240}})));
  ThermofluidStream.Boundaries.PhaseSeparator phaseSeparator annotation (Placement(transformation(extent={{82,220},{102,240}})));
  ThermofluidStream.Boundaries.PhaseSeparator2 phaseSeparator2 annotation (Placement(transformation(extent={{122,220},{142,240}})));
  ThermofluidStream.Boundaries.Reservoir reservoir annotation (Placement(transformation(extent={{162,220},{182,240}})));
  ThermofluidStream.Boundaries.Reservoir reservoir1(pEnvFromInput=true) annotation (Placement(transformation(extent={{202,220},{222,240}})));
  ThermofluidStream.Boundaries.CreateState createState annotation (Placement(transformation(extent={{202,260},{222,280}})));
  ThermofluidStream.Interfaces.StateInput u annotation (Placement(transformation(extent={{-402,432},{-362,472}})));
  ThermofluidStream.Interfaces.StateOutput y annotation (Placement(transformation(extent={{-342,442},{-322,462}})));
  ThermofluidStream.Interfaces.Inlet inlet annotation (Placement(transformation(extent={{-482,432},{-442,472}})));
  ThermofluidStream.Interfaces.Outlet outlet annotation (Placement(transformation(extent={{-444,432},{-404,472}})));
  Modelica.Blocks.Interfaces.RealInput u1 annotation (Placement(transformation(extent={{-402,392},{-362,432}})));
  Modelica.Blocks.Interfaces.RealOutput y1 annotation (Placement(transformation(extent={{-342,402},{-322,422}})));
  ThermofluidStream.HeatExchangers.DiscretizedCrossFlowHEX discretizedCrossFlowHEX annotation (Placement(transformation(extent={{-280,-220},{-260,-200}})));
  ThermofluidStream.HeatExchangers.DiscretizedCounterFlowHEX discretizedCounterFlowHEX annotation (Placement(transformation(extent={{-240,-220},{-220,-200}})));
  ThermofluidStream.HeatExchangers.DiscretizedCrossFlowHEX_FR discretizedCrossFlowHEX_FR annotation (Placement(transformation(extent={{-200,-220},{-180,-200}})));
  ThermofluidStream.HeatExchangers.DiscretizedCounterFlowHEX_FR discretizedCounterFlowHEX_FR annotation (Placement(transformation(extent={{-160,-220},{-140,-200}})));
  ThermofluidStream.FlowControl.BasicControlValve basicControlValve annotation (Placement(transformation(extent={{-60,-140},{-40,-120}})));
  ThermofluidStream.FlowControl.SpecificValveType specificValveType annotation (Placement(transformation(extent={{-20,-140},{0,-120}})));
  ThermofluidStream.FlowControl.TanValve tanValve annotation (Placement(transformation(extent={{20,-140},{40,-120}})));
  ThermofluidStream.FlowControl.CheckValve checkValve annotation (Placement(transformation(extent={{60,-140},{80,-120}})));
  ThermofluidStream.FlowControl.MCV mCV(setpointFromInput=true) annotation (Placement(transformation(extent={{-20,-180},{0,-160}})));
  ThermofluidStream.FlowControl.PCV pCV(pressureFromInput=true) annotation (Placement(transformation(extent={{-60,-180},{-40,-160}})));
  ThermofluidStream.FlowControl.Switch switch annotation (Placement(transformation(extent={{100,-180},{120,-160}})));
  ThermofluidStream.FlowControl.FourWaySwitch fourWaySwitch annotation (Placement(transformation(extent={{100,-140},{120,-120}})));
  ThermofluidStream.FlowControl.MCV mCV1(setpointFromInput=true, enableClippingOutput=true) annotation (Placement(transformation(extent={{20,-180},{40,-160}})));
  ThermofluidStream.FlowControl.MCV mCV2(
    displayInstanceName=false,
    setpointFromInput=true,
    enableClippingOutput=true) annotation (Placement(transformation(extent={{60,-180},{80,-160}})));
  ThermofluidStream.Boundaries.Reservoir reservoir2(displayInstanceName=false, pEnvFromInput=true) annotation (Placement(transformation(extent={{240,220},{260,240}})));
  Sensors.SingleSensorSelect singleSensorSelect(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K, outputValue=true) annotation (Placement(transformation(extent={{180,100},{200,120}})));
  Sensors.SingleSensorSelect singleSensorSelect1(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C) annotation (Placement(transformation(extent={{220,100},{240,120}})));
  Sensors.SingleSensorSelect singleSensorSelect2(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa, outputValue=true) annotation (Placement(transformation(extent={{260,100},{280,120}})));
  Sensors.SingleSensorSelect singleSensorSelect5(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_bar) annotation (Placement(transformation(extent={{180,80},{200,100}})));
  Sensors.SingleSensorSelect singleSensorSelect6(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_Pa, outputValue=true) annotation (Placement(transformation(extent={{220,80},{240,100}})));
  Sensors.SingleSensorSelect singleSensorSelect7(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_bar) annotation (Placement(transformation(extent={{260,80},{280,100}})));
  Sensors.SingleSensorSelect singleSensorSelect10(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3, outputValue=true) annotation (Placement(transformation(extent={{180,60},{200,80}})));
  Sensors.SingleSensorSelect singleSensorSelect11(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.v_m3pkg) annotation (Placement(transformation(extent={{220,60},{240,80}})));
  Sensors.SingleSensorSelect singleSensorSelect12(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.a_mps, outputValue=true) annotation (Placement(transformation(extent={{260,60},{280,80}})));
  Sensors.SingleSensorSelect2 singleSensorSelect2_1(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K, outputValue=true) annotation (Placement(transformation(extent={{300,100},{320,120}})));
  Sensors.SingleSensorSelect2 singleSensorSelect2_3(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C) annotation (Placement(transformation(extent={{340,100},{360,120}})));
  Sensors.SingleSensorSelect2 singleSensorSelect2_4(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa, outputValue=true) annotation (Placement(transformation(extent={{380,100},{400,120}})));
  Sensors.SingleSensorSelect2 singleSensorSelect22(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_bar) annotation (Placement(transformation(extent={{300,80},{320,100}})));
  Sensors.SingleSensorSelect2 singleSensorSelect23(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_Pa, outputValue=true) annotation (Placement(transformation(extent={{340,80},{360,100}})));
  Sensors.SingleSensorSelect2 singleSensorSelect24(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_bar) annotation (Placement(transformation(extent={{380,80},{400,100}})));
  Sensors.SingleSensorSelect2 singleSensorSelect27(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3, outputValue=true) annotation (Placement(transformation(extent={{300,60},{320,80}})));
  Sensors.SingleSensorSelect2 singleSensorSelect28(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.v_m3pkg) annotation (Placement(transformation(extent={{340,60},{360,80}})));
  Sensors.SingleSensorSelect2 singleSensorSelect29(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.a_mps, outputValue=true) annotation (Placement(transformation(extent={{380,60},{400,80}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg, outputValue=true) annotation (Placement(transformation(extent={{180,20},{200,40}})));
  Sensors.SensorState sensorState annotation (Placement(transformation(extent={{220,20},{240,40}})));
  Sensors.SingleSensorX singleSensorX(outputValue=true) annotation (Placement(transformation(extent={{260,20},{280,40}})));
  Sensors.MultiSensor_Tp multiSensor_Tp(outputTemperature=true, outputPressure=true) annotation (Placement(transformation(extent={{340,20},{360,40}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK, outputValue=true) annotation (Placement(transformation(extent={{300,20},{320,40}})));
  Sensors.SingleFlowSensor singleFlowSensor(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_gps, outputValue=true) annotation (Placement(transformation(extent={{380,20},{400,40}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm(
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true) annotation (Placement(transformation(extent={{180,-40},{200,-20}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect1(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg) annotation (Placement(transformation(extent={{180,0},{200,20}})));
  Sensors.SensorState sensorState1 annotation (Placement(transformation(extent={{220,0},{240,20}})));
  Sensors.SingleSensorX singleSensorX1 annotation (Placement(transformation(extent={{260,0},{280,20}})));
  Sensors.MultiSensor_Tp multiSensor_Tp1 annotation (Placement(transformation(extent={{342,-10},{362,10}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect1(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK) annotation (Placement(transformation(extent={{302,-10},{322,10}})));
  Sensors.SingleFlowSensor singleFlowSensor1(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_gps, outputValue=false) annotation (Placement(transformation(extent={{380,-10},{400,10}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm1 annotation (Placement(transformation(extent={{220,-40},{240,-20}})));
  Topology.Variants.Trash.SplitterT1v2 splitterT1new2 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-410,110})));
  Topology.Variants.Trash.SplitterT2v1 splitterT2new1 annotation (Placement(transformation(extent={{-460,60},{-440,80}})));
  Topology.Variants.Trash.JunctionT1v2 junctionT1new2 annotation (Placement(transformation(extent={{-420,20},{-400,40}})));
  Topology.Variants.Trash.SplitterT2v2 splitterT2new2 annotation (Placement(transformation(extent={{-420,60},{-400,80}})));
  Topology.Variants.JunctionT2v1 junctionT2new1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-450,-10})));
  Topology.Variants.Trash.JunctionT1v1 junctionT1new1 annotation (Placement(transformation(extent={{-460,20},{-440,40}})));
  Topology.Variants.Trash.SplitterT1v1 splitterT1new1 annotation (Placement(transformation(extent={{-460,100},{-440,120}})));
  Topology.Variants.Trash.JunctionT2v2 junctionT2new2 annotation (Placement(transformation(extent={{-420,-20},{-400,0}})));
  Topology.Variants.JunctionX1v2 junctionX1new annotation (Placement(transformation(extent={{-200,60},{-180,80}})));
  Topology.Variants.Trash.JunctionX2v2 junctionX2v2 annotation (Placement(transformation(extent={{-200,20},{-180,40}})));
  Topology.Variants.JunctionX3v2 junctionX3new annotation (Placement(transformation(extent={{-200,-20},{-180,0}})));
  Undirected.Interfaces.Rear rear annotation (Placement(transformation(extent={{-200,420},{-160,460}})));
  Undirected.Interfaces.Fore fore annotation (Placement(transformation(extent={{-160,420},{-120,460}})));
  Undirected.Boundaries.BoundaryRear boundaryRear annotation (Placement(transformation(extent={{-520,-440},{-500,-420}})));
  Undirected.Boundaries.BoundaryFore boundaryFore annotation (Placement(transformation(extent={{-480,-440},{-460,-420}})));
  Undirected.Boundaries.TerminalRear terminalRear annotation (Placement(transformation(extent={{-440,-440},{-420,-420}})));
  Undirected.Boundaries.TerminalFore terminalFore annotation (Placement(transformation(extent={{-400,-440},{-380,-420}})));
  Undirected.Boundaries.Volume volume1 annotation (Placement(transformation(extent={{-360,-440},{-340,-420}})));
  Undirected.Boundaries.VolumeFlex volumeFlex1 annotation (Placement(transformation(extent={{-320,-440},{-300,-420}})));
  Undirected.Boundaries.VolumeMix volumeMix1 annotation (Placement(transformation(extent={{-520,-480},{-500,-460}})));
  Undirected.Boundaries.PhaseSeparator phaseSeparator1 annotation (Placement(transformation(extent={{-478,-480},{-458,-460}})));
  Undirected.Boundaries.Reservoir reservoir3 annotation (Placement(transformation(extent={{-440,-480},{-420,-460}})));
  Undirected.Boundaries.Reservoir reservoir4(pEnvFromInput=true) annotation (Placement(transformation(extent={{-400,-480},{-380,-460}})));
  Undirected.Boundaries.Reservoir reservoir5(displayInstanceName=false, pEnvFromInput=true) annotation (Placement(transformation(extent={{-360,-480},{-340,-460}})));
  Boundaries.CreateState createState1 annotation (Placement(transformation(extent={{-320,-480},{-300,-460}})));
  Undirected.Topology.JunctionMN junctionMN annotation (Placement(transformation(extent={{-240,-440},{-220,-420}})));
  Undirected.Topology.ConnectInletFore connectInletFore annotation (Placement(transformation(extent={{-200,-440},{-180,-420}})));
  Undirected.Topology.ConnectInletRear connectInletRear annotation (Placement(transformation(extent={{-160,-440},{-140,-420}})));
  Undirected.Topology.ConnectRearOutlet connectRearOutlet annotation (Placement(transformation(extent={{-120,-440},{-100,-420}})));
  Undirected.Topology.ConnectForeOutlet connectForeOutlet annotation (Placement(transformation(extent={{-80,-440},{-60,-420}})));
  Undirected.Topology.ConnectForeFore connectForeFore annotation (Placement(transformation(extent={{-40,-440},{-20,-420}})));
  Undirected.Topology.ConnectRearRear connectRearRear annotation (Placement(transformation(extent={{0,-440},{20,-420}})));
  Undirected.Topology.ConnectorInletOutletFore connectorInletOutletFore annotation (Placement(transformation(extent={{40,-440},{60,-420}})));
  Undirected.Topology.JunctionRFF junctionRFF annotation (Placement(transformation(extent={{-240,-480},{-220,-460}})));
  Undirected.Topology.JunctionRFF2 junctionRFF2_1 annotation (Placement(transformation(extent={{-200,-480},{-180,-460}})));
  Undirected.Topology.JunctionRRF junctionRRF annotation (Placement(transformation(extent={{-160,-480},{-140,-460}})));
  Undirected.Topology.JunctionRRF2 junctionRRF2_1 annotation (Placement(transformation(extent={{-120,-480},{-100,-460}})));
  Undirected.Topology.JunctionRFFF junctionRFFF annotation (Placement(transformation(extent={{-80,-480},{-60,-460}})));
  Undirected.Topology.JunctionRRFF junctionRRFF annotation (Placement(transformation(extent={{-40,-480},{-20,-460}})));
  Undirected.Topology.JunctionRRFF2 junctionRRFF2_1 annotation (Placement(transformation(extent={{0,-480},{20,-460}})));
  Undirected.Topology.JunctionRRRF junctionRRRF annotation (Placement(transformation(extent={{40,-480},{60,-460}})));
  Undirected.Processes.FlowResistance flowResistance1 annotation (Placement(transformation(extent={{120,-440},{140,-420}})));
  Undirected.Processes.TransportDelay transportDelay1 annotation (Placement(transformation(extent={{160,-440},{180,-420}})));
  Undirected.Processes.ConductionElement conductionElement1 annotation (Placement(transformation(extent={{200,-440},{220,-420}})));
  Undirected.HeatExchangers.DiscretizedCrossFlowHEX discretizedCrossFlowHEX1 annotation (Placement(transformation(extent={{280,-440},{300,-420}})));
  Undirected.HeatExchangers.DiscretizedCounterFlowHEX discretizedCounterFlowHEX1 annotation (Placement(transformation(extent={{320,-440},{340,-420}})));
  Undirected.FlowControl.BasicControlValve basicControlValve1 annotation (Placement(transformation(extent={{-500,-580},{-480,-560}})));
  Undirected.FlowControl.SpecificValveType specificValveType1 annotation (Placement(transformation(extent={{-460,-580},{-440,-560}})));
  Undirected.FlowControl.TanValve tanValve1 annotation (Placement(transformation(extent={{-420,-580},{-400,-560}})));
  Undirected.FlowControl.MCV mCV3(setpointFromInput=true, enableClippingOutput=true) annotation (Placement(transformation(extent={{-500,-620},{-480,-600}})));
  Undirected.FlowControl.CheckValve checkValve1 annotation (Placement(transformation(extent={{-420,-620},{-400,-600}})));
  Undirected.FlowControl.MCV mCV4(
    displayInstanceName=false,
    setpointFromInput=true,
    enableClippingOutput=true) annotation (Placement(transformation(extent={{-460,-620},{-440,-600}})));
  Undirected.Sensors.SingleSensorSelect singleSensorSelect3(outputValue=true) annotation (Placement(transformation(extent={{160,-542},{180,-522}})));
  Undirected.Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect2(outputValue=true) annotation (Placement(transformation(extent={{200,-542},{220,-522}})));
  Undirected.Sensors.SensorState sensorState2 annotation (Placement(transformation(extent={{240,-542},{260,-522}})));
  Undirected.Sensors.SingleSensorX singleSensorX2 annotation (Placement(transformation(extent={{160,-572},{180,-552}})));
  Undirected.Sensors.MultiSensor_Tpm multiSensor_Tpm2 annotation (Placement(transformation(extent={{200,-572},{220,-552}})));
  Undirected.Sensors.MultiSensor_Tpm multiSensor_Tpm3(
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true) annotation (Placement(transformation(extent={{240,-572},{260,-552}})));
  Topology.Variants.Trash.SplitterT1v3 splitterT1v3_1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-370,110})));
  Topology.Variants.Trash.SplitterT1v3 splitterv3_2(rotateInstanceName=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-330,110})));
  Topology.Variants.Trash.SplitterT2v3 splitterT2v3_1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-370,70})));
  Topology.Variants.Trash.SplitterT2v3 splitterT2v3_2(rotateInstanceName=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-330,70})));
  Topology.Variants.JunctionT1v3 junctionT1v3 annotation (Placement(transformation(extent={{-380,20},{-360,40}})));
  Undirected.Topology.JunctionRFFF junctionRFFF1(displayInstanceName=false)
                                                annotation (Placement(transformation(extent={{-80,-520},{-60,-500}})));
  Undirected.Topology.JunctionRRFF junctionRRFF1(displayInstanceName=false)
                                                annotation (Placement(transformation(extent={{-40,-520},{-20,-500}})));
  Undirected.Topology.JunctionRRFF2 junctionRRFF2_2(displayInstanceName=false)
                                                    annotation (Placement(transformation(extent={{0,-520},{20,-500}})));
  Undirected.Topology.JunctionRRRF junctionRRRF1(displayInstanceName=false)
                                                annotation (Placement(transformation(extent={{40,-520},{60,-500}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-540,-780},{420,520}}), graphics={
        Rectangle(
          extent={{-566,390},{430,344}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Rectangle(
          extent={{-304,392},{-504,492}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-504,512},{-304,492}},
          textColor={28,108,200},
          textString="Interfaces"),
        Rectangle(
          extent={{280,200},{-60,300}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-60,320},{242,300}},
          textColor={28,108,200},
          textString="Boundaries"),
        Rectangle(
          extent={{-120,-100},{-540,160}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-540,180},{-122,160}},
          textColor={28,108,200},
          textString="Topology"),
        Rectangle(
          extent={{140,-40},{-80,140}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-80,160},{140,140}},
          textColor={28,108,200},
          textString="Processes"),
        Rectangle(
          extent={{-120,-240},{-300,-140}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-300,-120},{-120,-140}},
          textColor={28,108,200},
          textString="HeatExchangers"),
        Rectangle(
          extent={{140,-200},{-80,-100}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-80,-80},{140,-100}},
          textColor={28,108,200},
          textString="FlowControl"),
        Rectangle(
          extent={{420,-60},{160,140}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{160,160},{420,140}},
          textColor={28,108,200},
          textString="Sensors"),
        Rectangle(
          extent={{-538,-40},{-484,140}},
          lineColor={28,108,200},
          lineThickness=1),
        Rectangle(
          extent={{-528,6},{-520,0}},
          lineColor={28,108,200},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-480,-40},{-300,140}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-538,158},{-484,142}},
          textColor={28,108,200},
          textString="alt"),
        Text(
          extent={{-478,160},{-398,142}},
          textColor={28,108,200},
          textString="neu?"),
        Rectangle(
          extent={{-280,-40},{-226,140}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-220,160},{-140,142}},
          textColor={28,108,200},
          textString="neu?"),
        Text(
          extent={{-280,158},{-226,142}},
          textColor={28,108,200},
          textString="alt"),
        Rectangle(
          extent={{-222,-40},{-122,140}},
          lineColor={28,108,200},
          lineThickness=1),
        Rectangle(
          extent={{-528,46},{-520,40}},
          lineColor={28,108,200},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-268,86},{-260,80}},
          lineColor={28,108,200},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-268,6},{-260,0}},
          lineColor={28,108,200},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-212,122},{-204,116}},
          lineColor={28,108,200},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-216,118},{-124,86}},
          textColor={28,108,200},
          textString="shouldnt the outlet be on the 
right side for components that 
are marked with the red square?"),
        Text(
          extent={{-558,400},{418,340}},
          textColor={28,108,200},
          textString="Mark everything exept interfaces to check if displayInstanceName works"),
        Text(
          extent={{-540,-280},{420,-340}},
          textColor={28,108,200},
          textString="Undirected"),
        Text(
          extent={{-200,500},{-120,480}},
          textColor={28,108,200},
          textString="Interfaces"),
        Rectangle(
          extent={{-120,400},{-200,480}},
          lineColor={28,108,200},
          lineThickness=1),
        Rectangle(
          extent={{-280,-500},{-540,-400}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-540,-380},{-280,-400}},
          textColor={28,108,200},
          textString="Boundaries"),
        Rectangle(
          extent={{80,-542},{-260,-400}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-260,-380},{80,-400}},
          textColor={28,108,200},
          textString="Topology"),
        Rectangle(
          extent={{240,-460},{100,-400}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{100,-380},{240,-400}},
          textColor={28,108,200},
          textString="Processes"),
        Rectangle(
          extent={{360,-460},{260,-400}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{260,-360},{360,-400}},
          textColor={28,108,200},
          textString="HeatExchangers"),
        Text(
          extent={{-520,-522},{-380,-540}},
          textColor={28,108,200},
          textString="FlowControl"),
        Rectangle(
          extent={{-380,-640},{-520,-540}},
          lineColor={28,108,200},
          lineThickness=1),
        Rectangle(
          extent={{-528,126},{-520,120}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-468,126},{-460,120}},
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-428,126},{-420,120}},
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-354,120},{-346,114}},
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-468,86},{-460,80}},
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-428,86},{-420,80}},
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-354,80},{-346,74}},
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-528,86},{-520,80}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-468,46},{-460,40}},
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-428,46},{-420,40}},
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-388,46},{-380,40}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-428,6},{-420,0}},
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-468,6},{-460,0}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-268,126},{-260,120}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-208,86},{-200,80}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-268,46},{-260,40}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-208,6},{-200,0}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-208,46},{-200,40}},
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-674,102},{-666,96}},
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-672,132},{-664,126}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-660,140},{-560,120}},
          textColor={28,108,200},
          textString="my favorite version"),
        Text(
          extent={{-656,110},{-556,90}},
          textColor={28,108,200},
          textString="not necessary"),
        Rectangle(
          extent={{-676,74},{-668,68}},
          lineColor={28,108,200},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-660,80},{-560,60}},
          textColor={28,108,200},
          textString="i would change that"),
        Rectangle(
          extent={{280,-600},{140,-500}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{140,-480},{280,-500}},
          textColor={28,108,200},
          textString="Sensors")}));
end TestIcons;
