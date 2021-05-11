within ThermofluidStream.FlowControl;
model Switch

  replaceable package Medium =
      ThermofluidStream.myMedia.Interfaces.PartialMedium
    annotation(choicesAllMatching=true);

  parameter ThermofluidStream.Utilities.Units.Inertance L = dropOfCommons.L "Inertance of the flow"
    annotation(Dialog(tab="Advanced"));
  parameter SI.MassFlowRate m_flow_ref = 0.1 "Reference mass flow";
  parameter SI.Pressure p_ref = 1e5 "Rreference pressurre";
  parameter Real relativeLeakiness(unit="1") = 1e-3 "Imperfection of valve";
  parameter Boolean invertInput = false "Invert input meaning";

  ThermofluidStream.Interfaces.Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={-100,0})));
  ThermofluidStream.Interfaces.Outlet outletA(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={100,0})));
  ThermofluidStream.Interfaces.Outlet outletB(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={0,100})));

  Modelica.Blocks.Interfaces.RealInput u(min=0, max=1, unit="1") "Flow split"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={0,-80}),
      iconTransformation(extent={{-20,-20},{20,20}},rotation=90,origin={0,-80})));

  ThermofluidStream.FlowControl.TanValve tanValve(redeclare package Medium = Medium,
                                                  final invertInput=invertInput,
                                                  final m_flow_ref=m_flow_ref,
                                                  final p_ref=p_ref,
                                                  final relativeLeakiness=relativeLeakiness)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,40})));
  ThermofluidStream.FlowControl.TanValve tanValve1(redeclare package Medium = Medium,
                                                  final invertInput=not invertInput,
                                                  final m_flow_ref=m_flow_ref,
                                                  final p_ref=p_ref,
                                                  final relativeLeakiness=relativeLeakiness)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={40,0})));
  ThermofluidStream.Topology.SplitterT2 splitterT2_1(redeclare package Medium = Medium, L=0)
                                                     annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  // for dynamic select of graphics only
  Real u2 = (if not invertInput then u else 1-u);

protected
  outer ThermofluidStream.DropOfCommons dropOfCommons;
  constant Real delta(unit="1") = 0.1;

equation

  connect(inlet, splitterT2_1.inlet) annotation (Line(
      points={{-100,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT2_1.outletA, tanValve.inlet) annotation (Line(
      points={{0,10},{0,30}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT2_1.outletB, tanValve1.inlet) annotation (Line(
      points={{10,0},{30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(tanValve1.outlet, outletA) annotation (Line(
      points={{50,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(tanValve.outlet, outletB) annotation (Line(
      points={{6.66134e-16,50},{0,50},{0,100}},
      color={28,108,200},
      thickness=0.5));
  connect(tanValve1.u, u) annotation (Line(points={{40,-8},{40,-20},{0,-20},{0,-80}}, color={0,0,127}));
  connect(tanValve.u, u) annotation (Line(points={{-8,40},{-20,40},{-20,-20},{0,-20},{0,-80}}, color={0,0,127}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-56,54},{64,-66}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points=DynamicSelect({{-100,0},{100,0}}, if u2>=1-delta then {{-100,0},{0,0}} else {{-100,0},{100,0}}),
          color={28,108,200},
          thickness=0.5),
        Line(
          points=DynamicSelect({{0,0},{0,100}}, if u2<=delta then {{0,0},{0,0}} else {{0,0},{0,100}}),
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-6,6},{6,-6}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5)}),                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Switch;
