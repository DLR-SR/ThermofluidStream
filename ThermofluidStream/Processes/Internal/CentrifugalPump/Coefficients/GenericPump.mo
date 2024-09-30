within ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients;
record GenericPump "Generic centrifugal pump coefficient record"

  extends Modelica.Icons.Record;

  parameter SI.Density rho_ref(displayUnit="kg/l") = 1000 "Reference density";
  parameter SI.AngularVelocity  w_ref(displayUnit="rpm") = 314.1592653589793 "Reference angular velocity"; // 3000 rpm
  parameter Boolean setHead = true "= true, if reference head shall be given (= false, if reference pressure rise shall be given instead)"
    annotation(Dialog(group="Head curve parameters"),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Height head_ref = 0 "Reference head at zero volume flow rate"
    annotation (Dialog(group="Head curve parameters", enable=setHead));
  parameter SI.PressureDifference dp_ref = 0 "Reference pressure rise at zero volume flow rate"
    annotation (Dialog(group="Head curve parameters", enable= not setHead));
  parameter SI.VolumeFlowRate V_flow_ref = 0  "Reference volume flow rate at zero head"
    annotation (Dialog(group="Head curve parameters"));
  parameter Real c2_head = 0.23 "Dimensionless slope of head/pressure rise curve at zero volume flow rate; c2_head ≈ 0.23 ± 0.30, min c2_head = -0.3, max c2_head = 0.7 (based on 18 Wilo Pumps)"
    annotation (Dialog(group="Head curve parameters"));
  parameter Real eta_ref(min=0,max=1) = 0.8 "Reference (maximum) efficiency"
    annotation (Dialog(group="Efficiency curve parameters"));
  parameter Real Vr_peak(min=0,max=1) = 0.515 "Volume flow rate ratio V_flow/V_flow_ref at maximum efficiency; Vr_peak ≈ 0.515 ± 0.023, min Vr_peak = 0.478, max Vr_peak = 0.560 (based on 18 Wilo Pumps)"
    annotation (Dialog(group="Efficiency curve parameters"));
  parameter Real c3_power = -0.28 "Dimensionless curvature of power curve; c3_power ≈ −0.28±0.09, min c3_power = −0.44, max c3_power = −0.16 (based on 18 Wilo Pumps)"
    annotation (Dialog(group="Power curve parameters"));
  final parameter SI.Height head_ref_internal = if setHead then head_ref else dp_ref/(Modelica.Constants.g_n*rho_ref);
  annotation(Images(Parameters(group="Head curve parameters",
  source="modelica://ThermofluidStream/Resources/Doku/Pumps/HpQ30.png"),Parameters(group="Efficiency curve parameters",
  source="modelica://ThermofluidStream/Resources/Doku/Pumps/etaQ30.png"),Parameters(group="Power curve parameters",
  source="modelica://ThermofluidStream/Resources/Doku/Pumps/PQ30.png")),
  defaultComponentPrefixes = "parameter");
end GenericPump;
