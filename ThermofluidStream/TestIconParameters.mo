within ThermofluidStream;
model TestIconParameters
  extends Modelica.Icons.Example;
  inner DropOfCommons                   dropOfCommons(displayInstanceNames=true, displayParameters=false)
                                                                                  annotation (Placement(transformation(extent={{-14,480},{6,500}})));
  Boundaries.Source                   source(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    xiFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-820,402},{-800,422}})));
  Boundaries.Sink                   sink2(displayParameters=true,
    displayPressure=false,
    pressureFromInput=false,
    p0_par=100000)                       annotation (Placement(transformation(extent={{-140,100},{-120,120}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow(displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=false)                                                     annotation (Placement(transformation(extent={{20,-160},{40,-140}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow1(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=true)                                                      annotation (Placement(transformation(extent={{60,-160},{80,-140}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow2(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=false)                                                     annotation (Placement(transformation(extent={{100,-160},{120,-140}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow3(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=true)                                                      annotation (Placement(transformation(extent={{140,-160},{160,-140}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow4(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=false)                                                     annotation (Placement(transformation(extent={{180,-160},{200,-140}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow5(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=true)                                                      annotation (Placement(transformation(extent={{220,-160},{240,-140}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow6(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=false)                                                     annotation (Placement(transformation(extent={{260,-160},{280,-140}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow7(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=true)                                                      annotation (Placement(transformation(extent={{300,-160},{320,-140}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow8(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=false,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{20,-200},{40,-180}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow9(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=true,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{60,-200},{80,-180}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow10(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=false,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{100,-200},{120,-180}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow11(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=true,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{140,-200},{160,-180}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow12(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=false,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{180,-200},{200,-180}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow13(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=true,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{220,-200},{240,-180}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow14(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=false,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{260,-200},{280,-180}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow15(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=true,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{300,-200},{320,-180}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow16(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=false,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{20,-240},{40,-220}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow17(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=true,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{60,-240},{80,-220}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow18(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=false,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{100,-240},{120,-220}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow19(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=true,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{140,-240},{160,-220}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow20(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=false,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{180,-240},{200,-220}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow21(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=true,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{220,-240},{240,-220}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow22(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=false,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{260,-240},{280,-220}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow23(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=true,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{300,-240},{320,-220}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow24(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=false,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{20,-280},{40,-260}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow25(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=true,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{60,-280},{80,-260}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow26(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=false,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{100,-280},{120,-260}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow27(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=true,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{140,-280},{160,-260}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow28(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=false,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{180,-280},{200,-260}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow29(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=true,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{220,-280},{240,-260}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow30(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=false,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{260,-280},{280,-260}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow31(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=true,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{300,-280},{320,-260}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow2(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=false)                                          annotation (Placement(transformation(extent={{-320,-160},{-300,-140}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow3(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=true)                                           annotation (Placement(transformation(extent={{-280,-160},{-260,-140}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow4(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=true,
    displayCompressibilityApproach=false)                                          annotation (Placement(transformation(extent={{-240,-160},{-220,-140}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow5(displayParameters=true, displayOutletVelocity=false)
                                                                                   annotation (Placement(transformation(extent={{-200,-160},{-180,-140}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow6(
    displayParameters=true,
    displayInletArea=false,
    displayCompressibilityApproach=false)                                          annotation (Placement(transformation(extent={{-160,-160},{-140,-140}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow7(displayParameters=true, displayInletArea=false)
                                                                                   annotation (Placement(transformation(extent={{-120,-160},{-100,-140}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow8(
    displayParameters=true,
    displayInletArea=true,
    displayCompressibilityApproach=false)                                          annotation (Placement(transformation(extent={{-80,-160},{-60,-140}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow9(
    displayParameters=true,
    displayInletArea=true,
    displayCompressibilityApproach=true)                                           annotation (Placement(transformation(extent={{-40,-160},{-20,-140}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow10(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=false,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-320,-200},{-300,-180}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow11(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=true,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-280,-200},{-260,-180}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow12(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=true,
    displayCompressibilityApproach=false,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-240,-200},{-220,-180}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow13(
    displayParameters=true,
    displayOutletVelocity=false,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-200,-200},{-180,-180}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow14(
    displayParameters=true,
    displayInletArea=false,
    displayCompressibilityApproach=false,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-160,-200},{-140,-180}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow15(
    displayParameters=true,
    displayInletArea=false,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-120,-200},{-100,-180}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow16(
    displayParameters=true,
    displayInletArea=true,
    displayCompressibilityApproach=false,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-80,-200},{-60,-180}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow17(
    displayParameters=true,
    displayInletArea=true,
    displayCompressibilityApproach=true,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-40,-200},{-20,-180}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow18(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=false,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-320,-240},{-300,-220}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow19(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-280,-240},{-260,-220}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow20(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=true,
    displayCompressibilityApproach=false,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-240,-240},{-220,-220}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow21(
    displayParameters=true,
    displayOutletVelocity=false,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-200,-240},{-180,-220}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow22(
    displayParameters=true,
    displayInletArea=false,
    displayCompressibilityApproach=false,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-160,-240},{-140,-220}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow23(
    displayParameters=true,
    displayInletArea=false,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-120,-240},{-100,-220}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow24(
    displayParameters=true,
    displayInletArea=true,
    displayCompressibilityApproach=false,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-80,-240},{-60,-220}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow25(
    displayParameters=true,
    displayInletArea=true,
    displayCompressibilityApproach=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-40,-240},{-20,-220}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow26(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=false,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-320,-280},{-300,-260}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow27(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=true,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-280,-280},{-260,-260}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow28(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=true,
    displayCompressibilityApproach=false,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-240,-280},{-220,-260}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow29(
    displayParameters=true,
    displayOutletVelocity=false,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-200,-280},{-180,-260}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow30(
    displayParameters=true,
    displayInletArea=false,
    displayCompressibilityApproach=false,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-160,-280},{-140,-260}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow31(
    displayParameters=true,
    displayInletArea=false,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-120,-280},{-100,-260}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow32(
    displayParameters=true,
    displayInletArea=true,
    displayCompressibilityApproach=false,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-80,-280},{-60,-260}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow33(
    displayParameters=true,
    displayInletArea=true,
    displayCompressibilityApproach=true,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-40,-280},{-20,-260}})));
  Boundaries.Source                   source1(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-780,402},{-760,422}})));
  Boundaries.Source                   source2(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-740,402},{-720,422}})));
  Boundaries.Source                   source3(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-700,402},{-680,420}})));
  Boundaries.Source                   source4(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-820,362},{-800,382}})));
  Boundaries.Source                   source5(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-780,362},{-760,382}})));
  Boundaries.Source                   source6(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-740,362},{-720,382}})));
  Boundaries.Source                   source7(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-700,362},{-680,382}})));
  Boundaries.Source                   source8(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-820,322},{-800,342}})));
  Boundaries.Source                   source9(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-780,322},{-760,342}})));
  Boundaries.Source                   source10(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-740,322},{-720,342}})));
  Boundaries.Source                   source11(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-700,322},{-680,342}})));
  Boundaries.Source                   source12(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-820,282},{-800,302}})));
  Boundaries.Source                   source13(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-780,282},{-760,302}})));
  Boundaries.Source                   source14(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-740,282},{-720,302}})));
  Boundaries.Source                   source15(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-700,282},{-680,302}})));
  Boundaries.Source                   source16(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-820,242},{-800,262}})));
  Boundaries.Source                   source17(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-780,242},{-760,262}})));
  Boundaries.Source                   source18(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-740,242},{-720,262}})));
  Boundaries.Source                   source19(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-700,242},{-680,262}})));
  Boundaries.Sink                   sink1(
    displayParameters=true,
    pressureFromInput=false,
    p0_par=100000)                       annotation (Placement(transformation(extent={{-100,100},{-80,120}})));
  Boundaries.Sink                   sink3(
    displayParameters=true,
    displayPressure=false,
    pressureFromInput=true)              annotation (Placement(transformation(extent={{-140,60},{-120,80}})));
  Boundaries.Sink                   sink4(displayParameters=true, pressureFromInput=true)
                                         annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  HeatExchangers.CounterFlowNTU counterFlowNTU(
    displayParameters=true,
    displayArea=false,
    displaykNTU=false) annotation (Placement(transformation(extent={{-20,100},{0,120}})));
  HeatExchangers.CounterFlowNTU counterFlowNTU1(
    displayParameters=true,
    displayArea=true,
    displaykNTU=false) annotation (Placement(transformation(extent={{20,100},{40,120}})));
  HeatExchangers.CounterFlowNTU counterFlowNTU2(
    displayParameters=true,
    displayArea=false,
    displaykNTU=true) annotation (Placement(transformation(extent={{60,100},{80,120}})));
  HeatExchangers.CounterFlowNTU counterFlowNTU3(
    displayParameters=true,
    displayArea=true,
    displaykNTU=true) annotation (Placement(transformation(extent={{100,100},{120,120}})));
  HeatExchangers.DiscretizedCounterFlowHEX discretizedCounterFlowHEX(displayParameters=true, displayArea=false) annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  HeatExchangers.DiscretizedCounterFlowHEX discretizedCounterFlowHEX1(displayParameters=true) annotation (Placement(transformation(extent={{20,40},{40,60}})));
  HeatExchangers.DiscretizedCounterFlowHEX_FR FR_discretizedCounterFlowHEX(displayParameters=true, displayArea=false) annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  HeatExchangers.DiscretizedCounterFlowHEX_FR discretizedCounterFlowHEX_FR1(displayParameters=true) annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Undirected.HeatExchangers.DiscretizedCounterFlowHEX discretizedCounterFlowHEX2(displayParameters=true, displayArea=false) annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Undirected.HeatExchangers.DiscretizedCounterFlowHEX discretizedCounterFlowHEX3(displayParameters=true) annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-620,400},{-600,420}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear2(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-580,400},{-560,420}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear3(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-540,400},{-520,420}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear4(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-500,400},{-480,418}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear5(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-620,360},{-600,380}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear6(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-580,360},{-560,380}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear7(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-540,360},{-520,380}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear8(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-500,360},{-480,380}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear9(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-620,320},{-600,340}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear10(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-580,320},{-560,340}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear11(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-540,320},{-520,340}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear12(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-500,320},{-480,340}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear13(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-620,280},{-600,300}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear14(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-580,280},{-560,300}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear15(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-540,280},{-520,300}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear16(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-500,280},{-480,300}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear17(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-620,240},{-600,260}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear18(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-580,240},{-560,260}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear19(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-540,240},{-520,260}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear1(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-500,240},{-480,260}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-420,400},{-400,420}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore2(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-380,400},{-360,420}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore3(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-340,400},{-320,420}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore4(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-300,400},{-280,418}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore5(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-420,360},{-400,380}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore6(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-380,360},{-360,380}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore7(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-340,360},{-320,380}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore8(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-300,360},{-280,380}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore9(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-420,320},{-400,340}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore10(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-380,320},{-360,340}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore11(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-340,320},{-320,340}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore12(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-300,320},{-280,340}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore13(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-420,280},{-400,300}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore14(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-380,280},{-360,300}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore15(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-340,280},{-320,300}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore16(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-300,280},{-280,300}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore17(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-420,240},{-400,260}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore18(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-380,240},{-360,260}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore19(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-340,240},{-320,260}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore1(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-300,240},{-280,260}})));
  Boundaries.CreateState createState(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    p_par=100000,
    T_par=293.15) annotation (Placement(transformation(extent={{-220,400},{-200,420}})));
  Boundaries.CreateState createState1(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    p_par=100000,
    T_par=293.15) annotation (Placement(transformation(extent={{-180,400},{-160,420}})));
  Boundaries.CreateState createState2(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    p_par=100000,
    T_par=293.15) annotation (Placement(transformation(extent={{-140,400},{-120,420}})));
  Boundaries.CreateState createState3(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    p_par=100000,
    T_par=293.15) annotation (Placement(transformation(extent={{-100,400},{-80,420}})));
  Boundaries.CreateState createState4(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=true,
    p_par=100000,
    T_par=293.15) annotation (Placement(transformation(extent={{-220,360},{-200,380}})));
  Boundaries.CreateState createState5(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=true,
    p_par=100000,
    T_par=293.15) annotation (Placement(transformation(extent={{-180,360},{-160,380}})));
  Boundaries.CreateState createState6(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=true,
    p_par=100000,
    T_par=293.15) annotation (Placement(transformation(extent={{-140,360},{-120,380}})));
  Boundaries.CreateState createState7(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=true,
    p_par=100000,
    T_par=293.15) annotation (Placement(transformation(extent={{-100,360},{-80,380}})));
  Boundaries.CreateState createState8(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    PFromInput=true,
    p_par=100000,
    T_par=293.15) annotation (Placement(transformation(extent={{-220,320},{-200,340}})));
  Boundaries.CreateState createState9(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    PFromInput=true,
    p_par=100000,
    T_par=293.15) annotation (Placement(transformation(extent={{-180,320},{-160,340}})));
  Boundaries.CreateState createState10(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    PFromInput=true,
    p_par=100000,
    T_par=293.15) annotation (Placement(transformation(extent={{-140,320},{-120,340}})));
  Boundaries.CreateState createState11(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    PFromInput=true,
    p_par=100000,
    T_par=293.15) annotation (Placement(transformation(extent={{-100,320},{-80,340}})));
  Boundaries.CreateState createState12(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    TFromInput=true,
    p_par=100000,
    T_par=293.15) annotation (Placement(transformation(extent={{-220,280},{-200,300}})));
  Boundaries.CreateState createState13(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    TFromInput=true,
    p_par=100000,
    T_par=293.15) annotation (Placement(transformation(extent={{-180,280},{-160,300}})));
  Boundaries.CreateState createState14(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    TFromInput=true,
    p_par=100000,
    T_par=293.15) annotation (Placement(transformation(extent={{-140,280},{-120,300}})));
  Boundaries.CreateState createState15(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    TFromInput=true,
    p_par=100000,
    T_par=293.15) annotation (Placement(transformation(extent={{-100,280},{-80,300}})));
  Boundaries.CreateState createState16(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    XiFromInput=true,
    p_par=100000,
    T_par=293.15) annotation (Placement(transformation(extent={{-220,240},{-200,260}})));
  Boundaries.CreateState createState17(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    XiFromInput=true,
    p_par=100000,
    T_par=293.15) annotation (Placement(transformation(extent={{-180,240},{-160,260}})));
  Boundaries.CreateState createState18(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    XiFromInput=true,
    p_par=100000,
    T_par=293.15) annotation (Placement(transformation(extent={{-140,240},{-120,260}})));
  Boundaries.CreateState createState19(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    XiFromInput=true,
    p_par=100000,
    T_par=293.15) annotation (Placement(transformation(extent={{-100,240},{-80,260}})));
  Processes.TransportDelay transportDelay(
    displayParameters=true,
    displayLength=false,
    displayRadius=false,
    l=1,
    r=1e-3) annotation (Placement(transformation(extent={{-820,180},{-800,200}})));
  Processes.TransportDelay transportDelay1(
    displayParameters=true,
    displayLength=false,
    displayRadius=true,
    l=1,
    r=1e-3) annotation (Placement(transformation(extent={{-780,180},{-760,200}})));
  Processes.TransportDelay transportDelay2(
    displayParameters=true,
    displayLength=true,
    displayRadius=false,
    l=1,
    r=1e-3) annotation (Placement(transformation(extent={{-740,180},{-720,200}})));
  Processes.TransportDelay transportDelay3(
    displayParameters=true,
    displayLength=true,
    displayRadius=true,
    l=1,
    r=1e-3) annotation (Placement(transformation(extent={{-700,180},{-680,200}})));
  Processes.ThermalConvectionPipe thermalConvectionPipe(
    displayParameters=true,
    displayLength=false,
    displayRadius=false) annotation (Placement(transformation(extent={{-820,140},{-800,160}})));
  Processes.ThermalConvectionPipe thermalConvectionPipe1(
    displayParameters=true,
    displayLength=true,
    displayRadius=false) annotation (Placement(transformation(extent={{-780,140},{-760,160}})));
  Processes.ThermalConvectionPipe thermalConvectionPipe2(
    displayParameters=true,
    displayLength=false,
    displayRadius=true) annotation (Placement(transformation(extent={{-740,140},{-720,160}})));
  Processes.ThermalConvectionPipe thermalConvectionPipe3(
    displayParameters=true,
    displayLength=true,
    displayRadius=true) annotation (Placement(transformation(extent={{-700,140},{-680,160}})));
  Processes.ConductionElement conductionElement(
    displayParameters=true,
    displayVolume=false,
    displayConduction=false) annotation (Placement(transformation(extent={{-820,100},{-800,120}})));
  Processes.ConductionElement conductionElement1(
    displayParameters=true,
    displayVolume=false,
    displayConduction=true) annotation (Placement(transformation(extent={{-780,100},{-760,120}})));
  Processes.ConductionElement conductionElement2(
    displayParameters=true,
    displayVolume=true,
    displayConduction=false) annotation (Placement(transformation(extent={{-740,100},{-720,120}})));
  Processes.ConductionElement conductionElement3(
    displayParameters=true,
    displayVolume=true,
    displayConduction=true) annotation (Placement(transformation(extent={{-700,100},{-680,120}})));
  Processes.ConductionElement conductionElement4(
    displayParameters=true,
    displayVolume=false,
    displayConduction=false,
    resistanceFromAU=false,
    A=1,
    U=200) annotation (Placement(transformation(extent={{-820,60},{-800,80}})));
  Processes.ConductionElement conductionElement5(
    displayParameters=true,
    displayVolume=false,
    displayConduction=true,
    resistanceFromAU=false,
    A=1,
    U=200) annotation (Placement(transformation(extent={{-780,60},{-760,80}})));
  Processes.ConductionElement conductionElement6(
    displayParameters=true,
    displayVolume=true,
    displayConduction=false,
    resistanceFromAU=false,
    A=1,
    U=200) annotation (Placement(transformation(extent={{-740,60},{-720,80}})));
  Processes.ConductionElement conductionElement7(
    displayParameters=true,
    displayVolume=true,
    displayConduction=true,
    resistanceFromAU=false,
    A=1,
    U=200) annotation (Placement(transformation(extent={{-700,60},{-680,80}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-860,-500},{860,500}}), graphics={
        Text(
          extent={{-340,-100},{0,-120}},
          textColor={28,108,200},
          textString="DynamicPressureOutflow"),
        Rectangle(
          extent={{0,-298},{-340,-120}},
          lineColor={28,108,200},
          lineThickness=1),
        Rectangle(
          extent={{340,-298},{0,-120}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{2,-100},{342,-120}},
          textColor={28,108,200},
          textString="DynamicPressureInflow"),
        Rectangle(
          extent={{-660,222},{-840,440}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-840,460},{-660,440}},
          textColor={28,108,200},
          textString="Source"),
        Rectangle(
          extent={{-60,40},{-160,140}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-160,160},{-60,140}},
          textColor={28,108,200},
          textString="Sink"),
        Rectangle(
          extent={{140,-60},{-40,140}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-40,160},{140,140}},
          textColor={28,108,200},
          textString="CounterFlowNTU"),
        Rectangle(
          extent={{-460,222},{-640,440}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-640,460},{-460,440}},
          textColor={28,108,200},
          textString="BoundaryRear"),
        Rectangle(
          extent={{-260,222},{-440,440}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-440,460},{-260,440}},
          textColor={28,108,200},
          textString="BoundaryFore"),
        Text(
          extent={{-240,460},{-60,440}},
          textColor={28,108,200},
          textString="CreateState"),
        Rectangle(
          extent={{-60,222},{-240,440}},
          lineColor={28,108,200},
          lineThickness=1)}));
end TestIconParameters;
