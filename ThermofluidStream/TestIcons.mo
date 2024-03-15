within ThermofluidStream;
model TestIcons
  extends Modelica.Icons.Example;
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
                                                                                  annotation (Placement(transformation(extent={{-540,500},{-520,520}})));
  ThermofluidStream.Processes.FlowResistance flowResistance annotation (Placement(transformation(extent={{-302,264},{-282,284}})));
  ThermofluidStream.Processes.TransportDelay transportDelay annotation (Placement(transformation(extent={{-262,264},{-242,284}})));
  ThermofluidStream.Processes.Pump pump3(displayInstanceName=false)
                                         annotation (Placement(transformation(extent={{-220,260},{-200,280}})));
  ThermofluidStream.Processes.Pump pump4(omega_from_input=true) annotation (Placement(transformation(extent={{-180,260},{-160,280}})));
  ThermofluidStream.Processes.Pump pump5(
    omega_from_input=true,
    enableOutput=true,
    outputQuantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    enableAccessHeatPort=true) annotation (Placement(transformation(extent={{-140,260},{-120,280}})));
  ThermofluidStream.Processes.Compressor compressor annotation (Placement(transformation(extent={{-220,220},{-200,240}})));
  ThermofluidStream.Processes.Compressor compressor1(omega_from_input=true, enableOutput=false) annotation (Placement(transformation(extent={{-180,220},{-160,240}})));
  ThermofluidStream.Processes.Compressor compressor2(
    omega_from_input=false,
    enableOutput=true,
    outputQuantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    enableAccessHeatPort=true) annotation (Placement(transformation(extent={{-140,220},{-120,240}})));
  ThermofluidStream.Processes.Turbine turbine annotation (Placement(transformation(extent={{-220,180},{-200,200}})));
  ThermofluidStream.Processes.Turbine turbine1(omega_from_input=true) annotation (Placement(transformation(extent={{-180,180},{-160,200}})));
  ThermofluidStream.Processes.Turbine turbine2(
    omega_from_input=true,
    enableOutput=true,
    outputQuantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    enableAccessHeatPort=false) annotation (Placement(transformation(extent={{-140,180},{-120,200}})));
  ThermofluidStream.Processes.Fan fan annotation (Placement(transformation(extent={{-220,140},{-200,160}})));
  ThermofluidStream.Processes.Fan fan1(omega_from_input=true) annotation (Placement(transformation(extent={{-180,140},{-160,160}})));
  ThermofluidStream.Processes.Fan fan2(
    omega_from_input=false,
    enableOutput=false,
    outputQuantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    enableAccessHeatPort=true) annotation (Placement(transformation(extent={{-140,140},{-120,160}})));
  ThermofluidStream.Processes.ThermalConvectionPipe thermalConvectionPipe annotation (Placement(transformation(extent={{-300,220},{-280,240}})));
  ThermofluidStream.Processes.ConductionElement conductionElement annotation (Placement(transformation(extent={{-260,220},{-240,240}})));
  ThermofluidStream.Processes.Nozzle nozzle annotation (Placement(transformation(extent={{-300,180},{-280,200}})));
  ThermofluidStream.HeatExchangers.CounterFlowNTU counterFlowNTU annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-470,-10})));
  ThermofluidStream.HeatExchangers.CrossFlowNTU crossFlowNTU(displayInstanceName=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-510,-10})));
  ThermofluidStream.Topology.SplitterT1 splitterT1(displayInstanceName=true)
                                                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-510,270})));
  ThermofluidStream.Topology.SplitterT2 splitterT2(displayInstanceName=true)
                                                   annotation (Placement(transformation(extent={{-480,260},{-460,280}})));
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
  ThermofluidStream.Boundaries.Sink sink annotation (Placement(transformation(extent={{0,260},{20,280}})));
  ThermofluidStream.Boundaries.TerminalSource terminalSource annotation (Placement(transformation(extent={{40,260},{60,280}})));
  ThermofluidStream.Boundaries.TerminalSink terminalSink annotation (Placement(transformation(extent={{80,260},{100,280}})));
  ThermofluidStream.Boundaries.DynamicPressureInflow dynamicPressureInflow(areaFromInput=true, velocityFromInput=true) annotation (Placement(transformation(extent={{120,260},{140,280}})));
  ThermofluidStream.Boundaries.DynamicPressureOutflow dynamicPressureOutflow(areaFromInput=true, velocityFromInput=true) annotation (Placement(transformation(extent={{160,260},{180,280}})));
  ThermofluidStream.Boundaries.Volume volume annotation (Placement(transformation(extent={{-40,220},{-20,240}})));
  ThermofluidStream.Boundaries.VolumeFlex volumeFlex annotation (Placement(transformation(extent={{0,220},{20,240}})));
  ThermofluidStream.Boundaries.VolumeMix volumeMix(N=2)
                                                   annotation (Placement(transformation(extent={{40,220},{60,240}})));
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
  ThermofluidStream.HeatExchangers.DiscretizedCrossFlowHEX discretizedCrossFlowHEX annotation (Placement(transformation(extent={{-480,-60},{-460,-40}})));
  ThermofluidStream.HeatExchangers.DiscretizedCounterFlowHEX discretizedCounterFlowHEX annotation (Placement(transformation(extent={{-440,-20},{-420,0}})));
  ThermofluidStream.HeatExchangers.DiscretizedCrossFlowHEX_FR discretizedCrossFlowHEX_FR annotation (Placement(transformation(extent={{-440,-60},{-420,-40}})));
  ThermofluidStream.HeatExchangers.DiscretizedCounterFlowHEX_FR discretizedCounterFlowHEX_FR annotation (Placement(transformation(extent={{-520,-60},{-500,-40}})));
  ThermofluidStream.FlowControl.BasicControlValve basicControlValve annotation (Placement(transformation(extent={{-360,-20},{-340,0}})));
  ThermofluidStream.FlowControl.SpecificValveType specificValveType annotation (Placement(transformation(extent={{-320,-20},{-300,0}})));
  ThermofluidStream.FlowControl.TanValve tanValve annotation (Placement(transformation(extent={{-280,-20},{-260,0}})));
  ThermofluidStream.FlowControl.CheckValve checkValve annotation (Placement(transformation(extent={{-240,-20},{-220,0}})));
  ThermofluidStream.FlowControl.MCV mCV(setpointFromInput=true) annotation (Placement(transformation(extent={{-322,-60},{-302,-40}})));
  ThermofluidStream.FlowControl.PCV pCV(pressureFromInput=true) annotation (Placement(transformation(extent={{-360,-60},{-340,-40}})));
  ThermofluidStream.FlowControl.Switch switch annotation (Placement(transformation(extent={{-200,-60},{-180,-40}})));
  ThermofluidStream.FlowControl.FourWaySwitch fourWaySwitch annotation (Placement(transformation(extent={{-200,-20},{-180,0}})));
  ThermofluidStream.FlowControl.MCV mCV1(setpointFromInput=true, enableClippingOutput=true) annotation (Placement(transformation(extent={{-280,-60},{-260,-40}})));
  ThermofluidStream.FlowControl.MCV mCV2(
    displayInstanceName=false,
    setpointFromInput=true,
    enableClippingOutput=true) annotation (Placement(transformation(extent={{-240,-60},{-220,-40}})));
  ThermofluidStream.Boundaries.Reservoir reservoir2(displayInstanceName=false, pEnvFromInput=true) annotation (Placement(transformation(extent={{240,220},{260,240}})));
  Sensors.SingleSensorSelect singleSensorSelect(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K, outputValue=true) annotation (Placement(transformation(extent={{60,100},{80,120}})));
  Sensors.SingleSensorSelect singleSensorSelect1(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C) annotation (Placement(transformation(extent={{100,100},{120,120}})));
  Sensors.SingleSensorSelect singleSensorSelect2(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa, outputValue=true) annotation (Placement(transformation(extent={{140,100},{160,120}})));
  Sensors.SingleSensorSelect singleSensorSelect5(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.v_m3pkg)
                                                                                                                     annotation (Placement(transformation(extent={{140,80},{160,100}})));
  Sensors.SingleSensorSelect singleSensorSelect6(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg,     outputValue=true) annotation (Placement(transformation(extent={{60,60},{80,80}})));
  Sensors.SingleSensorSelect singleSensorSelect7(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK)     annotation (Placement(transformation(extent={{100,60},{120,80}})));
  Sensors.SingleSensorSelect singleSensorSelect10(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1,                                                 outputValue=true) annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Sensors.SingleSensorSelect singleSensorSelect11(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.a_mps)
                                                                                                                        annotation (Placement(transformation(extent={{140,40},{160,60}})));
  Sensors.SingleSensorSelect singleSensorSelect12(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.MM_kgpmol,                                           outputValue=true) annotation (Placement(transformation(extent={{60,20},{80,40}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg, outputValue=true) annotation (Placement(transformation(extent={{60,-140},{80,-120}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,      outputValue=true) annotation (Placement(transformation(extent={{260,0},{280,20}})));
  Sensors.SingleFlowSensor singleFlowSensor(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,outputValue=true) annotation (Placement(transformation(extent={{60,-58},{80,-38}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect1(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_K) annotation (Placement(transformation(extent={{100,-140},{120,-120}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect1(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)      annotation (Placement(transformation(extent={{300,0},{320,20}})));
  Sensors.SingleFlowSensor singleFlowSensor1(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_gps, outputValue=false) annotation (Placement(transformation(extent={{100,-58},{120,-38}})));
  Undirected.Interfaces.Rear rear annotation (Placement(transformation(extent={{-200,420},{-160,460}}), iconTransformation(extent={{-200,420},{-160,460}})));
  Undirected.Interfaces.Fore fore annotation (Placement(transformation(extent={{-160,420},{-120,460}}), iconTransformation(extent={{-160,420},{-120,460}})));
  Undirected.Boundaries.BoundaryRear boundaryRear annotation (Placement(transformation(extent={{-520,-400},{-500,-380}})));
  Undirected.Boundaries.BoundaryFore boundaryFore annotation (Placement(transformation(extent={{-480,-400},{-460,-380}})));
  Undirected.Boundaries.TerminalRear terminalRear annotation (Placement(transformation(extent={{-440,-400},{-420,-380}})));
  Undirected.Boundaries.TerminalFore terminalFore annotation (Placement(transformation(extent={{-400,-400},{-380,-380}})));
  Undirected.Boundaries.Volume volume1 annotation (Placement(transformation(extent={{-360,-400},{-340,-380}})));
  Undirected.Boundaries.VolumeFlex volumeFlex1 annotation (Placement(transformation(extent={{-320,-400},{-300,-380}})));
  Undirected.Boundaries.VolumeMix volumeMix1 annotation (Placement(transformation(extent={{-520,-440},{-500,-420}})));
  Undirected.Boundaries.PhaseSeparator phaseSeparator1 annotation (Placement(transformation(extent={{-480,-440},{-460,-420}})));
  Undirected.Boundaries.Reservoir reservoir3 annotation (Placement(transformation(extent={{-440,-440},{-420,-420}})));
  Undirected.Boundaries.Reservoir reservoir4(pEnvFromInput=true) annotation (Placement(transformation(extent={{-400,-440},{-380,-420}})));
  Undirected.Boundaries.Reservoir reservoir5(displayInstanceName=false, pEnvFromInput=true) annotation (Placement(transformation(extent={{-360,-440},{-340,-420}})));
  Boundaries.CreateState createState1 annotation (Placement(transformation(extent={{-320,-440},{-300,-420}})));
  Undirected.Topology.JunctionMN junctionMN annotation (Placement(transformation(extent={{-240,-400},{-220,-380}})));
  Undirected.Topology.ConnectInletFore connectInletFore annotation (Placement(transformation(extent={{-200,-400},{-180,-380}})));
  Undirected.Topology.ConnectInletRear connectInletRear annotation (Placement(transformation(extent={{-160,-400},{-140,-380}})));
  Undirected.Topology.ConnectRearOutlet connectRearOutlet annotation (Placement(transformation(extent={{-120,-400},{-100,-380}})));
  Undirected.Topology.ConnectForeOutlet connectForeOutlet annotation (Placement(transformation(extent={{-80,-400},{-60,-380}})));
  Undirected.Topology.ConnectForeFore connectForeFore annotation (Placement(transformation(extent={{-40,-400},{-20,-380}})));
  Undirected.Topology.ConnectRearRear connectRearRear annotation (Placement(transformation(extent={{0,-400},{20,-380}})));
  Undirected.Topology.ConnectorInletOutletFore connectorInletOutletFore annotation (Placement(transformation(extent={{40,-400},{60,-380}})));
  Undirected.Topology.JunctionRFF junctionRFF annotation (Placement(transformation(extent={{-240,-440},{-220,-420}})));
  Undirected.Topology.JunctionRFF2 junctionRFF2_1 annotation (Placement(transformation(extent={{-200,-440},{-180,-420}})));
  Undirected.Topology.JunctionRRF junctionRRF annotation (Placement(transformation(extent={{-160,-440},{-140,-420}})));
  Undirected.Topology.JunctionRRF2 junctionRRF2_1 annotation (Placement(transformation(extent={{-120,-440},{-100,-420}})));
  Undirected.Topology.JunctionRFFF junctionRFFF annotation (Placement(transformation(extent={{-80,-440},{-60,-420}})));
  Undirected.Topology.JunctionRRFF junctionRRFF annotation (Placement(transformation(extent={{-40,-440},{-20,-420}})));
  Undirected.Topology.JunctionRRFF2 junctionRRFF2_1 annotation (Placement(transformation(extent={{0,-440},{20,-420}})));
  Undirected.Topology.JunctionRRRF junctionRRRF annotation (Placement(transformation(extent={{40,-440},{60,-420}})));
  Undirected.Processes.FlowResistance flowResistance1 annotation (Placement(transformation(extent={{-300,-580},{-280,-560}})));
  Undirected.Processes.TransportDelay transportDelay1 annotation (Placement(transformation(extent={{-260,-580},{-240,-560}})));
  Undirected.Processes.ConductionElement conductionElement1 annotation (Placement(transformation(extent={{-220,-580},{-200,-560}})));
  Undirected.HeatExchangers.DiscretizedCounterFlowHEX discretizedCounterFlowHEX1 annotation (Placement(transformation(extent={{-140,-580},{-120,-560}})));
  Undirected.FlowControl.BasicControlValve basicControlValve1 annotation (Placement(transformation(extent={{-500,-540},{-480,-520}})));
  Undirected.FlowControl.SpecificValveType specificValveType1 annotation (Placement(transformation(extent={{-460,-540},{-440,-520}})));
  Undirected.FlowControl.TanValve tanValve1 annotation (Placement(transformation(extent={{-420,-540},{-400,-520}})));
  Undirected.FlowControl.MCV mCV3(setpointFromInput=true, enableClippingOutput=true) annotation (Placement(transformation(extent={{-500,-580},{-480,-560}})));
  Undirected.FlowControl.CheckValve checkValve1 annotation (Placement(transformation(extent={{-380,-580},{-360,-560}})));
  Undirected.FlowControl.MCV mCV4(
    setpointFromInput=true,
    enableClippingOutput=true) annotation (Placement(transformation(extent={{-460,-580},{-440,-560}})));
  Undirected.Topology.JunctionRFFF junctionRFFF1(displayInstanceName=false)
                                                annotation (Placement(transformation(extent={{-80,-480},{-60,-460}})));
  Undirected.Topology.JunctionRRFF junctionRRFF1(displayInstanceName=false)
                                                annotation (Placement(transformation(extent={{-40,-480},{-20,-460}})));
  Undirected.Topology.JunctionRRFF2 junctionRRFF2_2(displayInstanceName=false)
                                                    annotation (Placement(transformation(extent={{0,-480},{20,-460}})));
  Undirected.Topology.JunctionRRRF junctionRRRF1(displayInstanceName=false)
                                                annotation (Placement(transformation(extent={{40,-480},{60,-460}})));
  Undirected.HeatExchangers.DiscretizedCrossFlowHEX discretizedCrossFlowHEX3(displayInstanceName=false)
                                                                             annotation (Placement(transformation(extent={{-100,-580},{-80,-560}})));
  Undirected.FlowControl.MCV mCV5(setpointFromInput=true, enableClippingOutput=false)
                               annotation (Placement(transformation(extent={{-420,-580},{-400,-560}})));
  Sensors.SingleSensorSelect singleSensorSelect4(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3, outputValue=true)
                                                                                                                                    annotation (Placement(transformation(extent={{100,80},{120,100}})));
  Sensors.SingleSensorSelect singleSensorSelect3(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar, outputValue=true)
                                                                                                                                    annotation (Placement(transformation(extent={{60,80},{80,100}})));
  Sensors.SingleSensorSelect singleSensorSelect8(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK, outputValue=true)
                                                                                                                                    annotation (Placement(transformation(extent={{140,60},{160,80}})));
  Sensors.SingleSensorSelect singleSensorSelect9(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cv_JpkgK, outputValue=true)
                                                                                                                                    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Sensors.SingleSensorSelect singleSensorSelect13(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_Pa,
    outputValue=true)                                                                                                               annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Sensors.SingleSensorSelect singleSensorSelect14(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_bar,
    outputValue=true)                                                                                                               annotation (Placement(transformation(extent={{140,20},{160,40}})));
  Sensors.SingleSensorSelect singleSensorSelect15(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_Pa,
    outputValue=true)                                                                                                               annotation (Placement(transformation(extent={{60,0},{80,20}})));
  Sensors.SingleSensorSelect singleSensorSelect16(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_bar,
    outputValue=true)                                                                                                               annotation (Placement(transformation(extent={{100,0},{120,20}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect3(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C) annotation (Placement(transformation(extent={{140,-140},{160,-120}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect4(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa)
                                                                                                                                   annotation (Placement(transformation(extent={{60,-160},{80,-140}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect5(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_bar)
                                                                                                                                   annotation (Placement(transformation(extent={{100,-160},{120,-140}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect6(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K)
                                                                                                                                   annotation (Placement(transformation(extent={{140,-160},{160,-140}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect7(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_Pa)
                                                                                                                                   annotation (Placement(transformation(extent={{60,-180},{80,-160}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect8(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_bar)
                                                                                                                                   annotation (Placement(transformation(extent={{100,-180},{120,-160}})));
  Sensors.SingleFlowSensor singleFlowSensor2(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps,
    outputValue=true)                                                                                                                          annotation (Placement(transformation(extent={{100,-78},{120,-58}})));
  Sensors.SingleFlowSensor singleFlowSensor3(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.S_flow_JpKs,
    outputValue=false)                                                                                                                           annotation (Placement(transformation(extent={{140,-78},{160,-58}})));
  Sensors.SingleFlowSensor singleFlowSensor4(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.Cp_flow_JpKs,
    outputValue=true)                                                                                                                          annotation (Placement(transformation(extent={{60,-98},{80,-78}})));
  Sensors.SingleFlowSensor singleFlowSensor5(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_m3ps, outputValue=false)
                                                                                                                                                 annotation (Placement(transformation(extent={{140,-58},{160,-38}})));
  Sensors.SingleFlowSensor singleFlowSensor6(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_lpMin,
    outputValue=true)                                                                                                                          annotation (Placement(transformation(extent={{60,-78},{80,-58}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect2(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa, outputValue=true)    annotation (Placement(transformation(extent={{340,0},{360,20}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect3(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar)    annotation (Placement(transformation(extent={{260,-20},{280,0}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect4(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{260,-60},{280,-40}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect5(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.v_m3pkg)
                                                                                                                                annotation (Placement(transformation(extent={{300,-60},{320,-40}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect6(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{300,-20},{320,0}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect7(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK)
                                                                                                                                annotation (Placement(transformation(extent={{340,-20},{360,0}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect8(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{260,-40},{280,-20}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect9(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cv_JpkgK)
                                                                                                                                annotation (Placement(transformation(extent={{300,-40},{320,-20}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect10(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{340,-40},{360,-20}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect11(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.a_mps)
                                                                                                                                annotation (Placement(transformation(extent={{262,-100},{282,-80}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect12(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.MM_kgpmol, outputValue=true)
                                                                                                                                                 annotation (Placement(transformation(extent={{340,-60},{360,-40}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect13(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_Pa)    annotation (Placement(transformation(extent={{260,-80},{280,-60}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect14(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_bar, outputValue=true)  annotation (Placement(transformation(extent={{300,-80},{320,-60}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect15(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_Pa)
                                                                                                                                annotation (Placement(transformation(extent={{340,-80},{360,-60}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect16(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_bar)
                                                                                                                                annotation (Placement(transformation(extent={{300,-100},{320,-80}})));
  Modelica.Fluid.Sensors.RelativePressure relativePressure annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Fluid.Sensors.RelativeTemperature relativeTemperature annotation (Placement(transformation(extent={{-120,-60},{-100,-40}})));
  Modelica.Fluid.Sensors.Pressure pressure annotation (Placement(transformation(extent={{-160,60},{-140,80}})));
  Modelica.Fluid.Sensors.Density density annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Fluid.Sensors.DensityTwoPort density1 annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
  Modelica.Fluid.Sensors.Temperature temperature annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temperature1 annotation (Placement(transformation(extent={{-120,60},{-100,80}})));
  Modelica.Fluid.Sensors.SpecificEnthalpy specificEnthalpy annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Modelica.Fluid.Sensors.SpecificEnthalpyTwoPort specificEnthalpy1 annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Fluid.Sensors.SpecificEntropy specificEntropy annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Modelica.Fluid.Sensors.SpecificEntropyTwoPort specificEntropy1 annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Modelica.Fluid.Sensors.VolumeFlowRate volumeFlowRate annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg, outputValue=true) annotation (Placement(transformation(extent={{260,100},{280,120}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect1(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_K) annotation (Placement(transformation(extent={{300,100},{320,120}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect2(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C, outputValue=true) annotation (Placement(transformation(extent={{340,100},{360,120}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect3(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa) annotation (Placement(transformation(extent={{260,80},{280,100}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect4(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_bar, outputValue=true) annotation (Placement(transformation(extent={{300,80},{320,100}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect5(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K) annotation (Placement(transformation(extent={{340,80},{360,100}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect6(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_Pa, outputValue=true) annotation (Placement(transformation(extent={{260,60},{280,80}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect7(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_bar) annotation (Placement(transformation(extent={{300,60},{320,80}})));
  Sensors.SensorState sensorState annotation (Placement(transformation(extent={{200,-116},{220,-96}})));
  Sensors.SingleSensorX singleSensorX(outputValue=true) annotation (Placement(transformation(extent={{182,-68},{202,-48}})));
  Sensors.SingleSensorX singleSensorX1 annotation (Placement(transformation(extent={{222,-68},{242,-48}})));
  Modelica.Fluid.Sensors.MassFractions massFraction annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Fluid.Sensors.MassFractionsTwoPort massFraction1 annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Fluid.Sensors.TraceSubstancesTwoPort traceSubstance annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Modelica.Fluid.Sensors.TraceSubstances traceSubstance1 annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Sensors.MultiSensor_Tp multiSensor_Tp2(
    outputTemperature=true,
    outputPressure=true,
    filter_output=false)                                                                annotation (Placement(transformation(extent={{180,90},{200,110}})));
  Sensors.MultiSensor_Tp multiSensor_Tp5(temperatureUnit="degC", pressureUnit="bar") annotation (Placement(transformation(extent={{220,90},{240,110}})));
  Sensors.MultiSensor_Tp multiSensor_Tp6(outputTemperature=true, outputPressure=true) annotation (Placement(transformation(extent={{180,62},{200,82}})));
  Sensors.MultiSensor_Tp multiSensor_Tp7(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=true,
    outputPressure=true) annotation (Placement(transformation(extent={{224,58},{244,78}})));
  Sensors.DifferenceSensor_Tp differenceSensor_Tp annotation (Placement(transformation(extent={{180,-164},{200,-144}})));
  Sensors.DifferenceSensor_Tp differenceSensor_Tp1(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=false,
    outputPressure=false) annotation (Placement(transformation(extent={{220,-164},{240,-144}})));
  Sensors.DifferenceSensor_Tp differenceSensor_Tp2(outputTemperature=true, outputPressure=true) annotation (Placement(transformation(extent={{180,-194},{200,-174}})));
  Sensors.DifferenceSensor_Tp differenceSensor_Tp3(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=true,
    outputPressure=true) annotation (Placement(transformation(extent={{220,-194},{240,-174}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm1 annotation (Placement(transformation(extent={{180,14},{200,34}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm4(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)",
    outputTemperature=true)                annotation (Placement(transformation(extent={{220,14},{240,34}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm5(
    outputTemperature=false,
    outputPressure=true,
    outputMassFlowRate=false)              annotation (Placement(transformation(extent={{180,-16},{200,4}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm6(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)",
    outputTemperature=false,
    outputPressure=false,
    outputMassFlowRate=true)               annotation (Placement(transformation(extent={{220,-16},{240,4}})));
  Undirected.Sensors.SingleSensorSelect singleSensorSelect17(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K) annotation (Placement(transformation(extent={{120,-428},{140,-408}})));
  Undirected.Sensors.SingleSensorSelect singleSensorSelect18(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C, outputValue=true) annotation (Placement(transformation(extent={{160,-428},{180,-408}})));
  Undirected.Sensors.SingleSensorSelect singleSensorSelect19(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa) annotation (Placement(transformation(extent={{200,-428},{220,-408}})));
  Undirected.Sensors.SingleSensorSelect singleSensorSelect20(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar, outputValue=true) annotation (Placement(transformation(extent={{120,-458},{140,-438}})));
  Undirected.Sensors.SingleSensorSelect singleSensorSelect21(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3, outputValue=false) annotation (Placement(transformation(extent={{160,-458},{180,-438}})));
  Undirected.Sensors.SingleSensorSelect singleSensorSelect22(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.v_m3pkg, outputValue=true) annotation (Placement(transformation(extent={{200,-458},{220,-438}})));
  Undirected.Sensors.SingleSensorSelect singleSensorSelect23(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg) annotation (Placement(transformation(extent={{120,-488},{140,-468}})));
  Undirected.Sensors.SingleSensorSelect singleSensorSelect24(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK, outputValue=true) annotation (Placement(transformation(extent={{160,-488},{180,-468}})));
  Undirected.Sensors.SingleSensorSelect singleSensorSelect25(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK) annotation (Placement(transformation(extent={{200,-488},{220,-468}})));
  Undirected.Sensors.SingleSensorSelect singleSensorSelect26(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cv_JpkgK, outputValue=true) annotation (Placement(transformation(extent={{120,-518},{140,-498}})));
  Undirected.Sensors.SingleSensorSelect singleSensorSelect27(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1, outputValue=false) annotation (Placement(transformation(extent={{160,-518},{180,-498}})));
  Undirected.Sensors.SingleSensorSelect singleSensorSelect28(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.a_mps, outputValue=true) annotation (Placement(transformation(extent={{200,-518},{220,-498}})));
  Undirected.Sensors.SingleSensorSelect singleSensorSelect29(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.MM_kgpmol, outputValue=true) annotation (Placement(transformation(extent={{120,-548},{140,-528}})));
  Undirected.Sensors.SingleSensorSelect singleSensorSelect30(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_Pa, outputValue=false) annotation (Placement(transformation(extent={{160,-548},{180,-528}})));
  Undirected.Sensors.SingleSensorSelect singleSensorSelect31(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_bar, outputValue=true) annotation (Placement(transformation(extent={{200,-548},{220,-528}})));
  Undirected.Sensors.SingleSensorSelect singleSensorSelect32(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_Pa, outputValue=true) annotation (Placement(transformation(extent={{120,-578},{140,-558}})));
  Undirected.Sensors.SingleSensorSelect singleSensorSelect33(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_bar, outputValue=false) annotation (Placement(transformation(extent={{160,-578},{180,-558}})));
  Undirected.Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect9(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg, outputValue=false)
                                                                                  annotation (Placement(transformation(extent={{240,-428},{260,-408}})));
  Undirected.Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect10(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_K, outputValue=true)
                                                                                  annotation (Placement(transformation(extent={{280,-428},{300,-408}})));
  Undirected.Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect11(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C, outputValue=false)
                                                                                  annotation (Placement(transformation(extent={{320,-428},{340,-408}})));
  Undirected.Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect12(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa, outputValue=true)
                                                                                  annotation (Placement(transformation(extent={{240,-458},{260,-438}})));
  Undirected.Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect13(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_bar, outputValue=false)
                                                                                  annotation (Placement(transformation(extent={{280,-458},{300,-438}})));
  Undirected.Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect14(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C, outputValue=true)
                                                                                  annotation (Placement(transformation(extent={{320,-458},{340,-438}})));
  Undirected.Sensors.SensorState sensorState2 annotation (Placement(transformation(extent={{380,-428},{400,-408}})));
  Undirected.Sensors.SingleSensorX singleSensorX2(row=2) annotation (Placement(transformation(extent={{380,-488},{400,-468}})));
  Undirected.Sensors.MultiSensor_Tpm multiSensor_Tpm2 annotation (Placement(transformation(extent={{278,-618},{298,-598}})));
  Undirected.Sensors.MultiSensor_Tpm multiSensor_Tpm3(
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true) annotation (Placement(transformation(extent={{318,-618},{338,-598}})));
  Undirected.Sensors.MultiSensor_Tpm multiSensor_Tpm7(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)")                             annotation (Placement(transformation(extent={{358,-618},{378,-598}})));
  Undirected.Sensors.MultiSensor_Tpm multiSensor_Tpm8(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)",
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true) annotation (Placement(transformation(extent={{398,-618},{418,-598}})));
  Undirected.Sensors.SingleFlowSensor singleFlowSensor7(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps) annotation (Placement(transformation(extent={{240,-518},{260,-498}})));
  Undirected.Sensors.UnidirectionalSensorAdapter unidirectionalSensorAdapter(displayInstanceName=true) annotation (Placement(transformation(extent={{380,-538},{400,-518}})));
  Undirected.Sensors.SingleFlowSensor singleFlowSensor8(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_gps, outputValue=true) annotation (Placement(transformation(extent={{280,-518},{300,-498}})));
  Undirected.Sensors.SingleFlowSensor singleFlowSensor9(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_m3ps) annotation (Placement(transformation(extent={{320,-518},{340,-498}})));
  Undirected.Sensors.SingleFlowSensor singleFlowSensor10(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_lpMin, outputValue=true) annotation (Placement(transformation(extent={{240,-548},{260,-528}})));
  Undirected.Sensors.SingleFlowSensor singleFlowSensor11(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps, outputValue=false) annotation (Placement(transformation(extent={{280,-548},{300,-528}})));
  Undirected.Sensors.SingleFlowSensor singleFlowSensor12(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.S_flow_JpKs, outputValue=true) annotation (Placement(transformation(extent={{320,-548},{340,-528}})));
  Undirected.Sensors.SingleFlowSensor singleFlowSensor13(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.Cp_flow_JpKs, outputValue=false) annotation (Placement(transformation(extent={{240,-578},{260,-558}})));
  Boundaries.Source                   source annotation (Placement(transformation(extent={{-40,260},{-20,280}})));
  Utilities.showRealValue showRealValue(
    use_numberPort=false,
    description="",
    number=flowResistance1.r,
    displayVariable=false) annotation (Placement(transformation(extent={{360,258},{380,278}})));
  Utilities.showRealValue showRealValue1(
    use_numberPort=false,
    description="blabla",
    number=flowResistance1.r,
    displayVariable=true) annotation (Placement(transformation(extent={{400,258},{420,278}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-580,-800},{480,520}}), graphics={
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
          textString="1 Interfaces"),
        Rectangle(
          extent={{280,200},{-60,300}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-60,320},{242,300}},
          textColor={28,108,200},
          textString="2 Boundaries"),
        Rectangle(
          extent={{-360,80},{-540,300}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-540,320},{-360,300}},
          textColor={28,108,200},
          textString="3 Topology"),
        Rectangle(
          extent={{-100,120},{-320,300}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-320,320},{-100,300}},
          textColor={28,108,200},
          textString="4 Processes"),
        Rectangle(
          extent={{-400,-80},{-540,20}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-540,40},{-400,20}},
          textColor={28,108,200},
          textString="5 HeatExchangers"),
        Rectangle(
          extent={{-160,-80},{-380,20}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-380,40},{-160,20}},
          textColor={28,108,200},
          textString="6 FlowControl"),
        Rectangle(
          extent={{380,-200},{40,160}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{40,180},{378,160}},
          textColor={28,108,200},
          textString="7 Sensors"),
        Text(
          extent={{-562,388},{422,350}},
          textColor={28,108,200},
          textString="Mark everything exept interfaces to check if displayInstanceName works"),
        Text(
          extent={{-200,500},{-120,480}},
          textColor={28,108,200},
          textString="8.1 Undirected Interfaces"),
        Rectangle(
          extent={{-120,400},{-200,480}},
          lineColor={28,108,200},
          lineThickness=1),
        Rectangle(
          extent={{-280,-460},{-540,-360}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-540,-340},{-280,-360}},
          textColor={28,108,200},
          textString="8.2 Undirected Boundaries"),
        Rectangle(
          extent={{80,-502},{-260,-360}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-260,-340},{80,-360}},
          textColor={28,108,200},
          textString="8.3 Undirected Topology"),
        Rectangle(
          extent={{-180,-600},{-320,-540}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-320,-520},{-180,-540}},
          textColor={28,108,200},
          textString="8.4 Undirected Processes"),
        Rectangle(
          extent={{-60,-600},{-160,-540}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-160,-520},{-60,-540}},
          textColor={28,108,200},
          textString="8.5 Undirected HeatExchangers"),
        Text(
          extent={{-520,-482},{-360,-500}},
          textColor={28,108,200},
          textString="8.6 Undirected FlowControl"),
        Rectangle(
          extent={{-360,-600},{-520,-500}},
          lineColor={28,108,200},
          lineThickness=1),
        Rectangle(
          extent={{-674,212},{-666,206}},
          lineColor={28,108,200},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{60,140},{160,120}},
          textColor={28,108,200},
          textString="SingleSensorSelect"),
        Text(
          extent={{60,-100},{160,-120}},
          textColor={28,108,200},
          textString="TwoPhaseSensorSelect"),
        Text(
          extent={{60,-8},{160,-28}},
          textColor={28,108,200},
          textString="SingleFlowSensor"),
        Text(
          extent={{260,40},{360,20}},
          textColor={28,108,200},
          textString="DifferenceSensorSelect"),
        Text(
          extent={{260,140},{360,120}},
          textColor={28,108,200},
          textString="DifferenceTwoPhaseSensorSelect"),
        Rectangle(
          extent={{-674,234},{-666,228}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{182,-28},{242,-46}},
          textColor={28,108,200},
          textString="singleSensorX"),
        Text(
          extent={{180,140},{240,120}},
          textColor={28,108,200},
          textString="MultiSensor_Tp"),
        Text(
          extent={{180,-114},{240,-134}},
          textColor={28,108,200},
          textString="DifferenceSensor_Tp"),
        Text(
          extent={{180,54},{240,34}},
          textColor={28,108,200},
          textString="MultiSensor_Tpm"),
        Text(
          extent={{180,-74},{240,-92}},
          textColor={28,108,200},
          textString="SensorState"),
        Text(
          extent={{120,-378},{220,-398}},
          textColor={28,108,200},
          textString="SingleSensorSelect"),
        Text(
          extent={{240,-378},{340,-398}},
          textColor={28,108,200},
          textString="TwoPhaseSensorSelect"),
        Text(
          extent={{360,-380},{420,-398}},
          textColor={28,108,200},
          textString="SensorState"),
        Text(
          extent={{360,-438},{420,-458}},
          textColor={28,108,200},
          textString="SingleSensorX"),
        Text(
          extent={{180,-598},{260,-618}},
          textColor={28,108,200},
          textString="MultiSensor_Tpm"),
        Rectangle(
          extent={{440,-638},{100,-360}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{100,-340},{440,-358}},
          textColor={28,108,200},
          textString="7.1 Undirected Sensors"),
        Text(
          extent={{360,-498},{420,-518}},
          textColor={28,108,200},
          textString="UnidirectionalSensorAdapter"),
        Text(
          extent={{240,-468},{340,-488}},
          textColor={28,108,200},
          textString="SingleFlowSensor"),
        Rectangle(
          extent={{460,238},{340,298}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{340,318},{460,298}},
          textColor={28,108,200},
          textString="8 Utilities")}));
end TestIcons;
