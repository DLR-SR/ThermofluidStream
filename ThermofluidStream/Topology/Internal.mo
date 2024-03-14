within ThermofluidStream.Topology;
package Internal
  extends Modelica.Icons.InternalPackage;

  model SplitterRatio "Splits a flow into two subflows with prescribed ratio"

    extends ThermofluidStream.Utilities.DropOfCommonsPlus;

    replaceable package Medium = ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
      annotation (choicesAllMatching=true, Documentation(info="<html>
<p>Medium package used in the Component. Make sure it is the same one as all the components connected to all fluid ports are using. </p>
</html>"));
    parameter ThermofluidStream.Utilities.Units.Inertance L=dropOfCommons.L "Inertance of each inlet/outlet"
      annotation (Dialog(tab="Advanced"));

    parameter SI.Time TC = 0.1 "Time constant for RT massflow constraint"
      annotation(Dialog(tab="Advanced"));
    parameter SI.AbsolutePressure p_reg = 1e2 "Regularizaion pressure for pressure drop calculation"
      annotation(Dialog(tab="Advanced"));
    parameter SI.Density rho_min=dropOfCommons.rho_min "Minimum density"
      annotation(Dialog(tab="Advanced"));

    parameter SplitterModes mode = SplitterModes.pressureDrop "Splitter mode (see Documentation)";
    parameter Boolean invert = false "= true, if splitRatio input is inverted (1-splitRatio)"
      annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
    parameter SI.Time TC_input = 0.05 "Time constant for splitRatio input (PT1)"
      annotation(Dialog(tab="Advanced"));
    parameter SI.Power P_thresh = 1 "Power threshold for warning"
      annotation(Dialog(tab="Advanced"));

    ThermofluidStream.Interfaces.Inlet inlet(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
    ThermofluidStream.Interfaces.Outlet outletA(redeclare package Medium = Medium) annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={0,100})));
    ThermofluidStream.Interfaces.Outlet outletB(redeclare package Medium = Medium) annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=0,
          origin={100,0})));

    Modelica.Blocks.Interfaces.RealInput splitRatio(min=0, max=1) annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={0,-30})));

    SI.SpecificVolume v_in = 1/max(Medium.density(inlet.state), rho_min) "Inlet specific volume";
    SI.SpecificVolume v_A = 1/max(Medium.density(outletA.state), rho_min) "Outlet A specific volume";
    SI.SpecificVolume v_B = 1/max(Medium.density(outletB.state), rho_min) "Outlet B specific volume";

    SI.Power P_A = (v_in+v_A)/2*(-outletA.m_flow)*(p_A-p_in) "Loss in enthalpy flow rate (A)";
    SI.Power P_B = (v_in+v_B)/2*(-outletB.m_flow)*(p_B-p_in) "Loss in enthalpy flow rate (B)";

  protected
    SI.AbsolutePressure dp(stateSelect=StateSelect.always, start=0, fixed=true);
    SI.AbsolutePressure p_A "Outlet A pressure";
    SI.AbsolutePressure p_B "Outlet B pressure";

    SI.Pressure r_I;
    SI.Pressure r_A "Outlet A inertial pressure";
    SI.Pressure r_B "Outlet B inertial pressure";

    SI.Pressure r_corr_A;
    SI.Pressure r_corr_B;

    SI.AbsolutePressure p_in = Medium.pressure(inlet.state) "Inlet pressure";
    SI.SpecificEnthalpy h_in = Medium.specificEnthalpy(inlet.state) "Inlet specific enthalpy";
    SI.MassFraction Xi_in[Medium.nXi] = Medium.massFraction(inlet.state) "Inlet mass fractions";

    Real splitRatioLim(unit="1");
    parameter Real eps(unit="1") = 1e-5 "Numerical minimal distance of input to 0 and 1";

    parameter SI.AbsolutePressure p_min = dropOfCommons.p_min;

  initial equation
    splitRatioLim = min(1-eps, max(eps, if invert then 1-splitRatio else splitRatio));

  equation
    assert(P_A < P_thresh,
      "Splitter enforces mass flow constraint by artificially increasing pressure on outlet A",
      AssertionLevel.warning);

    assert(P_B < P_thresh,
      "Splitter enforces mass flow constraint by artificially increasing pressure on outlet B",
      AssertionLevel.warning);

    //conservation of mass
    inlet.m_flow + outletA.m_flow + outletB.m_flow = 0;

    // inertances on input and output paths
    der(inlet.m_flow) * L = inlet.r - r_I;
    der(outletA.m_flow) * L = outletA.r - r_A;
    der(outletB.m_flow) * L = outletB.r - r_B;

    // lowpass to disable input smoothness constraint
    der(splitRatioLim)* TC_input = min(1-eps, max(eps, if invert then 1-splitRatio else splitRatio)) - splitRatioLim;

    //these replace the standard two r_out=r_in equations. see Zimmer: Real-Time Simulation of an Aircraft Electric Driven Environmental Control System for Virtual Testing Purposes Sec 3.4
    splitRatioLim*inlet.m_flow = -outletA.m_flow;
    r_I = splitRatioLim*r_A + (1-splitRatioLim)*r_B;

    // integration of pressure so r->0 with anti-windup, when a output pressure is in lower bound
    der(dp) * TC = r_B - r_A +1* (r_corr_A-r_corr_B);

    // set output pressures depending on splitter mode. see doku.
    if mode == SplitterModes.A then
      p_A = p_in - dp;
    elseif mode == SplitterModes.B then
      p_A = p_in;
    elseif mode == SplitterModes.OneMinusS then
      p_A = p_in- (1-splitRatioLim)*dp;
    else
      // apply dp fully to one side (regularized), such that pressure increase never happens
      p_A = ThermofluidStream.Undirected.Internal.regStep(dp, p_in - dp, p_in, p_reg);
    end if;
    p_B = p_A + dp;

    // for anti-windwup of dp when p_out is clipped
    r_corr_A = p_A - Medium.pressure(outletA.state);
    r_corr_B = p_B - Medium.pressure(outletB.state);

    outletA.state = Medium.setState_phX(p= max(p_min,p_A), h=h_in, X=Xi_in);
    outletB.state = Medium.setState_phX(p= max(p_min,p_B), h=h_in, X=Xi_in);

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true), graphics={
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
            extent={{-60,120},{-20,80}},
            textColor={175,175,175},
            textString="A"),
          Text(
            extent={{80,-20},{120,-60}},
            textColor={175,175,175},
            textString="B")}),
      Diagram(coordinateSystem(preserveAspectRatio=true)),
      Documentation(info="<html>
<p><br>Splitter, that uses a directly set split ratio. In order to have stationary r that goes to zero, a pressure difference between outlet A and B is calculated, that is applied to one of the outlets, until r-&gt;0.</p><p><br>The idear builds on the splitter with an enforeced regime of Zimmer Real-Time&nbsp;Simulation&nbsp;of&nbsp;an&nbsp;Aircraft&nbsp;Electric&nbsp;Driven&nbsp;Environmental&nbsp;Control&nbsp;System&nbsp;for&nbsp;Virtual&nbsp;Testing&nbsp;Purposes&nbsp;Sec&nbsp;3.4</p>
<p><img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Topology.Internal.SplitterRatio.PNG\"/><img src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Topology.Internal.SplitterRatio2.PNG\"/></p>
</html>"));
  end SplitterRatio;

  type SplitterModes = enumeration(
      A "Port A",
      B "Port B",
      OneMinusS "1-s",
      pressureDrop "Pressure Drop")
      "Choices for the pressure drop behavior of SplitterRatio";
end Internal;
