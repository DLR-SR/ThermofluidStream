within ThermofluidStream.Utilities;
model DisplayComponentNameIndividually "Extend this to use 'displayComponentName'"
 parameter Boolean displayComponentName = dropOfCommons.displayComponentNames "=true, if u wish to display the component name" annotation(Dialog(group="Layout"),Evaluate=true, HideResult=true);

end DisplayComponentNameIndividually;
