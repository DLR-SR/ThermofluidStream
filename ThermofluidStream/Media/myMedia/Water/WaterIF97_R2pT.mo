within ThermofluidStream.Media.myMedia.Water;
package WaterIF97_R2pT "Region 2 (steam) water according to IF97 standard"
  extends WaterIF97_fixedregion(
    ThermoStates=ThermofluidStream.Media.myMedia.Interfaces.Choices.IndependentVariables.pT,
    final Region=2,
    final ph_explicit=false,
    final dT_explicit=false,
    final pT_explicit=true,
    smoothModel=true,
    onePhase=true);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97_R2pT;
