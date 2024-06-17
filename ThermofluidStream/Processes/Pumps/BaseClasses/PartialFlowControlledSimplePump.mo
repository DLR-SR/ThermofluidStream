within ThermofluidStream.Processes.Pumps.BaseClasses;
partial model PartialFlowControlledSimplePump "Base model of flow controlled simple pump"
  extends ThermofluidStream.Processes.Pumps.BaseClasses.SISOFlow_v2;

  parameter Real eta_is(min=0,max=1) = 1 "Fixed isentropic efficiency";
  parameter Real Delta_rho_rel = 1e-3 "Maximum compressibility |rho_out - rho_in|/rho"
    annotation(Dialog(tab="Advanced"));
protected
  SI.Density rho_in = Medium.density(inlet.state) "Inlet density";
  SI.Density rho_out = Medium.density(outlet.state) "Outlet density";
public
  SI.Density rho = rho_in "Density";
  SI.VolumeFlowRate V_flow = m_flow/rho "Volume flow rate";
  SI.SpecificEnthalpy w_t_is "Specific isentropic technical work (specific hydraulic work)";
  SI.SpecificEnthalpy w_t "Specific technical work";
  SI.Power P "Power (technical work flow rate)";
equation
  assert(abs(rho_in - rho_out)/max(rho_in,rho_out) < Delta_rho_rel, "Incompressibility check failed", dropOfCommons.assertionLevel);
  w_t_is = dp/rho;
  w_t = w_t_is/eta_is;
  P = m_flow*w_t;
  h_out = h_in + w_t;
  annotation (Icon(graphics={
         Text(visible=displayInstanceName,
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
         Ellipse(
          extent={{-58,54},{62,-66}},
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
        Line(
          points={{0,60},{60,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,-60},{60,0}},
          color={28,108,200},
          thickness=0.5)}));
end PartialFlowControlledSimplePump;
