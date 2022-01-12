within ThermofluidStream.Processes;
model Nozzle_Simscape "Model for dynamic pressure difference"
  
  extends Interfaces.SISOFlow(final L = L_value, final clip_p_out=true);

  parameter SI.Area A_in = 1 "Area of inlet";
  parameter SI.Area A_out = 1 "Area of outlet";
  parameter Utilities.Units.Inertance L_value = dropOfCommons.L "Inertance of Nozzle"
    annotation(Dialog(tab="Advanced"));
  parameter SI.Density rho_min = dropOfCommons.rho_min "Minimal input density"
    annotation(Dialog(tab="Advanced"));
  parameter Real B_lam = 0.999;
  parameter Real R(unit="J/K/mol") = 8.31446261815324;
  parameter Real molarMass(unit="kg/mol") = 0.0289647;

  outer DropOfCommons dropOfCommons;
  
  public
  SI.Density rho_A = Medium.density(inlet.state) "density at port A";
  SI.Density rho_B = Medium.density(outlet.state) "density at port B";
  
  SI.Velocity v_A "velocity at port A";
  SI.Velocity v_B "velocity at port B";
  
  Real area_ratio = A_in/A_out;
  
  Real rho_ratio_RA = rho_B/rho_A;
  Real rho_ratio_RB = rho_B/rho_B;
  
  SI.Pressure p_avg = abs(p_in + p_out)/2;
  SI.Pressure Dp_lam = p_avg * (1-B_lam);
  Real K_tur_AB = (1+area_ratio)*(1-rho_ratio_RA*area_ratio) - 2*area_ratio*(1-rho_ratio_RB*area_ratio);
  
  // for Flow Mach <1
  Real K_unchoked = sqrt((K_tur_AB * v_B)^2 + (1-area_ratio)^2*2*Dp_lam/(rho_B+1e-10));
  SI.Pressure dp_unchoked = 0.5 * rho_B * v_B * K_unchoked;
  
  // for Flow Mach = 1
  SI.Temperature T_R_limited = Medium.temperature(outlet.state);
  SI.Velocity a_R = sqrt(Medium.isentropicExponent(inlet.state) * R / molarMass * T_R_limited);
  Real K_choked = sqrt((K_tur_AB*a_R)^2 + (1-area_ratio)^2*2*Dp_lam/(rho_B+1e-10));
  SI.Pressure dp_choked = 0.5 * rho_B * K_choked * a_R;
  
  // Mach Number
  Real Mach_R = v_B/a_R;
  
  // Enthalpy Losses
  SI.Enthalpy dh = 0.5 * (v_A^2 - v_B^2);
 protected
    
equation 

    // pressure losses 
    if Mach_R<1 then
    dp = dp_unchoked;
    else
    dp = dp_choked;
    end if;  
    
    // Inlet and outlet velocities
    v_A = m_flow/(rho_A*A_in);
    
    // Enthalpy and Massfraction
    h_out = h_in + 1/2*(v_A^2 - v_B^2);
    Xi_out = Xi_in;
    
    // Velocity at Restriction
    if abs(v_A * area_ratio) > a_R then
      abs(v_B) = a_R;
    else
      v_B = - v_A * area_ratio;
    end if;
   
end Nozzle_Simscape;
