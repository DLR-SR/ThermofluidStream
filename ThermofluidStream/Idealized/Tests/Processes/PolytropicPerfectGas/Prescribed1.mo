within ThermofluidStream.Idealized.Tests.Processes.PolytropicPerfectGas;
model Prescribed1
  extends ThermofluidStream.Idealized.Tests.Processes.PolytropicPerfectGas.PartialPrescribed;

  inner ThermofluidStream.DropOfCommons dropOfCommons(displayInstanceNames=true, displayParameters=true) annotation(
    Placement(transformation(extent={{286,194},{306,214}})));

  ThermofluidStream.Boundaries.Source source(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-270,180},{-250,200}})));
  .ThermofluidStream.Boundaries.Sink_m sink(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-210,180},{-190,200}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas dp_eta_pol(
    redeclare package Medium = Medium,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-240,180},{-220,200}})));
  ThermofluidStream.Boundaries.Source source1(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-270,130},{-250,150}})));
  .ThermofluidStream.Boundaries.Sink_m sink1(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-210,130},{-190,150}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas pRatio_eta_pol(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-240,130},{-220,150}})));
  ThermofluidStream.Boundaries.Source source2(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-270,80},{-250,100}})));
  .ThermofluidStream.Boundaries.Sink_m sink2(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-210,80},{-190,100}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas p_out_eta_pol(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-240,80},{-220,100}})));
  ThermofluidStream.Boundaries.Source source3(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-270,30},{-250,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink3(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-210,30},{-190,50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas T_out_eta_pol(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-240,30},{-220,50}})));
  ThermofluidStream.Boundaries.Source source4(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-270,-20},{-250,0}})));
  .ThermofluidStream.Boundaries.Sink_m sink4(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-210,-20},{-190,0}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_eta_pol(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-240,-20},{-220,0}})));
  ThermofluidStream.Boundaries.Source source5(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-270,-70},{-250,-50}})));
  .ThermofluidStream.Boundaries.Sink_m sink5(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-210,-70},{-190,-50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_eta_pol(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletDensity,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-240,-70},{-220,-50}})));
  ThermofluidStream.Boundaries.Source source6(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-270,-120},{-250,-100}})));
  .ThermofluidStream.Boundaries.Sink_m sink6(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-210,-120},{-190,-100}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_eta_pol(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletSpecificVolume,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-240,-120},{-220,-100}})));
  ThermofluidStream.Boundaries.Source source7(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-160,180},{-140,200}})));
  .ThermofluidStream.Boundaries.Sink_m sink7(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-100,180},{-80,200}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas dp_n(
    redeclare package Medium = Medium,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.PolytropicExponent,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-130,180},{-110,200}})));
  ThermofluidStream.Boundaries.Source source8(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-160,130},{-140,150}})));
  .ThermofluidStream.Boundaries.Sink_m sink8(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-100,130},{-80,150}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas pRatio_n(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.PolytropicExponent,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-130,130},{-110,150}})));
  ThermofluidStream.Boundaries.Source source9(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-160,80},{-140,100}})));
  .ThermofluidStream.Boundaries.Sink_m sink9(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas p_out_n(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.PolytropicExponent,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-130,80},{-110,100}})));
  ThermofluidStream.Boundaries.Source source10(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-160,30},{-140,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink10(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas T_out_n(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.PolytropicExponent,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-130,30},{-110,50}})));
  ThermofluidStream.Boundaries.Source source11(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-160,-20},{-140,0}})));
  .ThermofluidStream.Boundaries.Sink_m sink11(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_n(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.PolytropicExponent,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-130,-20},{-110,0}})));
  ThermofluidStream.Boundaries.Source source12(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-160,-70},{-140,-50}})));
  .ThermofluidStream.Boundaries.Sink_m sink12(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_n(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletDensity,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.PolytropicExponent,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-130,-70},{-110,-50}})));
  ThermofluidStream.Boundaries.Source source13(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-160,-120},{-140,-100}})));
  .ThermofluidStream.Boundaries.Sink_m sink13(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-100,-120},{-80,-100}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_n(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletSpecificVolume,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.PolytropicExponent,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-130,-120},{-110,-100}})));
  ThermofluidStream.Boundaries.Source source14(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-50,180},{-30,200}})));
  .ThermofluidStream.Boundaries.Sink_m sink14(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{10,180},{30,200}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas dp_eta_is(
    redeclare package Medium = Medium,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.IsentropicEfficiency,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-20,180},{0,200}})));
  ThermofluidStream.Boundaries.Source source15(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-50,130},{-30,150}})));
  .ThermofluidStream.Boundaries.Sink_m sink15(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{10,130},{30,150}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas pRatio_eta_is(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.IsentropicEfficiency,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-20,130},{0,150}})));
  ThermofluidStream.Boundaries.Source source16(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-50,80},{-30,100}})));
  .ThermofluidStream.Boundaries.Sink_m sink16(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{10,80},{30,100}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas p_out_eta_is(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.IsentropicEfficiency,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-20,80},{0,100}})));
  ThermofluidStream.Boundaries.Source source17(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-50,30},{-30,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink17(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{10,30},{30,50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas T_out_eta_is(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.IsentropicEfficiency,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-20,30},{0,50}})));
  ThermofluidStream.Boundaries.Source source18(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-50,-20},{-30,0}})));
  .ThermofluidStream.Boundaries.Sink_m sink18(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{10,-20},{30,0}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_eta_is(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.IsentropicEfficiency,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-20,-20},{0,0}})));
  ThermofluidStream.Boundaries.Source source19(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-50,-70},{-30,-50}})));
  .ThermofluidStream.Boundaries.Sink_m sink19(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{10,-70},{30,-50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_eta_is(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletDensity,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.IsentropicEfficiency,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-20,-70},{0,-50}})));
  ThermofluidStream.Boundaries.Source source20(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-50,-120},{-30,-100}})));
  .ThermofluidStream.Boundaries.Sink_m sink20(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{10,-120},{30,-100}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_eta_is(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletSpecificVolume,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.IsentropicEfficiency,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-20,-120},{0,-100}})));
  ThermofluidStream.Boundaries.Source source21(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{60,180},{80,200}})));
  .ThermofluidStream.Boundaries.Sink_m sink21(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{120,180},{140,200}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas dp_T_out(
    redeclare package Medium = Medium,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{90,180},{110,200}})));
  ThermofluidStream.Boundaries.Source source22(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{60,130},{80,150}})));
  .ThermofluidStream.Boundaries.Sink_m sink22(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{120,130},{140,150}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas pRatio_T_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.PressureRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{90,130},{110,150}})));
  ThermofluidStream.Boundaries.Source source23(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{60,80},{80,100}})));
  .ThermofluidStream.Boundaries.Sink_m sink23(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{120,80},{140,100}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas p_out_T_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletPressure,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{90,80},{110,100}})));
  ThermofluidStream.Boundaries.Source source25(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{60,-20},{80,0}})));
  .ThermofluidStream.Boundaries.Sink_m sink25(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{120,-20},{140,0}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_T_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{90,-20},{110,0}})));
  ThermofluidStream.Boundaries.Source source26(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{60,-70},{80,-50}})));
  .ThermofluidStream.Boundaries.Sink_m sink26(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{120,-70},{140,-50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_T_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletDensity,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{90,-70},{110,-50}})));
  ThermofluidStream.Boundaries.Source source27(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{60,-120},{80,-100}})));
  .ThermofluidStream.Boundaries.Sink_m sink27(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{120,-120},{140,-100}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_T_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletSpecificVolume,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletTemperature,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{90,-120},{110,-100}})));
  ThermofluidStream.Boundaries.Source source28(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{170,-20},{190,0}})));
  .ThermofluidStream.Boundaries.Sink_m sink28(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{230,-20},{250,0}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rhoRatio_p_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.CompressionRatio,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletPressure,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{200,-20},{220,0}})));
  ThermofluidStream.Boundaries.Source source29(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{170,-70},{190,-50}})));
  .ThermofluidStream.Boundaries.Sink_m sink29(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{230,-70},{250,-50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas rho_out_p_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletDensity,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletPressure,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{200,-70},{220,-50}})));
  ThermofluidStream.Boundaries.Source source30(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{170,-120},{190,-100}})));
  .ThermofluidStream.Boundaries.Sink_m sink30(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{230,-120},{250,-100}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas v_out_p_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletSpecificVolume,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletPressure,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{200,-120},{220,-100}})));
  ThermofluidStream.Boundaries.Source source24(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{170,30},{190,50}})));
  .ThermofluidStream.Boundaries.Sink_m sink24(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{230,30},{250,50}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas T_out_p_out(
    redeclare package Medium = Medium,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.OutletTemperature,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletPressure,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{200,30},{220,50}})));
  ThermofluidStream.Boundaries.Source source31(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-270,-170},{-250,-150}})));
  .ThermofluidStream.Boundaries.Sink_m sink31(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-210,-170},{-190,-150}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas P_eta_pol(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-240,-170},{-220,-150}})));
  ThermofluidStream.Boundaries.Source source32(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-160,-170},{-140,-150}})));
  .ThermofluidStream.Boundaries.Sink_m sink32(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{-100,-170},{-80,-150}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas P_n(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.PolytropicExponent,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-130,-170},{-110,-150}})));
  ThermofluidStream.Boundaries.Source source33(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{-50,-170},{-30,-150}})));
  .ThermofluidStream.Boundaries.Sink_m sink33(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{10,-170},{30,-150}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas P_eta_is(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.IsentropicEfficiency,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{-20,-170},{0,-150}})));
  ThermofluidStream.Boundaries.Source source35(
    redeclare package Medium = Medium,
    pressureFromInput=true,
    temperatureFromInput=true)
                  annotation(Placement(transformation(extent={{170,-170},{190,-150}})));
  .ThermofluidStream.Boundaries.Sink_m sink35(redeclare package Medium = Medium, m_flowSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation (Placement(transformation(extent={{230,-170},{250,-150}})));
  ThermofluidStream.Idealized.Processes.PolytropicPerfectGas P_p_out(
    redeclare package Medium = Medium,
    powerSignal=ThermofluidStream.Idealized.Types.EnergyFlowSignalMode.Input,
    outletSpec=ThermofluidStream.Idealized.Types.OutletSpecification.Polytropic.Unspecified,
    outletValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed,
    processSpec=ThermofluidStream.Idealized.Types.PolytropicProcessSpecification.OutletPressure,
    processValueSpec=ThermofluidStream.Types.ValueSpecification.Prescribed) annotation(Placement(transformation(extent={{200,-170},{220,-150}})));

equation
  connect(source.outlet, dp_eta_pol.inlet) annotation(Line(
      points={{-250,190},{-240,190}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_eta_pol.outlet, sink.inlet) annotation(Line(
      points={{-220,190},{-210,190}},
      color={28,108,200},
      thickness=0.5));
  connect(source1.outlet, pRatio_eta_pol.inlet) annotation(Line(
      points={{-250,140},{-240,140}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_eta_pol.outlet, sink1.inlet) annotation(Line(
      points={{-220,140},{-210,140}},
      color={28,108,200},
      thickness=0.5));
  connect(source2.outlet, p_out_eta_pol.inlet) annotation(Line(
      points={{-250,90},{-240,90}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_eta_pol.outlet, sink2.inlet) annotation(Line(
      points={{-220,90},{-210,90}},
      color={28,108,200},
      thickness=0.5));
  connect(source3.outlet, T_out_eta_pol.inlet) annotation(Line(
      points={{-250,40},{-240,40}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_eta_pol.outlet, sink3.inlet) annotation(Line(
      points={{-220,40},{-210,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source4.outlet, rhoRatio_eta_pol.inlet) annotation(Line(
      points={{-250,-10},{-240,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_eta_pol.outlet, sink4.inlet) annotation(Line(
      points={{-220,-10},{-210,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(source5.outlet, rho_out_eta_pol.inlet) annotation(Line(
      points={{-250,-60},{-240,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_eta_pol.outlet, sink5.inlet) annotation(Line(
      points={{-220,-60},{-210,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(source6.outlet, v_out_eta_pol.inlet) annotation(Line(
      points={{-250,-110},{-240,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_eta_pol.outlet, sink6.inlet) annotation(Line(
      points={{-220,-110},{-210,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(source7.outlet, dp_n.inlet) annotation(Line(
      points={{-140,190},{-130,190}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_n.outlet, sink7.inlet) annotation(Line(
      points={{-110,190},{-100,190}},
      color={28,108,200},
      thickness=0.5));
  connect(source8.outlet, pRatio_n.inlet) annotation(Line(
      points={{-140,140},{-130,140}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_n.outlet, sink8.inlet) annotation(Line(
      points={{-110,140},{-100,140}},
      color={28,108,200},
      thickness=0.5));
  connect(source9.outlet, p_out_n.inlet) annotation(Line(
      points={{-140,90},{-130,90}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_n.outlet, sink9.inlet) annotation(Line(
      points={{-110,90},{-100,90}},
      color={28,108,200},
      thickness=0.5));
  connect(source10.outlet, T_out_n.inlet) annotation(Line(
      points={{-140,40},{-130,40}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_n.outlet, sink10.inlet) annotation(Line(
      points={{-110,40},{-100,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source11.outlet, rhoRatio_n.inlet) annotation(Line(
      points={{-140,-10},{-130,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_n.outlet, sink11.inlet) annotation(Line(
      points={{-110,-10},{-100,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(source12.outlet, rho_out_n.inlet) annotation(Line(
      points={{-140,-60},{-130,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_n.outlet, sink12.inlet) annotation(Line(
      points={{-110,-60},{-100,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(source13.outlet, v_out_n.inlet) annotation(Line(
      points={{-140,-110},{-130,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_n.outlet, sink13.inlet) annotation(Line(
      points={{-110,-110},{-100,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(source14.outlet, dp_eta_is.inlet) annotation(Line(
      points={{-30,190},{-20,190}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_eta_is.outlet, sink14.inlet) annotation(Line(
      points={{0,190},{10,190}},
      color={28,108,200},
      thickness=0.5));
  connect(source15.outlet, pRatio_eta_is.inlet) annotation(Line(
      points={{-30,140},{-20,140}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_eta_is.outlet, sink15.inlet) annotation(Line(
      points={{0,140},{10,140}},
      color={28,108,200},
      thickness=0.5));
  connect(source16.outlet, p_out_eta_is.inlet) annotation(Line(
      points={{-30,90},{-20,90}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_eta_is.outlet, sink16.inlet) annotation(Line(
      points={{0,90},{10,90}},
      color={28,108,200},
      thickness=0.5));
  connect(source17.outlet, T_out_eta_is.inlet) annotation(Line(
      points={{-30,40},{-20,40}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_eta_is.outlet, sink17.inlet) annotation(Line(
      points={{0,40},{10,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source18.outlet, rhoRatio_eta_is.inlet) annotation(Line(
      points={{-30,-10},{-20,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_eta_is.outlet, sink18.inlet) annotation(Line(
      points={{0,-10},{10,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(source19.outlet, rho_out_eta_is.inlet) annotation(Line(
      points={{-30,-60},{-20,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_eta_is.outlet, sink19.inlet) annotation(Line(
      points={{0,-60},{10,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(source20.outlet, v_out_eta_is.inlet) annotation(Line(
      points={{-30,-110},{-20,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_eta_is.outlet, sink20.inlet) annotation(Line(
      points={{0,-110},{10,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(source21.outlet, dp_T_out.inlet) annotation(Line(
      points={{80,190},{90,190}},
      color={28,108,200},
      thickness=0.5));
  connect(dp_T_out.outlet, sink21.inlet) annotation(Line(
      points={{110,190},{120,190}},
      color={28,108,200},
      thickness=0.5));
  connect(source22.outlet, pRatio_T_out.inlet) annotation(Line(
      points={{80,140},{90,140}},
      color={28,108,200},
      thickness=0.5));
  connect(pRatio_T_out.outlet, sink22.inlet) annotation(Line(
      points={{110,140},{120,140}},
      color={28,108,200},
      thickness=0.5));
  connect(source23.outlet, p_out_T_out.inlet) annotation(Line(
      points={{80,90},{90,90}},
      color={28,108,200},
      thickness=0.5));
  connect(p_out_T_out.outlet, sink23.inlet) annotation(Line(
      points={{110,90},{120,90}},
      color={28,108,200},
      thickness=0.5));
  connect(source25.outlet, rhoRatio_T_out.inlet) annotation(Line(
      points={{80,-10},{90,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_T_out.outlet, sink25.inlet) annotation(Line(
      points={{110,-10},{120,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(source26.outlet, rho_out_T_out.inlet) annotation(Line(
      points={{80,-60},{90,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_T_out.outlet, sink26.inlet) annotation(Line(
      points={{110,-60},{120,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(source27.outlet, v_out_T_out.inlet) annotation(Line(
      points={{80,-110},{90,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_T_out.outlet, sink27.inlet) annotation(Line(
      points={{110,-110},{120,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(source28.outlet, rhoRatio_p_out.inlet) annotation(Line(
      points={{190,-10},{200,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(rhoRatio_p_out.outlet, sink28.inlet) annotation(Line(
      points={{220,-10},{230,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(source29.outlet, rho_out_p_out.inlet) annotation(Line(
      points={{190,-60},{200,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(rho_out_p_out.outlet, sink29.inlet) annotation(Line(
      points={{220,-60},{230,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(source30.outlet, v_out_p_out.inlet) annotation(Line(
      points={{190,-110},{200,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(v_out_p_out.outlet, sink30.inlet) annotation(Line(
      points={{220,-110},{230,-110}},
      color={28,108,200},
      thickness=0.5));
  connect(source24.outlet, T_out_p_out.inlet) annotation(Line(
      points={{190,40},{200,40}},
      color={28,108,200},
      thickness=0.5));
  connect(T_out_p_out.outlet, sink24.inlet) annotation(Line(
      points={{220,40},{230,40}},
      color={28,108,200},
      thickness=0.5));
  connect(source31.outlet, P_eta_pol.inlet) annotation(Line(
      points={{-250,-160},{-240,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(P_eta_pol.outlet, sink31.inlet) annotation(Line(
      points={{-220,-160},{-210,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(source32.outlet, P_n.inlet) annotation(Line(
      points={{-140,-160},{-130,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(P_n.outlet, sink32.inlet) annotation(Line(
      points={{-110,-160},{-100,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(source33.outlet, P_eta_is.inlet) annotation(Line(
      points={{-30,-160},{-20,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(P_eta_is.outlet, sink33.inlet) annotation(Line(
      points={{0,-160},{10,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(source35.outlet, P_p_out.inlet) annotation(Line(
      points={{190,-160},{200,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(P_p_out.outlet, sink35.inlet) annotation(Line(
      points={{220,-160},{230,-160}},
      color={28,108,200},
      thickness=0.5));
  connect(sink31.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{-198,-160},{-180,-160},{-180,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{-198,190},{-180,190},{-180,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink1.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{-198,140},{-180,140},{-180,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink2.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{-198,90},{-180,90},{-180,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink3.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{-198,40},{-180,40},{-180,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink4.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{-198,-10},{-180,-10},{-180,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink5.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{-198,-60},{-180,-60},{-180,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink6.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{-198,-110},{-180,-110},{-180,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink32.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{-88,-160},{-70,-160},{-70,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink7.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{-88,190},{-70,190},{-70,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink13.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{-88,-110},{-70,-110},{-70,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink12.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{-88,-60},{-70,-60},{-70,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink11.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{-88,-10},{-70,-10},{-70,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink10.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{-88,40},{-70,40},{-70,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink9.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{-88,90},{-70,90},{-70,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink8.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{-88,140},{-70,140},{-70,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink33.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{22,-160},{40,-160},{40,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink14.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{22,190},{40,190},{40,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink15.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{22,140},{40,140},{40,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink16.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{22,90},{40,90},{40,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink17.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{22,40},{40,40},{40,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink18.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{22,-10},{40,-10},{40,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink19.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{22,-60},{40,-60},{40,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink20.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{22,-110},{40,-110},{40,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink21.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{132,190},{150,190},{150,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink27.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{132,-110},{150,-110},{150,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink26.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{132,-60},{150,-60},{150,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink25.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{132,-10},{150,-10},{150,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink23.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{132,90},{150,90},{150,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink22.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{132,140},{150,140},{150,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink24.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{242,40},{260,40},{260,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink35.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{242,-160},{260,-160},{260,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink30.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{242,-110},{260,-110},{260,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink29.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{242,-60},{260,-60},{260,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(sink28.m_flow_prescribed, massFlowRate.y) annotation(Line(points={{242,-10},{260,-10},{260,-192},{-316,-192},{-316,-150},{-319,-150}}, color={0,0,127}));
  connect(dp_eta_pol.outletSpec_prescribed, pressureDifference.y) annotation(Line(points={{-220,178},{-220,170},{-312,170},{-312,90},{-319,90}}, color={0,0,127}));
  connect(dp_n.outletSpec_prescribed, pressureDifference.y) annotation(Line(points={{-110,178},{-110,170},{-312,170},{-312,90},{-319,90}}, color={0,0,127}));
  connect(dp_eta_is.outletSpec_prescribed, pressureDifference.y) annotation(Line(points={{0,178},{0,170},{-312,170},{-312,90},{-319,90}}, color={0,0,127}));
  connect(dp_T_out.outletSpec_prescribed, pressureDifference.y) annotation(Line(points={{110,178},{110,170},{-312,170},{-312,90},{-319,90}}, color={0,0,127}));
  connect(pRatio_eta_pol.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{-220,128},{-220,120},{-310,120},{-310,66},{-319,66}}, color={0,0,127}));
  connect(pRatio_n.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{-110,128},{-110,120},{-310,120},{-310,66},{-319,66}}, color={0,0,127}));
  connect(pRatio_eta_is.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{0,128},{0,120},{-310,120},{-310,66},{-319,66}}, color={0,0,127}));
  connect(pRatio_T_out.outletSpec_prescribed, pressureRatio.y) annotation(Line(points={{110,128},{110,120},{-310,120},{-310,66},{-319,66}}, color={0,0,127}));
  connect(p_out_eta_pol.outletSpec_prescribed, outletPressure.y) annotation(Line(points={{-220,78},{-220,70},{-308,70},{-308,40},{-319,40}}, color={0,0,127}));
  connect(p_out_n.outletSpec_prescribed, outletPressure.y) annotation(Line(points={{-110,78},{-110,70},{-308,70},{-308,40},{-319,40}}, color={0,0,127}));
  connect(p_out_eta_is.outletSpec_prescribed, outletPressure.y) annotation(Line(points={{0,78},{0,70},{-308,70},{-308,40},{-319,40}}, color={0,0,127}));
  connect(p_out_T_out.outletSpec_prescribed, outletPressure.y) annotation(Line(points={{110,78},{110,70},{-308,70},{-308,40},{-319,40}}, color={0,0,127}));
  connect(T_out_eta_pol.outletSpec_prescribed, outletTemperature.y) annotation(Line(points={{-220,28},{-220,20},{-319,20}}, color={0,0,127}));
  connect(T_out_n.outletSpec_prescribed, outletTemperature.y) annotation(Line(points={{-110,28},{-110,20},{-319,20}}, color={0,0,127}));
  connect(T_out_eta_is.outletSpec_prescribed, outletTemperature.y) annotation(Line(points={{0,28},{0,20},{-319,20}}, color={0,0,127}));
  connect(rhoRatio_eta_pol.outletSpec_prescribed, compressionRatio.y) annotation(Line(points={{-220,-22},{-220,-32},{-304,-32},{-304,0},{-319,0}}, color={0,0,127}));
  connect(rhoRatio_n.outletSpec_prescribed, compressionRatio.y) annotation(Line(points={{-110,-22},{-110,-32},{-304,-32},{-304,0},{-319,0}}, color={0,0,127}));
  connect(rhoRatio_eta_is.outletSpec_prescribed, compressionRatio.y) annotation(Line(points={{0,-22},{0,-32},{-304,-32},{-304,0},{-319,0}}, color={0,0,127}));
  connect(rhoRatio_T_out.outletSpec_prescribed, compressionRatio.y) annotation(Line(points={{110,-22},{110,-32},{-304,-32},{-304,0},{-319,0}}, color={0,0,127}));
  connect(rhoRatio_p_out.outletSpec_prescribed, compressionRatio.y) annotation(Line(points={{220,-22},{220,-32},{-304,-32},{-304,0},{-319,0}}, color={0,0,127}));
  connect(T_out_p_out.outletSpec_prescribed, outletTemperature.y) annotation(Line(points={{220,28},{220,20},{-319,20}}, color={0,0,127}));
  connect(rho_out_eta_pol.outletSpec_prescribed, outletDensity.y) annotation(Line(points={{-220,-72},{-220,-82},{-302,-82},{-302,-20},{-319,-20}}, color={0,0,127}));
  connect(rho_out_n.outletSpec_prescribed, outletDensity.y) annotation(Line(points={{-110,-72},{-110,-82},{-302,-82},{-302,-20},{-319,-20}}, color={0,0,127}));
  connect(rho_out_eta_is.outletSpec_prescribed, outletDensity.y) annotation(Line(points={{0,-72},{0,-82},{-302,-82},{-302,-20},{-319,-20}}, color={0,0,127}));
  connect(rho_out_T_out.outletSpec_prescribed, outletDensity.y) annotation(Line(points={{110,-72},{110,-82},{-302,-82},{-302,-20},{-319,-20}}, color={0,0,127}));
  connect(rho_out_p_out.outletSpec_prescribed, outletDensity.y) annotation(Line(points={{220,-72},{220,-82},{-302,-82},{-302,-20},{-319,-20}}, color={0,0,127}));
  connect(v_out_eta_pol.outletSpec_prescribed, outletSpecificVolume.y) annotation(Line(points={{-220,-122},{-220,-130},{-300,-130},{-300,-40},{-319,-40}}, color={0,0,127}));
  connect(v_out_n.outletSpec_prescribed, outletSpecificVolume.y) annotation(Line(points={{-110,-122},{-110,-130},{-300,-130},{-300,-40},{-319,-40}}, color={0,0,127}));
  connect(v_out_eta_is.outletSpec_prescribed, outletSpecificVolume.y) annotation(Line(points={{0,-122},{0,-130},{-300,-130},{-300,-40},{-319,-40}}, color={0,0,127}));
  connect(v_out_T_out.outletSpec_prescribed, outletSpecificVolume.y) annotation(Line(points={{110,-122},{110,-130},{-300,-130},{-300,-40},{-319,-40}}, color={0,0,127}));
  connect(v_out_p_out.outletSpec_prescribed, outletSpecificVolume.y) annotation(Line(points={{220,-122},{220,-130},{-300,-130},{-300,-40},{-319,-40}}, color={0,0,127}));
  connect(P_eta_pol.processSpec_prescribed, polytropicEfficiency.y) annotation(Line(points={{-224,-172},{-224,-180},{-298,-180},{-298,-60},{-319,-60}}, color={0,0,127}));
  connect(dp_eta_pol.processSpec_prescribed, polytropicEfficiency.y) annotation(Line(points={{-224,178},{-224,168},{-298,168},{-298,-60},{-319,-60}}, color={0,0,127}));
  connect(pRatio_eta_pol.processSpec_prescribed, polytropicEfficiency.y) annotation(Line(points={{-224,128},{-224,118},{-298,118},{-298,-60},{-319,-60}}, color={0,0,127}));
  connect(p_out_eta_pol.processSpec_prescribed, polytropicEfficiency.y) annotation(Line(points={{-224,78},{-224,68},{-298,68},{-298,-60},{-319,-60}}, color={0,0,127}));
  connect(T_out_eta_pol.processSpec_prescribed, polytropicEfficiency.y) annotation(Line(points={{-224,28},{-224,18},{-298,18},{-298,-60},{-319,-60}}, color={0,0,127}));
  connect(rhoRatio_eta_pol.processSpec_prescribed, polytropicEfficiency.y) annotation(Line(points={{-224,-22},{-224,-34},{-298,-34},{-298,-60},{-319,-60}}, color={0,0,127}));
  connect(rho_out_eta_pol.processSpec_prescribed, polytropicEfficiency.y) annotation(Line(points={{-224,-72},{-224,-84},{-298,-84},{-298,-60},{-319,-60}}, color={0,0,127}));
  connect(v_out_eta_pol.processSpec_prescribed, polytropicEfficiency.y) annotation(Line(points={{-224,-122},{-224,-132},{-298,-132},{-298,-60},{-319,-60}}, color={0,0,127}));
  connect(dp_n.processSpec_prescribed, polytropicExponent.y) annotation(Line(points={{-114,178},{-114,166},{-296,166},{-296,-80},{-319,-80}}, color={0,0,127}));
  connect(v_out_n.processSpec_prescribed, polytropicExponent.y) annotation(Line(points={{-114,-122},{-114,-134},{-296,-134},{-296,-80},{-319,-80}}, color={0,0,127}));
  connect(rho_out_n.processSpec_prescribed, polytropicExponent.y) annotation(Line(points={{-114,-72},{-114,-86},{-296,-86},{-296,-80},{-319,-80}}, color={0,0,127}));
  connect(rhoRatio_n.processSpec_prescribed, polytropicExponent.y) annotation(Line(points={{-114,-22},{-114,-36},{-296,-36},{-296,-80},{-319,-80}}, color={0,0,127}));
  connect(T_out_n.processSpec_prescribed, polytropicExponent.y) annotation(Line(points={{-114,28},{-114,16},{-296,16},{-296,-80},{-319,-80}}, color={0,0,127}));
  connect(p_out_n.processSpec_prescribed, polytropicExponent.y) annotation(Line(points={{-114,78},{-114,66},{-296,66},{-296,-80},{-319,-80}}, color={0,0,127}));
  connect(pRatio_n.processSpec_prescribed, polytropicExponent.y) annotation(Line(points={{-114,128},{-114,116},{-296,116},{-296,-80},{-319,-80}}, color={0,0,127}));
  connect(dp_eta_is.processSpec_prescribed, isentropicEfficiency.y) annotation(Line(points={{-4,178},{-4,164},{-294,164},{-294,-110},{-319,-110}}, color={0,0,127}));
  connect(P_n.processSpec_prescribed, polytropicExponent.y) annotation(Line(points={{-114,-172},{-114,-182},{-296,-182},{-296,-80},{-319,-80}}, color={0,0,127}));
  connect(P_eta_is.processSpec_prescribed, isentropicEfficiency.y) annotation(Line(points={{-4,-172},{-4,-184},{-294,-184},{-294,-110},{-319,-110}}, color={0,0,127}));
  connect(v_out_eta_is.processSpec_prescribed, isentropicEfficiency.y) annotation(Line(points={{-4,-122},{-4,-136},{-294,-136},{-294,-110},{-319,-110}}, color={0,0,127}));
  connect(rho_out_eta_is.processSpec_prescribed, isentropicEfficiency.y) annotation(Line(points={{-4,-72},{-4,-88},{-294,-88},{-294,-110},{-319,-110}}, color={0,0,127}));
  connect(rhoRatio_eta_is.processSpec_prescribed, isentropicEfficiency.y) annotation(Line(points={{-4,-22},{-4,-38},{-294,-38},{-294,-110},{-319,-110}}, color={0,0,127}));
  connect(T_out_eta_is.processSpec_prescribed, isentropicEfficiency.y) annotation(Line(points={{-4,28},{-4,14},{-294,14},{-294,-110},{-319,-110}}, color={0,0,127}));
  connect(p_out_eta_is.processSpec_prescribed, isentropicEfficiency.y) annotation(Line(points={{-4,78},{-4,64},{-294,64},{-294,-110},{-319,-110}}, color={0,0,127}));
  connect(pRatio_eta_is.processSpec_prescribed, isentropicEfficiency.y) annotation(Line(points={{-4,128},{-4,114},{-294,114},{-294,-110},{-319,-110}}, color={0,0,127}));
  connect(dp_T_out.processSpec_prescribed, outletTemperature.y) annotation(Line(points={{106,178},{106,162},{-292,162},{-292,20},{-319,20}}, color={0,0,127}));
  connect(pRatio_T_out.processSpec_prescribed, outletTemperature.y) annotation(Line(points={{106,128},{106,112},{-292,112},{-292,20},{-319,20}}, color={0,0,127}));
  connect(p_out_T_out.processSpec_prescribed, outletTemperature.y) annotation(Line(points={{106,78},{106,62},{-292,62},{-292,20},{-319,20}}, color={0,0,127}));
  connect(v_out_T_out.processSpec_prescribed, outletTemperature.y) annotation(Line(points={{106,-122},{106,-138},{-292,-138},{-292,20},{-319,20}}, color={0,0,127}));
  connect(rho_out_T_out.processSpec_prescribed, outletTemperature.y) annotation(Line(points={{106,-72},{106,-90},{-292,-90},{-292,20},{-319,20}}, color={0,0,127}));
  connect(rhoRatio_T_out.processSpec_prescribed, outletTemperature.y) annotation(Line(points={{106,-22},{106,-40},{-292,-40},{-292,20},{-319,20}}, color={0,0,127}));
  connect(T_out_p_out.processSpec_prescribed, outletPressure.y) annotation(Line(points={{216,28},{216,12},{-290,12},{-290,40},{-319,40}}, color={0,0,127}));
  connect(rhoRatio_p_out.processSpec_prescribed, outletPressure.y) annotation(Line(points={{216,-22},{216,-42},{-290,-42},{-290,40},{-319,40}}, color={0,0,127}));
  connect(rho_out_p_out.processSpec_prescribed, outletPressure.y) annotation(Line(points={{216,-72},{216,-92},{-290,-92},{-290,40},{-319,40}}, color={0,0,127}));
  connect(v_out_p_out.processSpec_prescribed, outletPressure.y) annotation(Line(points={{216,-122},{216,-140},{-290,-140},{-290,40},{-319,40}}, color={0,0,127}));
  connect(P_p_out.processSpec_prescribed, outletPressure.y) annotation(Line(points={{216,-172},{216,-186},{-290,-186},{-290,40},{-319,40}}, color={0,0,127}));
  connect(P_eta_pol.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-230,-168},{-230,-194},{268,-194},{268,0},{279,0}}, color={255,170,85}));
  connect(P_n.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-120,-168},{-120,-194},{268,-194},{268,0},{279,0}}, color={255,170,85}));
  connect(P_eta_is.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{-10,-168},{-10,-194},{268,-194},{268,0},{279,0}}, color={255,170,85}));
  connect(P_p_out.P_in, energyFlowSource.E_flow_out) annotation(Line(points={{210,-168},{210,-194},{268,-194},{268,0},{279,0}}, color={255,170,85}));
  connect(source21.T0_var, inletTemperature.y) annotation(Line(points={{68,190},{56,190},{56,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source21.p0_var, inletPressure.y) annotation(Line(points={{68,196},{60,196},{60,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source7.p0_var, inletPressure.y) annotation(Line(points={{-152,196},{-160,196},{-160,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source7.T0_var, inletTemperature.y) annotation(Line(points={{-152,190},{-164,190},{-164,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source32.p0_var, inletPressure.y) annotation(Line(points={{-152,-154},{-160,-154},{-160,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source32.T0_var, inletTemperature.y) annotation(Line(points={{-152,-160},{-164,-160},{-164,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source31.p0_var, inletPressure.y) annotation(Line(points={{-262,-154},{-270,-154},{-270,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source31.T0_var, inletTemperature.y) annotation(Line(points={{-262,-160},{-274,-160},{-274,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source.p0_var, inletPressure.y) annotation(Line(points={{-262,196},{-270,196},{-270,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source.T0_var, inletTemperature.y) annotation(Line(points={{-262,190},{-274,190},{-274,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source1.p0_var, inletPressure.y) annotation(Line(points={{-262,146},{-270,146},{-270,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source1.T0_var, inletTemperature.y) annotation(Line(points={{-262,140},{-274,140},{-274,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source2.p0_var, inletPressure.y) annotation(Line(points={{-262,96},{-270,96},{-270,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source2.T0_var, inletTemperature.y) annotation(Line(points={{-262,90},{-274,90},{-274,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source3.p0_var, inletPressure.y) annotation(Line(points={{-262,46},{-270,46},{-270,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source3.T0_var, inletTemperature.y) annotation(Line(points={{-262,40},{-274,40},{-274,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source4.p0_var, inletPressure.y) annotation(Line(points={{-262,-4},{-270,-4},{-270,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source4.T0_var, inletTemperature.y) annotation(Line(points={{-262,-10},{-274,-10},{-274,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source5.p0_var, inletPressure.y) annotation(Line(points={{-262,-54},{-270,-54},{-270,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source5.T0_var, inletTemperature.y) annotation(Line(points={{-262,-60},{-274,-60},{-274,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source6.p0_var, inletPressure.y) annotation(Line(points={{-262,-104},{-270,-104},{-270,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source6.T0_var, inletTemperature.y) annotation(Line(points={{-262,-110},{-274,-110},{-274,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source8.p0_var, inletPressure.y) annotation(Line(points={{-152,146},{-160,146},{-160,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source8.T0_var, inletTemperature.y) annotation(Line(points={{-152,140},{-164,140},{-164,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source9.p0_var, inletPressure.y) annotation(Line(points={{-152,96},{-160,96},{-160,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source9.T0_var, inletTemperature.y) annotation(Line(points={{-152,90},{-164,90},{-164,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source10.p0_var, inletPressure.y) annotation(Line(points={{-152,46},{-160,46},{-160,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source10.T0_var, inletTemperature.y) annotation(Line(points={{-152,40},{-164,40},{-164,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source11.p0_var, inletPressure.y) annotation(Line(points={{-152,-4},{-160,-4},{-160,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source11.T0_var, inletTemperature.y) annotation(Line(points={{-152,-10},{-164,-10},{-164,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source12.p0_var, inletPressure.y) annotation(Line(points={{-152,-54},{-160,-54},{-160,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source12.T0_var, inletTemperature.y) annotation(Line(points={{-152,-60},{-164,-60},{-164,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source13.p0_var, inletPressure.y) annotation(Line(points={{-152,-104},{-160,-104},{-160,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source13.T0_var, inletTemperature.y) annotation(Line(points={{-152,-110},{-164,-110},{-164,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source33.p0_var, inletPressure.y) annotation(Line(points={{-42,-154},{-50,-154},{-50,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source33.T0_var, inletTemperature.y) annotation(Line(points={{-42,-160},{-54,-160},{-54,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source14.p0_var, inletPressure.y) annotation(Line(points={{-42,196},{-50,196},{-50,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source14.T0_var, inletTemperature.y) annotation(Line(points={{-42,190},{-54,190},{-54,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source15.p0_var, inletPressure.y) annotation(Line(points={{-42,146},{-50,146},{-50,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source15.T0_var, inletTemperature.y) annotation(Line(points={{-42,140},{-54,140},{-54,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source16.p0_var, inletPressure.y) annotation(Line(points={{-42,96},{-50,96},{-50,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source16.T0_var, inletTemperature.y) annotation(Line(points={{-42,90},{-54,90},{-54,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source17.p0_var, inletPressure.y) annotation(Line(points={{-42,46},{-50,46},{-50,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source17.T0_var, inletTemperature.y) annotation(Line(points={{-42,40},{-54,40},{-54,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source18.p0_var, inletPressure.y) annotation(Line(points={{-42,-4},{-50,-4},{-50,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source18.T0_var, inletTemperature.y) annotation(Line(points={{-42,-10},{-54,-10},{-54,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source19.p0_var, inletPressure.y) annotation(Line(points={{-42,-54},{-50,-54},{-50,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source19.T0_var, inletTemperature.y) annotation(Line(points={{-42,-60},{-54,-60},{-54,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source20.p0_var, inletPressure.y) annotation(Line(points={{-42,-104},{-50,-104},{-50,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source20.T0_var, inletTemperature.y) annotation(Line(points={{-42,-110},{-54,-110},{-54,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source27.p0_var, inletPressure.y) annotation(Line(points={{68,-104},{60,-104},{60,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source27.T0_var, inletTemperature.y) annotation(Line(points={{68,-110},{56,-110},{56,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source22.p0_var, inletPressure.y) annotation(Line(points={{68,146},{60,146},{60,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source22.T0_var, inletTemperature.y) annotation(Line(points={{68,140},{56,140},{56,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source23.p0_var, inletPressure.y) annotation(Line(points={{68,96},{60,96},{60,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source23.T0_var, inletTemperature.y) annotation(Line(points={{68,90},{56,90},{56,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source25.p0_var, inletPressure.y) annotation(Line(points={{68,-4},{60,-4},{60,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source25.T0_var, inletTemperature.y) annotation(Line(points={{68,-10},{56,-10},{56,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source26.p0_var, inletPressure.y) annotation(Line(points={{68,-54},{60,-54},{60,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source26.T0_var, inletTemperature.y) annotation(Line(points={{68,-60},{56,-60},{56,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source35.p0_var, inletPressure.y) annotation(Line(points={{178,-154},{170,-154},{170,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source35.T0_var, inletTemperature.y) annotation(Line(points={{178,-160},{166,-160},{166,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source24.p0_var, inletPressure.y) annotation(Line(points={{178,46},{170,46},{170,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source24.T0_var, inletTemperature.y) annotation(Line(points={{178,40},{166,40},{166,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source28.p0_var, inletPressure.y) annotation(Line(points={{178,-4},{170,-4},{170,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source28.T0_var, inletTemperature.y) annotation(Line(points={{178,-10},{166,-10},{166,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source29.p0_var, inletPressure.y) annotation(Line(points={{178,-54},{170,-54},{170,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source29.T0_var, inletTemperature.y) annotation(Line(points={{178,-60},{166,-60},{166,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));
  connect(source30.p0_var, inletPressure.y) annotation(Line(points={{178,-104},{170,-104},{170,212},{-320,212},{-320,160},{-329,160}}, color={0,0,127}));
  connect(source30.T0_var, inletTemperature.y) annotation(Line(points={{178,-110},{166,-110},{166,208},{-316,208},{-316,120},{-329,120}}, color={0,0,127}));

  annotation(
    experiment(
      StopTime=1.5,
      Interval=0.01,
      Tolerance=1e-6,
      __Dymola_Algorithm="Dassl"),
    Documentation(
      info="<html>
  <p>
    <a href=\"modelica://ThermofluidStream.Idealized.Processes.PolytropicPerfectGas\">PolytropicPerfectGas</a> test for time dependent (boundary) conditions (given mass flow rate).
  </p>

  <p>
    <code>pRatio = 1</code> and/or <code>m_flow = 0</code> is supported.
  </p>
</html>",
    revisions="<html>
  <ul>
    <li>
      2026, by Raphael Gebhart (raphael.gebhart@dlr.de):<br>
      Initial version.
    </li>
  </ul>
</html>"));
end Prescribed1;
