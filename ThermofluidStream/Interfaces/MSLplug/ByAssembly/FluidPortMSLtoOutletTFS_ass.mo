within ThermofluidStream.Interfaces.MSLplug.ByAssembly;
model FluidPortMSLtoOutletTFS_ass

  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
    "Medium model"    annotation (choicesAllMatching=true, Documentation(info =              "<html>
    <p><span style=\"font-family: Courier New;\">Medium package used in both sides of the connector.</span></p>
    </html>"));
  final parameter Boolean BoolMonoSubstance = Medium.nS<2;

  //Real Xi[Medium.nXi];

  Interfaces.Outlet outletTFS(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{8,-20},{48,20}}),  iconTransformation(extent={{8,-20},{48,20}})));
  Modelica.Fluid.Interfaces.FluidPort_b inportMSL(redeclare package Medium = Medium) "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-10,-20},{-50,20}}), iconTransformation(extent={{-12,-10},{-32,10}})));

  ThermofluidStream.Boundaries.Source source(redeclare package Medium = Medium, temperatureFromInput=true,
    xiFromInput=not (BoolMonoSubstance))
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Fluid.Sources.Boundary_pT boundary(
    redeclare package Medium = Medium,
    use_p_in=true,
    use_X_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{8,-28},{-8,-12}})));
  ThermofluidStream.Sensors.SingleSensorSelect singleSensorSelect(
    redeclare package Medium = Medium,
    quantity=ThermofluidStream.Sensors.Internal.Types.Quantities.p_Pa,
    outputValue=true,
    filter_output=false)
                      annotation (Placement(transformation(extent={{36,-26},{20,-14}})));
  Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-42,26},{-32,34}})));
  FlowControl.MCV                                            flowGenerator_SF(
    redeclare package Medium = Medium,
    setpointFromInput=true,
    TC=4) annotation (Placement(transformation(extent={{6,38},{22,22}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-20,-24},{-12,-16}})));
  Modelica.Blocks.Math.Gain forUnitCompatibility(k=1) annotation (Placement(transformation(
        extent={{-2,-2},{2,2}},
        rotation=90,
        origin={-16,-10})));
  Modelica.Blocks.Sources.RealExpression massFraction[Medium.nXi](y=inStream(inportMSL.Xi_outflow)) if not (BoolMonoSubstance)
                                                                        annotation (Placement(transformation(extent={{-32,20},{-20,28}})));
equation
  //Xi=inStream(inportMSL.Xi_outflow);


  connect(singleSensorSelect.value_out, boundary.p_in)
    annotation (Line(points={{20,-20},{14,-20},{14,-13.6},{9.6,-13.6}}, color={0,0,127}));
  connect(outletTFS, singleSensorSelect.inlet) annotation (Line(
      points={{28,0},{40,0},{40,-20},{36,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(inportMSL, inportMSL) annotation (Line(points={{-30,0},{-30,0}}, color={0,127,255}));
  connect(temperature.T, source.T0_var) annotation (Line(points={{-33.5,30},{-12,30}},
                                                                                     color={0,0,127}));
  connect(boundary.ports[1], massFlowRate.port_b) annotation (Line(points={{-8,-20},{-12,-20}}, color={0,127,255}));
  connect(massFlowRate.m_flow, forUnitCompatibility.u) annotation (Line(points={{-16,-15.6},{-16,-12.4}}, color={0,0,127}));
  connect(inportMSL, massFlowRate.port_a) annotation (Line(points={{-30,0},{-30,-20},{-20,-20}}, color={0,127,255}));
  connect(massFraction.y, source.xi_var) annotation (Line(points={{-19.4,24},{-12,24}}, color={0,0,127}));
  connect(inportMSL, temperature.port) annotation (Line(points={{-30,0},{-40,0},{-40,26},{-37,26}}, color={0,127,255}));
  connect(forUnitCompatibility.y, flowGenerator_SF.setpoint_var) annotation (Line(points={{-16,-7.8},{-16,2},{14,2},{14,23.6}}, color={0,0,127}));
  connect(source.outlet, flowGenerator_SF.inlet) annotation (Line(
      points={{0,30},{6,30}},
      color={28,108,200},
      thickness=0.5));
  connect(flowGenerator_SF.outlet, outletTFS) annotation (Line(
      points={{22,30},{28,30},{28,0}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-40,-40},{40,40}}), graphics={
        Rectangle(
          extent={{-20,20},{20,-20}},
          lineColor={28,108,200},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Line(
          points={{-12,0},{20,0}},
          color={28,108,200},
          thickness=0.5),                                                                            Polygon(
          points={{26,-20},{26,20},{56,0},{26,-20}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,20},{-2,-20}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-36,-20},{36,-40}},
          textColor={28,108,200},
          textString="TFS => MSL")}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-40,-40},
            {40,40}})));
end FluidPortMSLtoOutletTFS_ass;
