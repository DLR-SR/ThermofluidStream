within ThermofluidStream.Topology.Variants.Trash;
model RotateInstanceName
  parameter Boolean rotateInstanceName = false "= true, if you wish to rotate the instane name by 90°" annotation(Dialog(tab="Layout",group="Display instance name",enable=displayInstanceName),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter Boolean d1name = displayInstanceName and not rotateInstanceName "displayInstanceName version 1" annotation(Evaluate=true, HideResult=true);
  final parameter Boolean d2name = displayInstanceName and rotateInstanceName "displayInstanceName version 1" annotation(Evaluate=true, HideResult=true);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end RotateInstanceName;
