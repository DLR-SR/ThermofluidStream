within ThermofluidStream.Media.Tests.MoistAirDiscussion;
model MoistAirEntropyAndIsentropicExponent "Warning check for moist air concerning entropy and kappa, compare XSaturation with state.X to check if oversaturated"
  extends Modelica.Icons.Example;
  package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir
                                "Medium model";

  Medium.ThermodynamicState state;
  //SI.SpecificEntropy s2 = Medium.specificEntropy_pTX(state.p,state.T,state.X);
  SI.SpecificEntropy s = Medium.specificEntropy(state);
  Real kappa = Medium.isentropicExponent(state);
  Real XSaturation "Saturation of state3";
  parameter SI.Temperature T0 = 273.15+20;
  parameter SI.TemperatureDifference dT = 20;
  parameter SI.MassFraction X0 = 10e-3;
  parameter SI.AngularFrequency  omega0 = 10;
protected
  constant SI.Time unitTime=1;
equation
  state.p = 1.e5;
  state.T = T0 + dT*cos(omega0*time);
  state.X = {X0, 1-X0};
  XSaturation = Medium.Xsaturation(state);
  annotation (experiment(StopTime=1.0, Tolerance=1e-005), Documentation(info="<html>
<p>Check isentropic exponent <code>kappa</code>, mass fraction of water <code>X0</code> and mass fraction of water at saturation <code>XSaturation</code> versus <code>time</code>.</p>
<p>Pressure and water mass fraction are constant, whereas temperature is changed peridically, and therefor saturation is changed periodically</p>
<p> For (over)saturated state both Medium.specificEntropy(state), Medium.specificEntropy_pTX(p,T,X) and Medium.isentropicCoefficient will give a warning</p></html>"));
end MoistAirEntropyAndIsentropicExponent;
