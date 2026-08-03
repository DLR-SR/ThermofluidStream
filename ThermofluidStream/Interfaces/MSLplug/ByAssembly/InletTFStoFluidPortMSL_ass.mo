within ThermofluidStream.Interfaces.MSLplug.ByAssembly;
model InletTFStoFluidPortMSL_ass

  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium model"    annotation (choicesAllMatching=true, Documentation(info =              "<html>
    <p><span style=\"font-family: Courier New;\">Medium package used in both sides of the connector.</span></p>
    </html>"));
  final parameter Boolean BoolMonoSubstance = Medium.nS<2;


  Interfaces.Inlet inletTFS(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-56,-20},{-16,20}}),
      iconTransformation(extent={{-56,-20},{-16,20}})));
  Modelica.Fluid.Interfaces.FluidPort_b outportMSL(redeclare package Medium = Medium) "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{60,-20},{20,20}}), iconTransformation(extent={{30,-10},{10,10}})));

  ThermofluidStream.Boundaries.Sink sink(redeclare package Medium = Medium, pressureFromInput=true)
    annotation (Placement(transformation(extent={{6,20},{26,40}})));
  Modelica.Fluid.Sensors.Pressure pressure(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{36,24},
            {24,36}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_T_in=true,
    use_X_in=not (BoolMonoSubstance),
    use_C_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{2,-30},{22,-10}})));

  ThermofluidStream.Sensors.SingleFlowSensor singleFlowSensor(
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.MassFlowQuantities.m_flow_kgps,
    outputValue=true) annotation (Placement(transformation(extent={{-20,28},{-6,38}})));
  ThermofluidStream.Sensors.SingleSensorSelect singleSensorSelect(
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.T_K,
    outputValue=true) annotation (Placement(transformation(extent={{-20,-22},{-8,-10}})));
  Modelica.Blocks.Sources.RealExpression realExpression[Medium.nXi](y=Medium.massFraction(inletTFS.state)) if not (BoolMonoSubstance)
                                                                          annotation (Placement(transformation(extent={{-40,-38},{-20,-18}})));
equation
  //Xi=Medium.massFraction(inletTFS.state);

  connect(outportMSL, pressure.port) annotation (Line(points={{40,0},{30,0},{30,24}}, color={0,127,255}));
  connect(pressure.p, sink.p0_var) annotation (Line(points={{23.4,30},{18,30}},          color={0,0,127}));
  connect(outportMSL, boundary.ports[1]) annotation (Line(points={{40,0},{32,0},{32,-20},{22,-20}}, color={0,127,255}));
  connect(singleFlowSensor.value_out, boundary.m_flow_in)
    annotation (Line(points={{-6,33},{-6,-12},{2,-12}},       color={0,0,127}));
  connect(inletTFS, singleFlowSensor.inlet)
    annotation (Line(
      points={{-36,0},{-20,0},{-20,30}},
      color={28,108,200},
      thickness=0.5));
  connect(inletTFS, singleSensorSelect.inlet)
    annotation (Line(
      points={{-36,0},{-20,0},{-20,-16}},
      color={28,108,200},
      thickness=0.5));
  connect(singleSensorSelect.value_out, boundary.T_in) annotation (Line(points={{-8,-16},{0,-16}}, color={0,0,127}));
  connect(singleFlowSensor.outlet, sink.inlet) annotation (Line(
      points={{-6,30},{6,30}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression.y, boundary.X_in) annotation (Line(points={{-19,-28},{-8,-28},{-8,-24},{0,-24}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-40,-40},{40,40}}), graphics={Polygon(
          points={{-30,-20},{-30,20},{0,0},{-30,-20}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{0,20},{40,-20}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-36,-20},{36,-40}},
          textColor={28,108,200},
          textString="TFS => MSL")}),                           Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-40,-40},
            {40,40}})));
end InletTFStoFluidPortMSL_ass;
