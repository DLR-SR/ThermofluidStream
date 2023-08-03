within ThermofluidStreamTest.Undirected.Boundaries;
model ConditionalConnectorsSetEnthalpy
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium annotation(choicesAllMatching = true);

  ThermofluidStream.Undirected.Boundaries.BoundaryRear boundaryRear1(
    redeclare package Medium = Medium,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=true,
    enthalpyFromInput=true,
    xiFromInput=true) annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  ThermofluidStream.Undirected.Boundaries.BoundaryRear boundaryRear2(
    redeclare package Medium = Medium,
    setEnthalpy=true,
    pressureFromInput=true,
    temperatureFromInput=true,
    enthalpyFromInput=true,
    xiFromInput=true) annotation (Placement(transformation(extent={{40,60},{60,80}})));
  ThermofluidStream.Undirected.Boundaries.BoundaryRear boundaryRear3(
    redeclare package Medium = Medium,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true) annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  ThermofluidStream.Undirected.Boundaries.BoundaryRear boundaryRear4(
    redeclare package Medium = Medium,
    setEnthalpy=true,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true) annotation (Placement(transformation(extent={{40,20},{60,40}})));
  ThermofluidStream.Undirected.Boundaries.TerminalFore terminalFore1(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{10,80},{30,100}})));
  ThermofluidStream.Undirected.Boundaries.TerminalFore terminalFore2(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{70,60},{90,80}})));
  ThermofluidStream.Undirected.Boundaries.TerminalFore terminalFore3(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{10,40},{30,60}})));
  ThermofluidStream.Undirected.Boundaries.TerminalFore terminalFore4(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{70,20},{90,40}})));
  ThermofluidStream.Undirected.Boundaries.BoundaryFore boundaryFore1(
    redeclare package Medium = Medium,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=true,
    enthalpyFromInput=true,
    xiFromInput=true) annotation (Placement(transformation(extent={{0,-20},{-20,0}})));
  ThermofluidStream.Undirected.Boundaries.BoundaryFore boundaryFore2(
    redeclare package Medium = Medium,
    setEnthalpy=true,
    pressureFromInput=true,
    temperatureFromInput=true,
    enthalpyFromInput=true,
    xiFromInput=true) annotation (Placement(transformation(extent={{60,-38},{40,-18}})));
  ThermofluidStream.Undirected.Boundaries.BoundaryFore boundaryFore3(
    redeclare package Medium = Medium,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true) annotation (Placement(transformation(extent={{0,-58},{-20,-38}})));
  ThermofluidStream.Undirected.Boundaries.BoundaryFore boundaryFore4(
    redeclare package Medium = Medium,
    setEnthalpy=true,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true) annotation (Placement(transformation(extent={{60,-78},{40,-58}})));
  ThermofluidStream.Undirected.Boundaries.TerminalRear terminalRear1(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{30,-20},{10,0}})));
  ThermofluidStream.Undirected.Boundaries.TerminalRear terminalRear2(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{90,-38},{70,-18}})));
  ThermofluidStream.Undirected.Boundaries.TerminalRear terminalRear3(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{30,-58},{10,-38}})));
  ThermofluidStream.Undirected.Boundaries.TerminalRear terminalRear4(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{90,-78},{70,-58}})));
  inner ThermofluidStream.DropOfCommons dropOfCommons annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Sine sine_p(
    amplitude=0.1,
    f=1,
    offset=1e5) annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Blocks.Sources.Sine sine_h(
    amplitude=1,
    f=1,
    offset=4e4) annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  Modelica.Blocks.Sources.Sine sine_T(
    amplitude=1,
    f=1,
    offset=293) annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Blocks.Sources.Sine sine_xi(
    amplitude=0.001,
    f=0.5,
    offset=0.01) annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
equation
  connect(sine_p.y, boundaryRear1.p0_var) annotation (Line(points={{-59,40},{-32,40},{-32,96},{-12,96}}, color={0,0,127}));
  connect(sine_p.y, boundaryRear2.p0_var) annotation (Line(points={{-59,40},{-32,40},{-32,76},{48,76}}, color={0,0,127}));
  connect(sine_T.y, boundaryRear1.T0_var) annotation (Line(points={{-59,10},{-38,10},{-38,90},{-12,90}}, color={0,0,127}));
  connect(sine_xi.y, boundaryRear1.xi_var[1]) annotation (Line(points={{-59,-30},{-44,-30},{-44,84},{-12,84}}, color={0,0,127}));
  connect(sine_xi.y, boundaryRear2.xi_var[1]) annotation (Line(points={{-59,-30},{-44,-30},{-44,64},{48,64}}, color={0,0,127}));
  connect(sine_h.y, boundaryRear2.h0_var) annotation (Line(points={{-59,-90},{-26,-90},{-26,70},{48,70}}, color={0,0,127}));
  connect(sine_p.y,boundaryRear3. p0_var) annotation (Line(points={{-59,40},{-32,40},{-32,56},{-12,56}}, color={0,0,127}));
  connect(sine_p.y,boundaryRear4. p0_var) annotation (Line(points={{-59,40},{-32,40},{-32,36},{48,36}}, color={0,0,127}));
  connect(sine_T.y,boundaryRear3. T0_var) annotation (Line(points={{-59,10},{-38,10},{-38,50},{-12,50}}, color={0,0,127}));
  connect(sine_xi.y,boundaryRear3. xi_var[1]) annotation (Line(points={{-59,-30},{-44,-30},{-44,44},{-12,44}}, color={0,0,127}));
  connect(sine_xi.y,boundaryRear4. xi_var[1]) annotation (Line(points={{-59,-30},{-44,-30},{-44,24},{48,24}}, color={0,0,127}));
  connect(sine_h.y,boundaryRear4. h0_var) annotation (Line(points={{-59,-90},{-26,-90},{-26,30},{48,30}}, color={0,0,127}));
  connect(boundaryRear1.fore, terminalFore1.rear) annotation (Line(
      points={{0,90},{10,90}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryRear2.fore,terminalFore2. rear) annotation (Line(
      points={{60,70},{70,70}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryRear3.fore,terminalFore3. rear) annotation (Line(
      points={{0,50},{10,50}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryRear4.fore,terminalFore4. rear) annotation (Line(
      points={{60,30},{70,30}},
      color={28,108,200},
      thickness=0.5));
  connect(sine_p.y, boundaryFore1.p0_var) annotation (Line(points={{-59,40},{-32,40},{-32,-4},{-12,-4}}, color={0,0,127}));
  connect(sine_T.y, boundaryFore1.T0_var) annotation (Line(points={{-59,10},{-38,10},{-38,-10},{-12,-10}}, color={0,0,127}));
  connect(sine_xi.y, boundaryFore1.xi_var[1]) annotation (Line(points={{-59,-30},{-44,-30},{-44,-16},{-12,-16}}, color={0,0,127}));
  connect(boundaryFore1.rear, terminalRear1.fore) annotation (Line(
      points={{0,-10},{10,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(sine_p.y,boundaryFore2. p0_var) annotation (Line(points={{-59,40},{-32,40},{-32,-22},{48,-22}},
        color={0,0,127}));
  connect(sine_xi.y,boundaryFore2. xi_var[1]) annotation (Line(points={{-59,-30},{-44,-30},{-44,-34},{48,-34}},
        color={0,0,127}));
  connect(sine_h.y,boundaryFore2. h0_var) annotation (Line(points={{-59,-90},{-26,-90},{-26,-28},{48,-28}},
        color={0,0,127}));
  connect(sine_p.y,boundaryFore3. p0_var) annotation (Line(points={{-59,40},{-32,40},{-32,-42},{-12,-42}},
        color={0,0,127}));
  connect(sine_p.y,boundaryFore4. p0_var) annotation (Line(points={{-59,40},{-32,40},{-32,-62},{48,-62}},
        color={0,0,127}));
  connect(sine_T.y,boundaryFore3. T0_var) annotation (Line(points={{-59,10},{-38,10},{-38,-48},{-12,-48}},
        color={0,0,127}));
  connect(sine_xi.y,boundaryFore3. xi_var[1]) annotation (Line(points={{-59,-30},{-44,-30},{-44,-54},{-12,-54}},
        color={0,0,127}));
  connect(sine_xi.y,boundaryFore4. xi_var[1]) annotation (Line(points={{-59,-30},{-44,-30},{-44,-74},{48,-74}},
        color={0,0,127}));
  connect(sine_h.y,boundaryFore4. h0_var) annotation (Line(points={{-59,-90},{-26,-90},{-26,-68},{48,-68}},
        color={0,0,127}));
  connect(boundaryFore2.rear, terminalRear2.fore) annotation (Line(
      points={{60,-28},{70,-28}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryFore3.rear,terminalRear3. fore) annotation (Line(
      points={{0,-48},{10,-48}},
      color={28,108,200},
      thickness=0.5));
  connect(boundaryFore4.rear,terminalRear4. fore) annotation (Line(
      points={{60,-68},{70,-68}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{32,22},{78,12}},
          textColor={0,140,72},
          textString="setEnthalpy=true"),
        Line(
          points={{30,96},{30,-98}},
          color={0,140,72},
          pattern=LinePattern.Dash,
          thickness=0.5),
        Text(
          extent={{-18,22},{28,12}},
          textColor={238,46,47},
          textString="setEnthalpy=false")}));
end ConditionalConnectorsSetEnthalpy;
