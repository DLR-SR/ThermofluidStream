within ThermofluidStream.Undirected.Boundaries;
model PhaseSeparator "Base model for receiver and accumulator models"
  extends Internal.PartialVolume(
    redeclare replaceable package Medium =
        Media.myMedia.Interfaces.PartialTwoPhaseMedium,
    useHeatport=false,
    final useRear=true,
    final useFore=true,
    final initialize_energy=false,
    final T_start=0,
    final h_start=0,
    final use_hstart=false);

  import Init = ThermofluidStream.Boundaries.Internal.InitializationMethodsPhaseSeperator;

  parameter SI.Volume V_par(displayUnit="l")=0.01 "Volume";
  parameter Real pipe_low(unit="1", min=0, max=1) "Low end of pipe";
  parameter Real pipe_high(unit="1", min=0, max=1) "High end of pipe";
  parameter Boolean density_derp_h_from_media=false "= true, if the derivative of density by pressure at const specific enthalpy is calculated from media model (only available for some media models)"
     annotation(Dialog(tab="Advanced", group="Damping", enable=(k_volume_damping > 0)),Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.DerDensityByPressure density_derp_h_set = 1e-6 "Derivative of density by pressure at const specific enthalpy set value (e.g approx. 1e-5 for air, 1e-7 for water)"
     annotation(Dialog(enable = ((k_volume_damping > 0) and not density_derp_h_from_media), tab="Advanced", group="Damping"));
  parameter Init init_method = ThermofluidStream.Boundaries.Internal.InitializationMethodsPhaseSeperator.l "Initialization Method"
    annotation(Dialog(tab="Initialization"));
  parameter SI.SpecificEnthalpy h_0 = Medium.h_default "Initial value for specific enthalpy"
    annotation(Dialog(tab="Initialization", enable=(init_method==Init.h)));
  parameter SI.Mass M_0 = 1 "Initial mass"
    annotation(Dialog(tab="Initialization", enable=(init_method==Init.M)));
  parameter Real l_0(unit="1", min=0, max=1) = 0.5 "Initial liquid level"
    annotation(Dialog(tab="Initialization", enable=(init_method==Init.l)));
  parameter Real x_0(unit="kg/kg", min=0, max=1) = 0.5 "Initial vapor quality"
    annotation(Dialog(tab="Initialization", enable=(init_method==Init.x)));

  //Variables to calculate h_pipe
  Real liquid_level(unit="1") "Level of liquid line";
  Real liquid_level_pipe(unit="1") "Level of liquid line in pipe";

protected
  Medium.MassFraction x = (medium.h-h_bubble)/(h_dew - h_bubble) "Calculated quality of medium that can go below zero and above one";

  SI.SpecificEnthalpy h_pipe;

  SI.Density d_liq = Medium.bubbleDensity(Medium.setSat_p(medium.p)) "Bubble density at saturation";
  SI.Density d_gas = Medium.dewDensity(Medium.setSat_p(medium.p)) "Dew density at saturation";

  SI.SpecificEnthalpy h_bubble = Medium.bubbleEnthalpy(Medium.setSat_p(medium.p))-1 "Bubble specific enthalpy of Medium";
  SI.SpecificEnthalpy h_dew = Medium.dewEnthalpy(Medium.setSat_p(medium.p))+1 "Dew specific enthalpy of Medium";

initial equation
  assert(pipe_high > pipe_low, "Upper pipe end must be higher then lower end.", AssertionLevel.error);

  if init_method == Init.h then
    medium.h = h_0;
  elseif init_method == Init.M then
    x/d_gas+(1-x)/d_liq = V/M_0;
    assert(x>=0 and x<=1, "Initialization by mass might be inaccurate outside the two-phase region", AssertionLevel.warning);
  elseif init_method == Init.l then
    x = (d_gas*(1-l_0))/(d_liq*l_0+d_gas*(1-l_0));
  elseif init_method == Init.x then
    x = x_0;
  end if;

equation
  if density_derp_h_from_media then
    density_derp_h = Medium.density_derp_h(medium.state);
  else
    density_derp_h = density_derp_h_set;
  end if;

  V = V_par;
  W_v = 0;

  liquid_level = max(0, min(1, M*(1-x)/d_liq/V));
  liquid_level_pipe = max(0, min(1, (liquid_level-pipe_low)/(pipe_high-pipe_low)));

  h_pipe = smooth(1,
  if x < 0 then medium.h
  elseif x <= 1 then liquid_level_pipe*h_bubble + (1-liquid_level_pipe)*h_dew
  else medium.h);

  state_out_fore = Medium.setState_phX(medium.p, h_pipe, medium.Xi);
  state_out_rear = state_out_fore;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true),graphics={
       Text(visible=displayInstanceName,
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor=dropOfCommons.instanceNameColor)}),
                            Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p>This Volume is the parent class for Accumulator and Receiver models that separate the two phases and are able to output gas, liquid or two-phase medium, depending on its liquid level and the height of the outlet. </p>
<p>Since there is no formula to compute density_derp_h for this volume, an upper bound has to be set in the parameter density_derp_h_set. Alternativeley the derivative can be taken from the media model for all the media that implement the corresponding formula by setting density_derp_h_from_media=true (default:false).</p>
</html>"));
end PhaseSeparator;
