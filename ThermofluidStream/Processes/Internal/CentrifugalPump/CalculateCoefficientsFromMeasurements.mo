within ThermofluidStream.Processes.Internal.CentrifugalPump;
model CalculateCoefficientsFromMeasurements "Determine and print pump coefficients based on measurements"
  extends Modelica.Icons.Example;
  import Modelica.Utilities.Streams.print;
  replaceable parameter ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.Wilo.Stratos25slash1to4 measurements
    constrainedby ThermofluidStream.Processes.Internal.CentrifugalPump.Measurements.GenericPump  "Measurements"
    annotation (Dialog(group="Data"), choicesAllMatching=true);
  final parameter ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries.InternalCoefficients c=ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries.internalCoefficientsFromMeasurements(measurements) "Pump coefficients internally used in the centrifugal pump model";
  final parameter ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients.GenericPump coefficients=ThermofluidStream.Processes.Internal.CentrifugalPump.Auxiliaries.coefficientsFromInternalCoefficients(c);

algorithm
  when terminal() then
    print("\n\n");
    print("============================================================================================================================");
    print("Coefficients to set up a record that extends ThermofluidStream.Processes.Internal.CentrifugalPump.Coefficients.GenericPump:");
    print("============================================================================================================================");
    print("final setHead = true,");
    print("    final dp_peak = 0,");
    print("    w_ref = " + String(coefficients.w_ref) + ",");
    print("    rho_ref = " + String(coefficients.rho_ref) + ",");
    print("    V_flow_peak = " + String(coefficients.V_flow_peak) + ",");
    print("    head_peak = " + String(coefficients.head_peak) + ",");
    print("    eta_peak = " + String(coefficients.eta_peak) + ",");
    print("    V_0n = " + String(coefficients.V_0n) + ",");
    print("    h_0n = " + String(coefficients.h_0n) + ",");
    print("    P_0n = " + String(coefficients.P_0n));
    print("============================================================================================================================");
    print("\n\n");
  end when;

  //print("Analytical zero     = " + String(u_analytical[1], format="2.16f"));
  //print("Numerical zero      = " + String(u_numerical[1], format="2.16f"));
  //print("Absolute difference = " + String(u_err[1], format="2.0e"));
  annotation (experiment(StopTime=1.0, Tolerance=1e-6, Interval=1e-3, __Dymola_Algorithm="Dassl"), Documentation(revisions="<html>
<ul>
<li>
May 2025, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
Initial version.
</li>
</ul>
</html>"));
end CalculateCoefficientsFromMeasurements;
