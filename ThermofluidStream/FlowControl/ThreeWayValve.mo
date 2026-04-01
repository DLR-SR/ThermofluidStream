within ThermofluidStream.FlowControl;
model ThreeWayValve

  extends ThermofluidStream.Utilities.DropOfCommonsPlus;

  import FlowCoeffType = ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypesBasic;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation(choicesAllMatching=true);


  replaceable function valveCharacteristics =
      Internal.ControlValve.linearCharacteristics
    constrainedby Internal.ControlValve.partialValveCharacteristics "Select valve characteristics"
      annotation(choicesAllMatching = true, Dialog(group = "Valve parameters"),
    Documentation(info="<html>
<p>Characteristic curve of the valve.</p>
</html>"));
  parameter FlowCoeffType flowCoefficient = FlowCoeffType.Kvs "Select type of flow coefficient" annotation(Dialog(group = "Valve parameters"));
  //Reference Values
  parameter Real Kvs(unit = "m3/h") = 0  "Kvs-value (metric) from data sheet (valve fully open)"
    annotation(Dialog(group = "Valve parameters",enable = (flowCoefficient ==FlowCoeffType.Kvs)));
  parameter Real Cvs_US =  0 "Cvs-value (US [gal/min]) from data sheet (valve fully open)"
    annotation(Dialog(group = "Valve parameters",enable = (flowCoefficient ==FlowCoeffType.Cvs_US)));
  parameter Real Cvs_UK =  0 "Cvs-value (UK [gal/min]) from data sheet (valve fully open)"
    annotation(Dialog(group = "Valve parameters",enable = (flowCoefficient ==FlowCoeffType.Cvs_UK)));
  parameter SI.MassFlowRate m_flow_ref_set =  0.1 "Reference mass flow rate"
    annotation(Dialog(group = "Valve parameters",enable = (flowCoefficient ==FlowCoeffType.m_flow_set)));
  parameter Real k_min(unit="1", min = 1e-5, max = 1) = 0.03 "Remaining flow at actuation signal u = 0";

  parameter SI.Pressure p_ref = 1e5 "Reference pressure";
  parameter Boolean invertInput = false "=true, if input single is inverted" annotation (Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean initializeOneMassflowSplit = false "= true, if mass flow rate ratio is initialized"
    annotation(Dialog(tab="Initialization"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter ThermofluidStream.Utilities.Units.Inertance L = dropOfCommons.L "Inertance"
    annotation(Dialog(tab="Advanced"));

  ThermofluidStream.Interfaces.Inlet inlet(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  ThermofluidStream.Interfaces.Outlet outletA(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));
  ThermofluidStream.Interfaces.Outlet outletB(redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={0,100})));

  Modelica.Blocks.Interfaces.RealInput u(min=0, max=1, unit="1") "Flow split"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation=90,origin={0,-120})));

  BasicControlValve basicControlValve(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    final invertInput=invertInput,
    redeclare function valveCharacteristics = valveCharacteristics,
    flowCoefficient=flowCoefficient,
    Kvs=Kvs,
    Cvs_US=Cvs_US,
    Cvs_UK=Cvs_UK,
    m_flow_ref_set=m_flow_ref_set,
    k_min=k_min)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
      origin={0,40})));

  BasicControlValve basicControlValve1(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    final invertInput=not
                         (invertInput),
    redeclare function valveCharacteristics = valveCharacteristics,
    flowCoefficient=flowCoefficient,
    Kvs=Kvs,
    Cvs_US=Cvs_US,
    Cvs_UK=Cvs_UK,
    m_flow_ref_set=m_flow_ref_set,
    k_min=k_min)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={40,0})));

  ThermofluidStream.Topology.SplitterT2 splitterT2_1(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    L=0)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));


  // for dynamic select of graphics only
  Real u2 = (if not invertInput then u else 1-u);
protected
  constant Real delta(unit="1") = 0.1;

initial equation
  if initializeOneMassflowSplit then
    if not invertInput then
      outletA.m_flow = - inlet.m_flow * u;
    else
      outletB.m_flow = - inlet.m_flow * u;
    end if;
  end if;

equation

  connect(inlet, splitterT2_1.inlet) annotation (Line(
      points={{-100,0},{-10,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitterT2_1.outletA, basicControlValve.inlet) annotation (Line(
      points={{0,10},{0,30}},
      color={28,108,200},
      thickness=0.5));
  connect(basicControlValve.outlet, outletB) annotation (Line(
      points={{6.66134e-16,50},{0,50},{0,100}},
      color={28,108,200},
      thickness=0.5));

  connect(u, basicControlValve.u_in) annotation (Line(points={{0,-120},{0,-20},{-20,-20},{-20,40},{-8,40}}, color={0,0,127}));
  connect(splitterT2_1.outletB, basicControlValve1.inlet) annotation (Line(
      points={{10,0},{30,0}},
      color={28,108,200},
      thickness=0.5));
  connect(basicControlValve1.outlet, outletA) annotation (Line(
      points={{50,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(u, basicControlValve1.u_in) annotation (Line(points={{0,-120},{0,-20},{40,-20},{40,-8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Text(visible= displayInstanceName,
          extent={{-150,-60},{150,-100}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
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
          lineThickness=0.5)}), Diagram(
        coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>This model should only be used as a switch, i.e. it should either direct the flow completely in one or the other direction. This requires the input being either zero or one. All values in between will result in less mass flow and/ or a higher pressure drop, depending on the system up- or downstream of the switch, which in most cases is an undesired behaviour. </p>
<p>If e.g. a bypass shall be controlled, use the newly created ThreeWayValve which allows for splitting the flow continuously between zero and one.</p>
<p><br>To do: ask why input has to be between 0 and (1-l)</p>
</html>"));
end ThreeWayValve;
