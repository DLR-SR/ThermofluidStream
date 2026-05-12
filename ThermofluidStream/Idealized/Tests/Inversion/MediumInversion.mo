within ThermofluidStream.Idealized.Tests.Inversion;
model MediumInversion "Calculate (p,T) = f(h,s)"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Air.DryAirNasa constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation (choicesAllMatching=true);

 Medium.BaseProperties medium(p(start=1e5),T(start=300)); //Different p.start, T.start might eventually let the simulation fail
 Medium.SpecificEntropy s = Medium.specificEntropy(medium.state);
equation
  medium.h = 348069;
  s  = 6700;
  //medium.T = 273.15+20;
  //medium.p = 1e5;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false), graphics={
                                     Text(
          extent={{-80,20},{80,0}},
          textColor={28,108,200},
          textString="Find p, T for given  h, s")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    Find pressure and temperature for given specific entropy and specific enthalpy.<br>
    This results in two nonlinear equation systems of size 1, which are solved by Dymola using a nonlinear solver.
  </p>
</html>"));
end MediumInversion;
