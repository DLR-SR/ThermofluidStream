within ThermofluidStream.Interfaces.MSLplug.ByAssembly.Tests;
model TargetTest_01_NOK
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
        origin={20,10})));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{56,30},{76,50}})));

  ThermofluidStream.FlowControl.MCV mCV(
    redeclare package Medium = Medium, massFlow_set_par=1)
          annotation (Placement(transformation(extent={{50,-10},{30,-30}})));
  ThermofluidStream.FlowControl.MCV flowGenerator_SF(
    redeclare package Medium = Medium, massFlow_set_par=10)
          annotation (Placement(transformation(extent={{-30,-10},{-50,-30}})));

  ThermofluidStream.Boundaries.Source source(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{80,-30},{60,-10}})));
  inner DropOfCommons dropOfCommons(L=1000)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  inner Modelica.Fluid.System system(g=0.0000001)
                                     annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Noise.UniformNoise heatScenario(
    samplePeriod=60,
    y_min=-100,
    y_max=5000) annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Processes.ThermalConvectionPipe thermalConvectionPipe(
    redeclare package Medium = Medium,
    r=0.2,
    l=100)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,10})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation (Placement(transformation(extent={{-80,6},{-72,14}})));
  FluidPortMSLtoOutletTFS_ass fluidPortMSLtoOutletTFS_ass(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-18,-24},{-26,-16}})));
  InletTFStoFluidPortMSL_ass inletTFStoFluidPortMSL_ass(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{10,-24},{2,-16}})));
  Modelica.Fluid.Vessels.OpenTank tank(
    height=1000,
    crossArea=0.01,
    p_ambient=100000,
    level_start(displayUnit="cm") = 0.1,
    redeclare package Medium = Medium,
    use_portsData=false,
    nPorts=2) annotation (Placement(transformation(extent={{-18,-20},{2,0}})));
protected
  parameter Medium.ThermodynamicState state_0_CS = Medium.setState_phX(Medium.p_default, Medium.h_default, Medium.X_default[1:Medium.nXi]);
  parameter Modelica.Units.SI.Density rho_CS = Medium.density(state_0_CS);
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_CS = Medium.specificHeatCapacityCp(state_0_CS);
  parameter Medium.ThermodynamicState state_0_cuve = Medium.setState_phX(Medium.p_default, Medium.h_default, Medium.X_default[1:Medium.nXi]);
  parameter Modelica.Units.SI.Density rho_cuve = Medium.density(state_0_cuve);
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_cuve = Medium.specificHeatCapacityCp(state_0_cuve);

equation

  connect(mCV.outlet, pHEXSimplified.inletB) annotation (Line(
      points={{30,-20},{26,-20},{26,-4.44089e-15}},
      color={28,108,200},
      thickness=0.5));
  connect(pHEXSimplified.outletB, sink.inlet) annotation (Line(
      points={{26,20},{26,40},{56,40}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.inlet, source.outlet) annotation (Line(
      points={{50,-20},{60,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(flowGenerator_SF.outlet, thermalConvectionPipe.inlet) annotation (Line(
      points={{-50,-20},{-60,-20},{-60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConvectionPipe.outlet, pHEXSimplified.inletA)
    annotation (Line(
      points={{-60,20},{-60,40},{14,40},{14,20}},
      color={28,108,200},
      thickness=0.5));
  connect(heatScenario.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{-79,10},{-80,10}}, color={0,0,127}));
  connect(thermalConvectionPipe.heatPort, prescribedHeatFlow.port) annotation (Line(points={{-70,10},{-72,10}}, color={191,0,0}));
  connect(flowGenerator_SF.inlet, fluidPortMSLtoOutletTFS_ass.outletTFS)
    annotation (Line(
      points={{-30,-20},{-24.8,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(pHEXSimplified.outletA, inletTFStoFluidPortMSL_ass.inletTFS)
    annotation (Line(
      points={{14,-2.66454e-15},{14,-20},{9.6,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(inletTFStoFluidPortMSL_ass.outportMSL, tank.ports[1]) annotation (Line(points={{4,-20},{-9,-20}}, color={0,127,255}));
  connect(tank.ports[2], fluidPortMSLtoOutletTFS_ass.inportMSL) annotation (Line(points={{-7,-20},{-19.8,-20}}, color={0,127,255}));
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
end TargetTest_01_NOK;
