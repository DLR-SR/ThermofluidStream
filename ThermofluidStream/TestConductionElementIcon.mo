within ThermofluidStream;
model TestConductionElementIcon "To test if the icon is displayed correctly, can be removed before pushed"
  extends Modelica.Icons.Example;
  Processes.ConductionElement conductionElement annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Processes.ConductionElement conductionElement1(displayInstanceName=true)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Processes.ConductionElement conductionElement2(displayInstanceName=false, displayParameters=true)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Processes.ConductionElement conductionElement3(
    displayInstanceName=false,
    displayParameters=true,
    resistanceFromAU=false) annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Processes.ConductionElement conductionElement4(
    displayInstanceName=false,
    displayParameters=true,
    displayVolume=false) annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  Processes.ConductionElement conductionElement5(
    displayInstanceName=false,
    displayParameters=true,
    resistanceFromAU=false,
    displayVolume=false) annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Processes.ConductionElement conductionElement6(
    displayInstanceName=false,
    displayParameters=true,
    resistanceFromInput=true) annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Processes.ConductionElement conductionElement7(
    displayInstanceName=false,
    displayParameters=true,
    resistanceFromInput=true,
    resistanceFromAU=false) annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Processes.ConductionElement conductionElement8(
    displayInstanceName=false,
    displayParameters=true,
    resistanceFromInput=true,
    displayVolume=false) annotation (Placement(transformation(extent={{60,0},{80,20}})));
  Processes.ConductionElement conductionElement9(
    displayInstanceName=false,
    displayParameters=true,
    resistanceFromInput=true,
    resistanceFromAU=false,
    displayVolume=false,
    displayConduction=false) annotation (Placement(transformation(extent={{100,0},{120,20}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Seems to be fine.
</p>
</html>"));
end TestConductionElementIcon;
