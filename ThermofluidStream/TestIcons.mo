within ThermofluidStream;
model TestIcons
  extends Modelica.Icons.Example;
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true)  annotation (Placement(transformation(extent={{-540,500},{-520,520}})));
  ThermofluidStream.Processes.FlowResistance flowResistance annotation (Placement(transformation(extent={{-290,210},{-270,230}})));
  ThermofluidStream.Processes.TransportDelay transportDelay annotation (Placement(transformation(extent={{-250,210},{-230,230}})));
  ThermofluidStream.Processes.Pump pump3(displayInstanceName=false)
                                         annotation (Placement(transformation(extent={{-208,206},{-188,226}})));
  ThermofluidStream.Processes.Pump pump4(omega_from_input=true) annotation (Placement(transformation(extent={{-168,206},{-148,226}})));
  ThermofluidStream.Processes.Pump pump5(
    omega_from_input=true,
    enableOutput=true,
    outputQuantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    enableAccessHeatPort=true) annotation (Placement(transformation(extent={{-128,206},{-108,226}})));
  ThermofluidStream.Processes.Compressor compressor annotation (Placement(transformation(extent={{-208,166},{-188,186}})));
  ThermofluidStream.Processes.Compressor compressor1(omega_from_input=true, enableOutput=false) annotation (Placement(transformation(extent={{-168,166},{-148,186}})));
  ThermofluidStream.Processes.Compressor compressor2(
    omega_from_input=false,
    enableOutput=true,
    outputQuantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    enableAccessHeatPort=true) annotation (Placement(transformation(extent={{-128,166},{-108,186}})));
  ThermofluidStream.Processes.Turbine turbine annotation (Placement(transformation(extent={{-208,126},{-188,146}})));
  ThermofluidStream.Processes.Turbine turbine1(omega_from_input=true) annotation (Placement(transformation(extent={{-168,126},{-148,146}})));
  ThermofluidStream.Processes.Turbine turbine2(
    omega_from_input=true,
    enableOutput=true,
    outputQuantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    enableAccessHeatPort=false) annotation (Placement(transformation(extent={{-128,126},{-108,146}})));
  ThermofluidStream.Processes.Fan fan annotation (Placement(transformation(extent={{-208,86},{-188,106}})));
  ThermofluidStream.Processes.Fan fan1(omega_from_input=true) annotation (Placement(transformation(extent={{-168,86},{-148,106}})));
  ThermofluidStream.Processes.Fan fan2(
    omega_from_input=false,
    enableOutput=false,
    outputQuantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    enableAccessHeatPort=true) annotation (Placement(transformation(extent={{-128,86},{-108,106}})));
  ThermofluidStream.Processes.ThermalConvectionPipe thermalConvectionPipe annotation (Placement(transformation(extent={{-288,166},{-268,186}})));
  ThermofluidStream.Processes.ConductionElement conductionElement annotation (Placement(transformation(extent={{-248,166},{-228,186}})));
  ThermofluidStream.Processes.Nozzle nozzle annotation (Placement(transformation(extent={{-288,126},{-268,146}})));
  ThermofluidStream.HeatExchangers.CounterFlowNTU counterFlowNTU annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-210,-190})));
  ThermofluidStream.HeatExchangers.CrossFlowNTU crossFlowNTU(displayInstanceName=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-310,-180})));
  ThermofluidStream.Topology.SplitterT1 splitterT1(displayInstanceName=true)
                                                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-510,270})));
  ThermofluidStream.Topology.SplitterT2 splitterT2 annotation (Placement(transformation(extent={{-480,260},{-460,280}})));
  ThermofluidStream.Topology.JunctionT2 junctionT2 annotation (Placement(transformation(extent={{-400,260},{-380,280}})));
  ThermofluidStream.Topology.SplitterX splitterX(displayInstanceName=true)
                                                 annotation (Placement(transformation(extent={{-520,220},{-500,240}})));
  ThermofluidStream.Topology.JunctionX1 junctionX1 annotation (Placement(transformation(extent={{-480,220},{-460,240}})));
  ThermofluidStream.Topology.JunctionX2 junctionX2 annotation (Placement(transformation(extent={{-440,220},{-420,240}})));
  ThermofluidStream.Topology.JunctionX3 junctionX3 annotation (Placement(transformation(extent={{-400,220},{-380,240}})));
  ThermofluidStream.Topology.JunctionT1 junctionT1 annotation (Placement(transformation(extent={{-440,260},{-420,280}})));
  ThermofluidStream.Topology.SplitterN splitterN annotation (Placement(transformation(extent={{-520,180},{-500,200}})));
  ThermofluidStream.Topology.JunctionN junctionN annotation (Placement(transformation(extent={{-480,180},{-460,200}})));
  ThermofluidStream.Topology.JunctionNM junctionNM annotation (Placement(transformation(extent={{-440,180},{-420,200}})));
  ThermofluidStream.Topology.DynamicJunctionNM dynamicJunctionNM annotation (Placement(transformation(extent={{-440,140},{-420,160}})));
  ThermofluidStream.Topology.DynamicJunctionN dynamicJunctionN annotation (Placement(transformation(extent={{-480,140},{-460,160}})));
  ThermofluidStream.Topology.DynamicSplitterN dynamicSplitterN annotation (Placement(transformation(extent={{-520,140},{-500,160}})));
  ThermofluidStream.Topology.NonPhysical.RatioControl ratioControl annotation (Placement(transformation(extent={{-520,100},{-500,120}})));
  ThermofluidStream.Topology.NonPhysical.RTSwitch rTSwitch annotation (Placement(transformation(extent={{-480,100},{-460,120}})));
  ThermofluidStream.Topology.NonPhysical.LeakageA leakageA annotation (Placement(transformation(extent={{-440,100},{-420,120}})));
  ThermofluidStream.Topology.NonPhysical.JunctionRatio junctionRatio1 annotation (Placement(transformation(extent={{-400,100},{-380,120}})));
  ThermofluidStream.Boundaries.Source source annotation (Placement(transformation(extent={{-40,260},{-20,280}})));
  ThermofluidStream.Boundaries.Sink sink annotation (Placement(transformation(extent={{0,260},{20,280}})));
  ThermofluidStream.Boundaries.TerminalSource terminalSource annotation (Placement(transformation(extent={{40,260},{60,280}})));
  ThermofluidStream.Boundaries.TerminalSink terminalSink annotation (Placement(transformation(extent={{80,260},{100,280}})));
  ThermofluidStream.Boundaries.DynamicPressureInflow dynamicPressureInflow(areaFromInput=true, velocityFromInput=true) annotation (Placement(transformation(extent={{120,260},{140,280}})));
  ThermofluidStream.Boundaries.DynamicPressureOutflow dynamicPressureOutflow(areaFromInput=true, velocityFromInput=true) annotation (Placement(transformation(extent={{160,260},{180,280}})));
  ThermofluidStream.Boundaries.Volume volume annotation (Placement(transformation(extent={{-40,220},{-20,240}})));
  ThermofluidStream.Boundaries.VolumeFlex volumeFlex annotation (Placement(transformation(extent={{0,220},{20,240}})));
  ThermofluidStream.Boundaries.VolumeMix volumeMix annotation (Placement(transformation(extent={{40,220},{60,240}})));
  ThermofluidStream.Boundaries.PhaseSeparator phaseSeparator annotation (Placement(transformation(extent={{80,220},{100,240}})));
  ThermofluidStream.Boundaries.PhaseSeparator2 phaseSeparator2 annotation (Placement(transformation(extent={{120,220},{140,240}})));
  ThermofluidStream.Boundaries.Reservoir reservoir annotation (Placement(transformation(extent={{160,220},{180,240}})));
  ThermofluidStream.Boundaries.Reservoir reservoir1(pEnvFromInput=true) annotation (Placement(transformation(extent={{200,220},{220,240}})));
  ThermofluidStream.Boundaries.CreateState createState annotation (Placement(transformation(extent={{200,260},{220,280}})));
  ThermofluidStream.Interfaces.StateInput u annotation (Placement(transformation(extent={{-400,440},{-360,480}}), iconTransformation(extent={{-400,440},{-360,480}})));
  ThermofluidStream.Interfaces.StateOutput y annotation (Placement(transformation(extent={{-340,450},{-320,470}}), iconTransformation(extent={{-340,450},{-320,470}})));
  ThermofluidStream.Interfaces.Inlet inlet annotation (Placement(transformation(extent={{-480,440},{-442,478}}), iconTransformation(extent={{-480,440},{-442,478}})));
  ThermofluidStream.Interfaces.Outlet outlet annotation (Placement(transformation(extent={{-440,440},{-400,480}}), iconTransformation(extent={{-440,440},{-400,480}})));
  Modelica.Blocks.Interfaces.RealInput u1 annotation (Placement(transformation(extent={{-400,400},{-360,440}}), iconTransformation(extent={{-400,400},{-360,440}})));
  Modelica.Blocks.Interfaces.RealOutput y1 annotation (Placement(transformation(extent={{-340,410},{-320,430}}), iconTransformation(extent={{-340,410},{-320,430}})));
  ThermofluidStream.HeatExchangers.DiscretizedCrossFlowHEX discretizedCrossFlowHEX annotation (Placement(transformation(extent={{-320,-220},{-300,-200}})));
  ThermofluidStream.HeatExchangers.DiscretizedCounterFlowHEX discretizedCounterFlowHEX annotation (Placement(transformation(extent={{-220,-280},{-200,-260}})));
  ThermofluidStream.HeatExchangers.DiscretizedCrossFlowHEX_FR discretizedCrossFlowHEX_FR annotation (Placement(transformation(extent={{-320,-250},{-300,-230}})));
  ThermofluidStream.HeatExchangers.DiscretizedCounterFlowHEX_FR discretizedCounterFlowHEX_FR annotation (Placement(transformation(extent={{-220,-240},{-200,-220}})));
  ThermofluidStream.FlowControl.BasicControlValve basicControlValve annotation (Placement(transformation(extent={{-288,-34},{-268,-14}})));
  ThermofluidStream.FlowControl.SpecificValveType specificValveType annotation (Placement(transformation(extent={{-248,-34},{-228,-14}})));
  ThermofluidStream.FlowControl.TanValve tanValve annotation (Placement(transformation(extent={{-208,-34},{-188,-14}})));
  ThermofluidStream.FlowControl.CheckValve checkValve annotation (Placement(transformation(extent={{-168,-34},{-148,-14}})));
  ThermofluidStream.FlowControl.MCV mCV(setpointFromInput=true) annotation (Placement(transformation(extent={{-248,-74},{-228,-54}})));
  ThermofluidStream.FlowControl.PCV pCV(pressureFromInput=true) annotation (Placement(transformation(extent={{-288,-74},{-268,-54}})));
  ThermofluidStream.FlowControl.Switch switch annotation (Placement(transformation(extent={{-128,-74},{-108,-54}})));
  ThermofluidStream.FlowControl.FourWaySwitch fourWaySwitch annotation (Placement(transformation(extent={{-128,-34},{-108,-14}})));
  ThermofluidStream.FlowControl.MCV mCV1(setpointFromInput=true, enableClippingOutput=true) annotation (Placement(transformation(extent={{-208,-74},{-188,-54}})));
  ThermofluidStream.FlowControl.MCV mCV2(
    displayInstanceName=false,
    setpointFromInput=true,
    enableClippingOutput=true) annotation (Placement(transformation(extent={{-168,-74},{-148,-54}})));
  ThermofluidStream.Boundaries.Reservoir reservoir2(displayInstanceName=false, pEnvFromInput=true) annotation (Placement(transformation(extent={{240,220},{260,240}})));
  Sensors.SingleSensorSelect singleSensorSelect(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K, outputValue=true) annotation (Placement(transformation(extent={{140,100},{160,120}})));
  Sensors.SingleSensorSelect singleSensorSelect1(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C) annotation (Placement(transformation(extent={{180,100},{200,120}})));
  Sensors.SingleSensorSelect singleSensorSelect2(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa, outputValue=true) annotation (Placement(transformation(extent={{220,100},{240,120}})));
  Sensors.SingleSensorSelect singleSensorSelect5(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.v_m3pkg)
                                                                                                                     annotation (Placement(transformation(extent={{220,80},{240,100}})));
  Sensors.SingleSensorSelect singleSensorSelect6(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg,     outputValue=true) annotation (Placement(transformation(extent={{140,60},{160,80}})));
  Sensors.SingleSensorSelect singleSensorSelect7(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK)     annotation (Placement(transformation(extent={{180,60},{200,80}})));
  Sensors.SingleSensorSelect singleSensorSelect10(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1,                                                 outputValue=true) annotation (Placement(transformation(extent={{180,40},{200,60}})));
  Sensors.SingleSensorSelect singleSensorSelect11(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.a_mps)
                                                                                                                        annotation (Placement(transformation(extent={{220,40},{240,60}})));
  Sensors.SingleSensorSelect singleSensorSelect12(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.MM_kgpmol,                                           outputValue=true) annotation (Placement(transformation(extent={{140,20},{160,40}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg, outputValue=true) annotation (Placement(transformation(extent={{140,-180},{160,-160}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,      outputValue=true) annotation (Placement(transformation(extent={{140,-40},{160,-20}})));
  Sensors.SingleFlowSensor singleFlowSensor(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,outputValue=true) annotation (Placement(transformation(extent={{340,90},{360,110}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect1(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_K) annotation (Placement(transformation(extent={{180,-180},{200,-160}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect1(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)      annotation (Placement(transformation(extent={{180,-40},{200,-20}})));
  Sensors.SingleFlowSensor singleFlowSensor1(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_gps, outputValue=false) annotation (Placement(transformation(extent={{380,90},{400,110}})));
  Undirected.Interfaces.Rear rear annotation (Placement(transformation(extent={{-200,420},{-160,460}}), iconTransformation(extent={{-200,420},{-160,460}})));
  Undirected.Interfaces.Fore fore annotation (Placement(transformation(extent={{-160,420},{-120,460}}), iconTransformation(extent={{-160,420},{-120,460}})));
  Undirected.Boundaries.BoundaryRear boundaryRear annotation (Placement(transformation(extent={{-520,-558},{-500,-538}})));
  Undirected.Boundaries.BoundaryFore boundaryFore annotation (Placement(transformation(extent={{-480,-558},{-460,-538}})));
  Undirected.Boundaries.TerminalRear terminalRear annotation (Placement(transformation(extent={{-440,-558},{-420,-538}})));
  Undirected.Boundaries.TerminalFore terminalFore annotation (Placement(transformation(extent={{-400,-558},{-380,-538}})));
  Undirected.Boundaries.Volume volume1 annotation (Placement(transformation(extent={{-360,-558},{-340,-538}})));
  Undirected.Boundaries.VolumeFlex volumeFlex1 annotation (Placement(transformation(extent={{-320,-558},{-300,-538}})));
  Undirected.Boundaries.VolumeMix volumeMix1 annotation (Placement(transformation(extent={{-520,-598},{-500,-578}})));
  Undirected.Boundaries.PhaseSeparator phaseSeparator1 annotation (Placement(transformation(extent={{-480,-598},{-460,-578}})));
  Undirected.Boundaries.Reservoir reservoir3 annotation (Placement(transformation(extent={{-440,-598},{-420,-578}})));
  Undirected.Boundaries.Reservoir reservoir4(pEnvFromInput=true) annotation (Placement(transformation(extent={{-400,-598},{-380,-578}})));
  Undirected.Boundaries.Reservoir reservoir5(displayInstanceName=false, pEnvFromInput=true) annotation (Placement(transformation(extent={{-360,-598},{-340,-578}})));
  Boundaries.CreateState createState1 annotation (Placement(transformation(extent={{-320,-598},{-300,-578}})));
  Undirected.Topology.JunctionMN junctionMN annotation (Placement(transformation(extent={{-240,-558},{-220,-538}})));
  Undirected.Topology.ConnectInletFore connectInletFore annotation (Placement(transformation(extent={{-200,-558},{-180,-538}})));
  Undirected.Topology.ConnectInletRear connectInletRear annotation (Placement(transformation(extent={{-160,-558},{-140,-538}})));
  Undirected.Topology.ConnectRearOutlet connectRearOutlet annotation (Placement(transformation(extent={{-120,-558},{-100,-538}})));
  Undirected.Topology.ConnectForeOutlet connectForeOutlet annotation (Placement(transformation(extent={{-80,-558},{-60,-538}})));
  Undirected.Topology.ConnectForeFore connectForeFore annotation (Placement(transformation(extent={{-40,-558},{-20,-538}})));
  Undirected.Topology.ConnectRearRear connectRearRear annotation (Placement(transformation(extent={{0,-558},{20,-538}})));
  Undirected.Topology.ConnectorInletOutletFore connectorInletOutletFore annotation (Placement(transformation(extent={{40,-558},{60,-538}})));
  Undirected.Topology.JunctionRFF junctionRFF annotation (Placement(transformation(extent={{-240,-598},{-220,-578}})));
  Undirected.Topology.JunctionRFF2 junctionRFF2_1 annotation (Placement(transformation(extent={{-200,-598},{-180,-578}})));
  Undirected.Topology.JunctionRRF junctionRRF annotation (Placement(transformation(extent={{-160,-598},{-140,-578}})));
  Undirected.Topology.JunctionRRF2 junctionRRF2_1 annotation (Placement(transformation(extent={{-120,-598},{-100,-578}})));
  Undirected.Topology.JunctionRFFF junctionRFFF annotation (Placement(transformation(extent={{-80,-598},{-60,-578}})));
  Undirected.Topology.JunctionRRFF junctionRRFF annotation (Placement(transformation(extent={{-40,-598},{-20,-578}})));
  Undirected.Topology.JunctionRRFF2 junctionRRFF2_1 annotation (Placement(transformation(extent={{0,-598},{20,-578}})));
  Undirected.Topology.JunctionRRRF junctionRRRF annotation (Placement(transformation(extent={{40,-598},{60,-578}})));
  Undirected.Processes.FlowResistance flowResistance1 annotation (Placement(transformation(extent={{-240,-758},{-220,-738}})));
  Undirected.Processes.TransportDelay transportDelay1 annotation (Placement(transformation(extent={{-200,-758},{-180,-738}})));
  Undirected.Processes.ConductionElement conductionElement1 annotation (Placement(transformation(extent={{-160,-758},{-140,-738}})));
  Undirected.HeatExchangers.DiscretizedCrossFlowHEX discretizedCrossFlowHEX1 annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,-790})));
  Undirected.HeatExchangers.DiscretizedCounterFlowHEX discretizedCounterFlowHEX1 annotation (Placement(transformation(extent={{-80,-760},{-60,-740}})));
  Undirected.FlowControl.BasicControlValve basicControlValve1 annotation (Placement(transformation(extent={{-500,-698},{-480,-678}})));
  Undirected.FlowControl.SpecificValveType specificValveType1 annotation (Placement(transformation(extent={{-460,-698},{-440,-678}})));
  Undirected.FlowControl.TanValve tanValve1 annotation (Placement(transformation(extent={{-420,-698},{-400,-678}})));
  Undirected.FlowControl.MCV mCV3(setpointFromInput=true, enableClippingOutput=true) annotation (Placement(transformation(extent={{-500,-738},{-480,-718}})));
  Undirected.FlowControl.CheckValve checkValve1 annotation (Placement(transformation(extent={{-380,-738},{-360,-718}})));
  Undirected.FlowControl.MCV mCV4(
    setpointFromInput=true,
    enableClippingOutput=true) annotation (Placement(transformation(extent={{-460,-738},{-440,-718}})));
  Undirected.Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect2(outputValue=true) annotation (Placement(transformation(extent={{184,-466},{204,-446}})));
  Undirected.Sensors.SensorState sensorState2 annotation (Placement(transformation(extent={{224,-466},{244,-446}})));
  Undirected.Sensors.SingleSensorX singleSensorX2 annotation (Placement(transformation(extent={{144,-506},{164,-486}})));
  Undirected.Sensors.MultiSensor_Tpm multiSensor_Tpm2 annotation (Placement(transformation(extent={{184,-506},{204,-486}})));
  Undirected.Sensors.MultiSensor_Tpm multiSensor_Tpm3(
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true) annotation (Placement(transformation(extent={{224,-506},{244,-486}})));
  Undirected.Topology.JunctionRFFF junctionRFFF1(displayInstanceName=false)
                                                annotation (Placement(transformation(extent={{-80,-638},{-60,-618}})));
  Undirected.Topology.JunctionRRFF junctionRRFF1(displayInstanceName=false)
                                                annotation (Placement(transformation(extent={{-40,-638},{-20,-618}})));
  Undirected.Topology.JunctionRRFF2 junctionRRFF2_2(displayInstanceName=false)
                                                    annotation (Placement(transformation(extent={{0,-638},{20,-618}})));
  Undirected.Topology.JunctionRRRF junctionRRRF1(displayInstanceName=false)
                                                annotation (Placement(transformation(extent={{40,-638},{60,-618}})));
  Undirected.HeatExchangers.DiscretizedCrossFlowHEX discretizedCrossFlowHEX3(displayInstanceName=false)
                                                                             annotation (Placement(transformation(extent={{0,-800},{20,-780}})));
  Undirected.FlowControl.MCV mCV5(setpointFromInput=true, enableClippingOutput=false)
                               annotation (Placement(transformation(extent={{-420,-738},{-400,-718}})));
  Sensors.SingleSensorSelect singleSensorSelect4(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3, outputValue=true)
                                                                                                                                    annotation (Placement(transformation(extent={{180,80},{200,100}})));
  Sensors.SingleSensorSelect singleSensorSelect3(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar, outputValue=true)
                                                                                                                                    annotation (Placement(transformation(extent={{140,80},{160,100}})));
  Sensors.SingleSensorSelect singleSensorSelect8(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK, outputValue=true)
                                                                                                                                    annotation (Placement(transformation(extent={{220,60},{240,80}})));
  Sensors.SingleSensorSelect singleSensorSelect9(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cv_JpkgK, outputValue=true)
                                                                                                                                    annotation (Placement(transformation(extent={{140,40},{160,60}})));
  Sensors.SingleSensorSelect singleSensorSelect13(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_Pa,
    outputValue=true)                                                                                                               annotation (Placement(transformation(extent={{180,20},{200,40}})));
  Sensors.SingleSensorSelect singleSensorSelect14(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_bar,
    outputValue=true)                                                                                                               annotation (Placement(transformation(extent={{220,20},{240,40}})));
  Sensors.SingleSensorSelect singleSensorSelect15(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_Pa,
    outputValue=true)                                                                                                               annotation (Placement(transformation(extent={{140,0},{160,20}})));
  Sensors.SingleSensorSelect singleSensorSelect16(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_bar,
    outputValue=true)                                                                                                               annotation (Placement(transformation(extent={{180,0},{200,20}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect3(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C) annotation (Placement(transformation(extent={{220,-180},{240,-160}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect4(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa)
                                                                                                                                   annotation (Placement(transformation(extent={{140,-200},{160,-180}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect5(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_bar)
                                                                                                                                   annotation (Placement(transformation(extent={{180,-200},{200,-180}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect6(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K)
                                                                                                                                   annotation (Placement(transformation(extent={{220,-200},{240,-180}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect7(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_Pa)
                                                                                                                                   annotation (Placement(transformation(extent={{140,-220},{160,-200}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect8(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_bar)
                                                                                                                                   annotation (Placement(transformation(extent={{180,-220},{200,-200}})));
  Sensors.SingleFlowSensor singleFlowSensor2(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps,
    outputValue=true)                                                                                                                          annotation (Placement(transformation(extent={{380,70},{400,90}})));
  Sensors.SingleFlowSensor singleFlowSensor3(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.S_flow_JpKs,
    outputValue=false)                                                                                                                           annotation (Placement(transformation(extent={{420,70},{440,90}})));
  Sensors.SingleFlowSensor singleFlowSensor4(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.Cp_flow_JpKs,
    outputValue=true)                                                                                                                          annotation (Placement(transformation(extent={{340,50},{360,70}})));
  Sensors.SingleFlowSensor singleFlowSensor5(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_m3ps, outputValue=false)
                                                                                                                                                 annotation (Placement(transformation(extent={{420,90},{440,110}})));
  Sensors.SingleFlowSensor singleFlowSensor6(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_lpMin,
    outputValue=true)                                                                                                                          annotation (Placement(transformation(extent={{340,70},{360,90}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect2(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa, outputValue=true)    annotation (Placement(transformation(extent={{220,-40},{240,-20}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect3(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar)    annotation (Placement(transformation(extent={{140,-60},{160,-40}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect4(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{140,-100},{160,-80}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect5(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.v_m3pkg)
                                                                                                                                annotation (Placement(transformation(extent={{180,-100},{200,-80}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect6(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{180,-60},{200,-40}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect7(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK)
                                                                                                                                annotation (Placement(transformation(extent={{220,-60},{240,-40}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect8(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{140,-80},{160,-60}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect9(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cv_JpkgK)
                                                                                                                                annotation (Placement(transformation(extent={{180,-80},{200,-60}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect10(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{220,-80},{240,-60}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect11(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.a_mps)
                                                                                                                                annotation (Placement(transformation(extent={{140,-140},{160,-120}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect12(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.MM_kgpmol, outputValue=true)
                                                                                                                                                 annotation (Placement(transformation(extent={{220,-100},{240,-80}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect13(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_Pa)    annotation (Placement(transformation(extent={{140,-120},{160,-100}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect14(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_bar, outputValue=true)  annotation (Placement(transformation(extent={{180,-120},{200,-100}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect15(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_Pa)
                                                                                                                                annotation (Placement(transformation(extent={{220,-120},{240,-100}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect16(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_bar)
                                                                                                                                annotation (Placement(transformation(extent={{180,-140},{200,-120}})));
  Modelica.Fluid.Sensors.RelativePressure relativePressure annotation (Placement(transformation(extent={{80,-120},{100,-100}})));
  Modelica.Fluid.Sensors.RelativeTemperature relativeTemperature annotation (Placement(transformation(extent={{80,-90},{100,-70}})));
  Modelica.Fluid.Sensors.Pressure pressure annotation (Placement(transformation(extent={{98,58},{118,78}})));
  Modelica.Fluid.Sensors.Density density annotation (Placement(transformation(extent={{100,28},{120,48}})));
  Modelica.Fluid.Sensors.DensityTwoPort density1 annotation (Placement(transformation(extent={{60,28},{80,48}})));
  Modelica.Fluid.Sensors.Temperature temperature annotation (Placement(transformation(extent={{100,96},{120,116}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temperature1 annotation (Placement(transformation(extent={{60,98},{80,118}})));
  Modelica.Fluid.Sensors.SpecificEnthalpy specificEnthalpy annotation (Placement(transformation(extent={{100,-12},{120,8}})));
  Modelica.Fluid.Sensors.SpecificEnthalpyTwoPort specificEnthalpy1 annotation (Placement(transformation(extent={{60,-12},{80,8}})));
  Modelica.Fluid.Sensors.SpecificEntropy specificEntropy annotation (Placement(transformation(extent={{100,-52},{120,-32}})));
  Modelica.Fluid.Sensors.SpecificEntropyTwoPort specificEntropy1 annotation (Placement(transformation(extent={{60,-52},{80,-32}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate annotation (Placement(transformation(extent={{376,50},{396,70}})));
  Modelica.Fluid.Sensors.VolumeFlowRate volumeFlowRate annotation (Placement(transformation(extent={{416,50},{436,70}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg, outputValue=true) annotation (Placement(transformation(extent={{140,-260},{160,-240}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect1(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_K) annotation (Placement(transformation(extent={{180,-260},{200,-240}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect2(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C, outputValue=true) annotation (Placement(transformation(extent={{220,-260},{240,-240}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect3(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa) annotation (Placement(transformation(extent={{140,-280},{160,-260}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect4(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_bar, outputValue=true) annotation (Placement(transformation(extent={{180,-280},{200,-260}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect5(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K) annotation (Placement(transformation(extent={{220,-280},{240,-260}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect6(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_Pa, outputValue=true) annotation (Placement(transformation(extent={{140,-300},{160,-280}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect7(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_bar) annotation (Placement(transformation(extent={{180,-300},{200,-280}})));
  Sensors.SensorState sensorState annotation (Placement(transformation(extent={{370,-188},{390,-168}})));
  Sensors.SingleSensorX singleSensorX(outputValue=true) annotation (Placement(transformation(extent={{340,-90},{360,-70}})));
  Sensors.SingleSensorX singleSensorX1 annotation (Placement(transformation(extent={{380,-90},{400,-70}})));
  Modelica.Fluid.Sensors.MassFractions massFraction annotation (Placement(transformation(extent={{420,-90},{440,-70}})));
  Modelica.Fluid.Sensors.MassFractionsTwoPort massFraction1 annotation (Placement(transformation(extent={{420,-120},{440,-100}})));
  Modelica.Fluid.Sensors.TraceSubstancesTwoPort traceSubstance annotation (Placement(transformation(extent={{340,-120},{360,-100}})));
  Modelica.Fluid.Sensors.TraceSubstances traceSubstance1 annotation (Placement(transformation(extent={{380,-120},{400,-100}})));
  Sensors.TemperaturePressureSensor temperaturePressureSensor_1 annotation (Placement(transformation(extent={{340,0},{360,20}})));
  Sensors.TemperaturePressureSensor temperaturePressureSensor_2(temperatureUnit="degC", pressureUnit="bar") annotation (Placement(transformation(extent={{380,0},{400,20}})));
  Sensors.TemperaturePressureSensor temperaturePressureSensor_3(outputTemperature=true, outputPressure=true) annotation (Placement(transformation(extent={{340,-30},{360,-10}})));
  Sensors.TemperaturePressureSensor temperaturePressureSensor_4(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=true,
    outputPressure=true) annotation (Placement(transformation(extent={{380,-30},{400,-10}})));
  Undirected.HeatExchangers.DiscretizedCrossFlowHEX2 discretizedCrossFlowHEX2_1 annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,-790})));
  HeatExchangers.CrossFlowNTU2                  crossFlowNTU2(displayInstanceName=true)
                                                                                       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-270,-180})));
  HeatExchangers.DiscretizedCrossFlowHEX2                  discretizedCrossFlowHEX2_3
                                                                                   annotation (Placement(transformation(extent={{-280,-220},{-260,-200}})));
  HeatExchangers.DiscretizedCrossFlowHEX_FR2                  discretizedCrossFlowHEX_FR2
                                                                                         annotation (Placement(transformation(extent={{-280,-250},{-260,-230}})));
  Undirected.HeatExchangers.DiscretizedCrossFlowHEX discretizedCrossFlowHEX6 annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-310,-310})));
  Undirected.HeatExchangers.DiscretizedCrossFlowHEX2 discretizedCrossFlowHEX2_2 annotation (Placement(transformation(extent={{-280,-320},{-260,-300}})));
  HeatExchangers.DiscretizedCrossFlowHEX_FR                   discretizedCrossFlowHEX_FR1(displayInstanceName=false)
                                                                                         annotation (Placement(transformation(extent={{-320,-280},{-300,-260}})));
  HeatExchangers.DiscretizedCrossFlowHEX_FR2                  discretizedCrossFlowHEX_FR3(displayInstanceName=false)
                                                                                         annotation (Placement(transformation(extent={{-280,-280},{-260,-260}})));
  Undirected.HeatExchangers.DiscretizedCrossFlowHEX discretizedCrossFlowHEX2(displayInstanceName=false)
                                                                             annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-310,-350})));
  Undirected.HeatExchangers.DiscretizedCrossFlowHEX2 discretizedCrossFlowHEX2_4(displayInstanceName=false) annotation (Placement(transformation(extent={{-280,-360},{-260,-340}})));
  Sensors.MultiSensor_Tp multiSensor_Tp2(outputTemperature=false, outputPressure=false) annotation (Placement(transformation(extent={{260,90},{280,110}})));
  Sensors.MultiSensor_Tp multiSensor_Tp5(temperatureUnit="degC", pressureUnit="bar") annotation (Placement(transformation(extent={{300,90},{320,110}})));
  Sensors.MultiSensor_Tp multiSensor_Tp6(outputTemperature=true, outputPressure=true) annotation (Placement(transformation(extent={{260,62},{280,82}})));
  Sensors.MultiSensor_Tp multiSensor_Tp7(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=true,
    outputPressure=true) annotation (Placement(transformation(extent={{300,60},{320,80}})));
  Sensors.DifferenceSensor_Tp differenceSensor_Tp annotation (Placement(transformation(extent={{260,10},{280,30}})));
  Sensors.DifferenceSensor_Tp differenceSensor_Tp1(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=false,
    outputPressure=false) annotation (Placement(transformation(extent={{300,10},{320,30}})));
  Sensors.DifferenceSensor_Tp differenceSensor_Tp2(outputTemperature=true, outputPressure=true) annotation (Placement(transformation(extent={{260,-20},{280,0}})));
  Sensors.DifferenceSensor_Tp differenceSensor_Tp3(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=true,
    outputPressure=true) annotation (Placement(transformation(extent={{300,-20},{320,0}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm1 annotation (Placement(transformation(extent={{260,-70},{280,-50}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm4(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)")                  annotation (Placement(transformation(extent={{300,-70},{320,-50}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm5(
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true)               annotation (Placement(transformation(extent={{260,-100},{280,-80}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm6(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)",
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true)               annotation (Placement(transformation(extent={{300,-100},{320,-80}})));
  Sensors.MultiSensor_Tpm_v2 MultiSensor_Tpm_v2_1 annotation (Placement(transformation(extent={{260,-160},{280,-140}})));
  Sensors.MultiSensor_Tpm_v2 MultiSensor_Tpm_v2_3(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)") annotation (Placement(transformation(extent={{300,-160},{320,-140}})));
  Sensors.MultiSensor_Tpm_v2 MultiSensor_Tpm_v2_4(
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true) annotation (Placement(transformation(extent={{260,-190},{280,-170}})));
  Sensors.MultiSensor_Tpm_v2 MultiSensor_Tpm_v2_2(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)",
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true) annotation (Placement(transformation(extent={{300,-190},{320,-170}})));
  Sensors.MultiSensor_Tpm_v3 MultiSensor_Tpm_v3_1 annotation (Placement(transformation(extent={{260,-230},{280,-210}})));
  Sensors.MultiSensor_Tpm_v3 MultiSensor_Tpm_v3_3(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)") annotation (Placement(transformation(extent={{300,-230},{320,-210}})));
  Sensors.MultiSensor_Tpm_v3 MultiSensor_Tpm_v3_4(
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true) annotation (Placement(transformation(extent={{260,-260},{280,-240}})));
  Sensors.MultiSensor_Tpm_v3 MultiSensor_Tpm_v3_2(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)",
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true) annotation (Placement(transformation(extent={{300,-260},{320,-240}})));
equation
  connect(discretizedCrossFlowHEX2_1.rearA, discretizedCounterFlowHEX1.foreB) annotation (Line(
      points={{-30,-780},{-30,-744},{-60,-744}},
      color={28,108,200},
      thickness=0.5));
  connect(discretizedCrossFlowHEX1.rearA, discretizedCounterFlowHEX1.foreA) annotation (Line(
      points={{-70,-780},{-70,-774},{-80,-774},{-80,-756}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-540,-800},{1480,520}}),graphics={
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
          extent={{-360,80},{-540,300}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-540,320},{-360,300}},
          textColor={28,108,200},
          textString="Topology"),
        Rectangle(
          extent={{-88,66},{-308,246}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-308,266},{-88,246}},
          textColor={28,108,200},
          textString="Processes"),
        Rectangle(
          extent={{-180,-380},{-340,-140}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-340,-120},{-180,-140}},
          textColor={28,108,200},
          textString="HeatExchangers"),
        Rectangle(
          extent={{-88,-94},{-308,6}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-308,26},{-88,6}},
          textColor={28,108,200},
          textString="FlowControl"),
        Rectangle(
          extent={{466,-332},{44,158}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{160,180},{420,160}},
          textColor={28,108,200},
          textString="Sensors"),
        Text(
          extent={{-558,400},{418,340}},
          textColor={28,108,200},
          textString="Mark everything exept interfaces to check if displayInstanceName works"),
        Text(
          extent={{-542,-432},{84,-486}},
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
          extent={{-280,-618},{-540,-518}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-540,-498},{-280,-518}},
          textColor={28,108,200},
          textString="Boundaries"),
        Rectangle(
          extent={{80,-660},{-260,-518}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-260,-498},{80,-518}},
          textColor={28,108,200},
          textString="Topology"),
        Rectangle(
          extent={{-120,-778},{-260,-718}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-260,-698},{-120,-718}},
          textColor={28,108,200},
          textString="Processes"),
        Rectangle(
          extent={{40,-820},{-100,-718}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-100,-696},{40,-718}},
          textColor={28,108,200},
          textString="HeatExchangers"),
        Text(
          extent={{-520,-640},{-380,-658}},
          textColor={28,108,200},
          textString="FlowControl"),
        Rectangle(
          extent={{-360,-758},{-520,-658}},
          lineColor={28,108,200},
          lineThickness=1),
        Rectangle(
          extent={{-674,212},{-666,206}},
          lineColor={28,108,200},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-660,218},{-560,198}},
          textColor={28,108,200},
          textString="might be changed in a major release"),
        Rectangle(
          extent={{264,-526},{124,-426}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{124,-406},{264,-426}},
          textColor={28,108,200},
          textString="Sensors"),
        Text(
          extent={{140,140},{240,120}},
          textColor={28,108,200},
          textString="SingleSensorSelect"),
        Text(
          extent={{140,-140},{240,-160}},
          textColor={28,108,200},
          textString="TwoPhaseSensorSelect"),
        Text(
          extent={{340,140},{440,120}},
          textColor={28,108,200},
          textString="SingleFlowSensor"),
        Text(
          extent={{140,0},{240,-20}},
          textColor={28,108,200},
          textString="DifferenceSensorSelect"),
        Text(
          extent={{140,-220},{240,-240}},
          textColor={28,108,200},
          textString="DifferenceTwoPhaseSensorSelect"),
        Rectangle(
          extent={{-674,234},{-666,228}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-660,242},{-560,222}},
          textColor={28,108,200},
          textString="my favorite version"),
        Text(
          extent={{340,-40},{440,-60}},
          textColor={28,108,200},
          textString="singleSensorX"),
        Text(
          extent={{340,40},{400,20}},
          textColor={28,108,200},
          textString="FlowSensor_Tp"),
        Text(
          extent={{-320,-140},{-300,-160}},
          textColor={28,108,200},
          textString="v1"),
        Text(
          extent={{-280,-140},{-260,-160}},
          textColor={28,108,200},
          textString="v2"),
        Rectangle(
          extent={{-438,292},{-430,286}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-398,292},{-390,286}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-22,-774},{-14,-780}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-284,-156},{-276,-162}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-260,-194},{-252,-200}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-258,-224},{-250,-230}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{260,140},{320,120}},
          textColor={28,108,200},
          textString="MultiSensor_Tp"),
        Text(
          extent={{260,60},{320,40}},
          textColor={28,108,200},
          textString="DifferenceSensor_Tp"),
        Text(
          extent={{260,-30},{320,-50}},
          textColor={28,108,200},
          textString="MultiSensor_Tpm"),
        Text(
          extent={{260,-110},{320,-130}},
          textColor={28,108,200},
          textString="v2"),
        Text(
          extent={{260,-190},{320,-210}},
          textColor={28,108,200},
          textString="v3"),
        Text(
          extent={{360,-140},{400,-160}},
          textColor={28,108,200},
          textString="SensorState")}));
end TestIcons;
