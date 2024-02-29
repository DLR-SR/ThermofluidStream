within ThermofluidStream.Utilities;
model DisplayInstanceNameIndividually "Extend this to use 'displayComponentName'"
protected
  outer DropOfCommons dropOfCommons;
public
 parameter Boolean displayInstanceName = dropOfCommons.displayInstanceNames "= true, if you wish to display the component name" annotation(Dialog(group="Layout"),Evaluate=true, HideResult=true);

end DisplayInstanceNameIndividually;
