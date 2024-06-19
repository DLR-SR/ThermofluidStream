within TILMediaWrapper.UsersGuide;
class AddMedia "Add Custom Media Model"
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Adding other media models than the ones already provided is quite straight forward. This section gives a short step-by-step guideline on how to add custom media models to the interface so they can be used within the Thermofluid Stream. </p>
<h4>1. Define a new substance record</h4>
<p>First, a new substance record has to be defined. To do so, make a local copy of an existing record within the <a href=\"TILMediaWrapper.VLEFluidWrapper.SubstanceRecords\">substance records package. </a></p>
<p>In the base record for the VLEFluid definitions, all relevant parameters that have to be passed to the interface are defined. </p>
<p>The media of each substance record is defined in the substance name of the media that has to be wrapped. All the substance names available in the TIL (and also Refprop and Coolprop media names) can be found in the <a href=\"TILMedia.UsersGuide.SubstanceNames\">User&apos;s Guide of the TILMedia Suite</a>. </p>
<p>The substance name looks somehow like TILMedia.METHANOL or Refprop.R134A.FLD. This substance name has to be set in the parameter vleFluidNames as String value. </p>
<p>In most cases, for VLEFluid substances, the other parameters can be left unchanged unless the user does not want to mix the fluid with other substances. </p>
<p style = \"color:#ff5500;\">!Keep in mind that in the current state, the wrapper only covers VLE-Fluid media models!</p>
<h4>2. Create new package for the custom media model</h4>
<p>In the second step, the defined substance record from step 1 has to be defined as FluidType in the VLEFluid_ph model. To do so, make a local copy of an existing media package (for example <a href=\"TILMediaWrapper.VLEFluidWrapper.Methanol\">Methanol</a>) and replace the substance record by the one you just created. </p>
<h4>3. Use the custom media model in TFS</h4>
<p>
The media model is now ready to be used in the TFS!
</p>
</html>"));
end AddMedia;
