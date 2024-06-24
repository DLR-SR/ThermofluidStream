within TILMediaWrapper.UsersGuide;
class BasicInformation "Basic Information"
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This section gives an overview, how the interface is structured. </p>
<p>In general, the interface follows the structure of the TILMedia Suite itself. It consists of the following main packages:</p>
<ul>
<li><a href=\"TILMediaWrapper.VLEFluidWrapper.PartialModels.VLEFluid_ph\">VLEFluid_ph</a> </li>
<li><a href=\"TILMediaWrapper.VLEFluidWrapper.SubstanceRecords\">Substance Records</a> </li>
<li>Wrapped Media Models </li>
</ul>
<p>The basic idea is to adjust the VLE-Fluid model of the TILMedia Suite with p, h and xi as independent variables to match the Thermofluid Stream media interface. In the respective <a href=\"TILMediaWrapper.VLEFluidWrapper.PartialModels.VLEFluid_ph\">package</a>, the functions of the partialTwoPhaseMedium are redeclared and the thermodynamic properties are calculated with the <a href=\"TILMedia.VLEFluidFunctions\">functions from TILMedia Suite</a>. </p>
<p>For each media model that needs to be interfaced, an according substance record has to be defined. The procedure of adding custom media models is shortly explained in the <a href=\"TILMediaWrapper.UsersGuide.AddMedia\">corresponding section</a>. Redeclaring this substance record as FluidType in the <a href=\"TILMediaWrapper.VLEFluidWrapper.PartialModels.VLEFluid_ph\">VLEFluid_ph</a> package then forms the wrapped media model (for example <a href=\"TILMediaWrapper.VLEFluidWrapper.Methanol\">Methanol</a>). </p>
</html>"));
end BasicInformation;
