within ThermofluidStream.Processes.Sources.Tests.Utilities;
model CompressorIsentropicEfficiencyConstCp
  "Analytic Solution for compression of ideal gas with given constant kappa, isentropic efficiency, inlet and outlet pressure"

  extends Modelica.Blocks.Icons.Block;

  parameter Real eta_is(min=0,max=1)=1;
  Modelica.Blocks.Interfaces.RealOutput T2(unit="K") annotation (Placement(transformation(extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-10},{120,10}})));

  SI.SpecificEnergy wt_is;
  SI.SpecificEnergy wt;
  SI.Temperature T2_is;
  Modelica.Blocks.Interfaces.RealInput kappa annotation (Placement(transformation(extent={{-140,40},{-100,80}}),   iconTransformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput cp annotation (Placement(transformation(extent={{-140,0},{-100,40}}),    iconTransformation(extent={{-140,0},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput p1(unit="Pa") annotation (Placement(transformation(extent={{-140,-40},{-100,0}}), iconTransformation(extent={{-140,-40},{-100,0}})));
  Modelica.Blocks.Interfaces.RealInput p2(unit="Pa") annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120}),                                                                                                                                                                                                        iconTransformation(extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,60})));
  Modelica.Blocks.Interfaces.RealInput T1(unit="K") annotation (Placement(transformation(extent={{-140,-80},{-100,-40}}),
                                                                                                                        iconTransformation(extent={{-140,-80},{-100,-40}})));
algorithm
  T2_is := T1*(p2/p1)^((kappa-1)/kappa);
  wt_is :=cp*(T2_is - T1);
  wt :=wt_is/eta_is;
  T2 :=T1 + wt/cp;

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
const cp
compression")}), Documentation(info="<html>
<p>
In contrast to <a href=\"modelica://ThermofluidStream.Processes.Sources.IdealGasConstantKappa\">IdealGasConstantKappa</a> this model assumes constant isobaric heat capacity <code>c_p = const</code>.
</p>
</html>"));
end CompressorIsentropicEfficiencyConstCp;
