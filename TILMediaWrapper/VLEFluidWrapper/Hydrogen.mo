within TILMediaWrapper.VLEFluidWrapper;
package Hydrogen "TIL-media Hydrogen"
  extends PartialModels.VLEFluid_ph(
    redeclare record FluidType = SubstanceRecords.TILMedia_Hydrogen,
    final triplePointTemperature=13.8033,
    final triplePointPressure=7.04e3,
    final meltingPoint=14);

end Hydrogen;
