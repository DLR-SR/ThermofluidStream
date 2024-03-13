within ThermofluidStream.Boundaries.Internal.Display;
model SourceDisplay
  // Configure icon display options
  parameter Boolean displayPressure = true "= true to display the pressure set value p0_par" annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters and not pressureFromInput),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayTemperature = true "= true to display the temperature set value T0_par" annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters and not temperatureFromInput),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean displayInertance = false "= true to display the inertance value L" annotation(Dialog(tab="Layout",group="Display parameters",enable=displayParameters),Evaluate=true, HideResult=true, choices(checkBox=true));
  final parameter Boolean displayP = displayPressure and not pressureFromInput annotation(Evaluate=true, HideResult=true);
  final parameter Boolean displayT = displayTemperature and not temperatureFromInput and not setEnthalpy annotation(Evaluate=true, HideResult=true);

  final parameter String displayPos1=
  if displayP then
    "p = %p0_par"
  elseif displayT then
    "T = %T0_par"
  elseif displayInertance then
    "L = %L"
  else "";
  final parameter String displayPos2=
  if displayP and displayT then
    "T = %T0_par"
  elseif  displayInertance and (displayP or displayT) then
    "L = %L"
  else "";
  final parameter String displayPos3=
  if displayP and  displayT and displayInertance then
    "L = %L"
  else "" annotation(Evaluate=true, HideResult=true);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end SourceDisplay;
