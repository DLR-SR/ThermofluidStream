within ThermofluidStream.Utilities;
model DropOfCommonsPlus "Extend this to use 'dropOfCommons', 'displayInstanceName', 'displayParameterValues'"
protected
  outer DropOfCommons dropOfCommons;
public
 parameter Boolean displayInstanceName = dropOfCommons.displayInstanceNames "= true, if you wish to display the component name" annotation(Dialog(tab="Layout"),Evaluate=true, HideResult=true);

end DropOfCommonsPlus;
