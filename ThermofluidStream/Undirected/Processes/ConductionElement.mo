within ThermofluidStream.Undirected.Processes;
model ConductionElement "Volume with quasisationary mass and heatport"
  extends Interfaces.SISOBiFlow(final clip_p_out=false);

  parameter SI.Volume V = 1 "Volume of the element";
  parameter SI.Area A = 1 "Contact area of element with medium";
  parameter SI.CoefficientOfHeatTransfer U = 200 "Heat transfer coefficient to medium";
  parameter Internal.InitializationMethodsCondElement init=Internal.InitializationMethodsCondElement.rear "Initialization method for h"
    annotation (Dialog(tab="Initialization", group="Enthalpy"));
  parameter SI.Temperature T_0 = Medium.T_default "Initial Temperature"
    annotation(Dialog(tab="Initialization", group="Enthalpy", enable=(init == Internal.InitializationMethodsCondElement.T)));
  parameter SI.SpecificEnthalpy h_0 = Medium.h_default "Initial specific enthalpy"
    annotation(Dialog(tab="Initialization", group="Enthalpy", enable=(init == Internal.InitializationMethodsCondElement.h)));
  parameter SI.Density rho_min = dropOfCommons.rho_min "Minimal density"
    annotation(Dialog(tab="Advanced"));
  parameter Boolean neglectPressureChanges = true "Neglect pressure changes in energy equation"
    annotation(Dialog(tab="Advanced"));
  parameter SI.MassFlowRate m_flow_reg = dropOfCommons.m_flow_reg "Regularization massflow to switch between positive- and negative-massflow model"
    annotation(Dialog(tab="Advanced"));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(Q_flow=Q_flow, T=T_heatPort)
    annotation (Placement(transformation(extent={{-10,88},{10,108}})));

  SI.SpecificEnthalpy h(start=Medium.h_default, stateSelect = StateSelect.prefer);

  Medium.ThermodynamicState state = Medium.setState_phX(p, h, Xi);
  SI.Temperature T = Medium.temperature(state);

protected
  SI.Pressure p = Undirected.Internal.regStep(   m_flow, p_rear_in, p_fore_in, m_flow_reg);
  Medium.MassFraction[Medium.nXi] Xi = Undirected.Internal.regStep(   m_flow, Xi_rear_in, Xi_fore_in, m_flow_reg);
  //h_in only in rhs of ODE--> h still smooth, better results at low massflow than using regStep
  SI.SpecificEnthalpy h_in = if m_flow >= 0 then h_rear_in else h_fore_in;

  SI.Density rho = max(rho_min, Medium.density(state));
  SI.SpecificEnthalpy h_out = Medium.specificEnthalpy(state);

  SI.Mass M;

  SI.Temperature T_heatPort;
  SI.HeatFlowRate Q_flow;

initial equation
  if init == Internal.InitializationMethodsCondElement.T then
     h = Medium.specificEnthalpy(Medium.setState_pTX(p, T_0, Xi));
  elseif init == Internal.InitializationMethodsCondElement.h then
     h = h_0;
  elseif init == Internal.InitializationMethodsCondElement.port then
     h = h_in;
  elseif init == Internal.InitializationMethodsCondElement.fore then
     h = h_fore_in;
   else
     h = h_rear_in;
   end if;

equation

  //mass is assumed to be quasisationary-> this violates the conservation of mass since m_flow_in = m_flow_out. see documentation/information
  M = V*rho;

  // in both equations Mass is assumed to be (quasi-)stationary-> assumption der(M*h) = M*der(h)
  // with that and V=const -> der(U) = der(H - pV) = M*der(h)- V*der(p) = Q_in + H_in - H_out
  if not neglectPressureChanges then
    M*der(h) = Q_flow + abs(m_flow)*(h_in - h_out) + V*der(p);
  else
    //neglegt V*der(p), since p might not be smooth -> to notice a difference der(p) must be about 1e7 Pa/s. see documentation/information
    M*der(h) = Q_flow + abs(m_flow)*(h_in - h_out);
  end if;

  Q_flow = U*A*(T_heatPort - T);

  //forwards model
  dp_fore = 0;
  h_fore_out = h;
  Xi_fore_out = Xi_rear_in;

  //rearwards model
  dp_rear = 0;
  h_rear_out = h;
  Xi_rear_out = Xi_fore_in;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
       Line(
         points={{-100,0},{100,0}},
         thickness=0.5,
         color={28,108,200}),
       Ellipse(
         extent={{-70,-70},{70,70}},
         lineColor={28,108,200},
         lineThickness=0.5,
         fillColor={170,213,255},
         fillPattern=FillPattern.Solid,
         pattern=LinePattern.Solid),
       Line(
         points={{-50,-30},{50,-30}},
         color={238,46,47}),
       Line(
         points={{-50,-15},{50,-15}},
         color={238,46,47}),
       Line(
         points={{-50,0},{50,0}},
         color={238,46,47}),
       Line(
         points={{-50,15},{50,15}},
         color={238,46,47}),
       Line(
         points={{-50,30},{50,30}},
         color={238,46,47}),
       Line(
         points={{0,100},{0,-30}},
         color={238,46,47})}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Undirected implementation of the Conduction Element.</p>
<p>This Model is a Element with a fixed volume (fig. 1). The Mass in the volume is assumed quasi-stationary (statically computed with volume and density), and the fore massflow is coupled to the rear massflow. <span style=\"color: #f47d23;\">Because of this the ConductionElement cannot be used as a loop beaker</span><span style=\"color: #b83d00;\">. </span>The advantage is that multiple ConductionElements can be put behind each other without worrying about oscilations or fast eigenvalues between their masses. The Conduction Element implements conservation of mass and energy equations for over the Fluid mass contained within it.</p>
<p>Different to the Unidirectional ConductionElement, the model for forward massflow (see fig. 1) is valid for both flow directions.</p>
<p>Additionally the undirected Conduction Element offers more initialization methods for h. Additionally to initialize T or h by a paramter, one can choose to initialize with the incoming enthalpy from either one of the twp ports, or use the correct one, depending on the massflow (option 'port'). The last option can leed to large nonlinear initalzation problems, we advice to choose the port to initialize h from if known in advance (options 'rear' or 'fore').
<p>The ConductionElement makes different assumptions:</p>
<ul>
<li>Quasistationary Mass:<br>m_flow_rear = - m_flow_fore &amp; M = rho * V (this assumption violates conservation of Mass for changing densities, since the mass in the element can change although inflow and outflow are the same)<br>der(H) = der(M*h) = M*der(h) (This assumption violates the conservation of Energy for changing densities, since then the mass M of fluid in the Element is no longer constant)</li>
<li>Neglection of der(p) in the energy equation<br>V*der(p) = 0 (this assumption violates the conservation of energy for changing pressures. For a noticable difference in the testcase the der(p) bist be in the order of 1e5 Pa/s). <br>This assumption can be turned off by setting neglectPressureChanges=false (true by default) in the Advanced tab. <span style=\"color: #f47d23;\">This option requires the fore and rear input pressures to be smooth.</span><br></li>
</ul>
<p><img width=\"500\" src=\"modelica://ThermofluidStream/Resources/Doku/ThermofluidStream.Processes.ConductionElement_positive.png\"/></p>
<p><span style=\"font-size: 12pt;\">fig. 1: positive massflow model</span></p>
</html>"));
end ConductionElement;
