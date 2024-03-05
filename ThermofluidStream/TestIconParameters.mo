within ThermofluidStream;
model TestIconParameters
  extends Modelica.Icons.Example;
  inner DropOfCommons                   dropOfCommons(displayInstanceNames=true, displayParameters=false)
                                                                                  annotation (Placement(transformation(extent={{-340,280},{-320,300}})));
  Boundaries.Source                   source(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-320,102},{-300,122}})));
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
    p0_par=100000)                           annotation (Placement(transformation(extent={{-280,102},{-260,122}})));
  Boundaries.Source                   source2(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-240,102},{-220,122}})));
  Boundaries.Source                   source3(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-200,102},{-180,120}})));
  Boundaries.Source                   source4(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-320,62},{-300,82}})));
  Boundaries.Source                   source5(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-280,62},{-260,82}})));
  Boundaries.Source                   source6(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-240,62},{-220,82}})));
  Boundaries.Source                   source7(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-200,62},{-180,82}})));
  Boundaries.Source                   source8(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-320,22},{-300,42}})));
  Boundaries.Source                   source9(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-280,22},{-260,42}})));
  Boundaries.Source                   source10(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-240,22},{-220,42}})));
  Boundaries.Source                   source11(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-200,22},{-180,42}})));
  Boundaries.Source                   source12(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-320,-18},{-300,2}})));
  Boundaries.Source                   source13(
    displayParameters=true,
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-280,-18},{-260,2}})));
  Boundaries.Source                   source14(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-240,-18},{-220,2}})));
  Boundaries.Source                   source15(
    displayParameters=true,
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-200,-18},{-180,2}})));
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
    p0_par=100000)                           annotation (Placement(transformation(extent={{-320,-58},{-300,-38}})));
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
    p0_par=100000)                           annotation (Placement(transformation(extent={{-280,-58},{-260,-38}})));
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
    p0_par=100000)                           annotation (Placement(transformation(extent={{-240,-58},{-220,-38}})));
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
    p0_par=100000)                           annotation (Placement(transformation(extent={{-200,-58},{-180,-38}})));
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
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-340,-300},{340,300}}), graphics={
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
          extent={{-160,-78},{-340,140}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-340,160},{-160,140}},
          textColor={28,108,200},
          textString="Source"),
        Rectangle(
          extent={{-60,40},{-160,140}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-160,160},{-60,140}},
          textColor={28,108,200},
          textString="Sink")}));
end TestIconParameters;
