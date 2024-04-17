within ThermofluidStream.HeatExchangers.Internal;
function calculateEfficiency "Calculates heat exchanger efficiency"
  extends Modelica.Icons.Function;

  replaceable package MediumA = Media.myMedia.Interfaces.PartialMedium "Medium model A";
  replaceable package MediumB = Media.myMedia.Interfaces.PartialMedium "Medium model B";

  input MediumA.ThermodynamicState state_A_in "Inlet A thermodynamic state";
  input MediumB.ThermodynamicState state_B_in "Inlet B thermodynamic state";

  input MediumA.ThermodynamicState state_A_out "Outlet A thermodynamic state";
  input MediumB.ThermodynamicState state_B_out "Outlet B thermodynamic state";

  input SI.MassFlowRate m_flow_A "Mass flow rate of medium A";
  input SI.MassFlowRate m_flow_B "Mass flow rate of medium B";

  input SI.Power Q_flow "Heat flow rate";

  output Real efficiency(unit="1") = 0 "Heat exchanger efficiency";

protected
  SI.SpecificEnthalpy h_A_in = MediumA.specificEnthalpy(state_A_in) "Inlet A specific enthalpy";
  SI.SpecificEnthalpy h_B_in = MediumB.specificEnthalpy(state_B_in) "Inlet B specific enthalpy";

  SI.Pressure p_A = MediumA.pressure(state_A_out) "Outlet A pressure";
  SI.Pressure p_B = MediumB.pressure(state_B_out) "Outlet B pressure";

  SI.MassFraction[MediumA.nXi] Xi_A = MediumA.massFraction(state_A_out) "Outlet A mass fractions";
  SI.MassFraction[MediumB.nXi] Xi_B = MediumB.massFraction(state_B_out) "Outlet B mass fractions";

  SI.Temperature T_A_in = MediumA.temperature(state_A_in) "Inlet A temperature";
  SI.Temperature T_B_in = MediumB.temperature(state_B_in) "Inlet B temperature";

  constant SI.SpecificEnthalpy dh_0 = 1e4 "Initial specific enthalpy difference";
  constant SI.SpecificEnthalpy dh_fin = 1e1 "Stop condition";
  constant Real devisor(unit="1") = 3.5;
  SI.SpecificEnthalpy dh "Specific enthalpy difference";

  SI.SpecificEnthalpy dh_A=0 "Medium A specific enthalpy difference";
  SI.SpecificEnthalpy dh_B=0 "medium B specific enthalpy difference";

  constant SI.Power eps = 1e-8 "Minimum power";

algorithm
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

  efficiency := max(0, min(1, abs(Q_flow)/max(min(dh_A*abs(m_flow_A), dh_B*abs(m_flow_B)),eps)));

end calculateEfficiency;
