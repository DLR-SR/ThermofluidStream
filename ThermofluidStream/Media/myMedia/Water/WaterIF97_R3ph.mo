within ThermofluidStream.Media.myMedia.Water;
package WaterIF97_R3ph "Region 3 water according to IF97 standard"
  extends WaterIF97_fixedregion(
    final Region=3,
    ThermoStates=ThermofluidStream.Media.myMedia.Interfaces.Choices.IndependentVariables.ph,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    smoothModel=true,
    onePhase=true);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97_R3ph;
