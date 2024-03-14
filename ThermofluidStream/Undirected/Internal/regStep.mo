within ThermofluidStream.Undirected.Internal;
function regStep
  "Approximation of a general step, such that the characteristic is continuous and differentiable"
  extends Modelica.Icons.Function;
  input Real x "Abscissa value";
  input Real y1 "Ordinate value for x > 0";
  input Real y2 "Ordinate value for x < 0";
  input Real x_small(min=0) = 1e-5
    "Approximation of step for -x_small <= x <= x_small; x_small >= 0 required";
  output Real y "Ordinate value to approximate y = if x > 0 then y1 else y2";
algorithm
  y := smooth(1, if x >  x_small then y1 else
                 if x < -x_small then y2 else
                 if x_small > 0 then (x/x_small)*((x/x_small)^2 - 3)*(y2-y1)/4 + (y1+y2)/2 else (y1+y2)/2);
  annotation(Documentation(revisions="<html>
<ul>
<li><em>April 29, 2008</em>
    by <a href=\"mailto:Martin.Otter@DLR.de\">Martin Otter</a>:<br>
    Designed and implemented.</li>
<li><em>August 12, 2008</em>
    by <a href=\"mailto:Michael.Sielemann@dlr.de\">Michael Sielemann</a>:<br>
    Minor modification to cover the limit case <code>x_small -> 0</code> without division by zero.</li>
</ul>
</html>", info="<html>
<p>
This function is used to approximate the equation
</p>

<blockquote><pre>
y = <strong>if</strong> x &gt; 0 <strong>then</strong> y1 <strong>else</strong> y2;
</pre></blockquote>

<p>
by a smooth characteristic, so that the expression is continuous and differentiable:
</p>

<blockquote><pre>
y = <strong>smooth</strong>(1, <strong>if</strong> x &gt;  x_small <strong>then</strong> y1 <strong>else</strong>
              <strong>if</strong> x &lt; -x_small <strong>then</strong> y2 <strong>else</strong> f(y1, y2));
</pre></blockquote>

<p>
In the region -x_small &lt; x &lt; x_small a 2nd order polynomial is used
for a smooth transition from y1 to y2.
</p>
</html>"));
end regStep;
