within ThermofluidStream.Media.myMedia.Water;
package WaterIF97_R4ph "Region 4 water according to IF97 standard"
  extends WaterIF97_fixedregion(
    final Region=4,
    ThermoStates=ThermofluidStream.Media.myMedia.Interfaces.Choices.IndependentVariables.ph,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    smoothModel=true,
    onePhase=false);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97_R4ph;
