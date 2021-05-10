within ThermofluidStream.Undirected.Boundaries;
model PhaseSeperator "Parent to Reciever and Accumulator models"
  extends Internal.PartialVolume(
    redeclare replaceable package Medium =
        myMedia.Interfaces.PartialTwoPhaseMedium,
    useHeatport=false,
    final useRear=true,
    final useFore=true,
    final initialize_energy=false,
    final T_start=0,
    final h_start = 0,
    final use_hstart=false);

  import Init = ThermofluidStream.Boundaries.Internal.InitializationMethodsPhaseSeperator;

  parameter SI.Volume V_par(displayUnit="l")=0.01 "Volume of phase seperator";
  parameter Real pipe_low(unit="1", min=0, max=1) "Low end of pipe";
  parameter Real pipe_high(unit="1", min=0, max=1) "High end of pipe";
  parameter Boolean density_derp_h_from_media = false "EXPERIMENTAL: get density_derp_h from media model. The function is only implemented for some Media."
    annotation(Dialog(tab="Advanced", group="Damping", enable=(k_volume_damping > 0)));
  parameter SI.DerDensityByPressure density_derp_h_set = 1e-6 "Derivative of density by pressure estimation; Approx. 1e-5 for air, 1e-7 for water"
    annotation(Dialog(enable = ((k_volume_damping > 0) and not density_derp_h_from_media), tab="Advanced", group="Damping"));
  parameter Init init_method = ThermofluidStream.Boundaries.Internal.InitializationMethodsPhaseSeperator.l "Initialization Method"
    annotation(choicesAllMatching=true, Dialog(tab="Initialization"));
  parameter SI.SpecificEnthalpy h_0 = Medium.h_default "Initial specific enthalpy"
    annotation(Dialog(tab="Initialization", enable=(init_method==Init.h)));
  parameter SI.Mass M_0 = 1 "Initial Mass"
    annotation(Dialog(tab="Initialization", enable=(init_method==Init.M)));
  parameter Real l_0(unit="1", min=0, max=1) = 0.5 "Initial liquid level"
    annotation(Dialog(tab="Initialization", enable=(init_method==Init.l)));
  parameter Real x_0(unit="kg/kg", min=0, max=1) = 0.5 "Initial vapor quality"
    annotation(Dialog(tab="Initialization", enable=(init_method==Init.x)));

  //Variables to calculate h_pipe
  Real liquid_level(unit="1") "level of liquid line";
  Real liquid_level_pipe(unit="1") "level of liquid line in pipe";

protected
  Medium.MassFraction x = (medium.h-h_bubble)/(h_dew - h_bubble) "Calculated quality of medium that can go below zero and above one";

  SI.SpecificEnthalpy h_pipe;

  SI.Density d_liq = Medium.bubbleDensity(Medium.setSat_p(medium.p)) "bubble density at saturation";
  SI.Density d_gas = Medium.dewDensity(Medium.setSat_p(medium.p)) "dew density at saturation";

  SI.SpecificEnthalpy h_bubble = Medium.bubbleEnthalpy(Medium.setSat_p(medium.p))-1 "Bubble Enthalpy of Medium";
  SI.SpecificEnthalpy h_dew = Medium.dewEnthalpy(Medium.setSat_p(medium.p))+1 "Dew Enthalpy of Medium";

  Modelica.Blocks.Interfaces.RealInput tmp_dddp(unit="s2/m2") = Medium.density_derp_h(medium.state) if density_derp_h_from_media;
  Modelica.Blocks.Interfaces.RealOutput tmp2_dddp(unit="s2/m2");

initial equation
  if init_method == Init.h then
    medium.h = h_0;
  elseif init_method == Init.M then
    x/d_gas+(1-x)/d_liq  = V/M_0;
    assert(x>=0 and x<=1, "Initialization by Mass might be inaccurate outside the two-phase region", AssertionLevel.warning);
  elseif init_method == Init.l then
    x = (d_gas*(1-l_0))/(d_liq*l_0+d_gas*(1-l_0));
  elseif init_method == Init.x then
    x = x_0;
  end if;

equation
  //this workaround is necessary, because the method density_derp_h is not implemented in all media, and therefore has to be removed conditionally when not implemented"
  connect(tmp_dddp, tmp2_dddp);
  if density_derp_h_from_media then
    density_derp_h = tmp2_dddp;
  else
    density_derp_h = density_derp_h_set;
    tmp2_dddp = 0;
  end if;

  V = V_par;
  W_v = 0;

  liquid_level = max(0, min(1, M*(1-x)/d_liq/V));
  liquid_level_pipe = max(0, min(1, (liquid_level-pipe_low)/(pipe_high-pipe_low)));

  h_pipe = smooth(1,
  if x < 0 then medium.h
  elseif x <= 1 then liquid_level_pipe*h_bubble + (1-liquid_level_pipe)*h_dew
  else medium.h);
  state_out = Medium.setState_phX(medium.p, h_pipe, medium.Xi);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
                            Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This is the partial parent class for all unidirectional volumes with only one inlet and outlet. It is partial and is missing one equation for its volume or the medium pressure and one the volume work performed.</p>
<p>Conceptually a Volume is a Sink and a Source. It therefore defines the Level of inertial pressure r in a closed loop and acts as a Loop breaker.</p>
</html>"));
end PhaseSeperator;
