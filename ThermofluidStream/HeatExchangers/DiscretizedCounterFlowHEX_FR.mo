within ThermofluidStream.HeatExchangers;
model DiscretizedCounterFlowHEX_FR "Discretized Heat Exchanger for single- or two-phase working fluid with pressure drop"

  extends Internal.PartialDiscretizedHEX;

  parameter Real k1_A=1e2 "Linear flow resistance coefficient at side A"
    annotation (Dialog(group="Flow resistance coefficients"));
  parameter Real k2_A=1e2 "Quadratic flow resistance coefficient at side B"
    annotation (Dialog(group="Flow resistance coefficients"));
  parameter Real k1_B=1e2 "Linear flow resistance coefficient at side B"
    annotation (Dialog(group="Flow resistance coefficients"));
  parameter Real k2_B=1e2 "Quadratic flow resistance coefficient at side B"
    annotation (Dialog(group="Flow resistance coefficients"));

  Interfaces.Inlet inletB(
    redeclare package Medium = MediumB)
    annotation (Placement(
      transformation(extent={{-120,40},{-80,80}}),
      iconTransformation(extent={{-120,40},{-80,80}})));

  Interfaces.Outlet outletB(
    redeclare package Medium = MediumB)
    annotation (Placement(
      transformation(extent={{80,40},{120,80}}),
      iconTransformation(extent={{80,40},{120,80}})));

  Interfaces.Inlet inletA(
    redeclare package Medium = MediumA)
    annotation (Placement(
      transformation(extent={{120,-80},{80,-40}}),
      iconTransformation(extent={{120,-80},{80,-40}})));

  Interfaces.Outlet outletA(
    redeclare package Medium = MediumA)
    annotation (Placement(
      transformation(extent={{-80,-80},{-120,-40}}),
      iconTransformation(extent={{-80,-80},{-120,-40}})));

  Processes.FlowResistance flowResistanceB[nCells](
    redeclare package Medium = MediumB,
    each r=1,
    each l=1,
    each computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      each k=k1_B,
      each k2=k2_B)) annotation (Placement(transformation(extent={{40,50},{60,70}})));
  Processes.FlowResistance flowResistanceA[nCells](
    redeclare package Medium = MediumA,
    each r=1,
    each l=1,
    each computeL=false,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      each k=k1_A,
      each k2=k2_A)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-50,-60})));

initial equation
  if initializeMassFlow then
    inletA.m_flow = m_flow_0_A;
    inletB.m_flow = m_flow_0_B;
  end if;

equation
  inletA.state = inletA_state;
  inletA.m_flow = inletA_m_flow;
  inletA.r = inletA_r;

  inletB.state = inletB_state;
  inletB.m_flow = inletB_m_flow;
  inletB.r = inletB_r;

  outletA.state = outletA_state;
  outletA.m_flow = outletA_m_flow;
  outletA.r = outletA_r;

  outletB.state = outletB_state;
  outletB.m_flow = outletB_m_flow;
  outletB.r = outletB_r;

  //Connecting equations (to interconnect pipes)
  //Fluid Side B
  connect(inletB, thermalElementB[1].inlet) annotation (Line(points={{-100,60},{-56,60},{-56,60},{-10,60}},
                                                                                          color={28,108,200}));
  connect(flowResistanceB.inlet, thermalElementB.outlet) annotation (Line(
      points={{40,60},{10,60}},
      color={28,108,200},
      thickness=0.5));
  for i in 1:nCells - 1 loop
    connect(flowResistanceB[i].outlet, thermalElementB[i + 1].inlet);
  end for;
  connect(flowResistanceB[nCells].outlet, outletB) annotation (Line(
      points={{60,60},{100,60}},
      color={28,108,200},
      thickness=0.5));

  //Fluid Side A
  connect(inletA, thermalElementA[1].inlet) annotation (Line(points={{100,-60},{56,-60},{56,-60},{10,-60}},
                                                                                          color={28,108,200}));
  connect(flowResistanceA.inlet, thermalElementA.outlet) annotation (Line(
      points={{-40,-60},{-10,-60}},
      color={28,108,200},
      thickness=0.5));
  for i in 1:nCells - 1 loop
    connect(flowResistanceA[i].outlet, thermalElementA[i + 1].inlet);
  end for;
  connect(flowResistanceA[nCells].outlet, outletA) annotation (Line(
      points={{-60,-60},{-100,-60}},
      color={28,108,200},
      thickness=0.5));

  //Thermal connection
  connect(thermalElementB.heatPort, thermalConductor.port_b) annotation (Line(points={{4.44089e-16,50},{4.44089e-16,40},{0,40},{0,10}},   color={191,0,0}));
  for i in 1:nCells loop
    connect(thermalElementA[i].heatPort, thermalConductor[nCells + 1 - i].port_a) annotation (Line(points={{-6.66134e-16,-50},{-6.66134e-16,-10},{0,-10}},   color={191,0,0}));
  end for;

  annotation (Icon(graphics={
        Text(
          visible=displayInstanceName,
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
        Text(
          visible=d1A,
          extent={{-150,-90},{150,-120}},
          textColor={0,0,0},
          textString="A = %A"),
        Text(
          extent={{-120,40},{-80,0}},
          textColor={175,175,175},
          textString="B"),
        Text(
          extent={{80,0},{120,-40}},
          textColor={175,175,175},
          textString="A"),
        Rectangle(
          extent={{84,66},{-70,-86}},
          lineColor={215,215,215},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          radius=6),
        Rectangle(
          extent={{76,78},{-76,-78}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          radius=6),
        Line(
          points={{60,52},{-60,52}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{60,36},{-60,36}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{60,-44},{-60,-44}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{60,-60},{-60,-60}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{50,32},{60,36}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{50,40},{60,36}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-50,-48},{-60,-44}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-50,-40},{-60,-44}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{50,48},{60,52}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{50,56},{60,52}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-50,-64},{-60,-60}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-50,-56},{-60,-60}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{60,20},{-60,20}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{50,24},{60,20}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{50,16},{60,20}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A < summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{60,-28},{-60,-28}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-50,-24},{-60,-28}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Line(
          points={{-50,-32},{-60,-28}},
          color=DynamicSelect({215,215,215}, if summary.Tin_A > summary.Tin_B
               then {238,46,47} else {21,85,157}),
          thickness=0.5),
        Polygon(points={{-70,28},{62,28},{62,60},{-70,60},{-60,70},{70,70},{70,38},
              {62,28},{62,60},{70,70},{-60,70},{-70,60},{-70,28}}, lineColor={215,
              215,215}),
        Polygon(points={{-70,12},{62,12},{62,44},{70,54},{70,20},{62,12},{62,44},
              {62,44},{-70,44},{-70,12}}, lineColor={215,215,215}),
        Line(points={{-36,70},{-46,60},{-46,12}}, color={215,215,215}),
        Line(points={{-16,70},{-26,60},{-26,12}}, color={215,215,215}),
        Line(points={{4,70},{-6,60},{-6,12}}, color={215,215,215}),
        Line(points={{26,70},{16,60},{16,12}}, color={215,215,215}),
        Line(points={{48,70},{38,60},{38,12}}, color={215,215,215}),
        Polygon(points={{-70,-52},{62,-52},{62,-20},{-70,-20},{-60,-10},{70,-10},
              {70,-42},{62,-52},{62,-20},{70,-10},{-60,-10},{-70,-20},{-70,-52}},
            lineColor={215,215,215}),
        Polygon(points={{-70,-68},{62,-68},{62,-36},{70,-26},{70,-60},{62,-68},{
              62,-36},{62,-36},{-70,-36},{-70,-68}}, lineColor={215,215,215}),
        Line(points={{-36,-10},{-46,-20},{-46,-68}}, color={215,215,215}),
        Line(points={{-16,-10},{-26,-20},{-26,-68}}, color={215,215,215}),
        Line(points={{4,-10},{-6,-20},{-6,-68}}, color={215,215,215}),
        Line(points={{26,-10},{16,-20},{16,-68}}, color={215,215,215}),
        Line(points={{48,-10},{38,-20},{38,-68}}, color={215,215,215})}),
      Documentation(info="<html>
<p>The counter-flow discretized heat exchanger uses a number of conduction elements (which is set by the parameter nCells) as discrete control volumes to exchange heat between two fluid streams. This model differs from DiscretizedCounterFlowHEX by introducing flow-resistances after each control volume, but otherwise is the same, therefore consider the documentation of DiscretizedCounterFlowHEX. </p>
<p>The flowResistances are parametrized by the parameters in the group laminar-turbulent flowRes.</p>
</html>"));
end DiscretizedCounterFlowHEX_FR;
