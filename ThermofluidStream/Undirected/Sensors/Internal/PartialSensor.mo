within ThermofluidStream.Undirected.Sensors.Internal;
partial model PartialSensor "Partial undirected sensor"
  replaceable package Medium = myMedia.Interfaces.PartialMedium "Medium model" annotation (choicesAllMatching=true, Documentation(
        info="<html>
<p>Replaceable medium package for the sensor.</p>
</html>"));

  parameter Integer digits(min=0) = 1 "Number of displayed digits"
    annotation(Dialog(group="Sensor display"));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Regularization threshold of mass flow rate"
    annotation(Dialog(tab="Advanced", group="Regularization"));

  Interfaces.Rear rear( redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={-100,-80})));
  Interfaces.Fore fore(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={100,-80})));

  function regStep = Undirected.Internal.regStepState (redeclare package Medium =
          Medium)                                                                         "RegStep function for a state"
    annotation (Documentation(info="<html>
<p><span style=\"font-family: Courier New;\">RegStep function for a state. The medium of the sensor is used and given to the function.</span></p>
</html>"));

  Medium.ThermodynamicState state = regStep(rear.m_flow, rear.state_forwards, rear.state_rearwards, m_flow_reg);

protected
  outer DropOfCommons dropOfCommons;

equation
  fore.state_forwards = rear.state_forwards;
  rear.state_rearwards = fore.state_rearwards;
  fore.r = rear.r;
  fore.m_flow + rear.m_flow = 0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-100,-80},{100,-80}},
          color={28,108,200},
          thickness=0.5)}),
       Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Parent class of all undirected sensors.</p>
</html>"));
end PartialSensor;
