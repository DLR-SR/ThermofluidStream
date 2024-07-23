within ThermofluidStream.Undirected.FlowControl;
model SpecificValveType "Specific technical valve types"

  extends ThermofluidStream.Undirected.FlowControl.Internal.PartialValve;

  import FlowCoeffType = ThermofluidStream.FlowControl.Internal.Types.FlowCoefficientTypes;

  replaceable record ZetaValueRecord =
    ThermofluidStream.FlowControl.Internal.Curves.SlideValveZetaCurve
    constrainedby ThermofluidStream.FlowControl.Internal.Curves.PartialCharacteristicZetaCurves "Select valve type"
    annotation(choicesAllMatching = true, Dialog(group = "Valve parameters"));

  parameter FlowCoeffType flowCoefficient = FlowCoeffType.Kvs "Select type of flow coefficient"
    annotation(Dialog(group = "Valve parameters"));
  //Reference Values
  parameter Real Kvs(unit = "m3/h") = 0 "Kvs-value (metric) from data sheet (valve fully open)"
    annotation(Dialog(group = "Valve parameters",enable = (flowCoefficient ==FlowCoeffType.Kvs)));
  parameter Real Cvs_US = 0 "Cvs-value (US [gal/min]) from data sheet (valve fully open)"
    annotation(Dialog(group = "Valve parameters",enable = (flowCoefficient ==FlowCoeffType.Cvs_US)));
  parameter Real Cvs_UK = 0 "Cvs-value (UK [gal/min]) from data sheet (valve fully open)"
    annotation(Dialog(group = "Valve parameters",enable = (flowCoefficient ==FlowCoeffType.Cvs_UK)));
  parameter SI.MassFlowRate m_flow_ref_set = 0 "Reference mass flow rate"
    annotation(Dialog(group = "Valve parameters",enable = (flowCoefficient ==FlowCoeffType.m_flow_set)));
  //Set valve data as parameter
  parameter SI.Diameter d_valve = 0 "Flow diameter"
    annotation (Dialog(group="Valve parameters", enable=(flowCoefficient== FlowCoeffType.flowDiameter)));

protected
  constant ZetaValueRecord valveData;
  final parameter SI.Area A_valve=0.25*Modelica.Constants.pi*d_valve^2 "Cross-sectional valve area";

  Real k_u(unit="1") "Kv/Kvs, respecting flow characteristics";
  Real k_u_zeta(unit="1") "Kv/Kvs respecting zeta curve";

  Modelica.Blocks.Tables.CombiTable1Ds combiTable1D_zeta(
  final smoothness = Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative1,
  final tableOnFile = false,
  final table = valveData.zetaTable) "Interpolation of pressure loss coefficient datapoints";

  Real zeta(unit="1", start = 0) "Pressure loss coefficient";
  final parameter Real zeta1(unit="1") = valveData.zetaTable[end,2] "Pressure loss coefficient for fully opened valve";

  final parameter SI.VolumeFlowRate V_flow_ref=
    if flowCoefficient == FlowCoeffType.Kvs then Kvs/secondsPerHour
    elseif flowCoefficient == FlowCoeffType.Cvs_US then (Cvs_US/1.1561)/secondsPerHour
    elseif flowCoefficient == FlowCoeffType.Cvs_UK then (Cvs_UK/0.9626)/secondsPerHour
    elseif flowCoefficient == FlowCoeffType.flowDiameter then A_valve*sqrt((2/zeta1)*(dp_ref/rho_ref))
    else m_flow_ref_set/rho_ref "Reference volume flow rate";

initial equation
  //this if clause shall ensure that valid parameters have been entered
  if flowCoefficient == FlowCoeffType.Kvs then
    assert(Kvs > 0, "Invalid coefficient for Kvs. Default value 0 shall not be used", level=AssertionLevel.error);
  elseif flowCoefficient == FlowCoeffType.Cvs_US then
    assert(Cvs_US > 0, "Invalid coefficient for Cvs_US. Default value 0 shall not be used", level=AssertionLevel.error);
  elseif flowCoefficient == FlowCoeffType.Cvs_UK then
    assert(Cvs_UK > 0, "Invalid coefficient for Cvs_UK. Default value 0 shall not be used", level=AssertionLevel.error);
  elseif flowCoefficient == FlowCoeffType.flowDiameter then
    assert(d_valve > 0, "Invalid coefficient for d_valve. Default value 0 (or negative value) shall not be used", level=AssertionLevel.error);
  else
    assert(m_flow_ref_set > 0, "Invalid coefficient for m_flow_ref_set. Default value 0 (or negative value) shall not be used", level=AssertionLevel.error);
  end if;

  //Calculate reference mass flow rate from reference volume flow rate
  m_flow_ref = V_flow_ref*rho_ref;

equation

  //Retrieving pressure loss coefficient from input
  combiTable1D_zeta.u = u;
  zeta = combiTable1D_zeta.y[1];

  //Evaluate characteristic for given pressure loss curve
  k_u_zeta = sqrt(zeta1/zeta);

  k_u = k_min + (1 - k_min)*k_u_zeta;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
        Line(
          points={{-84,0},{-40,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{40,0},{-40,0}},
          color={28,108,200},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Line(
          points={{0,0},{0,60}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{40,0},{84,0}},
          color={28,108,200},
          thickness=0.5),
        Polygon(
          points={{-20,40},{0,0},{20,40},{-20,40}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor=DynamicSelect({255,255,255}, if invertInput == true then
                  {28,108,200} else {255,255,255}),
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,20},{0,-20},{20,20},{-20,20}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor=DynamicSelect({255,255,255}, if invertInput == true then
                  {28,108,200} else {255,255,255}),
          fillPattern=FillPattern.Solid,
          origin={0,-20},
          rotation=180)}), Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>Undirected implementation of the specific valve type.</p>
<p>This valve models the behavior of specific valve types.</p>
<p><br>The technical type of the valve can be chosen (e.g. sliding valve). The characteristic curve is then set accordingly from a table for the zeta (flow resistance) values dependent on the valve opening.</p>
<p><br>To conclude the parameterization, a flow coefficient has to be set. Most data sheets of valves deliver a corresponding &quot;KVs (CVs)&quot;-Value. Otherwise a nominal mass-flow rate or a flow-diameter can be set. </p>
<p>For incompressible flow, the reference values for density (1g/cm3) and pressure (1bar) should be unchanged.</p>
</html>"));
end SpecificValveType;
