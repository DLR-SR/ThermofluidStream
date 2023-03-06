within ThermofluidStream.Utilities;
block showRealValue
  "Show Real value from numberPort or from number input field in diagram layer dynamically"
  parameter Boolean use_numberPort = true "= true, if numberPort enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter String description = "" "Add description (in quotes!)";
  input Real number = 0.0
    "Number to visualize if use_numberPort=false (time varying)"
    annotation(Dialog(enable=not use_numberPort), HideResult=true);
  parameter Integer significantDigits(min=1) = 2
    "Number of significant digits to be shown";

  Modelica.Blocks.Interfaces.RealInput numberPort if use_numberPort "Number to be shown in diagram layer if use_numberPort = true [variable]"
    annotation (HideResult=true,Placement(transformation(extent={{-130,-15},{-100,15}})));
  Modelica.Blocks.Interfaces.RealOutput showNumber "Number shown on screen [variable]";

equation
  if use_numberPort then
     connect(numberPort, showNumber);
  else
     showNumber = number;
  end if;

  annotation (Icon(
      coordinateSystem(preserveAspectRatio=false,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Text(extent={{-94.0,-34.0},{96.0,34.0}},
          lineColor={28,108,200},
          textString=DynamicSelect("0.0", String(showNumber, significantDigits=significantDigits))), Text(
          extent={{-52,76},{54,28}},
          lineColor={28,108,200},
          textString="%description")}),
    Documentation(info="<html>
<p>
This block visualizes a Real number in a diagram animation.
The number to be visualized can be defined in the following ways:
</p>

<ul>
<li> If useNumberPort = <strong>true</strong> (which is the default), a Real
     input is present and this input variable is shown.</li>

<li> If useNumberPort = <strong>false</strong> no input connector is present.
     Instead, a Real input field is activated in the parameter menu
     and the Real expression from this input menu is shown.</li>
</ul>

<p>
The two versions of the block are shown in the following image (in the right variant, the
name of the variable value that is displayed is also shown below the icon):
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Interaction/RealValue.png\"
     alt=\"RealValue.png\">
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.RealNetwork1\">Modelica.Blocks.Examples.RealNetwork1</a>.
</p>
</html>"));
end showRealValue;
