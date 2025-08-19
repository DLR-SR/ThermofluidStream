within ThermofluidStream.Examples;
model SimpleStream "Simple pneumatic network"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.MoistAir
    constrainedby Media.myMedia.Interfaces.PartialMedium
    annotation(choicesAllMatching = true);

  inner DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation (Placement(transformation(extent={{-140,30},{-120,50}})));
  ThermofluidStream.Utilities.Icons.DLRLogo dLRLogo annotation (Placement(transformation(extent={{122,-58},{158,-22}})));
  Boundaries.Source source(
    redeclare package Medium = Medium,
    p0_par=100000,
    T0_par=293.15,
    Xi0_par={0})
    annotation (Placement(transformation(extent={{-150,-10},{-130,10}})));
  Boundaries.Sink sink(redeclare package Medium = Medium, p0_par=80000)
    annotation (Placement(transformation(extent={{130,-10},{150,10}})));
  Processes.FlowResistance pipe(
    redeclare package Medium = Medium,
    r=0.1,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Processes.FlowResistance pipe1(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=10,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Processes.FlowResistance pipe2(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r=0.1,
    l=100,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
  Processes.FlowResistance pipe3(
    redeclare package Medium = Medium,
    r=0.1,
    l=20,
    redeclare function pLoss = Processes.Internal.FlowResistance.laminarTurbulentPressureLoss)
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Topology.SplitterT1 splitter(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Topology.JunctionT1 junction(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=40e3, T(start=368.15, fixed=true))
    annotation (Placement(transformation(extent={{-40,36},{-20,56}})));
  Processes.ConductionElement thermalConduction(
    redeclare package Medium = Medium,
    L=100,
    V(displayUnit="m3") = 1,
    init=ThermofluidStream.Processes.Internal.InitializationMethodsCondElement.T,
    T_0=368.15,
    A=20)  annotation (Placement(transformation(extent={{-40,30},{-20,10}})));
  Sensors.MultiSensor_Tpm sensor(
    redeclare package Medium = Medium,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
  Sensors.MultiSensor_Tpm sensor1(
    redeclare package Medium = Medium,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Sensors.MultiSensor_Tpm sensor2(
    redeclare package Medium = Medium,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{10,-20},{30,-40}})));
  Sensors.MultiSensor_Tpm sensor3(
    redeclare package Medium = Medium,
    temperatureUnit="degC",
    pressureUnit="bar") annotation (Placement(transformation(extent={{70,0},{90,20}})));

equation
  connect(source.outlet, pipe.inlet)
    annotation (Line(
      points={{-130,0},{-120,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pipe.outlet, sensor.inlet)
    annotation (Line(
      points={{-100,0},{-90,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sensor.outlet, splitter.inlet)
    annotation (Line(
      points={{-70,0},{-60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter.outletA, thermalConduction.inlet)
    annotation (Line(
      points={{-50,10},{-50,20},{-40,20}},
      color={28,108,200},
      thickness=0.5));
  connect(thermalConduction.outlet, sensor1.inlet)
    annotation (Line(
      points={{-20,20},{-10,20}},
      color={28,108,200},
      thickness=0.5));
  connect(sensor1.outlet, pipe1.inlet)
    annotation (Line(
      points={{10,20},{20,20}},
      color={28,108,200},
      thickness=0.5));
  connect(pipe1.outlet, junction.inletA)
    annotation (Line(
      points={{40,20},{50,20},{50,10}},
      color={28,108,200},
      thickness=0.5));
  connect(splitter.outletB, pipe2.inlet)
    annotation (Line(
      points={{-50,-10},{-50,-20},{-30,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(pipe2.outlet, sensor2.inlet)
    annotation (Line(
      points={{-10,-20},{10,-20}},
      color={28,108,200},
      thickness=0.5));
  connect(sensor2.outlet, junction.inletB)
    annotation (Line(
      points={{30,-20},{50,-20},{50,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(junction.outlet, sensor3.inlet)
    annotation (Line(
      points={{60,0},{70,0}},
      color={28,108,200},
      thickness=0.5));
  connect(sensor3.outlet, pipe3.inlet)
    annotation (Line(
      points={{90,0},{100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(pipe3.outlet, sink.inlet)
    annotation (Line(
      points={{120,0},{130,0}},
      color={28,108,200},
      thickness=0.5));
  connect(heatCapacitor.port, thermalConduction.heatPort)
    annotation (Line(points={{-30,36},{-30,30}}, color={191,0,0}));
  annotation (
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-60},{160,
            60}})),
    experiment(
      StopTime=100,
      Interval=0.1,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
        Documentation(info="<html>
<p>Example of a simple pneumatic pipe network, including splitter, junction and heat transfer, driven by a constant pressure difference.</p>
<p>This examples demonstrates:</p>
<ul>
<li>
the mass flow rate dynamics, that are influenced by the inertia of the fluid in the pipes. The Thermofluid Stream Library considers this by the inertance <code>L</code>.
For a pipe the inertance <code>L = l/A</code></li>
<li>the temperature dynamics of the <code>heatCapacitor</code> and the <code>thermalConduction</code> model. The dynamics are influenced by the heat capacities <code>C</code> 
and <code>V*rho*c</code> respectively and by the overall thermal conductance <code>U*A</code></li>
</ul>

<p>
Note:
</p>
<ul>
<li>the splitter, junction and thermalConduction models are ideal, i.e. they consider no pressure losses</li>
<li>the pressures, e.g. <code>pipe1.outlet.state.p</code> and <code>pipe2.outlet.state.p</code> are <strong>steady state</strong> pressures, and are not required to be equal at junctions or equal
to the boundary condition of a sink or a volume.<br>
Junctions, sinks and volumes balance the sum of steady state pressure <code>p</code> and pressure difference due to the acceleration of mass (the so called inertial pressure) <code>r</code> however, i.e. their 
sum <code>p+r</code> is equal for every inlet of a junction or equal to the boundary condition of a sink or a volume.</li>
</ul>

<p><br>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end SimpleStream;
