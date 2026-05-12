within ThermofluidStream.Idealized.Examples.TUMExercisesThermodynamicCycles;
model Exercise6SteamPowerPlant "Exercise 8.6: Steam Power Plant [TUM2019]"
  extends Modelica.Icons.Example;

  replaceable package Medium = ThermofluidStream.Media.myMedia.Examples.TwoPhaseWater
    constrainedby
    ThermofluidStream.Media.myMedia.Interfaces.PartialMedium "Medium model"
    annotation(choicesAllMatching=true);

  parameter Medium.AbsolutePressure p_Condensor=5000 "Condensor pressure";
  parameter Medium.SpecificEnthalpy h_bubble = Medium.bubbleEnthalpy(Medium.setSat_p(p_Condensor)) "Bubble enthalpy at condensor pressure";

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true)
    annotation(Placement(transformation(extent={{100,80},{120,100}})));

  ThermofluidStream.Idealized.Processes.Adiabatic pump(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,

    p_out_fixed=2000000) annotation(Placement(transformation(extent={{-40,-20},{-60,0}})));
  ThermofluidStream.Idealized.Processes.Adiabatic turbine(
    redeclare package Medium = Medium,
    redeclare model ThermodynamicModel = ThermofluidStream.Idealized.Processes.Utilities.AdiabaticThermodynamicModels.Flow.FullMedium "Based on Medium.specificEntropy()",
    eta_fixed=0.889,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Adiabatic.OutletPressure,
    p_out_fixed=p_Condensor) annotation(Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,60})));
  ThermofluidStream.Idealized.Processes.Isobaric heater(
    redeclare package Medium = Medium,
    heatFlowSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    specifyOutlet=false) annotation(Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-70,20})));
  Sources.LoopBreaker_m loopBreaker(
    redeclare package Medium = Medium,
    m_flow_in_par=84.316,
    p_out_fixed(displayUnit="bar") = p_Condensor,
    thermalSpec=ThermofluidStream.Types.ThermalSpecification.SpecificEnthalpy,
    h_out_fixed=h_bubble) annotation(Placement(transformation(extent={{20,-20},{0,0}})));
  ThermofluidStream.Idealized.Processes.Isobaric condensor(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Isobaric.OutletSpecificEnthalpy,

    h_out_fixed=h_bubble) annotation(Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,20})));
  ThermofluidStream.Utilities.showRealValue efficiency(
    description="eta_th",
    use_numberPort=false,
    number=(-turbine.dh - pump.dh)/(heater.dh),
    displayVariable=false,
    significantDigits=3) annotation(Placement(transformation(extent={{20,-60},{40,-40}})));
  ThermofluidStream.Sensors.TwoPhaseSensorSelect vaporQualitySensor(
    displayInstanceName=true,
    redeclare package Medium = Medium,
    digits=2,
    quantity=ThermofluidStream.Sensors.Internal.Types.TwoPhaseQuantities.x_kgpkg)
    annotation(Placement(transformation(extent={{62,30},{82,50}})));
  ThermofluidStream.Utilities.showRealValue heaterOutletTemperature(
    description="T_4",
    use_numberPort=false,
    number=heater.outlet.state.T - 273.15,
    displayVariable=false,
    significantDigits=3) annotation(Placement(transformation(extent={{-100,-60},{-80,-40}})));
  ThermofluidStream.Utilities.showRealValue turbineOutletVaporQuality(
    description="x_5",
    use_numberPort=false,
    number=vaporQualitySensor.value,
    displayVariable=false,
    significantDigits=3) annotation(Placement(transformation(extent={{-60,-60},{-40,-40}})));
  ThermofluidStream.Utilities.showRealValue electricPower(
    description="P_el",
    use_numberPort=false,
    number=-turbine.P - pump.P,
    displayVariable=false,
    significantDigits=3) annotation(Placement(transformation(extent={{-20,-60},{0,-40}})));
  EnergyFlow.Sources.FixedEnergyFlow heatFlow(E_flow(displayUnit="MW") = 288000000) annotation(Placement(transformation(extent={{-112,10},{-92,30}})));
equation
  connect(heater.outlet, turbine.inlet)
    annotation(Line(
      points={{-70,30},{-70,80},{50,80},{50,70}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker.inlet, condensor.outlet)
    annotation(Line(
      points={{20,-10},{50,-10},{50,10}},
      color={28,108,200},
      thickness=0.5));
  connect(turbine.outlet, condensor.inlet)
    annotation(Line(
      points={{50,50},{50,30}},
      color={28,108,200},
      thickness=0.5));
  connect(loopBreaker.outlet, pump.inlet)
    annotation(Line(
      points={{0,-10},{-40,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(pump.outlet, heater.inlet)
    annotation(Line(
      points={{-60,-10},{-70,-10},{-70,10}},
      color={28,108,200},
      thickness=0.5));
  connect(vaporQualitySensor.inlet, turbine.outlet)
    annotation(Line(
      points={{62,40},{50,40},{50,50}},
      color={28,108,200},
      thickness=0.5));
  connect(heatFlow.E_flow_out, heater.Q_flow_in) annotation(Line(points={{-91,20},{-78,20}}, color={255,170,85}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-120,-80},{120,100}}), graphics={
        Text(
          extent={{44,-4},{50,-10}},
          textColor={28,108,200},
          textString="1"),
        Text(
          extent={{-70,-4},{-64,-10}},
          textColor={28,108,200},
          textString="2"),
        Text(
          extent={{-70,80},{-64,74}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{44,80},{50,74}},
          textColor={28,108,200},
          textString="4"),
        Text(
          extent={{44,42},{50,36}},
          textColor={28,108,200},
          textString="5")}),
    Documentation(revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>", info="<html>
  <p>
    Example of a steam power plant.
  </p>

  <h4>Problem description</h4>
  
  <p>
    Saturated liquid water (<code>32.90 degC</code>, <code>50.0 mbar</code>, <code>84.316 kg/s</code>) 
    is pumped in a reversible adiabatic feedwater <code>pump</code> to <code>20.0 bar</code>.
  </p>

  <p>
    In the isobaric <code>heater</code>, the water is heated, vaporized and superheated (<code>288 MW</code>).
    The <code>heater</code> is adiabatic on the outside.
  </p>

  <p>
    The steam is then expanded in the steam <code>turbine</code> (isentropic efficiency 
    <code>eta_is = 0.889</code>), condensed in the isobaric <code>condenser</code> and returned to the pump, closing the cycle.
  </p>
</html>"));
end Exercise6SteamPowerPlant;
