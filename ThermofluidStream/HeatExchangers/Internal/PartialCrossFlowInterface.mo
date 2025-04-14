within ThermofluidStream.HeatExchangers.Internal;

partial model PartialCrossFlowInterface "Partial heat exchanger icon and connectors for cross flow"

  replaceable package MediumA = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model A"
    annotation (choicesAllMatching=true);
  replaceable package MediumB = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model B"
    annotation (choicesAllMatching=true);

  ThermofluidStream.Interfaces.Inlet inletA(redeclare package Medium = MediumA) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-60}), iconTransformation(extent={{-120,-20},{-80,20}})));
  ThermofluidStream.Interfaces.Outlet outletA(redeclare package Medium = MediumA) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={100,-60}), iconTransformation(extent= {{80,-20},{120,20}})));
  ThermofluidStream.Interfaces.Inlet inletB(redeclare package Medium = MediumB) annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=0,
        origin={100,60}), iconTransformation(extent={{-120,-20},{-80,20}}, rotation=-90)));
  ThermofluidStream.Interfaces.Outlet outletB(redeclare package Medium = MediumB) annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=0,
        origin={-100,60}), iconTransformation(extent={{80,-20},{120,20}}, rotation=-90)));

  annotation (Documentation(info="<html>
<p>
This is the partial parent class for all heat exchangers cross flow configuration.
</html>"));
end PartialCrossFlowInterface;
