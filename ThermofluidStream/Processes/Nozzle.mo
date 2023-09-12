within ThermofluidStream.Processes;
model Nozzle "Model for dynamic pressure difference"
  extends Interfaces.SISOFlow(final L = L_value, final clip_p_out=true);

  parameter SI.Area A_in = 1 "Area of inlet";
  parameter SI.Area A_out = 1 "Area of outlet";
  parameter Utilities.Units.Inertance L_value = dropOfCommons.L "Inertance of Nozzle"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean assumeConstantDensity=true "= true, if only inlet density is applied"
    annotation(Dialog(tab="Advanced"));

protected
  SI.Density rho_in = Medium.density(inlet.state) "Density of medium entering";
  SI.Density rho_out "Density of medium exiting";

  SI.Velocity v_in;
  SI.Velocity v_out;

equation
   if assumeConstantDensity then
      rho_out = rho_in;
   else
      rho_out = Medium.density(outlet.state);
   end if;

  v_in = m_flow/(rho_in*A_in);
  v_out = m_flow/(rho_out*A_out);

  dp = (rho_in/2)*v_in^2 - (rho_out/2)*v_out^2; //beware of density assumption....
  h_out = h_in + 1/2*(v_in^2 - v_out^2);
  Xi_out = Xi_in;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-56,54},{64,-66}},
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
          extent={{-60,60},{60,-60}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-42,42},{42,-42}},
          lineColor={28,108,200}),
        Polygon(
          points={{0,60},{-60,0},{0,-60},{60,0},{0,60}},
          lineColor={28,108,200}),
        Ellipse(
          extent={{-42,42},{42,-42}},
          lineColor={170,255,170},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Sphere),
        Ellipse(
          extent={{-42,42},{42,-42}},
          lineColor={0,140,72},
          lineThickness=0.5)}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Implementation of a nozzle taking gas dynamic effects into account.</p>
</html>"));
end Nozzle;
