within ThermofluidStream.Interfaces.MSLplug.ByAssembly.Tests;
model TargetTest_02_NOK
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Water.StandardWaterOnePhase
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    annotation (
      choicesAllMatching=true);

  parameter Modelica.Units.NonSI.Temperature_degC T_SP=80 "Solar field outlet temperature setpoint"
    annotation(Dialog(group = "Control"));
  parameter  Modelica.Units.NonSI.Temperature_degC l_s=55 "Security maximum temperature threshold for production switching"
    annotation(Dialog(group = "Control"));
  parameter Modelica.Units.NonSI.Temperature_degC hyst_prod_pre=5  "Temperature hysteresis for switches in between in production and out of production"
    annotation(Dialog(group = "Control"));
  parameter Modelica.Units.NonSI.Temperature_degC detlat_T_SP=10  "Security margin deduced from the temperature setpoint to switch in production (compared with l_s and valuabe process temperature)."
    annotation(Dialog(group = "Control"));
  parameter Modelica.Units.NonSI.Temperature_degC detlat_T_min=5  "Minimum temperature difference supplied to the process"
    annotation(Dialog(group = "Control"));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "nominal mass flow rate for regularisation"
    annotation(Dialog(tab = "Advanced", group = "Regularisation parameters"));
  parameter Boolean computeL=true "Compute L from r and l" annotation (Dialog(tab="Advanced", group="Flow inertance"));

  HeatExchangers.CounterFlowNTU pHEXSimplified(
    redeclare package MediumA = Medium,
    redeclare package MediumB = Medium,
    A=10)              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={20,-10})));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{56,10},{76,30}})));

  ThermofluidStream.FlowControl.MCV mCV(
    redeclare package Medium = Medium,
    setpointFromInput=true,
    massFlow_set_par=1)
          annotation (Placement(transformation(extent={{50,-50},{30,-30}})));
  ThermofluidStream.FlowControl.MCV flowGenerator_SF(
    redeclare package Medium = Medium, massFlow_set_par=10)
          annotation (Placement(transformation(extent={{-44,-30},{-64,-50}})));

  ThermofluidStream.Boundaries.Source source(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{80,-50},{60,-30}})));
  inner DropOfCommons dropOfCommons(L=1000)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  inner Modelica.Fluid.System system(g=0.0000001)
                                     annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Noise.UniformNoise heatScenario(
    samplePeriod=60,
    y_min=-100,
    y_max=5000) annotation (Placement(transformation(extent={{-110,-20},{-90,0}})));
  Modelica.Blocks.Noise.UniformNoise mFlowScenario(
    samplePeriod=60,
    y_min=0.001,
    y_max=15) annotation (Placement(transformation(extent={{100,-30},{80,-10}})));
  Processes.ThermalConvectionPipe thermalConvectionPipe(
    redeclare package Medium = Medium,
    r=0.2,
    l=100)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,-10})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation (Placement(transformation(extent={{-88,-14},{-80,-6}})));
  FluidPortMSLtoOutletTFS_ass fluidPortMSLtoOutletTFS_ass(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-32,-44},{-40,-36}})));
  InletTFStoFluidPortMSL_ass inletTFStoFluidPortMSL_ass(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-4,-44},{-12,-36}})));
  Modelica.Fluid.Vessels.OpenTank tank(
    height=1000,
    crossArea=0.01,
    p_ambient=100000,
    level_start(displayUnit="cm") = 0.1,
    redeclare package Medium = Medium,
    use_portsData=false,
    nPorts=2) annotation (Placement(transformation(extent={{-32,-40},{-12,-20}})));
  FlowControl.Switch switch annotation (Placement(transformation(extent={{-6,26},{6,14}})));
  Topology.JunctionT2 junctionT2_1 annotation (Placement(transformation(extent={{0,-46},{10,-34}})));
  Sensors.SingleSensorSelect singleSensorSelect(quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_C, outputValue=true)
    annotation (Placement(transformation(extent={{-56,20},{-36,40}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0) annotation (Placement(transformation(extent={{-24,36},{-16,44}})));
  Modelica.Blocks.Sources.RealExpression stepoint(y=80) annotation (Placement(transformation(extent={{-46,32},{-34,48}})));
protected
  parameter Medium.ThermodynamicState state_0_CS = Medium.setState_phX(Medium.p_default, Medium.h_default, Medium.X_default[1:Medium.nXi]);
  parameter Modelica.Units.SI.Density rho_CS = Medium.density(state_0_CS);
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_CS = Medium.specificHeatCapacityCp(state_0_CS);
  parameter Medium.ThermodynamicState state_0_cuve = Medium.setState_phX(Medium.p_default, Medium.h_default, Medium.X_default[1:Medium.nXi]);
  parameter Modelica.Units.SI.Density rho_cuve = Medium.density(state_0_cuve);
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_cuve = Medium.specificHeatCapacityCp(state_0_cuve);

equation

  connect(mCV.outlet, pHEXSimplified.inletB) annotation (Line(
      points={{30,-40},{26,-40},{26,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(pHEXSimplified.outletB, sink.inlet) annotation (Line(
      points={{26,0},{26,20},{56,20}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.inlet, source.outlet) annotation (Line(
      points={{50,-40},{60,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(flowGenerator_SF.outlet, thermalConvectionPipe.inlet) annotation (Line(
      points={{-64,-40},{-70,-40},{-70,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(heatScenario.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{-89,-10},{-88,-10}}, color={0,0,127}));
  connect(thermalConvectionPipe.heatPort, prescribedHeatFlow.port) annotation (Line(points={{-80,-10},{-80,-10}},
                                                                                                                color={191,0,0}));
  connect(flowGenerator_SF.inlet, fluidPortMSLtoOutletTFS_ass.outletTFS)
    annotation (Line(
      points={{-44,-40},{-38.8,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(inletTFStoFluidPortMSL_ass.outportMSL, tank.ports[1]) annotation (Line(points={{-10,-40},{-23,-40}}, color={0,127,255}));
  connect(tank.ports[2], fluidPortMSLtoOutletTFS_ass.inportMSL) annotation (Line(points={{-21,-40},{-33.8,-40}}, color={0,127,255}));
  connect(thermalConvectionPipe.outlet, switch.inlet) annotation (Line(
      points={{-70,0},{-70,20},{-6,20}},
      color={28,108,200},
      thickness=0.5));
  connect(switch.outletA, pHEXSimplified.inletA) annotation (Line(
      points={{6,20},{14,20},{14,0}},
      color={28,108,200},
      thickness=0.5));
  connect(inletTFStoFluidPortMSL_ass.inletTFS, junctionT2_1.outlet) annotation (Line(
      points={{-4.4,-40},{0,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(pHEXSimplified.outletA, junctionT2_1.inletB) annotation (Line(
      points={{14,-20},{14,-40},{10,-40}},
      color={28,108,200},
      thickness=0.5));
  connect(switch.outletB, junctionT2_1.inletA) annotation (Line(
      points={{0,14},{0,-30},{5,-30},{5,-34}},
      color={28,108,200},
      thickness=0.5));
  connect(mFlowScenario.y, mCV.setpoint_var) annotation (Line(points={{79,-20},{40,-20},{40,-32}}, color={0,0,127}));
  connect(thermalConvectionPipe.outlet, singleSensorSelect.inlet)
    annotation (Line(
      points={{-70,0},{-70,20},{-60,20},{-60,30},{-56,30}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.value_out, PID.u_m) annotation (Line(points={{-36,30},{-20,30},{-20,35.2}}, color={0,0,127}));
  connect(stepoint.y, PID.u_s) annotation (Line(points={{-33.4,40},{-24.8,40}}, color={0,0,127}));
  connect(PID.y, switch.u) annotation (Line(points={{-15.6,40},{0,40},{0,24.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{100,80}})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{100,80}})),
    experiment(
      StopTime=3600,
      Interval=60,
      __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(
      executeCall(ensureSimulated=true) = {createPlot(
        id=1,
        position={0,0,1614,678},
        y={"solarField_V2.inlet.state.T","solarField_V2.outlet.state.T","solarField_V2.heatTransferElement_Solar_V2.T","weather.T_amb","solarField_V2.heatTransferElement_Solar_V2.T_in_eff",
          "solarField_V2.inlet.m_flow"},
        range={0.0,195.0,-5.0,90.0},
        grid=true,
        colors={{28,108,200},{238,46,47},{217,67,180},{0,140,72},{102,44,145},{0,0,0}},
        timeUnit="h",
        displayUnits={"degC","degC","degC","degC","degC","kg/s"})} "Temp CS",
      executeCall(ensureSimulated=true) = {createPlot(
        id=1,
        position={0,0,1614,697},
        y={"weather.T_amb","solarField_V2.inlet.state.T","solarField_V2.outlet.state.T","solarField_V2.heatTransferElement_Solar_V2.T","solarField_V2.heatTransferElement_Solar_V2.T_in_eff",
          "solarField_V2.inlet.m_flow"},
        range={0.0,195.0,-10.0,90.0},
        grid=true,
        subPlot=101,
        colors={{0,140,72},{28,108,200},{238,46,47},{217,67,180},{102,44,145},{0,0,0}},
        timeUnit="h",
        displayUnits={"degC","degC","degC","degC","degC","kg/s"}),createPlot(
        id=1,
        position={0,0,1614,697},
        y={"stratifiedTank_Diffuser.T_lay[1]","stratifiedTank_Diffuser.T_lay[3]","stratifiedTank_Diffuser.T_lay[5]","stratifiedTank_Diffuser.T_lay[7]","stratifiedTank_Diffuser.T_lay[9]",
          "stratifiedTank_Diffuser.T_lay[11]","stratifiedTank_Diffuser.T_lay[13]","stratifiedTank_Diffuser.T_lay[15]","stratifiedTank_Diffuser.T_lay[17]","stratifiedTank_Diffuser.T_lay[19]",
          "stratifiedTank_Diffuser.T_lay[20]"},
        range={0.0,195.0,10.0,80.0},
        grid=true,
        subPlot=102,
        colors={{28,108,200},{238,46,47},{0,140,72},{217,67,180},{0,0,0},{162,29,33},{244,125,35},{102,44,145},{28,108,200},{238,46,47},{0,140,72}},
        patterns={LinePattern.Solid,LinePattern.Solid,LinePattern.Solid,LinePattern.Solid,LinePattern.Solid,LinePattern.Solid,LinePattern.Solid,
          LinePattern.Solid,LinePattern.Dash,LinePattern.Dash,LinePattern.Dash},
        timeUnit="h",
        displayUnits={"degC","degC","degC","degC","degC","degC","degC","degC","degC","degC","degC"})} "Températures CS et cuve",
      executeCall(ensureSimulated=true) = {createPlot(
        id=1,
        position={0,0,1614,678},
        y={"prod_switch.y","flowGenerator_SF.V_flow_out","flowGenerator_SF.V_flow_sp"},
        range={0.0,700000.0,-5.0,50.0},
        grid=true,
        subPlot=101,
        colors={{0,140,72},{28,108,200},{238,46,47}},
        timeUnit="s",
        displayUnits={"","m3/h","m3/h"}),createPlot(
        id=1,
        position={0,0,1614,678},
        y={"flowGenerator_SF.L"},
        range={0.0,700000.0,-1000000.0,11000000.0},
        grid=true,
        subPlot=202,
        colors={{28,108,200}},
        timeUnit="s",
        displayUnits={"1/m"}),createPlot(
        id=1,
        position={0,0,1614,678},
        y={"flowGenerator_SF.dr","flowGenerator_SF.dr_set"},
        range={0.0,700000.0,-4.0,4.0},
        grid=true,
        subPlot=201,
        colors={{28,108,200},{238,46,47}},
        timeUnit="s",
        displayUnits={"bar","bar"}),createPlot(
        id=1,
        position={0,0,1614,678},
        y={"flowGenerator_SF.p_in","flowGenerator_SF.p_out"},
        range={0.0,700000.0,0.5,4.0},
        grid=true,
        subPlot=102,
        colors={{28,108,200},{238,46,47}},
        timeUnit="s",
        displayUnits={"bar","bar"})} "Inertance analysis"));
end TargetTest_02_NOK;
