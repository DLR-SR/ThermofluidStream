within ThermofluidStream.HeatExchangers.Internal;
function calculateEfficency "calculates efficency for a general HEX"
  extends Modelica.Icons.Function;

  replaceable package MediumA = Media.myMedia.Interfaces.PartialMedium;
  replaceable package MediumB = Media.myMedia.Interfaces.PartialMedium;

  input MediumA.ThermodynamicState state_A_in;
  input MediumB.ThermodynamicState state_B_in;

  input MediumA.ThermodynamicState state_A_out;
  input MediumB.ThermodynamicState state_B_out;

  input SI.MassFlowRate m_flow_A;
  input SI.MassFlowRate m_flow_B;

  input SI.Power Q_flow;

  input Boolean calculate_efficency = true;

  output Real efficency(unit="1") = 0;

protected
  SI.SpecificEnthalpy h_A_in = MediumA.specificEnthalpy(state_A_in);
  SI.SpecificEnthalpy h_B_in = MediumB.specificEnthalpy(state_B_in);

  SI.Pressure p_A = MediumA.pressure(state_A_out);
  SI.Pressure p_B = MediumB.pressure(state_B_out);

  SI.MassFraction[MediumA.nXi] Xi_A = MediumA.massFraction(state_A_out);
  SI.MassFraction[MediumB.nXi] Xi_B = MediumB.massFraction(state_B_out);

  SI.Temperature T_A_in = MediumA.temperature(state_A_in);
  SI.Temperature T_B_in = MediumB.temperature(state_B_in);

  constant SI.SpecificEnthalpy dh_0 = 1e5;
  constant SI.SpecificEnthalpy dh_fin = 1e1;
  constant Real devisor(unit="1") = 3.5;
  SI.SpecificEnthalpy dh;

  SI.SpecificEnthalpy dh_A=0;
  SI.SpecificEnthalpy dh_B=0;

  constant SI.Power eps = 1e-8;

algorithm
  if not calculate_efficency then
    return;
  end if;

  if T_A_in == T_B_in then
    return;
  end if;

  dh :=dh_0;
  while dh > dh_fin loop
    if T_A_in > T_B_in then
      if MediumA.temperature(MediumA.setState_phX(p_A, h_A_in-(dh+dh_A), Xi_A)) > T_B_in then
        dh_A :=dh + dh_A;
      else
        dh :=dh/devisor;
      end if;
    else
      if MediumA.temperature(MediumA.setState_phX(p_A, h_A_in+(dh+dh_A), Xi_A)) < T_B_in then
        dh_A :=dh + dh_A;
      else
        dh :=dh/devisor;
      end if;
    end if;
  end while;

  dh :=dh_0;
  while dh > dh_fin loop
    if T_B_in > T_A_in then
      if MediumB.temperature(MediumB.setState_phX(p_B, h_B_in-(dh+dh_B), Xi_B)) > T_A_in then
        dh_B :=dh + dh_B;
      else
        dh :=dh/devisor;
      end if;
    else
      if MediumB.temperature(MediumB.setState_phX(p_B, h_B_in+(dh+dh_B), Xi_B)) < T_A_in then
        dh_B :=dh + dh_B;
      else
        dh :=dh/devisor;
      end if;
    end if;
  end while;

  efficency := max(0, min(1, abs(Q_flow)/max(min(dh_A*abs(m_flow_A), dh_B*abs(m_flow_B)),eps)));

end calculateEfficency;
