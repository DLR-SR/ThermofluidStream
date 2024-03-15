within ThermofluidStream.Media.Tests.MoistAirDiscussion;
model MoistAirEntropy "Find PsiXmax concerning entropy, found that entropy is continous and therefor not as critical as kappa"
  extends Modelica.Icons.Example;
  package Medium = ThermofluidStream.Media.myMedia.Air.MoistAir
                                "Medium model";

  Medium.ThermodynamicState state;
  //SI.SpecificEntropy s2 = Medium.specificEntropy_pTX(state.p,state.T,state.X);
  SI.SpecificEntropy s1 = Medium.specificEntropy(state);
  Real XSaturation "Saturation of state3";
  parameter SI.Pressure p0 = 1e5;
  parameter SI.Temperature T0 = 273.15+20;
  parameter SI.TemperatureDifference dT = 20;
  parameter Real x0 = Medium.xsaturation_pT(p0,T0);
  parameter SI.MassFraction X0 = x0/(1+x0);
  parameter SI.MassFraction dX0 = X0;
  parameter SI.AngularFrequency  omega0 = 10;
  Real phi;
protected
  constant SI.Time unitTime=1;
equation
  state.p = p0;
  state.T = T0;
  state.X = {X0, 1-X0} - {dX0, 1-dX0}*(2*time-1);
  XSaturation = Medium.Xsaturation(state);
  phi = Medium.relativeHumidity(state);
  annotation (experiment(StopTime=1.0, Tolerance=1e-005), Documentation(info="<html>
<p>Check specific entropy <code>s</code> and relative humidity <code>phi</code> versus <code>time</code>.</p>
<p>Since there is no kink in specific entropy <code>s</code> at satuarion (<code>X_sat = X</code>), i assume, that MoistAir uses the specific entropy of vapor also for condensed water.
Of course this is wrong, but the error is proportional to the amount of condensed water, and therefor the calculation of specific entropy is not as critial as the calculation of isentropic coefficient kappa, which jumps at saturation.</p>
</html>"));
end MoistAirEntropy;
