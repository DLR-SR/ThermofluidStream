within ThermofluidStream.Utilities;
model DropOfCommonsPlus "Extend this to use 'dropOfCommons', 'displayInstanceName', 'displayParameterValues'"
protected
  outer DropOfCommons dropOfCommons;
public
 parameter Boolean displayInstanceName = dropOfCommons.displayInstanceNames "= true to display the instance name" annotation(Dialog(tab="Layout"),Evaluate=true, HideResult=true);
 parameter Boolean displayParameters = dropOfCommons.displayParameters "= true to enable displaying relevant parameters" annotation(Dialog(tab="Layout"),Evaluate=true, HideResult=true);

end DropOfCommonsPlus;
