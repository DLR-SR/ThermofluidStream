within ThermofluidStream;
model TestIcons
  extends Modelica.Icons.Example;
  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true)  annotation (Placement(transformation(extent={{-540,500},{-520,520}})));
  ThermofluidStream.Processes.FlowResistance flowResistance annotation (Placement(transformation(extent={{-288,206},{-268,226}})));
  ThermofluidStream.Processes.TransportDelay transportDelay annotation (Placement(transformation(extent={{-248,206},{-228,226}})));
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
  ThermofluidStream.Topology.SplitterT1 splitterT1 annotation (Placement(transformation(
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
  Sensors.SingleSensorSelect singleSensorSelect(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K, outputValue=true) annotation (Placement(transformation(extent={{180,100},{200,120}})));
  Sensors.SingleSensorSelect singleSensorSelect1(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C) annotation (Placement(transformation(extent={{180,80},{200,100}})));
  Sensors.SingleSensorSelect singleSensorSelect2(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa, outputValue=true) annotation (Placement(transformation(extent={{180,60},{200,80}})));
  Sensors.SingleSensorSelect singleSensorSelect5(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.v_m3pkg)
                                                                                                                     annotation (Placement(transformation(extent={{180,0},{200,20}})));
  Sensors.SingleSensorSelect singleSensorSelect6(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg,     outputValue=true) annotation (Placement(transformation(extent={{180,-20},{200,0}})));
  Sensors.SingleSensorSelect singleSensorSelect7(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK)     annotation (Placement(transformation(extent={{180,-40},{200,-20}})));
  Sensors.SingleSensorSelect singleSensorSelect10(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1,                                                 outputValue=true) annotation (Placement(transformation(extent={{180,-100},{200,-80}})));
  Sensors.SingleSensorSelect singleSensorSelect11(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.a_mps)
                                                                                                                        annotation (Placement(transformation(extent={{180,-120},{200,-100}})));
  Sensors.SingleSensorSelect singleSensorSelect12(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.MM_kgpmol,                                           outputValue=true) annotation (Placement(transformation(extent={{180,-140},{200,-120}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg, outputValue=true) annotation (Placement(transformation(extent={{320,100},{340,120}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,      outputValue=true) annotation (Placement(transformation(extent={{680,90},{700,110}})));
  Sensors.SingleFlowSensor singleFlowSensor(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,outputValue=true) annotation (Placement(transformation(extent={{460,90},{480,110}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect1(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_K) annotation (Placement(transformation(extent={{320,80},{340,100}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect1(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)      annotation (Placement(transformation(extent={{680,60},{700,80}})));
  Sensors.SingleFlowSensor singleFlowSensor1(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_gps, outputValue=false) annotation (Placement(transformation(extent={{460,60},{480,80}})));
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
  Undirected.Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect2(outputValue=true) annotation (Placement(transformation(extent={{160,-682},{180,-662}})));
  Undirected.Sensors.SensorState sensorState2 annotation (Placement(transformation(extent={{200,-682},{220,-662}})));
  Undirected.Sensors.SingleSensorX singleSensorX2 annotation (Placement(transformation(extent={{120,-722},{140,-702}})));
  Undirected.Sensors.MultiSensor_Tpm multiSensor_Tpm2 annotation (Placement(transformation(extent={{160,-722},{180,-702}})));
  Undirected.Sensors.MultiSensor_Tpm multiSensor_Tpm3(
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true) annotation (Placement(transformation(extent={{200,-722},{220,-702}})));
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
                                                                                                                                    annotation (Placement(transformation(extent={{180,20},{200,40}})));
  Sensors.SingleSensorSelect singleSensorSelect3(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar, outputValue=true)
                                                                                                                                    annotation (Placement(transformation(extent={{180,40},{200,60}})));
  Sensors.SingleSensorSelect singleSensorSelect8(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK, outputValue=true)
                                                                                                                                    annotation (Placement(transformation(extent={{180,-60},{200,-40}})));
  Sensors.SingleSensorSelect singleSensorSelect9(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cv_JpkgK, outputValue=true)
                                                                                                                                    annotation (Placement(transformation(extent={{180,-80},{200,-60}})));
  Sensors.SingleSensorSelect singleSensorSelect13(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_Pa,
    outputValue=true)                                                                                                               annotation (Placement(transformation(extent={{180,-160},{200,-140}})));
  Sensors.SingleSensorSelect singleSensorSelect14(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_bar,
    outputValue=true)                                                                                                               annotation (Placement(transformation(extent={{180,-180},{200,-160}})));
  Sensors.SingleSensorSelect singleSensorSelect15(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_Pa,
    outputValue=true)                                                                                                               annotation (Placement(transformation(extent={{180,-200},{200,-180}})));
  Sensors.SingleSensorSelect singleSensorSelect16(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_bar,
    outputValue=true)                                                                                                               annotation (Placement(transformation(extent={{180,-220},{200,-200}})));
  Sensors.SingleSensorSelect2 singleSensorSelect2_1(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K, outputValue=true)
                                                                                                                                    annotation (Placement(transformation(extent={{220,100},{240,120}})));
  Sensors.SingleSensorSelect2 singleSensorSelect2_3(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)
                                                                                                                   annotation (Placement(transformation(extent={{220,80},{240,100}})));
  Sensors.SingleSensorSelect2 singleSensorSelect2_4(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa, outputValue=true)
                                                                                                                                      annotation (Placement(transformation(extent={{220,60},{240,80}})));
  Sensors.SingleSensorSelect2 singleSensorSelect2_5(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.v_m3pkg)
                                                                                                                     annotation (Placement(transformation(extent={{220,0},{240,20}})));
  Sensors.SingleSensorSelect2 singleSensorSelect2_6(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg, outputValue=true)  annotation (Placement(transformation(extent={{220,-20},{240,0}})));
  Sensors.SingleSensorSelect2 singleSensorSelect2_7(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK)  annotation (Placement(transformation(extent={{220,-40},{240,-20}})));
  Sensors.SingleSensorSelect2 singleSensorSelect2_8(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1,
    outputValue=true)                                                                                                                       annotation (Placement(transformation(extent={{220,-100},{240,-80}})));
  Sensors.SingleSensorSelect2 singleSensorSelect2_9(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.a_mps)
                                                                                                                        annotation (Placement(transformation(extent={{220,-120},{240,-100}})));
  Sensors.SingleSensorSelect2 singleSensorSelect2_10(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.MM_kgpmol,
    outputValue=true)                                                                                                                   annotation (Placement(transformation(extent={{220,-140},{240,-120}})));
  Sensors.SingleSensorSelect2 singleSensorSelect2_11(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3, outputValue=true)
                                                                                                                                    annotation (Placement(transformation(extent={{220,20},{240,40}})));
  Sensors.SingleSensorSelect2 singleSensorSelect2_12(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar, outputValue=true)
                                                                                                                                    annotation (Placement(transformation(extent={{220,40},{240,60}})));
  Sensors.SingleSensorSelect2 singleSensorSelect2_13(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK, outputValue=true)
                                                                                                                                    annotation (Placement(transformation(extent={{220,-60},{240,-40}})));
  Sensors.SingleSensorSelect2 singleSensorSelect2_14(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cv_JpkgK, outputValue=true)
                                                                                                                                    annotation (Placement(transformation(extent={{220,-80},{240,-60}})));
  Sensors.SingleSensorSelect2 singleSensorSelect2_15(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_Pa,
    outputValue=true)                                                                                                               annotation (Placement(transformation(extent={{220,-160},{240,-140}})));
  Sensors.SingleSensorSelect2 singleSensorSelect2_16(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_bar,
    outputValue=true)                                                                                                               annotation (Placement(transformation(extent={{220,-180},{240,-160}})));
  Sensors.SingleSensorSelect2 singleSensorSelect2_17(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_Pa,
    outputValue=true)                                                                                                               annotation (Placement(transformation(extent={{220,-200},{240,-180}})));
  Sensors.SingleSensorSelect2 singleSensorSelect2_2(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_bar,
    outputValue=true)                                                                                                               annotation (Placement(transformation(extent={{220,-220},{240,-200}})));
  Sensors.SingleSensorSelect3 singleSensorSelect3_1(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K, outputValue=true)
                                                                                                                                    annotation (Placement(transformation(extent={{260,100},{280,120}})));
  Sensors.SingleSensorSelect3 singleSensorSelect3_3(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)
                                                                                                                   annotation (Placement(transformation(extent={{260,80},{280,100}})));
  Sensors.SingleSensorSelect3 singleSensorSelect3_4(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa, outputValue=true)
                                                                                                                                      annotation (Placement(transformation(extent={{260,60},{280,80}})));
  Sensors.SingleSensorSelect3 singleSensorSelect3_5(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.v_m3pkg)
                                                                                                                     annotation (Placement(transformation(extent={{260,0},{280,20}})));
  Sensors.SingleSensorSelect3 singleSensorSelect3_6(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg, outputValue=true)  annotation (Placement(transformation(extent={{260,-20},{280,0}})));
  Sensors.SingleSensorSelect3 singleSensorSelect3_7(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK)  annotation (Placement(transformation(extent={{260,-40},{280,-20}})));
  Sensors.SingleSensorSelect3 singleSensorSelect3_8(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1,
    outputValue=true)                                                                                                                       annotation (Placement(transformation(extent={{260,-100},{280,-80}})));
  Sensors.SingleSensorSelect3 singleSensorSelect3_9(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.a_mps)
                                                                                                                        annotation (Placement(transformation(extent={{260,-120},{280,-100}})));
  Sensors.SingleSensorSelect3 singleSensorSelect3_10(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.MM_kgpmol,
    outputValue=true)                                                                                                                   annotation (Placement(transformation(extent={{260,-140},{280,-120}})));
  Sensors.SingleSensorSelect3 singleSensorSelect3_11(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3, outputValue=true)
                                                                                                                                    annotation (Placement(transformation(extent={{260,20},{280,40}})));
  Sensors.SingleSensorSelect3 singleSensorSelect3_12(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar, outputValue=true)
                                                                                                                                    annotation (Placement(transformation(extent={{260,40},{280,60}})));
  Sensors.SingleSensorSelect3 singleSensorSelect3_13(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK, outputValue=true)
                                                                                                                                    annotation (Placement(transformation(extent={{260,-60},{280,-40}})));
  Sensors.SingleSensorSelect3 singleSensorSelect3_14(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cv_JpkgK, outputValue=true)
                                                                                                                                    annotation (Placement(transformation(extent={{260,-80},{280,-60}})));
  Sensors.SingleSensorSelect3 singleSensorSelect3_15(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_Pa,
    outputValue=true)                                                                                                               annotation (Placement(transformation(extent={{260,-160},{280,-140}})));
  Sensors.SingleSensorSelect3 singleSensorSelect3_16(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_bar,
    outputValue=true)                                                                                                               annotation (Placement(transformation(extent={{260,-180},{280,-160}})));
  Sensors.SingleSensorSelect3 singleSensorSelect3_17(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_Pa,
    outputValue=true)                                                                                                               annotation (Placement(transformation(extent={{260,-200},{280,-180}})));
  Sensors.SingleSensorSelect3 singleSensorSelect3_2(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_bar,
    outputValue=true)                                                                                                               annotation (Placement(transformation(extent={{260,-220},{280,-200}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect3(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C) annotation (Placement(transformation(extent={{320,60},{340,80}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect4(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa)
                                                                                                                                   annotation (Placement(transformation(extent={{320,40},{340,60}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect5(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_bar)
                                                                                                                                   annotation (Placement(transformation(extent={{320,20},{340,40}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect6(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K)
                                                                                                                                   annotation (Placement(transformation(extent={{320,0},{340,20}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect7(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_Pa)
                                                                                                                                   annotation (Placement(transformation(extent={{320,-20},{340,0}})));
  Sensors.TwoPhaseSensorSelect twoPhaseSensorSelect8(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_bar)
                                                                                                                                   annotation (Placement(transformation(extent={{320,-40},{340,-20}})));
  Sensors.TwoPhaseSensorSelect2 twoPhaseSensorSelect2_1(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg, outputValue=true)
                                                                                                                                                    annotation (Placement(transformation(extent={{360,100},{380,120}})));
  Sensors.TwoPhaseSensorSelect2 twoPhaseSensorSelect2_3(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_K)
                                                                                                                                   annotation (Placement(transformation(extent={{360,80},{380,100}})));
  Sensors.TwoPhaseSensorSelect2 twoPhaseSensorSelect2_4(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C)
                                                                                                                                   annotation (Placement(transformation(extent={{360,60},{380,80}})));
  Sensors.TwoPhaseSensorSelect2 twoPhaseSensorSelect2_5(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa)
                                                                                                                                   annotation (Placement(transformation(extent={{360,40},{380,60}})));
  Sensors.TwoPhaseSensorSelect2 twoPhaseSensorSelect2_6(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_bar)
                                                                                                                                   annotation (Placement(transformation(extent={{360,20},{380,40}})));
  Sensors.TwoPhaseSensorSelect2 twoPhaseSensorSelect2_7(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K)
                                                                                                                                   annotation (Placement(transformation(extent={{360,0},{380,20}})));
  Sensors.TwoPhaseSensorSelect2 twoPhaseSensorSelect2_8(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_Pa)
                                                                                                                                   annotation (Placement(transformation(extent={{360,-20},{380,0}})));
  Sensors.TwoPhaseSensorSelect2 twoPhaseSensorSelect2_2(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_bar)
                                                                                                                                   annotation (Placement(transformation(extent={{360,-40},{380,-20}})));
  Sensors.TwoPhaseSensorSelect3 twoPhaseSensorSelect3_1(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg, outputValue=true)
                                                                                                                                                    annotation (Placement(transformation(extent={{400,100},{420,120}})));
  Sensors.TwoPhaseSensorSelect3 twoPhaseSensorSelect3_3(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_K)
                                                                                                                                   annotation (Placement(transformation(extent={{400,80},{420,100}})));
  Sensors.TwoPhaseSensorSelect3 twoPhaseSensorSelect3_4(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C)
                                                                                                                                   annotation (Placement(transformation(extent={{400,60},{420,80}})));
  Sensors.TwoPhaseSensorSelect3 twoPhaseSensorSelect3_5(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa)
                                                                                                                                   annotation (Placement(transformation(extent={{400,40},{420,60}})));
  Sensors.TwoPhaseSensorSelect3 twoPhaseSensorSelect3_6(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_bar)
                                                                                                                                   annotation (Placement(transformation(extent={{400,20},{420,40}})));
  Sensors.TwoPhaseSensorSelect3 twoPhaseSensorSelect3_7(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K)
                                                                                                                                   annotation (Placement(transformation(extent={{400,0},{420,20}})));
  Sensors.TwoPhaseSensorSelect3 twoPhaseSensorSelect3_8(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_Pa)
                                                                                                                                   annotation (Placement(transformation(extent={{400,-20},{420,0}})));
  Sensors.TwoPhaseSensorSelect3 twoPhaseSensorSelect3_2(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_bar)
                                                                                                                                   annotation (Placement(transformation(extent={{400,-40},{420,-20}})));
  Sensors.SingleFlowSensor singleFlowSensor2(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps,
    outputValue=true)                                                                                                                          annotation (Placement(transformation(extent={{460,-30},{480,-10}})));
  Sensors.SingleFlowSensor singleFlowSensor3(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.S_flow_JpKs,
    outputValue=false)                                                                                                                           annotation (Placement(transformation(extent={{460,-60},{480,-40}})));
  Sensors.SingleFlowSensor singleFlowSensor4(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.Cp_flow_JpKs,
    outputValue=true)                                                                                                                          annotation (Placement(transformation(extent={{460,-90},{480,-70}})));
  Sensors.SingleFlowSensor singleFlowSensor5(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_m3ps, outputValue=false)
                                                                                                                                                 annotation (Placement(transformation(extent={{460,30},{480,50}})));
  Sensors.SingleFlowSensor singleFlowSensor6(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_lpMin,
    outputValue=true)                                                                                                                          annotation (Placement(transformation(extent={{460,0},{480,20}})));
  Sensors.SingleFlowSensor2 singleFlowSensor2_1(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps, outputValue=true)
                                                                                                                                               annotation (Placement(transformation(extent={{500,90},{520,110}})));
  Sensors.SingleFlowSensor2 singleFlowSensor2_3(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_gps, outputValue=false)
                                                                                                                                                 annotation (Placement(transformation(extent={{500,60},{520,80}})));
  Sensors.SingleFlowSensor2 singleFlowSensor2_4(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps,
    outputValue=true)                                                                                                                          annotation (Placement(transformation(extent={{500,-30},{520,-10}})));
  Sensors.SingleFlowSensor2 singleFlowSensor2_5(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.S_flow_JpKs,
    outputValue=false)                                                                                                                           annotation (Placement(transformation(extent={{500,-60},{520,-40}})));
  Sensors.SingleFlowSensor2 singleFlowSensor2_6(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.Cp_flow_JpKs,
    outputValue=true)                                                                                                                          annotation (Placement(transformation(extent={{500,-90},{520,-70}})));
  Sensors.SingleFlowSensor2 singleFlowSensor2_7(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_m3ps, outputValue=false)
                                                                                                                                                 annotation (Placement(transformation(extent={{500,30},{520,50}})));
  Sensors.SingleFlowSensor2 singleFlowSensor2_2(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_lpMin,
    outputValue=true)                                                                                                                          annotation (Placement(transformation(extent={{500,0},{520,20}})));
  Sensors.SingleFlowSensor22
                           singleFlowSensor22_1(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps, outputValue=true)
                                                                                                                                               annotation (Placement(transformation(extent={{540,90},{560,110}})));
  Sensors.SingleFlowSensor22
                           singleFlowSensor22_3(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_gps, outputValue=false)
                                                                                                                                                 annotation (Placement(transformation(extent={{540,60},{560,80}})));
  Sensors.SingleFlowSensor22
                           singleFlowSensor22_4(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps,
    outputValue=true)                                                                                                                          annotation (Placement(transformation(extent={{540,-30},{560,-10}})));
  Sensors.SingleFlowSensor22
                           singleFlowSensor22_5(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.S_flow_JpKs,
    outputValue=false)                                                                                                                           annotation (Placement(transformation(extent={{540,-60},{560,-40}})));
  Sensors.SingleFlowSensor22
                           singleFlowSensor22_6(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.Cp_flow_JpKs,
    outputValue=true)                                                                                                                          annotation (Placement(transformation(extent={{540,-90},{560,-70}})));
  Sensors.SingleFlowSensor22
                           singleFlowSensor22_7(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_m3ps, outputValue=false)
                                                                                                                                                 annotation (Placement(transformation(extent={{540,30},{560,50}})));
  Sensors.SingleFlowSensor22
                           singleFlowSensor22_2(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_lpMin,
    outputValue=true)                                                                                                                          annotation (Placement(transformation(extent={{540,0},{560,20}})));
  Sensors.SingleFlowSensor3 singleFlowSensor3_1(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps, outputValue=true)
                                                                                                                                               annotation (Placement(transformation(extent={{580,90},{600,110}})));
  Sensors.SingleFlowSensor3 singleFlowSensor3_3(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_gps, outputValue=false)
                                                                                                                                                 annotation (Placement(transformation(extent={{580,60},{600,80}})));
  Sensors.SingleFlowSensor3 singleFlowSensor3_4(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps,
    outputValue=true)                                                                                                                          annotation (Placement(transformation(extent={{580,-30},{600,-10}})));
  Sensors.SingleFlowSensor3 singleFlowSensor3_5(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.S_flow_JpKs,
    outputValue=false)                                                                                                                           annotation (Placement(transformation(extent={{580,-60},{600,-40}})));
  Sensors.SingleFlowSensor3 singleFlowSensor3_6(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.Cp_flow_JpKs,
    outputValue=true)                                                                                                                          annotation (Placement(transformation(extent={{580,-90},{600,-70}})));
  Sensors.SingleFlowSensor3 singleFlowSensor3_7(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_m3ps, outputValue=false)
                                                                                                                                                 annotation (Placement(transformation(extent={{580,30},{600,50}})));
  Sensors.SingleFlowSensor3 singleFlowSensor3_2(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_lpMin,
    outputValue=true)                                                                                                                          annotation (Placement(transformation(extent={{580,0},{600,20}})));
  Sensors.SingleFlowSensor32
                           singleFlowSensor32_1(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps, outputValue=true)
                                                                                                                                               annotation (Placement(transformation(extent={{620,90},{640,110}})));
  Sensors.SingleFlowSensor32
                           singleFlowSensor32_3(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_gps, outputValue=false)
                                                                                                                                                 annotation (Placement(transformation(extent={{620,60},{640,80}})));
  Sensors.SingleFlowSensor32
                           singleFlowSensor32_4(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.H_flow_Jps,
    outputValue=true)                                                                                                                          annotation (Placement(transformation(extent={{620,-30},{640,-10}})));
  Sensors.SingleFlowSensor32
                           singleFlowSensor32_5(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.S_flow_JpKs,
    outputValue=false)                                                                                                                           annotation (Placement(transformation(extent={{620,-60},{640,-40}})));
  Sensors.SingleFlowSensor32
                           singleFlowSensor32_6(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.Cp_flow_JpKs,
    outputValue=true)                                                                                                                          annotation (Placement(transformation(extent={{620,-90},{640,-70}})));
  Sensors.SingleFlowSensor32
                           singleFlowSensor32_7(quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_m3ps, outputValue=false)
                                                                                                                                                 annotation (Placement(transformation(extent={{620,30},{640,50}})));
  Sensors.SingleFlowSensor32
                           singleFlowSensor32_2(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_lpMin,
    outputValue=true)                                                                                                                          annotation (Placement(transformation(extent={{620,0},{640,20}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect2(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa, outputValue=true)    annotation (Placement(transformation(extent={{680,30},{700,50}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect3(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar)    annotation (Placement(transformation(extent={{680,0},{700,20}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect4(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{680,-30},{700,-10}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect5(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.v_m3pkg)
                                                                                                                                annotation (Placement(transformation(extent={{680,-60},{700,-40}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect6(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{680,-90},{700,-70}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect7(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK)
                                                                                                                                annotation (Placement(transformation(extent={{680,-120},{700,-100}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect8(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{680,-150},{700,-130}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect9(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cv_JpkgK)
                                                                                                                                annotation (Placement(transformation(extent={{680,-180},{700,-160}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect10(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{680,-210},{700,-190}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect11(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.a_mps)
                                                                                                                                annotation (Placement(transformation(extent={{680,-240},{700,-220}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect12(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.MM_kgpmol, outputValue=true)
                                                                                                                                                 annotation (Placement(transformation(extent={{680,-270},{700,-250}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect13(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_Pa)    annotation (Placement(transformation(extent={{680,-300},{700,-280}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect14(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_bar, outputValue=true)  annotation (Placement(transformation(extent={{680,-330},{700,-310}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect15(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_Pa)
                                                                                                                                annotation (Placement(transformation(extent={{680,-360},{700,-340}})));
  Sensors.DifferenceSensorSelect differenceSensorSelect16(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_bar)
                                                                                                                                annotation (Placement(transformation(extent={{680,-390},{700,-370}})));
  Sensors.DifferenceSensorSelect2 differenceSensorSelect2_1(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K, outputValue=true)  annotation (Placement(transformation(extent={{720,90},{740,110}})));
  Sensors.DifferenceSensorSelect2 differenceSensorSelect2_3(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)   annotation (Placement(transformation(extent={{720,60},{740,80}})));
  Sensors.DifferenceSensorSelect2 differenceSensorSelect2_4(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa, outputValue=true) annotation (Placement(transformation(extent={{720,30},{740,50}})));
  Sensors.DifferenceSensorSelect2 differenceSensorSelect20(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar)  annotation (Placement(transformation(extent={{720,0},{740,20}})));
  Sensors.DifferenceSensorSelect2 differenceSensorSelect21(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{720,-30},{740,-10}})));
  Sensors.DifferenceSensorSelect2 differenceSensorSelect22(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.v_m3pkg)
                                                                                                                                annotation (Placement(transformation(extent={{720,-60},{740,-40}})));
  Sensors.DifferenceSensorSelect2 differenceSensorSelect23(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{720,-90},{740,-70}})));
  Sensors.DifferenceSensorSelect2 differenceSensorSelect24(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK)
                                                                                                                                annotation (Placement(transformation(extent={{720,-120},{740,-100}})));
  Sensors.DifferenceSensorSelect2 differenceSensorSelect25(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{720,-150},{740,-130}})));
  Sensors.DifferenceSensorSelect2 differenceSensorSelect26(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cv_JpkgK)
                                                                                                                                annotation (Placement(transformation(extent={{720,-180},{740,-160}})));
  Sensors.DifferenceSensorSelect2 differenceSensorSelect27(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{720,-210},{740,-190}})));
  Sensors.DifferenceSensorSelect2 differenceSensorSelect28(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.a_mps)
                                                                                                                                annotation (Placement(transformation(extent={{720,-240},{740,-220}})));
  Sensors.DifferenceSensorSelect2 differenceSensorSelect29(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.MM_kgpmol, outputValue=true)
                                                                                                                                                 annotation (Placement(transformation(extent={{720,-270},{740,-250}})));
  Sensors.DifferenceSensorSelect2 differenceSensorSelect2_5(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_Pa)  annotation (Placement(transformation(extent={{720,-300},{740,-280}})));
  Sensors.DifferenceSensorSelect2 differenceSensorSelect2_6(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_bar, outputValue=true)
                                                                                                                                                 annotation (Placement(transformation(extent={{720,-330},{740,-310}})));
  Sensors.DifferenceSensorSelect2 differenceSensorSelect2_7(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_Pa)
                                                                                                                                annotation (Placement(transformation(extent={{720,-360},{740,-340}})));
  Sensors.DifferenceSensorSelect2 differenceSensorSelect2_2(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_bar)
                                                                                                                                annotation (Placement(transformation(extent={{720,-390},{740,-370}})));
  Sensors.DifferenceSensorSelect22
                                 differenceSensorSelect22_1(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K, outputValue=true)  annotation (Placement(transformation(extent={{760,90},{780,110}})));
  Sensors.DifferenceSensorSelect22
                                 differenceSensorSelect22_3(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)   annotation (Placement(transformation(extent={{760,60},{780,80}})));
  Sensors.DifferenceSensorSelect22
                                 differenceSensorSelect22_4(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa, outputValue=true) annotation (Placement(transformation(extent={{760,30},{780,50}})));
  Sensors.DifferenceSensorSelect22
                                 differenceSensorSelect22_5(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar) annotation (Placement(transformation(extent={{760,0},{780,20}})));
  Sensors.DifferenceSensorSelect22
                                 differenceSensorSelect22_6(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{760,-30},{780,-10}})));
  Sensors.DifferenceSensorSelect22
                                 differenceSensorSelect22_7(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.v_m3pkg)
                                                                                                                                annotation (Placement(transformation(extent={{760,-60},{780,-40}})));
  Sensors.DifferenceSensorSelect22
                                 differenceSensorSelect22_8(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{760,-90},{780,-70}})));
  Sensors.DifferenceSensorSelect22
                                 differenceSensorSelect22_9(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK)
                                                                                                                                annotation (Placement(transformation(extent={{760,-120},{780,-100}})));
  Sensors.DifferenceSensorSelect22
                                 differenceSensorSelect22_10(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{760,-150},{780,-130}})));
  Sensors.DifferenceSensorSelect22
                                 differenceSensorSelect22_11(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cv_JpkgK)
                                                                                                                                annotation (Placement(transformation(extent={{760,-180},{780,-160}})));
  Sensors.DifferenceSensorSelect22
                                 differenceSensorSelect22_12(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{760,-210},{780,-190}})));
  Sensors.DifferenceSensorSelect22
                                 differenceSensorSelect22_13(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.a_mps)
                                                                                                                                annotation (Placement(transformation(extent={{760,-240},{780,-220}})));
  Sensors.DifferenceSensorSelect22
                                 differenceSensorSelect22_14(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.MM_kgpmol, outputValue=true)
                                                                                                                                                 annotation (Placement(transformation(extent={{760,-270},{780,-250}})));
  Sensors.DifferenceSensorSelect22
                                 differenceSensorSelect22_15(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_Pa) annotation (Placement(transformation(extent={{760,-300},{780,-280}})));
  Sensors.DifferenceSensorSelect22
                                 differenceSensorSelect22_16(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_bar, outputValue=true)
                                                                                                                                                 annotation (Placement(transformation(extent={{760,-330},{780,-310}})));
  Sensors.DifferenceSensorSelect22
                                 differenceSensorSelect22_17(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_Pa)
                                                                                                                                annotation (Placement(transformation(extent={{760,-360},{780,-340}})));
  Sensors.DifferenceSensorSelect22
                                 differenceSensorSelect22_2(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_bar)
                                                                                                                                annotation (Placement(transformation(extent={{760,-390},{780,-370}})));
  Modelica.Fluid.Sensors.RelativePressure relativePressure annotation (Placement(transformation(extent={{836,164},{856,184}})));
  Modelica.Fluid.Sensors.RelativeTemperature relativeTemperature annotation (Placement(transformation(extent={{778,164},{798,184}})));
  Sensors.DifferenceSensorSelect23
                                 differenceSensorSelect23_18(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K, outputValue=true) annotation (Placement(transformation(extent={{800,90},{820,110}})));
  Sensors.DifferenceSensorSelect23
                                 differenceSensorSelect23_19(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)  annotation (Placement(transformation(extent={{800,60},{820,80}})));
  Sensors.DifferenceSensorSelect23
                                 differenceSensorSelect23_20(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa, outputValue=true)
                                                                                                                                                 annotation (Placement(transformation(extent={{800,30},{820,50}})));
  Sensors.DifferenceSensorSelect23
                                 differenceSensorSelect23_21(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar)
                                                                                                                                annotation (Placement(transformation(extent={{800,0},{820,20}})));
  Sensors.DifferenceSensorSelect23
                                 differenceSensorSelect23_22(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{800,-30},{820,-10}})));
  Sensors.DifferenceSensorSelect23
                                 differenceSensorSelect23_23(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.v_m3pkg)
                                                                                                                                annotation (Placement(transformation(extent={{800,-60},{820,-40}})));
  Sensors.DifferenceSensorSelect23
                                 differenceSensorSelect23_24(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{800,-90},{820,-70}})));
  Sensors.DifferenceSensorSelect23
                                 differenceSensorSelect23_25(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK)
                                                                                                                                annotation (Placement(transformation(extent={{800,-120},{820,-100}})));
  Sensors.DifferenceSensorSelect23
                                 differenceSensorSelect23_26(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{800,-150},{820,-130}})));
  Sensors.DifferenceSensorSelect23
                                 differenceSensorSelect23_27(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cv_JpkgK)
                                                                                                                                annotation (Placement(transformation(extent={{800,-180},{820,-160}})));
  Sensors.DifferenceSensorSelect23
                                 differenceSensorSelect23_28(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{800,-210},{820,-190}})));
  Sensors.DifferenceSensorSelect23
                                 differenceSensorSelect23_29(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.a_mps)
                                                                                                                                annotation (Placement(transformation(extent={{800,-240},{820,-220}})));
  Sensors.DifferenceSensorSelect23
                                 differenceSensorSelect23_30(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.MM_kgpmol, outputValue=true)
                                                                                                                                                 annotation (Placement(transformation(extent={{800,-270},{820,-250}})));
  Sensors.DifferenceSensorSelect23
                                 differenceSensorSelect23_31(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_Pa) annotation (Placement(transformation(extent={{800,-300},{820,-280}})));
  Sensors.DifferenceSensorSelect23
                                 differenceSensorSelect23_32(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_bar, outputValue=true)
                                                                                                                                                 annotation (Placement(transformation(extent={{800,-330},{820,-310}})));
  Sensors.DifferenceSensorSelect23
                                 differenceSensorSelect23_33(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_Pa)
                                                                                                                                annotation (Placement(transformation(extent={{800,-360},{820,-340}})));
  Sensors.DifferenceSensorSelect23
                                 differenceSensorSelect23_34(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_bar)
                                                                                                                                annotation (Placement(transformation(extent={{800,-390},{820,-370}})));
  Sensors.DifferenceSensorSelect32
                                 differenceSensorSelect32_1(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K, outputValue=true)  annotation (Placement(transformation(extent={{880,90},{900,110}})));
  Sensors.DifferenceSensorSelect32
                                 differenceSensorSelect32_3(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)   annotation (Placement(transformation(extent={{880,60},{900,80}})));
  Sensors.DifferenceSensorSelect32
                                 differenceSensorSelect32_4(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa, outputValue=true) annotation (Placement(transformation(extent={{880,30},{900,50}})));
  Sensors.DifferenceSensorSelect32
                                 differenceSensorSelect32_5(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar) annotation (Placement(transformation(extent={{880,0},{900,20}})));
  Sensors.DifferenceSensorSelect32
                                 differenceSensorSelect32_6(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{880,-30},{900,-10}})));
  Sensors.DifferenceSensorSelect32
                                 differenceSensorSelect32_7(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.v_m3pkg)
                                                                                                                                annotation (Placement(transformation(extent={{880,-60},{900,-40}})));
  Sensors.DifferenceSensorSelect32
                                 differenceSensorSelect32_8(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{880,-90},{900,-70}})));
  Sensors.DifferenceSensorSelect32
                                 differenceSensorSelect32_9(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK)
                                                                                                                                annotation (Placement(transformation(extent={{880,-120},{900,-100}})));
  Sensors.DifferenceSensorSelect32
                                 differenceSensorSelect32_10(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{880,-150},{900,-130}})));
  Sensors.DifferenceSensorSelect32
                                 differenceSensorSelect32_11(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cv_JpkgK)
                                                                                                                                annotation (Placement(transformation(extent={{880,-180},{900,-160}})));
  Sensors.DifferenceSensorSelect32
                                 differenceSensorSelect32_12(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{880,-210},{900,-190}})));
  Sensors.DifferenceSensorSelect32
                                 differenceSensorSelect32_13(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.a_mps)
                                                                                                                                annotation (Placement(transformation(extent={{880,-240},{900,-220}})));
  Sensors.DifferenceSensorSelect32
                                 differenceSensorSelect32_14(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.MM_kgpmol, outputValue=true)
                                                                                                                                                 annotation (Placement(transformation(extent={{880,-270},{900,-250}})));
  Sensors.DifferenceSensorSelect32
                                 differenceSensorSelect32_15(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_Pa) annotation (Placement(transformation(extent={{880,-300},{900,-280}})));
  Sensors.DifferenceSensorSelect32
                                 differenceSensorSelect32_16(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_bar, outputValue=true)
                                                                                                                                                 annotation (Placement(transformation(extent={{880,-330},{900,-310}})));
  Sensors.DifferenceSensorSelect32
                                 differenceSensorSelect32_17(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_Pa)
                                                                                                                                annotation (Placement(transformation(extent={{880,-360},{900,-340}})));
  Sensors.DifferenceSensorSelect32
                                 differenceSensorSelect32_2(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_bar)
                                                                                                                                annotation (Placement(transformation(extent={{880,-390},{900,-370}})));
  Sensors.DifferenceSensorSelect3 differenceSensorSelect3_1(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K, outputValue=true)  annotation (Placement(transformation(extent={{840,90},{860,110}})));
  Sensors.DifferenceSensorSelect3 differenceSensorSelect3_3(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)   annotation (Placement(transformation(extent={{840,60},{860,80}})));
  Sensors.DifferenceSensorSelect3 differenceSensorSelect3_4(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa, outputValue=true) annotation (Placement(transformation(extent={{840,30},{860,50}})));
  Sensors.DifferenceSensorSelect3 differenceSensorSelect3_5(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar) annotation (Placement(transformation(extent={{840,0},{860,20}})));
  Sensors.DifferenceSensorSelect3 differenceSensorSelect3_6(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{840,-30},{860,-10}})));
  Sensors.DifferenceSensorSelect3 differenceSensorSelect3_7(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.v_m3pkg)
                                                                                                                                annotation (Placement(transformation(extent={{840,-60},{860,-40}})));
  Sensors.DifferenceSensorSelect3 differenceSensorSelect3_8(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{840,-90},{860,-70}})));
  Sensors.DifferenceSensorSelect3 differenceSensorSelect3_9(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK)
                                                                                                                                annotation (Placement(transformation(extent={{840,-120},{860,-100}})));
  Sensors.DifferenceSensorSelect3 differenceSensorSelect3_10(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{840,-150},{860,-130}})));
  Sensors.DifferenceSensorSelect3 differenceSensorSelect3_11(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cv_JpkgK)
                                                                                                                                annotation (Placement(transformation(extent={{840,-180},{860,-160}})));
  Sensors.DifferenceSensorSelect3 differenceSensorSelect3_12(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{840,-210},{860,-190}})));
  Sensors.DifferenceSensorSelect3 differenceSensorSelect3_13(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.a_mps)
                                                                                                                                annotation (Placement(transformation(extent={{840,-240},{860,-220}})));
  Sensors.DifferenceSensorSelect3 differenceSensorSelect3_14(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.MM_kgpmol, outputValue=true)
                                                                                                                                                 annotation (Placement(transformation(extent={{840,-270},{860,-250}})));
  Sensors.DifferenceSensorSelect3 differenceSensorSelect3_15(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_Pa) annotation (Placement(transformation(extent={{840,-300},{860,-280}})));
  Sensors.DifferenceSensorSelect3 differenceSensorSelect3_16(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_bar, outputValue=true)
                                                                                                                                                 annotation (Placement(transformation(extent={{840,-330},{860,-310}})));
  Sensors.DifferenceSensorSelect3 differenceSensorSelect3_17(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_Pa)
                                                                                                                                annotation (Placement(transformation(extent={{840,-360},{860,-340}})));
  Sensors.DifferenceSensorSelect3 differenceSensorSelect3_2(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_bar)
                                                                                                                                annotation (Placement(transformation(extent={{840,-390},{860,-370}})));
  Sensors.DifferenceSensorSelect33
                                 differenceSensorSelect33_1(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K, outputValue=true)  annotation (Placement(transformation(extent={{920,90},{940,110}})));
  Sensors.DifferenceSensorSelect33
                                 differenceSensorSelect33_3(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C)   annotation (Placement(transformation(extent={{920,60},{940,80}})));
  Sensors.DifferenceSensorSelect33
                                 differenceSensorSelect33_4(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa, outputValue=true) annotation (Placement(transformation(extent={{920,30},{940,50}})));
  Sensors.DifferenceSensorSelect33
                                 differenceSensorSelect33_5(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar) annotation (Placement(transformation(extent={{920,0},{940,20}})));
  Sensors.DifferenceSensorSelect33
                                 differenceSensorSelect33_6(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{920,-30},{940,-10}})));
  Sensors.DifferenceSensorSelect33
                                 differenceSensorSelect33_7(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.v_m3pkg)
                                                                                                                                annotation (Placement(transformation(extent={{920,-60},{940,-40}})));
  Sensors.DifferenceSensorSelect33
                                 differenceSensorSelect33_8(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.h_Jpkg,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{920,-90},{940,-70}})));
  Sensors.DifferenceSensorSelect33
                                 differenceSensorSelect33_9(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.s_JpkgK)
                                                                                                                                annotation (Placement(transformation(extent={{920,-120},{940,-100}})));
  Sensors.DifferenceSensorSelect33
                                 differenceSensorSelect33_10(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cp_JpkgK,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{920,-150},{940,-130}})));
  Sensors.DifferenceSensorSelect33
                                 differenceSensorSelect33_11(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.cv_JpkgK)
                                                                                                                                annotation (Placement(transformation(extent={{920,-180},{940,-160}})));
  Sensors.DifferenceSensorSelect33
                                 differenceSensorSelect33_12(
    displayInstanceName=false,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.kappa_1,
    outputValue=true)                                                                                                                            annotation (Placement(transformation(extent={{920,-210},{940,-190}})));
  Sensors.DifferenceSensorSelect33
                                 differenceSensorSelect33_13(displayInstanceName=false, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.a_mps)
                                                                                                                                annotation (Placement(transformation(extent={{920,-240},{940,-220}})));
  Sensors.DifferenceSensorSelect33
                                 differenceSensorSelect33_14(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.MM_kgpmol, outputValue=true)
                                                                                                                                                 annotation (Placement(transformation(extent={{920,-270},{940,-250}})));
  Sensors.DifferenceSensorSelect33
                                 differenceSensorSelect33_15(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_Pa) annotation (Placement(transformation(extent={{920,-300},{940,-280}})));
  Sensors.DifferenceSensorSelect33
                                 differenceSensorSelect33_16(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.r_bar, outputValue=true)
                                                                                                                                                 annotation (Placement(transformation(extent={{920,-330},{940,-310}})));
  Sensors.DifferenceSensorSelect33
                                 differenceSensorSelect33_17(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_Pa)
                                                                                                                                annotation (Placement(transformation(extent={{920,-360},{940,-340}})));
  Sensors.DifferenceSensorSelect33
                                 differenceSensorSelect33_2(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_total_bar)
                                                                                                                                annotation (Placement(transformation(extent={{920,-390},{940,-370}})));
  Modelica.Fluid.Sensors.Pressure pressure annotation (Placement(transformation(extent={{138,50},{158,70}})));
  Modelica.Fluid.Sensors.Density density annotation (Placement(transformation(extent={{140,20},{160,40}})));
  Modelica.Fluid.Sensors.DensityTwoPort density1 annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Fluid.Sensors.Temperature temperature annotation (Placement(transformation(extent={{140,88},{160,108}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temperature1 annotation (Placement(transformation(extent={{100,90},{120,110}})));
  Modelica.Fluid.Sensors.SpecificEnthalpy specificEnthalpy annotation (Placement(transformation(extent={{140,-20},{160,0}})));
  Modelica.Fluid.Sensors.SpecificEnthalpyTwoPort specificEnthalpy1 annotation (Placement(transformation(extent={{100,-20},{120,0}})));
  Modelica.Fluid.Sensors.SpecificEntropy specificEntropy annotation (Placement(transformation(extent={{140,-60},{160,-40}})));
  Modelica.Fluid.Sensors.SpecificEntropyTwoPort specificEntropy1 annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate annotation (Placement(transformation(extent={{510,180},{530,200}})));
  Modelica.Fluid.Sensors.VolumeFlowRate volumeFlowRate annotation (Placement(transformation(extent={{550,180},{570,200}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg, outputValue=true) annotation (Placement(transformation(extent={{980,90},{1000,110}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect1(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_K) annotation (Placement(transformation(extent={{980,60},{1000,80}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect2(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C, outputValue=true) annotation (Placement(transformation(extent={{980,30},{1000,50}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect3(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa) annotation (Placement(transformation(extent={{980,0},{1000,20}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect4(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_bar, outputValue=true) annotation (Placement(transformation(extent={{980,-30},{1000,-10}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect5(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K) annotation (Placement(transformation(extent={{980,-60},{1000,-40}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect6(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_Pa, outputValue=true) annotation (Placement(transformation(extent={{980,-90},{1000,-70}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect differenceTwoPhaseSensorSensorSelect7(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_bar) annotation (Placement(transformation(extent={{980,-120},{1000,-100}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect2 differenceTwoPhaseSensorSensorSelect2_1(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg, outputValue=true) annotation (Placement(transformation(extent={{1020,90},{1040,110}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect2 differenceTwoPhaseSensorSensorSelect2_3(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_K) annotation (Placement(transformation(extent={{1020,60},{1040,80}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect2 differenceTwoPhaseSensorSensorSelect2_4(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C, outputValue=true) annotation (Placement(transformation(extent={{1020,30},{1040,50}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect2 differenceTwoPhaseSensorSensorSelect2_5(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa) annotation (Placement(transformation(extent={{1020,0},{1040,20}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect2 differenceTwoPhaseSensorSensorSelect2_6(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_bar, outputValue=true) annotation (Placement(transformation(extent={{1020,-30},{1040,-10}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect2 differenceTwoPhaseSensorSensorSelect2_7(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K) annotation (Placement(transformation(extent={{1020,-60},{1040,-40}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect2 differenceTwoPhaseSensorSensorSelect2_8(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_Pa, outputValue=true) annotation (Placement(transformation(extent={{1020,-90},{1040,-70}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect2 differenceTwoPhaseSensorSensorSelect2_2(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_bar) annotation (Placement(transformation(extent={{1020,-120},{1040,-100}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect22 differenceTwoPhaseSensorSensorSelect22_1(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg, outputValue=true) annotation (Placement(transformation(extent={{1060,90},{1080,110}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect22 differenceTwoPhaseSensorSensorSelect22_3(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_K) annotation (Placement(transformation(extent={{1060,60},{1080,80}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect22 differenceTwoPhaseSensorSensorSelect22_4(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C, outputValue=true) annotation (Placement(transformation(extent={{1060,30},{1080,50}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect22 differenceTwoPhaseSensorSensorSelect22_5(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa) annotation (Placement(transformation(extent={{1060,0},{1080,20}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect22 differenceTwoPhaseSensorSensorSelect22_6(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_bar, outputValue=true) annotation (Placement(transformation(extent={{1060,-30},{1080,-10}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect22 differenceTwoPhaseSensorSensorSelect22_7(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K) annotation (Placement(transformation(extent={{1060,-60},{1080,-40}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect22 differenceTwoPhaseSensorSensorSelect22_8(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_Pa, outputValue=true) annotation (Placement(transformation(extent={{1060,-90},{1080,-70}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect22 differenceTwoPhaseSensorSensorSelect22_2(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_bar) annotation (Placement(transformation(extent={{1060,-120},{1080,-100}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect23 differenceTwoPhaseSensorSensorSelect23_1(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg, outputValue=true) annotation (Placement(transformation(extent={{1100,90},{1120,110}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect23 differenceTwoPhaseSensorSensorSelect23_3(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_K) annotation (Placement(transformation(extent={{1100,60},{1120,80}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect23 differenceTwoPhaseSensorSensorSelect23_4(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C, outputValue=true) annotation (Placement(transformation(extent={{1100,30},{1120,50}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect23 differenceTwoPhaseSensorSensorSelect23_5(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa) annotation (Placement(transformation(extent={{1100,0},{1120,20}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect23 differenceTwoPhaseSensorSensorSelect23_6(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_bar, outputValue=true) annotation (Placement(transformation(extent={{1100,-30},{1120,-10}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect23 differenceTwoPhaseSensorSensorSelect23_7(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K) annotation (Placement(transformation(extent={{1100,-60},{1120,-40}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect23 differenceTwoPhaseSensorSensorSelect23_8(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_Pa, outputValue=true) annotation (Placement(transformation(extent={{1100,-90},{1120,-70}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect23 differenceTwoPhaseSensorSensorSelect23_2(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_bar) annotation (Placement(transformation(extent={{1100,-120},{1120,-100}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect3 differenceTwoPhaseSensorSensorSelect3_1(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg, outputValue=true) annotation (Placement(transformation(extent={{1140,90},{1160,110}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect3 differenceTwoPhaseSensorSensorSelect3_3(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_K) annotation (Placement(transformation(extent={{1140,60},{1160,80}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect3 differenceTwoPhaseSensorSensorSelect3_4(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C, outputValue=true) annotation (Placement(transformation(extent={{1140,30},{1160,50}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect3 differenceTwoPhaseSensorSensorSelect3_5(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa) annotation (Placement(transformation(extent={{1140,0},{1160,20}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect3 differenceTwoPhaseSensorSensorSelect3_6(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_bar, outputValue=true) annotation (Placement(transformation(extent={{1140,-30},{1160,-10}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect3 differenceTwoPhaseSensorSensorSelect3_7(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K) annotation (Placement(transformation(extent={{1140,-60},{1160,-40}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect3 differenceTwoPhaseSensorSensorSelect3_8(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_Pa, outputValue=true) annotation (Placement(transformation(extent={{1140,-90},{1160,-70}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect3 differenceTwoPhaseSensorSensorSelect3_2(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_bar) annotation (Placement(transformation(extent={{1140,-120},{1160,-100}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect32 differenceTwoPhaseSensorSensorSelect32_1(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg, outputValue=true) annotation (Placement(transformation(extent={{1180,90},{1200,110}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect32 differenceTwoPhaseSensorSensorSelect32_3(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_K) annotation (Placement(transformation(extent={{1180,60},{1200,80}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect32 differenceTwoPhaseSensorSensorSelect32_4(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C, outputValue=true) annotation (Placement(transformation(extent={{1180,30},{1200,50}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect32 differenceTwoPhaseSensorSensorSelect32_5(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa) annotation (Placement(transformation(extent={{1180,0},{1200,20}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect32 differenceTwoPhaseSensorSensorSelect32_6(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_bar, outputValue=true) annotation (Placement(transformation(extent={{1180,-30},{1200,-10}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect32 differenceTwoPhaseSensorSensorSelect32_7(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K) annotation (Placement(transformation(extent={{1180,-60},{1200,-40}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect32 differenceTwoPhaseSensorSensorSelect32_8(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_Pa, outputValue=true) annotation (Placement(transformation(extent={{1180,-90},{1200,-70}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect32 differenceTwoPhaseSensorSensorSelect32_2(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_bar) annotation (Placement(transformation(extent={{1180,-120},{1200,-100}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect33 differenceTwoPhaseSensorSensorSelect33_1(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg, outputValue=true) annotation (Placement(transformation(extent={{1220,90},{1240,110}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect33 differenceTwoPhaseSensorSensorSelect33_3(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_K) annotation (Placement(transformation(extent={{1220,60},{1240,80}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect33 differenceTwoPhaseSensorSensorSelect33_4(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_sat_C, outputValue=true) annotation (Placement(transformation(extent={{1220,30},{1240,50}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect33 differenceTwoPhaseSensorSensorSelect33_5(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_Pa) annotation (Placement(transformation(extent={{1220,0},{1240,20}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect33 differenceTwoPhaseSensorSensorSelect33_6(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_sat_bar, outputValue=true) annotation (Placement(transformation(extent={{1220,-30},{1240,-10}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect33 differenceTwoPhaseSensorSensorSelect33_7(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.T_oversat_K) annotation (Placement(transformation(extent={{1220,-60},{1240,-40}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect33 differenceTwoPhaseSensorSensorSelect33_8(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_Pa, outputValue=true) annotation (Placement(transformation(extent={{1220,-90},{1240,-70}})));
  Sensors.DifferenceTwoPhaseSensorSensorSelect33 differenceTwoPhaseSensorSensorSelect33_2(quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.p_oversat_bar) annotation (Placement(transformation(extent={{1220,-120},{1240,-100}})));
  Sensors.DifferenceSensor_Tp differenceSensor_Tp annotation (Placement(transformation(extent={{442,-510},{462,-490}})));
  Sensors.DifferenceSensor_Tp differenceSensor_Tp1(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=false,
    outputPressure=false) annotation (Placement(transformation(extent={{442,-542},{462,-522}})));
  Sensors.SensorState sensorState annotation (Placement(transformation(extent={{620,-760},{640,-740}})));
  Sensors.SingleSensorX singleSensorX(outputValue=true) annotation (Placement(transformation(extent={{792,-758},{812,-738}})));
  Sensors.MultiSensor_Tp multiSensor_Tp(outputTemperature=false, outputPressure=false)
                                                                                     annotation (Placement(transformation(extent={{300,-510},{320,-490}})));
  Sensors.SingleSensorX singleSensorX1 annotation (Placement(transformation(extent={{792,-788},{812,-768}})));
  Sensors.MultiSensor_Tp multiSensor_Tp1(temperatureUnit="degC", pressureUnit="bar")
                                         annotation (Placement(transformation(extent={{300,-540},{320,-520}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm1 annotation (Placement(transformation(extent={{680,-520},{700,-500}})));
  Modelica.Fluid.Sensors.MassFractions massFraction annotation (Placement(transformation(extent={{712,-758},{732,-738}})));
  Modelica.Fluid.Sensors.MassFractionsTwoPort massFraction1 annotation (Placement(transformation(extent={{752,-758},{772,-738}})));
  Modelica.Fluid.Sensors.TraceSubstancesTwoPort traceSubstance annotation (Placement(transformation(extent={{752,-790},{772,-770}})));
  Modelica.Fluid.Sensors.TraceSubstances traceSubstance1 annotation (Placement(transformation(extent={{712,-788},{732,-768}})));
  Sensors.MultiSensor_Tp multiSensor_Tp3(outputTemperature=true, outputPressure=true)
                                                                                     annotation (Placement(transformation(extent={{300,-570},{320,-550}})));
  Sensors.MultiSensor_Tp multiSensor_Tp4(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=true,
    outputPressure=true)                 annotation (Placement(transformation(extent={{300,-600},{320,-580}})));
  Sensors.MultiSensor_Tp2 multiSensor_Tp2(outputTemperature=false, outputPressure=false)
                                                                                     annotation (Placement(transformation(extent={{340,-510},{360,-490}})));
  Sensors.MultiSensor_Tp2 multiSensor_Tp2_2(temperatureUnit="degC", pressureUnit="bar")
                                         annotation (Placement(transformation(extent={{340,-540},{360,-520}})));
  Sensors.MultiSensor_Tp2 multiSensor_Tp2_3(outputTemperature=true, outputPressure=true)
                                                                                     annotation (Placement(transformation(extent={{340,-570},{360,-550}})));
  Sensors.MultiSensor_Tp2 multiSensor_Tp2_1(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=true,
    outputPressure=true)                 annotation (Placement(transformation(extent={{340,-600},{360,-580}})));
  Sensors.MultiSensor_Tp3 multiSensor_Tp3_1(outputTemperature=false, outputPressure=false)
                                                                                     annotation (Placement(transformation(extent={{380,-510},{400,-490}})));
  Sensors.MultiSensor_Tp3 multiSensor_Tp3_3(temperatureUnit="degC", pressureUnit="bar")
                                         annotation (Placement(transformation(extent={{380,-540},{400,-520}})));
  Sensors.MultiSensor_Tp3 multiSensor_Tp3_4(outputTemperature=true, outputPressure=true)
                                                                                     annotation (Placement(transformation(extent={{380,-570},{400,-550}})));
  Sensors.MultiSensor_Tp3 multiSensor_Tp3_2(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=true,
    outputPressure=true)                 annotation (Placement(transformation(extent={{380,-600},{400,-580}})));
  Sensors.DifferenceSensor_Tp differenceSensor_Tp2(outputTemperature=true, outputPressure=true) annotation (Placement(transformation(extent={{440,-568},{460,-548}})));
  Sensors.DifferenceSensor_Tp differenceSensor_Tp3(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=true,
    outputPressure=true) annotation (Placement(transformation(extent={{440,-600},{460,-580}})));
  Sensors.DifferenceSensor_Tp2 differenceSensor_Tp3_1 annotation (Placement(transformation(extent={{480,-510},{500,-490}})));
  Sensors.DifferenceSensor_Tp2 differenceSensor_Tp3_3(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=false,
    outputPressure=false) annotation (Placement(transformation(extent={{480,-542},{500,-522}})));
  Sensors.DifferenceSensor_Tp2 differenceSensor_Tp3_4(outputTemperature=true, outputPressure=true) annotation (Placement(transformation(extent={{478,-568},{498,-548}})));
  Sensors.DifferenceSensor_Tp2 differenceSensor_Tp3_2(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=true,
    outputPressure=true) annotation (Placement(transformation(extent={{478,-600},{498,-580}})));
  Sensors.DifferenceSensor_Tp3 differenceSensor_Tp3_5 annotation (Placement(transformation(extent={{520,-510},{540,-490}})));
  Sensors.DifferenceSensor_Tp3 differenceSensor_Tp3_6(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=false,
    outputPressure=false) annotation (Placement(transformation(extent={{520,-540},{540,-520}})));
  Sensors.DifferenceSensor_Tp3 differenceSensor_Tp3_7(outputTemperature=true, outputPressure=true) annotation (Placement(transformation(extent={{520,-570},{540,-550}})));
  Sensors.DifferenceSensor_Tp3 differenceSensor_Tp3_8(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=true,
    outputPressure=true) annotation (Placement(transformation(extent={{520,-600},{540,-580}})));
  Sensors.DifferenceSensor_Tp4 differenceSensor_Tp4_1 annotation (Placement(transformation(extent={{560,-510},{580,-490}})));
  Sensors.DifferenceSensor_Tp4 differenceSensor_Tp4_3(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=false,
    outputPressure=false) annotation (Placement(transformation(extent={{560,-540},{580,-520}})));
  Sensors.DifferenceSensor_Tp4 differenceSensor_Tp4_4(outputTemperature=true, outputPressure=true) annotation (Placement(transformation(extent={{560,-570},{580,-550}})));
  Sensors.DifferenceSensor_Tp4 differenceSensor_Tp4_2(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=true,
    outputPressure=true) annotation (Placement(transformation(extent={{560,-600},{580,-580}})));
  Sensors.DifferenceSensor_Tp5 differenceSensor_Tp5_5 annotation (Placement(transformation(extent={{600,-510},{620,-490}})));
  Sensors.DifferenceSensor_Tp5 differenceSensor_Tp5_6(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=false,
    outputPressure=false) annotation (Placement(transformation(extent={{600,-540},{620,-520}})));
  Sensors.DifferenceSensor_Tp5 differenceSensor_Tp5_7(outputTemperature=true, outputPressure=true) annotation (Placement(transformation(extent={{600,-570},{620,-550}})));
  Sensors.DifferenceSensor_Tp5 differenceSensor_Tp5_8(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=true,
    outputPressure=true) annotation (Placement(transformation(extent={{600,-600},{620,-580}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm4(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)")                  annotation (Placement(transformation(extent={{680,-560},{700,-540}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm5(
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true)               annotation (Placement(transformation(extent={{680,-600},{700,-580}})));
  Sensors.MultiSensor_Tpm multiSensor_Tpm6(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)",
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true)               annotation (Placement(transformation(extent={{678,-640},{698,-620}})));
  Sensors.MultiSensor_Tpm2 multiSensor_Tpm2_1
                                           annotation (Placement(transformation(extent={{880,-520},{900,-500}})));
  Sensors.MultiSensor_Tpm2 multiSensor_Tpm2_3(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)")                  annotation (Placement(transformation(extent={{880,-560},{900,-540}})));
  Sensors.MultiSensor_Tpm2 multiSensor_Tpm2_4(
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true)               annotation (Placement(transformation(extent={{880,-600},{900,-580}})));
  Sensors.MultiSensor_Tpm2 multiSensor_Tpm2_2(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)",
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true)               annotation (Placement(transformation(extent={{880,-640},{900,-620}})));
  Sensors.MultiSensor_Tpm3 multiSensor_Tpm3_1
                                           annotation (Placement(transformation(extent={{920,-520},{940,-500}})));
  Sensors.MultiSensor_Tpm3 multiSensor_Tpm3_3(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)")                  annotation (Placement(transformation(extent={{920,-560},{940,-540}})));
  Sensors.MultiSensor_Tpm3 multiSensor_Tpm3_4(
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true)               annotation (Placement(transformation(extent={{920,-600},{940,-580}})));
  Sensors.MultiSensor_Tpm3 multiSensor_Tpm3_2(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)",
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true)               annotation (Placement(transformation(extent={{920,-640},{940,-620}})));
  Sensors.MultiSensor_Tpm4 multiSensor_Tpm4_1
                                           annotation (Placement(transformation(extent={{960,-520},{980,-500}})));
  Sensors.MultiSensor_Tpm4 multiSensor_Tpm4_3(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)")                  annotation (Placement(transformation(extent={{960,-560},{980,-540}})));
  Sensors.MultiSensor_Tpm4 multiSensor_Tpm4_4(
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true)               annotation (Placement(transformation(extent={{960,-600},{980,-580}})));
  Sensors.MultiSensor_Tpm4 multiSensor_Tpm4_2(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)",
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true)               annotation (Placement(transformation(extent={{960,-640},{980,-620}})));
  Sensors.MultiSensor_Tpm5 multiSensor_Tpm5_1
                                           annotation (Placement(transformation(extent={{800,-520},{820,-500}})));
  Sensors.MultiSensor_Tpm5 multiSensor_Tpm5_3(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)")                  annotation (Placement(transformation(extent={{800,-560},{820,-540}})));
  Sensors.MultiSensor_Tpm5 multiSensor_Tpm5_4(
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true)               annotation (Placement(transformation(extent={{800,-600},{820,-580}})));
  Sensors.MultiSensor_Tpm5 multiSensor_Tpm5_2(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)",
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true)               annotation (Placement(transformation(extent={{800,-640},{820,-620}})));
  Sensors.MultiSensor_Tpm1 multiSensor_Tpm1_1
                                           annotation (Placement(transformation(extent={{720,-520},{740,-500}})));
  Sensors.MultiSensor_Tpm1 multiSensor_Tpm1_2(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)")                  annotation (Placement(transformation(extent={{720,-560},{740,-540}})));
  Sensors.MultiSensor_Tpm1 multiSensor_Tpm1_3(
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true)               annotation (Placement(transformation(extent={{720,-600},{740,-580}})));
  Sensors.MultiSensor_Tpm1 multiSensor_Tpm10(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)",
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true)               annotation (Placement(transformation(extent={{718,-640},{738,-620}})));
  Sensors.MultiSensor_Tpm6 multiSensor_Tpm6_1
                                           annotation (Placement(transformation(extent={{840,-520},{860,-500}})));
  Sensors.MultiSensor_Tpm6 multiSensor_Tpm6_3(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)")                  annotation (Placement(transformation(extent={{840,-560},{860,-540}})));
  Sensors.MultiSensor_Tpm6 multiSensor_Tpm6_4(
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true)               annotation (Placement(transformation(extent={{840,-600},{860,-580}})));
  Sensors.MultiSensor_Tpm6 multiSensor_Tpm6_2(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)",
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true)               annotation (Placement(transformation(extent={{840,-640},{860,-620}})));
  Sensors.MultiSensor_Tp_TwoPort1
                          multiSensor_Tpm1_4
                                           annotation (Placement(transformation(extent={{1060,-520},{1080,-500}})));
  Sensors.MultiSensor_Tp_TwoPort1
                          multiSensor_Tpm1_5(temperatureUnit="degC", pressureUnit="bar")
                                           annotation (Placement(transformation(extent={{1060,-560},{1080,-540}})));
  Sensors.MultiSensor_Tp_TwoPort1
                          multiSensor_Tpm1_6(outputTemperature=true, outputPressure=true)
                                           annotation (Placement(transformation(extent={{1060,-600},{1080,-580}})));
  Sensors.MultiSensor_Tp_TwoPort1
                          multiSensor_Tpm7(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=true,
    outputPressure=true)                   annotation (Placement(transformation(extent={{1058,-640},{1078,-620}})));
  Sensors.MultiSensor_Tp_TwoPort2
                          multiSensor_Tpm1_7
                                           annotation (Placement(transformation(extent={{1100,-520},{1120,-500}})));
  Sensors.MultiSensor_Tp_TwoPort2
                          multiSensor_Tpm1_8(temperatureUnit="degC", pressureUnit="bar")
                                           annotation (Placement(transformation(extent={{1100,-560},{1120,-540}})));
  Sensors.MultiSensor_Tp_TwoPort2
                          multiSensor_Tpm1_9(outputTemperature=true, outputPressure=true)
                                           annotation (Placement(transformation(extent={{1100,-600},{1120,-580}})));
  Sensors.MultiSensor_Tp_TwoPort2
                          multiSensor_Tpm8(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=true,
    outputPressure=true)                   annotation (Placement(transformation(extent={{1098,-640},{1118,-620}})));
  Sensors.MultiSensor_Tp_TwoPort3
                          multiSensor_Tpm1_10
                                           annotation (Placement(transformation(extent={{1140,-520},{1160,-500}})));
  Sensors.MultiSensor_Tp_TwoPort3
                          multiSensor_Tpm1_11(temperatureUnit="degC", pressureUnit="bar")
                                           annotation (Placement(transformation(extent={{1140,-560},{1160,-540}})));
  Sensors.MultiSensor_Tp_TwoPort3
                          multiSensor_Tpm1_12(outputTemperature=true, outputPressure=true)
                                           annotation (Placement(transformation(extent={{1140,-600},{1160,-580}})));
  Sensors.MultiSensor_Tp_TwoPort3
                          multiSensor_Tpm9(
    temperatureUnit="degC",
    pressureUnit="bar",
    outputTemperature=true,
    outputPressure=true)                   annotation (Placement(transformation(extent={{1140,-640},{1160,-620}})));
  Sensors.MultiSensor_Tpm1small
                          multiSensor_Tpm1small
                                           annotation (Placement(transformation(extent={{760,-520},{780,-500}})));
  Sensors.MultiSensor_Tpm1small
                          multiSensor_Tpm1small2(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)")                  annotation (Placement(transformation(extent={{760,-560},{780,-540}})));
  Sensors.MultiSensor_Tpm1small
                          multiSensor_Tpm1small3(
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true)               annotation (Placement(transformation(extent={{760,-600},{780,-580}})));
  Sensors.MultiSensor_Tpm1small
                          multiSensor_Tpm1small1(
    temperatureUnit="degC",
    pressureUnit="bar",
    massFlowUnit="(g/s)",
    outputTemperature=true,
    outputPressure=true,
    outputMassFlowRate=true)               annotation (Placement(transformation(extent={{758,-640},{778,-620}})));
  Undirected.HeatExchangers.DiscretizedCrossFlowHEX2 discretizedCrossFlowHEX2_1 annotation (Placement(transformation(extent={{-40,-800},{-20,-780}})));
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
          extent={{1280,-400},{80,160}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{160,180},{420,160}},
          textColor={28,108,200},
          textString="Sensors"),
        Rectangle(
          extent={{-408,286},{-400,280}},
          lineColor={28,108,200},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-448,286},{-440,280}},
          lineColor={28,108,200},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-488,246},{-480,240}},
          lineColor={28,108,200},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-408,246},{-400,240}},
          lineColor={28,108,200},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
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
          extent={{240,-742},{100,-642}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{100,-622},{240,-642}},
          textColor={28,108,200},
          textString="Sensors"),
        Text(
          extent={{180,140},{200,120}},
          textColor={28,108,200},
          textString="v1"),
        Text(
          extent={{220,140},{240,120}},
          textColor={28,108,200},
          textString="v2"),
        Text(
          extent={{260,140},{280,120}},
          textColor={28,108,200},
          textString="v3"),
        Text(
          extent={{180,160},{280,140}},
          textColor={28,108,200},
          textString="SingleSensorSelect"),
        Text(
          extent={{320,160},{420,140}},
          textColor={28,108,200},
          textString="TwoPhaseSensorSelect"),
        Text(
          extent={{320,140},{340,120}},
          textColor={28,108,200},
          textString="v1"),
        Text(
          extent={{360,140},{380,120}},
          textColor={28,108,200},
          textString="v2"),
        Text(
          extent={{400,140},{420,120}},
          textColor={28,108,200},
          textString="v3"),
        Text(
          extent={{460,140},{480,120}},
          textColor={28,108,200},
          textString="v1"),
        Text(
          extent={{500,140},{520,120}},
          textColor={28,108,200},
          textString="v2"),
        Text(
          extent={{540,140},{560,120}},
          textColor={28,108,200},
          textString="v2.2"),
        Text(
          extent={{580,140},{600,120}},
          textColor={28,108,200},
          textString="v3"),
        Text(
          extent={{620,140},{640,120}},
          textColor={28,108,200},
          textString="v3.2"),
        Text(
          extent={{460,160},{640,140}},
          textColor={28,108,200},
          textString="SingleFlowSensor"),
        Text(
          extent={{680,140},{700,120}},
          textColor={28,108,200},
          textString="v1"),
        Text(
          extent={{720,140},{740,120}},
          textColor={28,108,200},
          textString="v2"),
        Text(
          extent={{760,140},{780,120}},
          textColor={28,108,200},
          textString="v2.2"),
        Text(
          extent={{800,140},{820,120}},
          textColor={28,108,200},
          textString="v2.3"),
        Text(
          extent={{840,140},{860,120}},
          textColor={28,108,200},
          textString="v3"),
        Text(
          extent={{880,140},{900,120}},
          textColor={28,108,200},
          textString="v3.2"),
        Text(
          extent={{920,140},{940,120}},
          textColor={28,108,200},
          textString="v3.3"),
        Text(
          extent={{980,140},{1000,120}},
          textColor={28,108,200},
          textString="v1"),
        Text(
          extent={{1020,140},{1040,120}},
          textColor={28,108,200},
          textString="v2"),
        Text(
          extent={{1060,140},{1080,120}},
          textColor={28,108,200},
          textString="v2.2"),
        Text(
          extent={{1100,140},{1120,120}},
          textColor={28,108,200},
          textString="v2.3"),
        Text(
          extent={{1140,140},{1160,120}},
          textColor={28,108,200},
          textString="v3"),
        Text(
          extent={{1180,138},{1200,118}},
          textColor={28,108,200},
          textString="v3.2"),
        Text(
          extent={{1220,140},{1240,120}},
          textColor={28,108,200},
          textString="v3.3"),
        Text(
          extent={{280,-420},{540,-440}},
          textColor={28,108,200},
          textString="more Sensors"),
        Text(
          extent={{680,160},{940,140}},
          textColor={28,108,200},
          textString="DifferenceSensorSelect"),
        Text(
          extent={{980,160},{1240,140}},
          textColor={28,108,200},
          textString="DifferenceTwoPhaseSensorSelect"),
        Rectangle(
          extent={{1180,-660},{280,-440}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{300,-460},{320,-480}},
          textColor={28,108,200},
          textString="v1"),
        Text(
          extent={{340,-460},{360,-480}},
          textColor={28,108,200},
          textString="v2"),
        Text(
          extent={{380,-460},{400,-480}},
          textColor={28,108,200},
          textString="v3"),
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
          extent={{300,-440},{400,-460}},
          textColor={28,108,200},
          textString="MultiSensor_Tp"),
        Text(
          extent={{712,-698},{812,-718}},
          textColor={28,108,200},
          textString="singleSensorX"),
        Text(
          extent={{440,-460},{460,-480}},
          textColor={28,108,200},
          textString="v1"),
        Text(
          extent={{480,-460},{500,-480}},
          textColor={28,108,200},
          textString="v2"),
        Text(
          extent={{520,-460},{540,-480}},
          textColor={28,108,200},
          textString="v3"),
        Text(
          extent={{560,-460},{580,-480}},
          textColor={28,108,200},
          textString="v4"),
        Text(
          extent={{600,-460},{620,-480}},
          textColor={28,108,200},
          textString="v5"),
        Text(
          extent={{680,-460},{700,-480}},
          textColor={28,108,200},
          textString="v1"),
        Text(
          extent={{880,-460},{900,-480}},
          textColor={28,108,200},
          textString="v2"),
        Text(
          extent={{920,-460},{940,-480}},
          textColor={28,108,200},
          textString="v3"),
        Text(
          extent={{960,-460},{980,-480}},
          textColor={28,108,200},
          textString="v4"),
        Text(
          extent={{800,-460},{820,-480}},
          textColor={28,108,200},
          textString="v5"),
        Text(
          extent={{720,-460},{740,-480}},
          textColor={28,108,200},
          textString="v1.1"),
        Text(
          extent={{840,-460},{860,-480}},
          textColor={28,108,200},
          textString="v6"),
        Text(
          extent={{1060,-460},{1080,-480}},
          textColor={28,108,200},
          textString="v1"),
        Text(
          extent={{1100,-460},{1120,-480}},
          textColor={28,108,200},
          textString="v2"),
        Rectangle(
          extent={{726,-494},{734,-500}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{806,-486},{814,-492}},
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{844,-486},{852,-492}},
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{1066,-488},{1074,-494}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{1146,-488},{1154,-494}},
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{486,-478},{494,-484}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{606,-480},{614,-486}},
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{386,-478},{394,-484}},
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{440,-440},{620,-460}},
          textColor={28,108,200},
          textString="DifferenceSensor_Tp"),
        Text(
          extent={{680,-440},{940,-460}},
          textColor={28,108,200},
          textString="MultiSensor_Tpm"),
        Text(
          extent={{1060,-440},{1160,-460}},
          textColor={28,108,200},
          textString="MultiSensor_Tp"),
        Text(
          extent={{1140,-460},{1160,-480}},
          textColor={28,108,200},
          textString="v3"),
        Text(
          extent={{760,-460},{780,-480}},
          textColor={28,108,200},
          textString="v1small"),
        Rectangle(
          extent={{766,-488},{774,-494}},
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-320,-140},{-300,-160}},
          textColor={28,108,200},
          textString="v1"),
        Text(
          extent={{-280,-140},{-260,-160}},
          textColor={28,108,200},
          textString="v2")}));
end TestIcons;
