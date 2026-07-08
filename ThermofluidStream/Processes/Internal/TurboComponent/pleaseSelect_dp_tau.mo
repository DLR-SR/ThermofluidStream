within ThermofluidStream.Processes.Internal.TurboComponent;
model pleaseSelect_dp_tau "Please select dp_tau model"
  extends partial_dp_tau;

algorithm
  assert(false, "please select dp_tau model");

  dp := 0;
  tau_st := 0;

  annotation (Documentation(info="<html>
<p>dp-tau model without actual equations with an always failing assert to output a meaningful error, when the user forgot to select a model. This should be used as a default. </p>
</html>"));
end pleaseSelect_dp_tau;
