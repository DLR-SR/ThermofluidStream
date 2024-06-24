within ThermofluidStream.Processes.Sources.Tests.SimplePumpTests;
model Test_VolumePerRevolutionSimplePump
  extends ThermofluidStream.Processes.Sources.Tests.SimplePumpTests.BaseClasses.PartialTest_SimplePump;

  Modelica.Mechanics.Rotational.Sources.Speed speed annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Modelica.Blocks.Sources.Sine w_sine(
    amplitude=1,
    f=5e-4,
    offset=2,
    startTime=1e3) annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation (Placement(transformation(extent={{-88,-50},{-68,-30}})));
  Modelica.Blocks.Sources.Sine tau_sine(
    amplitude=50,
    f=5e-4,
    offset=100,
    startTime=1e3) annotation (Placement(transformation(extent={{-120,-50},{-100,-30}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=1, w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-60,-50},
            {-40,-30}})));
  IncompressibleFluid.VolumePerRevolutionSimplePump simplePump(redeclare package Medium = Medium_liquid, V=1e-3)
    annotation (Placement(transformation(extent={{-20,10},{-40,30}})));
equation
  connect(w_sine.y,speed. w_ref) annotation (Line(points={{-99,-10},{-82,-10}}, color={0,0,127}));
  connect(tau_sine.y,torque. tau) annotation (Line(points={{-99,-40},{-90,-40}}, color={0,0,127}));
  connect(speed.flange,simplePump. flange) annotation (Line(points={{-60,-10},{-30,-10},{-30,10}}, color={0,0,0}));
  connect(torque.flange,inertia. flange_a) annotation (Line(points={{-68,-40},{-60,-40}}, color={0,0,0}));
  connect(multiSensor_Tpm3.inlet, simplePump.outlet)
    annotation (Line(
      points={{-50,20},{-40,20}},
      color={28,108,200},
      thickness=0.5));
  connect(simplePump.inlet, multiSensor_Tpm2.outlet)
    annotation (Line(
      points={{-20,20},{-10,20}},
      color={28,108,200},
      thickness=0.5));
end Test_VolumePerRevolutionSimplePump;
