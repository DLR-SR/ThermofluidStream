within ThermofluidStream.Utilities.Functions;
function massFractionK
  extends Modelica.Icons.Function;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium;

  input Medium.ThermodynamicState state;
  input Integer k;
  output Medium.MassFraction x;

protected
  Medium.MassFraction Xi[Medium.nXi] = Medium.massFraction(state);

algorithm
  x := Xi[k];

end massFractionK;
