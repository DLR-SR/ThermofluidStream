within ThermofluidStream.Utilities;
block RealVector "Set output vector signal to a time varying Real expression"

  parameter Integer N = 1 "Size of signal";

  Modelica.Blocks.Interfaces.RealOutput y[N](each unit="1")=zeros(N) "Value of Real output vector"
    annotation (Dialog(group="Time varying output vector"), Placement(
        transformation(extent={{100,-10},{120,10}})));

  annotation (Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,40},{100,-40}},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised),
        Text(
          extent={{-96,15},{96,-15}},
          textString="%y"),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
</html>"));

end RealVector;
