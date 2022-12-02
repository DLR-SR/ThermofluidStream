within ThermofluidStream.Media.myMedia.Water;
package WaterIF97OnePhase_ph
  "Water using the IF97 standard, explicit in p and h, and only valid outside the two-phase dome"
  extends WaterIF97_base(
    ThermoStates=ThermofluidStream.Media.myMedia.Interfaces.Choices.IndependentVariables.ph,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    final smoothModel=true,
    final onePhase=true);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97OnePhase_ph;
