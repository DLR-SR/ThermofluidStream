within ThermofluidStream.Examples.Utilities;
model Accumulator "Accumulator model for vapor cycle applications"
  extends Boundaries.PhaseSeparator(pipe_low=0.85, pipe_high=0.95);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-56,76},{64,16}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-56,46},{64,-56}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-56,-28},{64,-88}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-100,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-60,-20},{60,-80}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,50},{60,-50}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-60,80},{60,20}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,50},{-60,-52}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{60,50},{60,-52}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-24,72},{-24,16},{-24,-34}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{-38,72},{-38,16},{-38,-34}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{24,72},{24,16},{24,-34}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{38,72},{38,16},{38,-34}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Ellipse(
          extent={{-24,-12},{24,-56}},
          lineColor={0,0,0},
          startAngle=0,
          endAngle=180,
          closure=EllipseClosure.None),
        Ellipse(
          extent={{-38,2},{38,-68}},
          lineColor={0,0,0},
          startAngle=0,
          endAngle=180,
          closure=EllipseClosure.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-38,74},{-24,68}},
          lineColor={0,0,0},
          closure=EllipseClosure.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{24,74},{38,68}},
          lineColor={0,0,0},
          closure=EllipseClosure.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{28,-68},{-28,-34}},
          startAngle=210,
          endAngle=330,
          closure=EllipseClosure.Chord,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}),
                            Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Model of an accumulator for application in vapor-cycle systems.</p>
<p><br>It inherits the basic balance equations from the volume model.</p>
<p><br>The purpose of this model is to separate the phases and provide gaseous phase to the compressor. The gas is extracted through a pipe. The low and high end of the pipe can be set by the respective parameters. Depending on the liquid level of the accumulator, the outlet enthalpy is set:</p>
<p><br>If the liquid level is higher than the upper end of the pipe, liquid is extracted.</p>
<p>If the liquid level is lower then the lower end of the pipe, the actual enthalpy of the medium in the accumulator is extracted.</p>
<p>If the liquid level is between the lower and the upper end of the pipe, the outlet enthalpy is weighted on the liquid level in the pipe.</p>
<p>Known problems: full phaseSeparator is very stiff, therefore simulation might get slow then, especially at the moment when the separator fills up. Consider changing the timeconstant and check if the mass-flow dynamic is fast enough.</p>
<p><br><img src=\"modelica://ThermofluidStream/Resources/Doku/accumulator.png\"/></p>
</html>"));
end Accumulator;
