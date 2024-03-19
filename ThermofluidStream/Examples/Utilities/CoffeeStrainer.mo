within ThermofluidStream.Examples.Utilities;
model CoffeeStrainer "Holds coffee in the machine."
  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium model for the coffee strainer. It is expected to be
water of some sorts.
</p>
</html>"));

  Interfaces.Inlet inlet(redeclare package Medium=Medium)
     annotation (Placement(transformation(extent={{-60,-20},{-20,20}}),
                        iconTransformation(extent={{-60,-20},{-20,20}})));
  Interfaces.Outlet outlet(redeclare package Medium=Medium) annotation (Placement(transformation(extent={{20,-20},
            {60,20}}), iconTransformation(extent={{20,-20},{60,20}})));

  Processes.FlowResistance coffeeStrainer(
    redeclare package Medium = Medium,
    r(displayUnit="mm") = 0.003,
    l=0.3,
    redeclare function pLoss = Processes.Internal.FlowResistance.linearQuadraticPressureLoss (
      k=8e8,
          k2=0)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,0})));
equation
  connect(coffeeStrainer.inlet, inlet) annotation (Line(
      points={{-10,0},{-40,0}},
      color={28,108,200},
      thickness=0.5));
  connect(coffeeStrainer.outlet, outlet) annotation (Line(
      points={{10,0},{58,0},{58,0},{40,0}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-18,-26},{18,26}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={68,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,-30},{22,30}},
          pattern=LinePattern.None,
          fillColor={153,153,153},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{22,-10},{26,-20}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={153,153,153},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{22,20},{26,10}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={153,153,153},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{8,-100},{-6,30}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
This is a flow resistance, with the icon of a coffee strainer.
</p>
</html>"));
end CoffeeStrainer;
