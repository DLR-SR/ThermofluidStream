within ThermofluidStream.Processes.Compressors.Tests.Utilities;
model CompressorIsentropicEfficiencyConstKappa
  "Analytic Solution for compression of ideal gas with given constant kappa (using media specific enthalpy), isentropic efficiency, inlet and outlet pressure"

  extends Modelica.Blocks.Icons.Block;
  replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium"
    annotation (choicesAllMatching=true, Documentation(info="<html>
<p>
Medium package used in the Source. Make sure it is the same as the one
the inlet the source is connected to.
</p>
</html>"));

  parameter SI.Efficiency eta_is(min=0,max=1)=1;
  Modelica.Blocks.Interfaces.RealOutput T2(unit="K") annotation (Placement(transformation(extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-10},{120,10}})));


  Interfaces.StateInput inletState(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-140,
            -20},{-100,20}}), iconTransformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput p2(unit="Pa") annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120}),                                                                                                                                                                                                        iconTransformation(extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,60})));

  SI.Temperature T1 = Medium.temperature(inletState.state);
  SI.Pressure p1 = Medium.pressure(inletState.state);
  SI.SpecificEnthalpy h1 = Medium.specificEnthalpy(inletState.state);
  SI.MassFraction Xi[Medium.nXi] = Medium.massFraction(inletState.state);
  SI.IsentropicExponent kappa = Medium.isentropicExponent(inletState.state);

  SI.Temperature T2_is;
  SI.SpecificEnthalpy h2_is;
  SI.SpecificEnergy wt_is;
  SI.SpecificEnergy wt;
  SI.SpecificEnthalpy h2;



algorithm
  T2_is := T1*(p2/p1)^((kappa-1)/kappa);
  h2_is := Medium.specificEnthalpy_pTX(
    p2,
    T2_is,
    Xi);
  wt_is := h2_is - h1;
  wt := wt_is/eta_is;
  h2 := h1 + wt;
  T2 := Medium.temperature_phX(p2, h2, Xi);

  annotation (Icon(graphics={
        Text(
          extent={{-150,-110},{150,-140}},
          textColor={0,0,0},
          textString="η = %eta_is"),
        Text(visible=displayInstanceName,
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-98,96},{98,-100}},
          textColor={28,108,200},
          textString="ideal gas
const kappa
compression")}));
end CompressorIsentropicEfficiencyConstKappa;
