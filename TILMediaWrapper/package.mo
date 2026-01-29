within ;
package TILMediaWrapper "Wrapper for the TIL Media Suite"
  extends Modelica.Icons.Package;

  annotation (
  version="0.1.2",
  uses(
    Modelica(version="4.0.0"),
    ThermofluidStream(version="1.2.0"),
    TILMedia(version="3.15.0")),
  Documentation(info="<html>
<p>This is the interface to the <strong>VLE-Fluid</strong> (<strong>V</strong>apor-<strong>L</strong>iquid<strong> E</strong>quilibrium) media models from TILMedia Suite by TLK-Thermo GmbH. </p>
<p style=\"color:#ff5500;\">This package only provides the functionality of an interface to the TILMedia Suite and doesn&apos;t include the media models itself! For usage of the media models, a license of the TILMedia Suite is necessary.</p>
</html>"),
    Icon(graphics={
         Ellipse(
          extent={{-58,16},{-18,-24}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-24,12},{22,34}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-24,-12},{22,-34}},
          color={28,108,200},
          thickness=1),
         Ellipse(
          extent={{22,-24},{62,-64}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
         Ellipse(
          extent={{22,56},{62,16}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-60,20},{-20,-20}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{20,60},{60,20}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{20,-20},{60,-60}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}));
end TILMediaWrapper;
