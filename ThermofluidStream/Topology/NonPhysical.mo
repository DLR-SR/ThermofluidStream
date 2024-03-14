within ThermofluidStream.Topology;
package NonPhysical "Junctions and splitters with non-physical constraints"
  extends Modelica.Icons.VariantsPackage;

  model RatioControl "SplitterRatio in pressure drop mode"
    extends Internal.SplitterRatio(final mode = Internal.SplitterModes.pressureDrop);

    annotation (
      Documentation(info="<html>
<p>A splitter with prescribed split ratio that acts as a pressure control valve on both outlets. Pressure is reduced on the outlets in order to follow the mass-flow split prescription. </p>
<p>For reversed mass-flow the component might create work in form of increasing pressure of the fluid flowing from outlet to inlet. </p>
<p>For SplitterRatio and JunctionRatio make sure to only prescribe mass-flow-split in Splitter or Junction.</p>
</html>"));
  end RatioControl;

  model RTSwitch "SplitterRatio in full switch mode"
    extends Internal.SplitterRatio(final mode = Internal.SplitterModes.OneMinusS);

    annotation (
      Documentation(info="<html>
<p>A switch with a fixed split ratio that is intended as a switch between two paths. Therefore the input should be 1 or 0 for the most part. </p>
<p><br>Otherwise it will create work in the form of pressure on one of the two paths in order to fulfill the prescribed split ratio. </p>
<p>For SplitterRatio and JunctionRatio make sure to only prescribe mass-flow-split in Splitter or Junction.</p>
</html>"));
  end RTSwitch;

  model LeakageA "Leakage on path A to a lower pressure level"
    extends Internal.SplitterRatio(final mode = Internal.SplitterModes.A);

    annotation (
      Documentation(info="<html>
<p>A splitter with prescribed mass-flow split, that changes (increases or reduces) pressure on outletA in order to fulfull the mass-flow prescription. In case an increase of pressure is necessary for the mass-flow (or for reversed mass-flow), the component will create work in the form of increasing pressure on the A-path.</p>
<p>For SplitterRatio and JunctionRatio make sure to only prescribe mass-flow-split in Splitter or Junction.</p>
</html>"));
  end LeakageA;

  model JunctionRatio "Split-ratio Junction for a bypass"

    extends ThermofluidStream.Utilities.DropOfCommonsPlus;

    replaceable package Medium = Media.myMedia.Interfaces.PartialMedium "Medium model"
      annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));
    parameter Boolean assumeConstantDensity = true "= true, if mixture states are determined by mass flow rates"
      annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
    parameter SI.MassFlowRate m_flow_eps = dropOfCommons.m_flow_reg "Regularization threshold for small mass flows"
      annotation (Dialog(tab="Advanced"));
    parameter Utilities.Units.Inertance L=dropOfCommons.L "Inertance of each inlet/outlet"
      annotation (Dialog(tab="Advanced"));
    parameter SI.Time TC_input = 0.05 "Time constant";
    parameter Boolean invert = false "= true, if splitRatio input is inverted (1-splitRatio)"
      annotation(Evaluate=true, HideResult=true, choices(checkBox=true));

    Interfaces.Outlet outlet(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=180, origin={-100,0})));
    Interfaces.Inlet inletA(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=-90, origin={0,100})));
    Interfaces.Inlet inletB(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=180, origin={100,0})));

    Modelica.Blocks.Interfaces.RealInput splitRatio(min=0, max=1) annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={0,-30})));

    // these are needed by DynamicJunctionN
  protected
    Real w[2](each unit="1") "Regularized weighting factor for specific enthalpy";
    SI.Density rho[2] = {Medium.density(inletA.state),Medium.density(inletB.state)} "Density at inlets";


    SI.Pressure p[2] =  {Medium.pressure(inletA.state),Medium.pressure(inletB.state)} "(Steady mass flow) pressure at inlets";
    SI.Pressure r_in[2] "Inertial pressure at inlets";
    SI.SpecificEnthalpy h[2] =  {Medium.specificEnthalpy(inletA.state),Medium.specificEnthalpy(inletB.state)} "Specific enthapy at inlets";
    Medium.MassFraction Xi[Medium.nXi,2] "Mass factions at inlets";

    SI.Pressure p_mix "Outlet (steady mass flow) pressure";
    SI.Pressure r_mix "Outlet inertial pressure";
    SI.SpecificEnthalpy h_mix "Outlet specific enthalpy";
    Medium.MassFraction Xi_mix[Medium.nXi] "Outlet mass fractions";

    Real w2[2](each unit="1") "Regularized weighting factor for steady mass flow pressure";


    function mfk = Utilities.Functions.massFractionK(redeclare package Medium = Medium);

    Real splitRatioLim(unit="1");
    parameter Real eps(unit="1") = 1e-5 "Numerical minimal distance of input to 0 and 1";

  initial equation
    splitRatioLim = min(1-eps, max(eps, if invert then 1-splitRatio else splitRatio));

  equation
    inletA.m_flow + inletB.m_flow + outlet.m_flow = 0;

    der(inletA.m_flow) * L = inletA.r - r_in[1];
    der(inletB.m_flow) * L = inletB.r - r_in[2];
    der(outlet.m_flow) * L =  outlet.r - r_mix;

    // OM_WORKAROUND
    for j in 1:Medium.nXi loop
      Xi[j,1] = mfk(inletA.state, j);
      Xi[j,2] = mfk(inletB.state, j);
    end for;
    //instead of
    /* Xi[:,i] = Medium.massFraction(inlets[i].state); */

    //p[1] + r_in[2] = p_mix + r_mix;
    //p[2] + r_in[1] = p_mix + r_mix;


    // lowpass to disable input smoothness constraint
    der(splitRatioLim)* TC_input = min(1-eps, max(eps, if invert then 1-splitRatio else splitRatio)) - splitRatioLim;

    inletA.m_flow = -splitRatioLim*outlet.m_flow;
    r_mix = splitRatioLim*r_in[1] + (1-splitRatioLim)*r_in[2];

    w[1] = (abs(inletA.m_flow)+m_flow_eps) / (abs(inletA.m_flow)+abs(inletB.m_flow)+2*m_flow_eps);
    w[2] = (abs(inletB.m_flow)+m_flow_eps) / (abs(inletA.m_flow)+abs(inletB.m_flow)+2*m_flow_eps);
    w2[1] = ((abs(inletA.m_flow) + m_flow_eps)/rho[1]) / ((abs(inletA.m_flow)+m_flow_eps)/rho[1]+(abs(inletB.m_flow)+m_flow_eps)/rho[2]);
    w2[2] = ((abs(inletB.m_flow) + m_flow_eps)/rho[2]) / ((abs(inletA.m_flow)+m_flow_eps)/rho[1]+(abs(inletB.m_flow)+m_flow_eps)/rho[2]);

    if not assumeConstantDensity then
      p_mix = sum(w2.*p);
    else
      p_mix = sum(w.*p);
    end if;
    h_mix = sum(w.*h);
    Xi_mix = Xi*w;

    outlet.state = Medium.setState_phX(p_mix,h_mix,Xi_mix);

    annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
          Text(visible=displayInstanceName,
            extent={{-150,65},{150,25}},
            textString="%name",
            textColor=dropOfCommons.instanceNameColor),
          Line(visible= not displayInstanceName,
            points={{0,0},{0,100}},
            color={28,108,200},
            thickness=0.5),
          Line(visible= displayInstanceName,
            points={{0,0},{0,20}},
            color={28,108,200},
            thickness=0.5),
          Line(visible= displayInstanceName,
            points={{0,70},{0,100}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-100,0},{100,0}},
            color={28,108,200},
            thickness=0.5),
          Ellipse(
            extent={{-6,6},{6,-6}},
            lineColor={28,108,200},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid,
            lineThickness=0.5),
          Text(
            extent={{20,120},{60,80}},
            textColor={175,175,175},
            textString="A"),
          Text(
            extent={{80,-20},{120,-60}},
            textColor={175,175,175},
            textString="B")}),
      Diagram(coordinateSystem(preserveAspectRatio=true)),
      Documentation(info="<html>
<p>A junction with a fixed mass-flow split. It can be understood to use energy of the higher-pressure inlet to pull the lower-pressure stream (likely to dynamic pressure effects).</p>
<p>For SplitterRatio and JunctionRatio make to only prescribe mass-flow-split in Splitter or Junction.</p>
</html>"));
  end JunctionRatio;

  annotation (Documentation(info="<html>
<p>This package contains topology elements that have non-physical assumptions or constraints like mass-flow splits. </p>
<p>Although they are non-physical they can be used to model certain behavior like a leakage or mass-flow-split controlled junction-valve combinations and simplify the model by not explicitly modeling the phenomena like a controlled valve.</p>
<p>For SplitterRatio and JunctionRatio make to only prescribe mass-flow-split in Splitter <u><strong>or</strong></u> Junction.</p>
</html>"));
end NonPhysical;
