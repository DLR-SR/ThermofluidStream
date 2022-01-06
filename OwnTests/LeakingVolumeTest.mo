within ThermofluidStream.Boundaries.Tests;
model Volumes "Test Volumes"
  extends Modelica.Icons.Example;

  replaceable package Medium = Media.myMedia.Air.DryAirNasa
                                                     constrainedby Media.myMedia.Interfaces.PartialMedium
                                     "Medium package"
      annotation (Documentation(info="<html>
<p><span style=\"font-family: Courier New;\">Medium package used in the Test.</span></p>
</html>"));

  package MediumMix = Media.myMedia.IdealGases.MixtureGases.CombustionAir
                                                                    "Medium package"
      annotation (Documentation(info="<html>
<p><span style=\"font-family: Courier New;\">Medium package used in the Test of the MixVolumes.</span> </p>
</html>"));


  inner DropOfCommons dropOfCommons(assertionLevel = AssertionLevel.warning)
    annotation (Placement(transformation(extent={{70,-170},{90,-150}})));
  
  Source source7(
  redeclare package Medium = Medium, 
  p0_par=100000)
    annotation (Placement(transformation(extent={{-70,110},{-50,130}})));
  
  Sink sink5(
  redeclare package Medium = Medium, 
  p0_par=100000)
            annotation (Placement(transformation(extent={{50,110},{70,130}})));

  Volume volume1(
    redeclare package Medium = Medium,
    T_start(displayUnit = "K") =313.15,
    k_volume_damping=0,
    p_start(displayUnit = "Pa") = 300000)
    annotation (Placement(transformation(extent={{-12,110},{8,130}})));

  Processes.FlowResistance flowResistance10(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.01,
    l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=1e5))
    annotation (Placement(transformation(extent={{20,110},{40,130}})));

  Processes.FlowResistance flowResistance11(
    redeclare package Medium = Medium,
    initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
    r(displayUnit="mm") = 0.01,
    l=1,
    redeclare function pLoss =
        Processes.Internal.FlowResistance.linearQuadraticPressureLoss (k=1e5))
    annotation (Placement(transformation(extent={{-40,110},{-20,130}})));

equation
  connect(volume1.outlet, flowResistance10.inlet) annotation(
    Line(points = {{8, 120}, {20, 120}}, color = {28, 108, 200}, thickness = 0.5));
  connect(flowResistance10.outlet, sink5.inlet) annotation(
    Line(points = {{40, 120}, {50, 120}}, color = {28, 108, 200}, thickness = 0.5));
  connect(volume1.inlet, flowResistance11.outlet) annotation(
    Line(points = {{-12, 120}, {-20, 120}}, color = {28, 108, 200}, thickness = 0.5));
  connect(flowResistance11.inlet, source7.outlet) annotation(
    Line(points = {{-40, 120}, {-50, 120}}, color = {28, 108, 200}, thickness = 0.5));
  annotation (experiment(StopTime=1, Tolerance=1e-6, Interval=0.001),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-200},{100,200}})),
        Documentation(info="<html>
<p>This test purposely violates the asserts for reversed mass-flows to test the behaviour of volumes for prolonged reversed massflow for some of the volumes. The assert is set to warning.</p>
<p><br>Owner: <a href=\"mailto:michael.meissner@dlr.de\">Michael Mei&szlig;ner</a></p>
</html>"));
end Volumes;
