within ThermofluidStream.Processes.Compressors.BaseClasses;
partial model PartialFlowSource "Base model of a pressure source with fixed isentropic efficiency suitable as both pump (incompressible media) or compressor/blower/fan (compressible media)"

  extends ThermofluidStream.Processes.Compressors.BaseClasses.SISOFlow_v2;

  parameter Real eta_is(min=0,max=1) = 1 "Fixed isentropic efficiency";

public
  SI.SpecificEnthalpy w_t_is "Specific isentropic technical work";
  SI.SpecificEnthalpy w_t "Specific technical work";
  SI.Power P "Power (technichal work flow rate)";
protected
  SI.Density rho_in = Medium.density(inlet.state) "Inlet density";
public
  SI.Density rho = rho_in "Density";
  SI.VolumeFlowRate V_flow = m_flow/rho "Volume flow rate";
protected
  SI.SpecificEntropy s_in = Medium.specificEntropy(inlet.state);
  SI.SpecificEnthalpy h_out_is = Medium.specificEnthalpy_psX(
      p_out,
      s_in,
      Xi_in);
equation
  w_t_is = h_out_is - h_in;
  w_t = w_t_is/eta_is;
  h_out = h_in + w_t;
  P = m_flow*w_t;
  Xi_out = Xi_in;
  annotation (Icon(graphics={
         Text(visible=displayInstanceName,
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor),
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
        Line(
          points={{-30,52},{56,20}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-30,-52},{56,-20}},
          color={28,108,200},
          thickness=0.5)}), Documentation(info="<html>
See <a href=\"modelica://ThermofluidStream.Processes.Compressors.AllMediaBasedOnEntropy.FlowSource\">FlowSource</a> for its usage and for further information.
</html>"));
end PartialFlowSource;
