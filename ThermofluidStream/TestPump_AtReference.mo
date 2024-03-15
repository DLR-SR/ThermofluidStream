within ThermofluidStream;
model TestPump_AtReference
  extends Modelica.Icons.Example;
    replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium model"
     annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Source. Make sure it is the same as the one
the inlet the source is connected to.
</p>
</html>"));

  //replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater;
  parameter SI.Pressure p0=100000
                                 "Inlet pressure";
  parameter SI.Density rho0(displayUnit="kg/m3")=998.2
                                  "Water Density at 20°C";

  parameter SI.Height TDH_D = 3.6610 "Design pressure head"
    annotation(Dialog(group="Scaling"));
  parameter SI.VolumeFlowRate V_flow_D = 3.06e-3 "Design volume flow"
    annotation(Dialog(group="Scaling"));
  parameter SI.AngularVelocity omega_D = 314.2 "Design angular velocity"
    annotation(Dialog(group="Scaling"));
  final parameter SI.PressureDifference dp_D = TDH_D*Modelica.Constants.g_n*rho0 "Design pressure difference";

  ThermofluidStream.Processes.Pump pump(
    redeclare package Medium = Medium,
    omega_from_input=true,
    enableOutput=false,
    redeclare function dp_tau_pump = ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal (
        TDH_D=TDH_D,
        V_flow_D=V_flow_D,
        omega_D=omega_D)) annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    T0_par=293.15,
    p0_par=p0)     annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium, p0_par(displayUnit="Pa") = p0 + rho0*TDH_D*Modelica.Constants.g_n)                 annotation (Placement(transformation(extent={{40,20},{60,40}})));
  Modelica.Blocks.Sources.RealExpression omega_D_input(y=314.2) annotation (Placement(transformation(extent={{-56,0},{-36,20}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons                             annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  ThermofluidStream.Sensors.SingleFlowSensor singleFlowSensor(redeclare package Medium = Medium, quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_m3ps)
                                                              annotation (Placement(transformation(extent={{0,26},{20,46}})));
  ThermofluidStream.Sensors.SingleSensorSelect sensorDensity(redeclare package Medium = Medium, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3) annotation (Placement(transformation(extent={{0,42},{20,62}})));
  ThermofluidStream.Processes.Pump pump1(
    redeclare package Medium = Medium,
    omega_from_input=true,
    enableOutput=false,
    redeclare function dp_tau_pump = ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal (
        TDH_D=TDH_D,
        V_flow_D=V_flow_D,
        omega_D=omega_D)) annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    T0_par=293.15,
    p0_par=p0)     annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  ThermofluidStream.Boundaries.Sink sink1(redeclare package Medium = Medium, p0_par(displayUnit="Pa") = p0)                                                    annotation (Placement(transformation(extent={{80,-60},{100,-40}})));
  Modelica.Blocks.Sources.RealExpression omega_D_input2(y=314.2) annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  ThermofluidStream.Sensors.SingleFlowSensor singleFlowSensor1(redeclare package Medium = Medium, quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_m3ps)
                                                              annotation (Placement(transformation(extent={{0,-54},{20,-34}})));
  ThermofluidStream.Sensors.SingleSensorSelect sensorDensity1(redeclare package Medium = Medium, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3)
                                                                                                                                                                        annotation (Placement(transformation(extent={{0,-38},{20,-18}})));
  ThermofluidStream.FlowControl.MCV mCV(
    redeclare package Medium = Medium,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.volume_flow,
    setpointFromInput=true) annotation (Placement(transformation(extent={{40,-40},{60,-60}})));
  Modelica.Blocks.Sources.RealExpression V_flow_input(y=V_flow_D) annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  PumpTFSExplicit pumpTFSExplicit(
    redeclare package Medium = Medium,
    omega_from_input=true,
    enableOutput=false) annotation (Placement(transformation(extent={{184,28},{204,48}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    T0_par=293.15,
    p0_par=p0)     annotation (Placement(transformation(extent={{144,28},{164,48}})));
  ThermofluidStream.Boundaries.Sink sink2(redeclare package Medium = Medium, p0_par(displayUnit="Pa") = p0 + rho0*TDH_D*Modelica.Constants.g_n)                annotation (Placement(transformation(extent={{264,28},{284,48}})));
  Modelica.Blocks.Sources.RealExpression omega_D_input1(y=314.2)
                                                                annotation (Placement(transformation(extent={{168,8},{188,28}})));
  ThermofluidStream.Sensors.SingleFlowSensor singleFlowSensor2(redeclare package Medium = Medium, quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_m3ps)
                                                              annotation (Placement(transformation(extent={{224,34},{244,54}})));
  ThermofluidStream.Sensors.SingleSensorSelect sensorDensity2(redeclare package Medium = Medium, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3)
                                                                                                                                                                        annotation (Placement(transformation(extent={{224,50},{244,70}})));
  PumpTFSExplicit pumpTFSExplicit1(
    redeclare package Medium = Medium,
    omega_from_input=true,
    enableOutput=false) annotation (Placement(transformation(extent={{184,-52},{204,-32}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    T0_par=293.15,
    p0_par=p0)     annotation (Placement(transformation(extent={{144,-52},{164,-32}})));
  ThermofluidStream.Boundaries.Sink sink3(redeclare package Medium = Medium, p0_par(displayUnit="Pa") = p0)                                                    annotation (Placement(transformation(extent={{304,-52},{324,-32}})));
  Modelica.Blocks.Sources.RealExpression omega_D_input3(y=314.2) annotation (Placement(transformation(extent={{164,-72},{184,-52}})));
  ThermofluidStream.Sensors.SingleFlowSensor singleFlowSensor3(redeclare package Medium = Medium, quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.V_flow_m3ps)
                                                              annotation (Placement(transformation(extent={{224,-46},{244,-26}})));
  ThermofluidStream.Sensors.SingleSensorSelect sensorDensity3(redeclare package Medium = Medium, quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.rho_kgpm3)
                                                                                                                                                                        annotation (Placement(transformation(extent={{224,-30},{244,-10}})));
  ThermofluidStream.FlowControl.MCV mCV1(
    redeclare package Medium = Medium,
    mode=ThermofluidStream.FlowControl.Internal.Types.MassflowControlValveMode.volume_flow,
    setpointFromInput=true) annotation (Placement(transformation(extent={{264,-32},{284,-52}})));
  Modelica.Blocks.Sources.RealExpression V_flow_input1(y=V_flow_D)
                                                                  annotation (Placement(transformation(extent={{244,-72},{264,-52}})));
equation

  connect(source.outlet, pump.inlet) annotation (Line(
      points={{-60,30},{-40,30}},
      color={28,108,200},
      thickness=0.5));
  connect(omega_D_input.y, pump.omega_input) annotation (Line(points={{-35,10},{-30,10},{-30,20}}, color={0,0,127}));
  connect(pump.outlet, singleFlowSensor.inlet) annotation (Line(
      points={{-20,30},{0,30}},
      color={28,108,200},
      thickness=0.5));
  connect(sink.inlet, singleFlowSensor.outlet) annotation (Line(
      points={{40,30},{20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorDensity.inlet, pump.outlet) annotation (Line(
      points={{0,52},{-10,52},{-10,30},{-20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(omega_D_input2.y, pump1.omega_input) annotation (Line(points={{-39,-70},{-30,-70},{-30,-60}}, color={0,0,127}));
  connect(pump1.outlet, singleFlowSensor1.inlet) annotation (Line(
      points={{-20,-50},{0,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorDensity1.inlet, pump1.outlet) annotation (Line(
      points={{0,-28},{-10,-28},{-10,-50},{-20,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(pump1.inlet, source1.outlet) annotation (Line(
      points={{-40,-50},{-60,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor1.outlet, mCV.inlet) annotation (Line(
      points={{20,-50},{40,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.outlet, sink1.inlet) annotation (Line(
      points={{60,-50},{80,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV.setpoint_var, V_flow_input.y) annotation (Line(points={{50,-58},{50,-70},{41,-70}}, color={0,0,127}));
  connect(source2.outlet, pumpTFSExplicit.inlet) annotation (Line(
      points={{164,38},{184,38}},
      color={28,108,200},
      thickness=0.5));
  connect(omega_D_input1.y, pumpTFSExplicit.omega_input) annotation (Line(points={{189,18},{194,18},{194,28}}, color={0,0,127}));
  connect(pumpTFSExplicit.outlet, singleFlowSensor2.inlet) annotation (Line(
      points={{204,38},{224,38}},
      color={28,108,200},
      thickness=0.5));
  connect(sink2.inlet, singleFlowSensor2.outlet) annotation (Line(
      points={{264,38},{244,38}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorDensity2.inlet, pumpTFSExplicit.outlet) annotation (Line(
      points={{224,60},{214,60},{214,38},{204,38}},
      color={28,108,200},
      thickness=0.5));
  connect(omega_D_input3.y, pumpTFSExplicit1.omega_input) annotation (Line(points={{185,-62},{194,-62},{194,-52}}, color={0,0,127}));
  connect(pumpTFSExplicit1.outlet, singleFlowSensor3.inlet) annotation (Line(
      points={{204,-42},{224,-42}},
      color={28,108,200},
      thickness=0.5));
  connect(sensorDensity3.inlet, pumpTFSExplicit1.outlet) annotation (Line(
      points={{224,-20},{214,-20},{214,-42},{204,-42}},
      color={28,108,200},
      thickness=0.5));
  connect(pumpTFSExplicit1.inlet, source3.outlet) annotation (Line(
      points={{184,-42},{164,-42}},
      color={28,108,200},
      thickness=0.5));
  connect(singleFlowSensor3.outlet, mCV1.inlet) annotation (Line(
      points={{244,-42},{264,-42}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV1.outlet, sink3.inlet) annotation (Line(
      points={{284,-42},{304,-42}},
      color={28,108,200},
      thickness=0.5));
  connect(mCV1.setpoint_var, V_flow_input1.y) annotation (Line(points={{274,-50},{274,-62},{265,-62}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Text(
          extent={{-220,40},{-100,20}},
          textColor={28,108,200},
          textString="Check Vflow for given dp"), Text(
          extent={{-220,-40},{-100,-60}},
          textColor={28,108,200},
          textString="Check dp for given V_flow"),                                Text(
          extent={{-162,144},{96,112}},
          textColor={28,108,200},
          textString="There is still a \"recognizable\" difference, 
even if the density difference is only 1000 to 998...."),                         Text(
          extent={{90,100},{348,68}},
          textColor={28,108,200},
          textString="f_Q, f_H and f_eta do not tend to 1 for using the reference fluid. 
Therefoe the scaling approach should not be used with the reference fluid, e.g. with water! 
(only with oil or whatever)")}),                                         Icon(coordinateSystem(extent={{-100,-80},{100,100}})));
end TestPump_AtReference;
