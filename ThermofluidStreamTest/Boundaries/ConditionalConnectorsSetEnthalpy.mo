within ThermofluidStreamTest.Boundaries;
model ConditionalConnectorsSetEnthalpy
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir
    constrainedby ThermofluidStream.Media.myMedia.Interfaces.PartialMedium annotation(choicesAllMatching = true);

  inner ThermofluidStream.DropOfCommons dropOfCommons annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=true,
    enthalpyFromInput=true,
    xiFromInput=true,
    outlet(m_flow(start=0.5, fixed=true)))
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    setEnthalpy=true,
    pressureFromInput=true,
    temperatureFromInput=true,
    enthalpyFromInput=true,
    xiFromInput=true) annotation (Placement(transformation(extent={{40,60},{60,80}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    outlet(m_flow(start=0.5, fixed=true)))
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    setEnthalpy=true,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true) annotation (Placement(transformation(extent={{40,20},{60,40}})));
  ThermofluidStream.Boundaries.CreateState createState1(
    redeclare package Medium = Medium,
    setEnthalpy=false,
    PFromInput=true,
    TFromInput=true,
    hFromInput=true,
    XiFromInput=true) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  ThermofluidStream.Boundaries.CreateState createState2(
    redeclare package Medium = Medium,
    setEnthalpy=true,
    PFromInput=true,
    TFromInput=true,
    hFromInput=true,
    XiFromInput=true) annotation (Placement(transformation(extent={{42,-40},{62,-20}})));
  ThermofluidStream.Boundaries.CreateState createState3(
    redeclare package Medium = Medium,
    setEnthalpy=false,
    PFromInput=true,
    TFromInput=true,
    hFromInput=true,
    XiFromInput=true) annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  ThermofluidStream.Boundaries.CreateState createState4(
    redeclare package Medium = Medium,
    setEnthalpy=true,
    PFromInput=true,
    TFromInput=true,
    hFromInput=true,
    XiFromInput=true) annotation (Placement(transformation(extent={{42,-100},{62,-80}})));
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
  connect(sine_p.y, source1.p0_var) annotation (Line(points={{-59,40},{-32,40},{-32,96},{-12,96}},
        color={0,0,127}));
  connect(sine_p.y, source2.p0_var) annotation (Line(points={{-59,40},{-32,40},{-32,76},{48,76}}, color={0,0,127}));
  connect(sine_p.y, createState1.p_inp) annotation (Line(points={{-59,40},{-32,40},{-32,10},{-10,10}}, color={0,0,127}));
  connect(sine_p.y, createState2.p_inp) annotation (Line(points={{-59,40},{-32,40},{-32,-20},{42,-20}}, color={0,0,127}));
  connect(sine_T.y, source1.T0_var) annotation (Line(points={{-59,10},{-38,10},{-38,90},{-12,90}},
        color={0,0,127}));
  connect(sine_xi.y, source1.xi_var[1]) annotation (Line(points={{-59,-30},{-44,-30},{-44,84},{-12,84}},
        color={0,0,127}));
  connect(sine_xi.y, source2.xi_var[1]) annotation (Line(points={{-59,-30},{-44,-30},{-44,64},{48,64}},color={0,0,127}));
  connect(sine_T.y, createState1.T_inp) annotation (Line(points={{-59,10},{-38,10},{-38,0},{-10,0}}, color={0,0,127}));
  connect(sine_xi.y, createState1.Xi_inp[1]) annotation (Line(points={{-59,-30},{-44,-30},{-44,-10},{-10,-10}}, color={0,0,127}));
  connect(sine_xi.y, createState2.Xi_inp[1]) annotation (Line(points={{-59,-30},{-44,-30},{-44,-40},{42,-40}}, color={0,0,127}));
  connect(sine_h.y, createState2.h0_var) annotation (Line(points={{-59,-90},{-26,-90},{-26,-30},{50,-30}},
        color={0,0,127}));
  connect(sine_h.y, source2.h0_var) annotation (Line(points={{-59,-90},{-26,-90},{-26,70},{48,70}},
        color={0,0,127}));
  connect(sine_p.y,source3. p0_var) annotation (Line(points={{-59,40},{-32,40},{-32,56},{-12,56}},
        color={0,0,127}));
  connect(sine_p.y,source4. p0_var) annotation (Line(points={{-59,40},{-32,40},{-32,36},{48,36}},color={0,0,127}));
  connect(sine_T.y,source3. T0_var) annotation (Line(points={{-59,10},{-38,10},{-38,50},{-12,50}},
        color={0,0,127}));
  connect(sine_xi.y,source3. xi_var[1]) annotation (Line(points={{-59,-30},{-44,-30},{-44,44},{-12,44}},
        color={0,0,127}));
  connect(sine_xi.y,source4. xi_var[1]) annotation (Line(points={{-59,-30},{-44,-30},{-44,24},{48,24}},color={0,0,127}));
  connect(sine_h.y,source4. h0_var) annotation (Line(points={{-59,-90},{-26,-90},{-26,30},{48,30}},
        color={0,0,127}));
  connect(sine_p.y,createState3. p_inp) annotation (Line(points={{-59,40},{-32,40},{-32,-50},{-10,-50}},color={0,0,127}));
  connect(sine_p.y,createState4. p_inp) annotation (Line(points={{-59,40},{-32,40},{-32,-80},{42,-80}}, color={0,0,127}));
  connect(sine_T.y,createState3. T_inp) annotation (Line(points={{-59,10},{-38,10},{-38,-60},{-10,-60}},
        color={0,0,127}));
  connect(sine_xi.y,createState3. Xi_inp[1]) annotation (Line(points={{-59,-30},{-44,-30},{-44,-70},{-10,-70}},color={0,0,127}));
  connect(sine_xi.y,createState4. Xi_inp[1]) annotation (Line(points={{-59,-30},{-44,-30},{-44,-100},{42,-100}},
        color={0,0,127}));
  connect(sine_h.y,createState4. h0_var) annotation (Line(points={{-59,-90},{50,-90}}, color={0,0,127}));
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
