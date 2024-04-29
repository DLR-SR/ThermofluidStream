within ThermofluidStream.Boundaries.Tests;
model TankExtendedChaoticLifeTest8_cluckingUpsideDownBottle
  extends TankExtendedTest8_upsideDownBottle(tank(
      outletTransition=0.0001,                    chaoticLife=true,
        gasBubbleVolume=0.0008));
  annotation (experiment(StopTime=10, __Dymola_Algorithm="Dassl"));
end TankExtendedChaoticLifeTest8_cluckingUpsideDownBottle;
