within ThermofluidStream.Media.Tests.MoistAirDiscussion;
model MoistAirIsentropicExponent "Find PsiXmax concerning kappa (found to be 0.998)"
  extends Modelica.Icons.Example;
  package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir
                                "Medium model";

  Medium.ThermodynamicState state;
  //SI.SpecificEntropy s2 = Medium.specificEntropy_pTX(state.p,state.T,state.X);
  //SI.SpecificEntropy s1 = Medium.specificEntropy(state);
  Real kappa = Medium.isentropicExponent(state);
  Real XSaturation "Saturation of state3";
  parameter SI.Pressure p0 = 1e5;
  parameter SI.Temperature T0 = 273.15+20;
  parameter SI.TemperatureDifference dT = 20;
  parameter Real x0 = Medium.xsaturation_pT(p0,T0);
  parameter SI.MassFraction X0 = x0/(1+x0);
  parameter SI.MassFraction dX0 = 1e-2*X0;
  parameter SI.AngularFrequency  omega0 = 10;
  Real phi;
  parameter Real kappa0 = 1.39811;
  Real e_kappa_real = (kappa-kappa0)/kappa0;
  SI.SpecificEntropy s1 = Medium.specificEntropy(state);
protected
  constant SI.Time unitTime=1;
equation
  state.p = p0;
  state.T = T0;
  state.X = {X0, 1-X0} - {dX0, 1-dX0}*time;
  XSaturation = Medium.Xsaturation(state);
  phi = Medium.relativeHumidity(state);
  annotation (experiment(StopTime=1.0, Tolerance=1e-005), Documentation(info="<html>
<p>Check isentropic exponent <code>kappa</code> and relative humidity <code>phi</code> versus <code>time</code>.</p>
<p>  Isentropic exponent <code>kappa</code> 'jumps' at approximatly <code>phi=1</code>. Therefor the calculation of isentropic exponent <code>kappa</code> should be limited.
I suggest a limit of <code>phimax=0.998</code>, we could of course also choose one that is more on the 'safe side', but <code>phimax</code> may not be 1!</p></html>"));
end MoistAirIsentropicExponent;
