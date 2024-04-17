within ThermofluidStream.Utilities;
model DropOfCommonsPlus "Extend this to use 'dropOfCommons', 'displayInstanceName' and 'displayParameters'"
protected
  outer DropOfCommons dropOfCommons;
public
 parameter Boolean displayInstanceName = dropOfCommons.displayInstanceNames "= true, if instance name is displayed" annotation(Dialog(tab="Layout"),Evaluate=true, HideResult=true);
 parameter Boolean displayParameters = dropOfCommons.displayParameters "= true, if displaying parameters is enabled" annotation(Dialog(tab="Layout"),Evaluate=true, HideResult=true);

end DropOfCommonsPlus;
