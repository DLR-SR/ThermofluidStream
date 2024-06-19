within ThermofluidStream.Undirected.Sensors.Internal;
partial model PartialSensor "Partial undirected sensor"

  extends ThermofluidStream.Utilities.DropOfCommonsPlus(displayInstanceName = false);

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true, Documentation(
        info="<html>
<p>Replaceable medium package for the sensor.</p>
</html>"));
  parameter Integer digits(min=0) = 1 "Number of displayed digits"
    annotation(Dialog(group="Sensor display"));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Regularization threshold of mass flow rate"
    annotation(Dialog(tab="Advanced", group="Regularization"));

  Interfaces.Rear rear(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={-100,-80}), iconTransformation(extent={{-120,-20},{-80,20}})));
  Interfaces.Fore fore(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={100,-80}), iconTransformation(extent={{80,-20},{120,20}})));

/*  function regStepSt = Undirected.Internal.regStepState (
    redeclare package Medium = Medium) "RegStep function for a state"
    annotation (Documentation(info="<html>
<p><span style=\"font-family: Courier New;\">RegStep function for a state. The medium of the sensor is used and given to the function.</span></p>
</html>"));
*/
  Medium.ThermodynamicState state = Medium.setState_phX(p_reg, h_reg, Xi_reg); //= regStepSt(rear.m_flow, rear.state_forwards, rear.state_rearwards, m_flow_reg);

protected
 SI.Pressure p_reg= Undirected.Internal.regStep(rear.m_flow, Medium.pressure(rear.state_forwards), Medium.pressure(rear.state_rearwards), m_flow_reg);
  SI.SpecificEnthalpy h_reg = Undirected.Internal.regStep(rear.m_flow, Medium.specificEnthalpy(rear.state_forwards), Medium.specificEnthalpy(rear.state_rearwards), m_flow_reg);
  Medium.MassFraction Xi_reg[Medium.nXi];

  Medium.MassFraction Xi_forwards[Medium.nXi] = Medium.massFraction(rear.state_forwards);
  Medium.MassFraction Xi_rearwards[Medium.nXi] = Medium.massFraction(rear.state_rearwards);

equation
  for i in 1:Medium.nXi loop
    Xi_reg[i] = Undirected.Internal.regStep(rear.m_flow, Xi_forwards[i], Xi_rearwards[i], m_flow_reg);
  end for;

  fore.state_forwards = rear.state_forwards;
  rear.state_rearwards = fore.state_rearwards;
  fore.r = rear.r;
  fore.m_flow + rear.m_flow = 0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Line(
          points={{-100,0},{100,0}},
          color={28,108,200},
          thickness=0.5)}),
       Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Parent class of all undirected sensors.</p>
</html>"));
end PartialSensor;
