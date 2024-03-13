within ThermofluidStream;
model TestIconParameters
  extends Modelica.Icons.Example;
  inner DropOfCommons                   dropOfCommons(displayInstanceNames=true, displayParameters=true)
                                                                                  annotation (Placement(transformation(extent={{-20,480},{0,500}})));
  Boundaries.Source                   source(
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
    p0_par=100000)                       annotation (Placement(transformation(extent={{0,398},{20,418}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow(displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=false)                                                     annotation (Placement(transformation(extent={{-140,-62},{-120,-42}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow1(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=true)                                                      annotation (Placement(transformation(extent={{-100,-62},{-80,-42}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow2(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=false)                                                     annotation (Placement(transformation(extent={{-60,-62},{-40,-42}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow3(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=true)                                                      annotation (Placement(transformation(extent={{-20,-62},{0,-42}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow4(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=false)                                                     annotation (Placement(transformation(extent={{20,-62},{40,-42}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow5(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=true)                                                      annotation (Placement(transformation(extent={{60,-62},{80,-42}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow6(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=false)                                                     annotation (Placement(transformation(extent={{100,-62},{120,-42}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow7(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=true)                                                      annotation (Placement(transformation(extent={{140,-62},{160,-42}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow8(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=false,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{-140,-102},{-120,-82}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow9(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=true,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{-100,-102},{-80,-82}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow10(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=false,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{-60,-102},{-40,-82}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow11(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=true,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{-20,-102},{0,-82}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow12(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=false,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{20,-102},{40,-82}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow13(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=true,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{60,-102},{80,-82}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow14(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=false,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{100,-102},{120,-82}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow15(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=true,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{140,-102},{160,-82}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow16(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=false,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{-140,-142},{-120,-122}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow17(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=true,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{-100,-142},{-80,-122}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow18(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=false,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{-60,-142},{-40,-122}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow19(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=true,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{-20,-142},{0,-122}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow20(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=false,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{20,-142},{40,-122}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow21(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=true,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{60,-142},{80,-122}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow22(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=false,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{100,-142},{120,-122}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow23(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=true,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{140,-142},{160,-122}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow24(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=false,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{-140,-182},{-120,-162}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow25(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=true,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{-100,-182},{-80,-162}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow26(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=false,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{-60,-182},{-40,-162}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow27(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=true,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{-20,-182},{0,-162}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow28(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=false,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{20,-182},{40,-162}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow29(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=true,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{60,-182},{80,-162}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow30(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=false,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{100,-182},{120,-162}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow31(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=true,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{140,-182},{160,-162}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow2(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=false)                                          annotation (Placement(transformation(extent={{-480,-62},{-460,-42}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow3(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=true)                                           annotation (Placement(transformation(extent={{-440,-62},{-420,-42}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow4(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=true,
    displayCompressibilityApproach=false)                                          annotation (Placement(transformation(extent={{-400,-62},{-380,-42}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow5(displayParameters=true, displayOutletVelocity=false)
                                                                                   annotation (Placement(transformation(extent={{-360,-62},{-340,-42}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow6(
    displayParameters=true,
    displayInletArea=false,
    displayCompressibilityApproach=false)                                          annotation (Placement(transformation(extent={{-320,-62},{-300,-42}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow7(displayParameters=true, displayInletArea=false)
                                                                                   annotation (Placement(transformation(extent={{-280,-62},{-260,-42}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow8(
    displayParameters=true,
    displayInletArea=true,
    displayCompressibilityApproach=false)                                          annotation (Placement(transformation(extent={{-240,-62},{-220,-42}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow9(
    displayParameters=true,
    displayInletArea=true,
    displayCompressibilityApproach=true)                                           annotation (Placement(transformation(extent={{-200,-62},{-180,-42}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow10(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=false,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-480,-102},{-460,-82}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow11(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=true,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-440,-102},{-420,-82}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow12(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=true,
    displayCompressibilityApproach=false,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-400,-102},{-380,-82}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow13(
    displayParameters=true,
    displayOutletVelocity=false,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-360,-102},{-340,-82}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow14(
    displayParameters=true,
    displayInletArea=false,
    displayCompressibilityApproach=false,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-320,-102},{-300,-82}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow15(
    displayParameters=true,
    displayInletArea=false,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-280,-102},{-260,-82}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow16(
    displayParameters=true,
    displayInletArea=true,
    displayCompressibilityApproach=false,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-240,-102},{-220,-82}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow17(
    displayParameters=true,
    displayInletArea=true,
    displayCompressibilityApproach=true,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-200,-102},{-180,-82}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow18(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=false,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-480,-142},{-460,-122}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow19(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-440,-142},{-420,-122}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow20(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=true,
    displayCompressibilityApproach=false,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-400,-142},{-380,-122}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow21(
    displayParameters=true,
    displayOutletVelocity=false,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-360,-142},{-340,-122}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow22(
    displayParameters=true,
    displayInletArea=false,
    displayCompressibilityApproach=false,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-320,-142},{-300,-122}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow23(
    displayParameters=true,
    displayInletArea=false,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-280,-142},{-260,-122}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow24(
    displayParameters=true,
    displayInletArea=true,
    displayCompressibilityApproach=false,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-240,-142},{-220,-122}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow25(
    displayParameters=true,
    displayInletArea=true,
    displayCompressibilityApproach=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-200,-142},{-180,-122}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow26(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=false,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-480,-182},{-460,-162}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow27(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=true,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-440,-182},{-420,-162}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow28(
    displayParameters=true,
    displayOutletVelocity=false,
    displayInletArea=true,
    displayCompressibilityApproach=false,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-400,-182},{-380,-162}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow29(
    displayParameters=true,
    displayOutletVelocity=false,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-360,-182},{-340,-162}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow30(
    displayParameters=true,
    displayInletArea=false,
    displayCompressibilityApproach=false,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-320,-182},{-300,-162}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow31(
    displayParameters=true,
    displayInletArea=false,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-280,-182},{-260,-162}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow32(
    displayParameters=true,
    displayInletArea=true,
    displayCompressibilityApproach=false,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-240,-182},{-220,-162}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow33(
    displayParameters=true,
    displayInletArea=true,
    displayCompressibilityApproach=true,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-200,-182},{-180,-162}})));
  Boundaries.Source                   source1(
    displayPressure=false,
    displayTemperature=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-780,402},{-760,422}})));
  Boundaries.Source                   source2(
    displayPressure=true,
    displayTemperature=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-740,402},{-720,422}})));
  Boundaries.Source                   source3(
    displayPressure=true,
    displayTemperature=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-700,402},{-680,420}})));
  Boundaries.Source                   source4(
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-820,362},{-800,382}})));
  Boundaries.Source                   source5(
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-780,362},{-760,382}})));
  Boundaries.Source                   source6(
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-740,362},{-720,382}})));
  Boundaries.Source                   source7(
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-700,362},{-680,382}})));
  Boundaries.Source                   source8(
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-820,322},{-800,342}})));
  Boundaries.Source                   source9(
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-780,322},{-760,342}})));
  Boundaries.Source                   source10(
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-740,322},{-720,342}})));
  Boundaries.Source                   source11(
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-700,322},{-680,342}})));
  Boundaries.Source                   source12(
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-820,282},{-800,302}})));
  Boundaries.Source                   source13(
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-780,282},{-760,302}})));
  Boundaries.Source                   source14(
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-740,282},{-720,302}})));
  Boundaries.Source                   source15(
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-700,282},{-680,302}})));
  Boundaries.Source                   source16(
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
    p0_par=100000)                       annotation (Placement(transformation(extent={{40,398},{60,418}})));
  Boundaries.Sink                   sink3(
    displayParameters=true,
    displayPressure=false,
    pressureFromInput=true)              annotation (Placement(transformation(extent={{0,358},{20,378}})));
  Boundaries.Sink                   sink4(displayParameters=true, pressureFromInput=true)
                                         annotation (Placement(transformation(extent={{40,358},{60,378}})));
  HeatExchangers.CounterFlowNTU counterFlowNTU(
    displayParameters=true,
    displayArea=false,
    displaykNTU=false) annotation (Placement(transformation(extent={{16,212},{36,232}})));
  HeatExchangers.CounterFlowNTU counterFlowNTU1(
    displayParameters=true,
    displayArea=true,
    displaykNTU=false) annotation (Placement(transformation(extent={{56,212},{76,232}})));
  HeatExchangers.CounterFlowNTU counterFlowNTU2(
    displayParameters=true,
    displayArea=false,
    displaykNTU=true) annotation (Placement(transformation(extent={{96,212},{116,232}})));
  HeatExchangers.CounterFlowNTU counterFlowNTU3(
    displayParameters=true,
    displayArea=true,
    displaykNTU=true) annotation (Placement(transformation(extent={{136,212},{156,232}})));
  HeatExchangers.DiscretizedCounterFlowHEX discretizedCounterFlowHEX(displayParameters=true, displayArea=false) annotation (Placement(transformation(extent={{20,152},{40,172}})));
  HeatExchangers.DiscretizedCounterFlowHEX discretizedCounterFlowHEX1(displayParameters=true) annotation (Placement(transformation(extent={{56,152},{76,172}})));
  HeatExchangers.DiscretizedCounterFlowHEX_FR FR_discretizedCounterFlowHEX(displayParameters=true, displayArea=false) annotation (Placement(transformation(extent={{20,112},{40,132}})));
  HeatExchangers.DiscretizedCounterFlowHEX_FR discretizedCounterFlowHEX_FR1(displayParameters=true) annotation (Placement(transformation(extent={{56,112},{76,132}})));
  Undirected.HeatExchangers.DiscretizedCounterFlowHEX discretizedCounterFlowHEX2(displayParameters=true, displayArea=false) annotation (Placement(transformation(extent={{16,72},{36,92}})));
  Undirected.HeatExchangers.DiscretizedCounterFlowHEX discretizedCounterFlowHEX3(displayParameters=true) annotation (Placement(transformation(extent={{56,72},{76,92}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear(
    displayPressure=false,
    displayTemperature=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-620,400},{-600,420}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear2(
    displayPressure=false,
    displayTemperature=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-580,400},{-560,420}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear3(
    displayPressure=true,
    displayTemperature=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-540,400},{-520,420}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear4(
    displayPressure=true,
    displayTemperature=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-500,400},{-480,418}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear5(
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-620,360},{-600,380}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear6(
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-580,360},{-560,380}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear7(
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-540,360},{-520,380}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear8(
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-500,360},{-480,380}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear9(
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-620,320},{-600,340}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear10(
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-580,320},{-560,340}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear11(
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-540,320},{-520,340}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear12(
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-500,320},{-480,340}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear13(
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-620,280},{-600,300}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear14(
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-580,280},{-560,300}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear15(
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-540,280},{-520,300}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear16(
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-500,280},{-480,300}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear17(
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
    displayPressure=false,
    displayTemperature=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-420,400},{-400,420}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore2(
    displayPressure=false,
    displayTemperature=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-380,400},{-360,420}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore3(
    displayPressure=true,
    displayTemperature=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-340,400},{-320,420}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore4(
    displayPressure=true,
    displayTemperature=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-300,400},{-280,418}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore5(
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-420,360},{-400,380}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore6(
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-380,360},{-360,380}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore7(
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-340,360},{-320,380}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore8(
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-300,360},{-280,380}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore9(
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-420,320},{-400,340}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore10(
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-380,320},{-360,340}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore11(
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-340,320},{-320,340}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore12(
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-300,320},{-280,340}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore13(
    displayPressure=false,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-420,280},{-400,300}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore14(
    displayPressure=false,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-380,280},{-360,300}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore15(
    displayPressure=true,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-340,280},{-320,300}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore16(
    displayPressure=true,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000)                           annotation (Placement(transformation(extent={{-300,280},{-280,300}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore17(
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
    r=1e-3) annotation (Placement(transformation(extent={{264,244},{284,264}})));
  Processes.TransportDelay transportDelay1(
    displayParameters=true,
    displayLength=false,
    displayRadius=true,
    l=1,
    r=1e-3) annotation (Placement(transformation(extent={{304,244},{324,264}})));
  Processes.TransportDelay transportDelay2(
    displayParameters=true,
    displayLength=true,
    displayRadius=false,
    l=1,
    r=1e-3) annotation (Placement(transformation(extent={{344,244},{364,264}})));
  Processes.TransportDelay transportDelay3(
    displayParameters=true,
    displayLength=true,
    displayRadius=true,
    l=1,
    r=1e-3) annotation (Placement(transformation(extent={{384,244},{404,264}})));
  Processes.ThermalConvectionPipe thermalConvectionPipe(
    displayParameters=true,
    displayLength=false,
    displayRadius=false) annotation (Placement(transformation(extent={{264,204},{284,224}})));
  Processes.ThermalConvectionPipe thermalConvectionPipe1(
    displayParameters=true,
    displayLength=true,
    displayRadius=false) annotation (Placement(transformation(extent={{304,204},{324,224}})));
  Processes.ThermalConvectionPipe thermalConvectionPipe2(
    displayParameters=true,
    displayLength=false,
    displayRadius=true) annotation (Placement(transformation(extent={{344,204},{364,224}})));
  Processes.ThermalConvectionPipe thermalConvectionPipe3(
    displayParameters=true,
    displayLength=true,
    displayRadius=true) annotation (Placement(transformation(extent={{384,204},{404,224}})));
  Processes.ConductionElement conductionElement(
    displayParameters=true,
    displayVolume=false,
    displayConduction=false) annotation (Placement(transformation(extent={{260,160},{280,180}})));
  Processes.ConductionElement conductionElement1(
    displayParameters=true,
    displayVolume=false,
    displayConduction=true) annotation (Placement(transformation(extent={{300,160},{320,180}})));
  Processes.ConductionElement conductionElement2(
    displayParameters=true,
    displayVolume=true,
    displayConduction=false) annotation (Placement(transformation(extent={{340,160},{360,180}})));
  Processes.ConductionElement conductionElement3(
    displayParameters=true,
    displayVolume=true,
    displayConduction=true) annotation (Placement(transformation(extent={{380,160},{400,180}})));
  Processes.ConductionElement conductionElement4(
    displayParameters=true,
    displayVolume=false,
    displayConduction=false,
    resistanceFromAU=false,
    A=1,
    U=200) annotation (Placement(transformation(extent={{264,124},{284,144}})));
  Processes.ConductionElement conductionElement5(
    displayParameters=true,
    displayVolume=false,
    displayConduction=true,
    resistanceFromAU=false,
    A=1,
    U=200) annotation (Placement(transformation(extent={{304,124},{324,144}})));
  Processes.ConductionElement conductionElement6(
    displayParameters=true,
    displayVolume=true,
    displayConduction=false,
    resistanceFromAU=false,
    A=1,
    U=200) annotation (Placement(transformation(extent={{344,124},{364,144}})));
  Processes.ConductionElement conductionElement7(
    displayParameters=true,
    displayVolume=true,
    displayConduction=true,
    resistanceFromAU=false,
    A=1,
    U=200) annotation (Placement(transformation(extent={{384,124},{404,144}})));
  Boundaries.Source                   source20(
    displayPressure=false,
    displayTemperature=false,
    displayInertance=true,
    pressureFromInput=false,
    temperatureFromInput=false,
    xiFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-822,200},{-802,220}})));
  Boundaries.Source                   source21(
    displayPressure=false,
    displayTemperature=true,
    displayInertance=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-782,200},{-762,220}})));
  Boundaries.Source                   source22(
    displayPressure=true,
    displayTemperature=false,
    displayInertance=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-742,200},{-722,220}})));
  Boundaries.Source                   source23(
    displayPressure=true,
    displayTemperature=true,
    displayInertance=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-702,200},{-682,218}})));
  Boundaries.Source                   source24(
    displayPressure=false,
    displayTemperature=false,
    displayInertance=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-822,160},{-802,180}})));
  Boundaries.Source                   source25(
    displayPressure=false,
    displayTemperature=true,
    displayInertance=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-782,160},{-762,180}})));
  Boundaries.Source                   source26(
    displayPressure=true,
    displayTemperature=false,
    displayInertance=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-742,160},{-722,180}})));
  Boundaries.Source                   source27(
    displayPressure=true,
    displayTemperature=true,
    displayInertance=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-702,160},{-682,180}})));
  Boundaries.Source                   source28(
    displayPressure=false,
    displayTemperature=false,
    displayInertance=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-822,120},{-802,140}})));
  Boundaries.Source                   source29(
    displayPressure=false,
    displayTemperature=true,
    displayInertance=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-782,120},{-762,140}})));
  Boundaries.Source                   source30(
    displayPressure=true,
    displayTemperature=false,
    displayInertance=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-742,120},{-722,140}})));
  Boundaries.Source                   source31(
    displayPressure=true,
    displayTemperature=true,
    displayInertance=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-702,120},{-682,140}})));
  Boundaries.Source                   source32(
    displayPressure=false,
    displayTemperature=false,
    displayInertance=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-822,80},{-802,100}})));
  Boundaries.Source                   source33(
    displayPressure=false,
    displayTemperature=true,
    displayInertance=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-782,80},{-762,100}})));
  Boundaries.Source                   source34(
    displayPressure=true,
    displayTemperature=false,
    displayInertance=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-742,80},{-722,100}})));
  Boundaries.Source                   source35(
    displayPressure=true,
    displayTemperature=true,
    displayInertance=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-702,80},{-682,100}})));
  Boundaries.Source                   source36(
    displayPressure=false,
    displayTemperature=false,
    displayInertance=true,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-822,40},{-802,60}})));
  Boundaries.Source                   source37(
    displayPressure=false,
    displayTemperature=true,
    displayInertance=true,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-782,40},{-762,60}})));
  Boundaries.Source                   source38(
    displayPressure=true,
    displayTemperature=false,
    displayInertance=true,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-742,40},{-722,60}})));
  Boundaries.Source                   source39(
    displayPressure=true,
    displayTemperature=true,
    displayInertance=true,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-702,40},{-682,60}})));
  Boundaries.Sink                   sink5(
    displayParameters=true,
    displayPressure=false,
    displayInertance=true,
    pressureFromInput=false,
    p0_par=100000,
    L=1)                                 annotation (Placement(transformation(extent={{80,400},{100,420}})));
  Boundaries.Sink                   sink6(
    displayParameters=true,
    displayInertance=true,
    pressureFromInput=false,
    p0_par=100000,
    L=1)                                 annotation (Placement(transformation(extent={{120,400},{140,420}})));
  Boundaries.Sink                   sink7(
    displayParameters=true,
    displayPressure=false,
    displayInertance=true,
    pressureFromInput=true,
    L=1)                                 annotation (Placement(transformation(extent={{80,360},{100,380}})));
  Boundaries.Sink                   sink8(
    displayParameters=true,
    displayInertance=true,
    pressureFromInput=true,
    L=1)                                 annotation (Placement(transformation(extent={{120,360},{140,380}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear20(
    displayPressure=false,
    displayTemperature=false,
    displayInertance=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-618,200},{-598,220}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear21(
    displayPressure=false,
    displayTemperature=true,
    displayInertance=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-578,200},{-558,220}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear22(
    displayPressure=true,
    displayTemperature=false,
    displayInertance=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-538,200},{-518,220}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear23(
    displayPressure=true,
    displayTemperature=true,
    displayInertance=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-498,200},{-478,218}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear24(
    displayPressure=false,
    displayTemperature=false,
    displayInertance=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-618,160},{-598,180}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear25(
    displayPressure=false,
    displayTemperature=true,
    displayInertance=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-578,160},{-558,180}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear26(
    displayPressure=true,
    displayTemperature=false,
    displayInertance=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-538,160},{-518,180}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear27(
    displayPressure=true,
    displayTemperature=true,
    displayInertance=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-498,160},{-478,180}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear28(
    displayPressure=false,
    displayTemperature=false,
    displayInertance=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-618,120},{-598,140}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear29(
    displayPressure=false,
    displayTemperature=true,
    displayInertance=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-578,120},{-558,140}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear30(
    displayPressure=true,
    displayTemperature=false,
    displayInertance=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-538,120},{-518,140}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear31(
    displayPressure=true,
    displayTemperature=true,
    displayInertance=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-498,120},{-478,140}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear32(
    displayPressure=false,
    displayTemperature=false,
    displayInertance=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-618,80},{-598,100}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear33(
    displayPressure=false,
    displayTemperature=true,
    displayInertance=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-578,80},{-558,100}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear34(
    displayPressure=true,
    displayTemperature=false,
    displayInertance=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-538,80},{-518,100}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear35(
    displayPressure=true,
    displayTemperature=true,
    displayInertance=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-498,80},{-478,100}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear36(
    displayPressure=false,
    displayTemperature=false,
    displayInertance=true,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-618,40},{-598,60}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear37(
    displayPressure=false,
    displayTemperature=true,
    displayInertance=true,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-578,40},{-558,60}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear38(
    displayPressure=true,
    displayTemperature=false,
    displayInertance=true,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-538,40},{-518,60}})));
  Undirected.Boundaries.BoundaryRear  boundaryRear39(
    displayPressure=true,
    displayTemperature=true,
    displayInertance=true,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-498,40},{-478,60}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore20(
    displayParameters=true,
    displayPressure=false,
    displayInertance=true,
    displayTemperature=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-420,200},{-400,220}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore21(
    displayParameters=true,
    displayPressure=false,
    displayInertance=true,
    displayTemperature=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-380,200},{-360,220}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore22(
    displayParameters=true,
    displayPressure=true,
    displayInertance=true,
    displayTemperature=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-340,200},{-320,220}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore23(
    displayParameters=true,
    displayPressure=true,
    displayInertance=true,
    displayTemperature=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-300,200},{-280,218}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore24(
    displayParameters=true,
    displayPressure=false,
    displayInertance=true,
    displayTemperature=false,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-420,160},{-400,180}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore25(
    displayParameters=true,
    displayPressure=false,
    displayInertance=true,
    displayTemperature=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-380,160},{-360,180}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore26(
    displayParameters=true,
    displayPressure=true,
    displayInertance=true,
    displayTemperature=false,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-340,160},{-320,180}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore27(
    displayParameters=true,
    displayPressure=true,
    displayInertance=true,
    displayTemperature=true,
    setEnthalpy=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-300,160},{-280,180}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore28(
    displayParameters=true,
    displayPressure=false,
    displayInertance=true,
    displayTemperature=false,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-420,120},{-400,140}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore29(
    displayParameters=true,
    displayPressure=false,
    displayInertance=true,
    displayTemperature=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-380,120},{-360,140}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore30(
    displayParameters=true,
    displayPressure=true,
    displayInertance=true,
    displayTemperature=false,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-340,120},{-320,140}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore31(
    displayParameters=true,
    displayPressure=true,
    displayInertance=true,
    displayTemperature=true,
    setEnthalpy=false,
    temperatureFromInput=true,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-300,120},{-280,140}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore32(
    displayParameters=true,
    displayPressure=false,
    displayInertance=true,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-420,80},{-400,100}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore33(
    displayParameters=true,
    displayPressure=false,
    displayInertance=true,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-380,80},{-360,100}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore34(
    displayParameters=true,
    displayPressure=true,
    displayInertance=true,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-340,80},{-320,100}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore35(
    displayParameters=true,
    displayPressure=true,
    displayInertance=true,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=true,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-300,80},{-280,100}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore36(
    displayParameters=true,
    displayPressure=false,
    displayInertance=true,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-420,40},{-400,60}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore37(
    displayParameters=true,
    displayPressure=false,
    displayInertance=true,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-380,40},{-360,60}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore38(
    displayParameters=true,
    displayPressure=true,
    displayInertance=true,
    displayTemperature=false,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-340,40},{-320,60}})));
  Undirected.Boundaries.BoundaryFore  boundaryFore39(
    displayParameters=true,
    displayPressure=true,
    displayInertance=true,
    displayTemperature=true,
    setEnthalpy=false,
    pressureFromInput=false,
    temperatureFromInput=false,
    enthalpyFromInput=false,
    xiFromInput=true,
    T0_par=293.15,
    p0_par=100000,
    L=1)                                     annotation (Placement(transformation(extent={{-300,40},{-280,60}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow32(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=false,
    displayInertance=true)                                                       annotation (Placement(transformation(extent={{-140,-232},{-120,-212}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow33(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=true,
    displayInertance=true)                                                       annotation (Placement(transformation(extent={{-100,-232},{-80,-212}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow34(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=false,
    displayInertance=true)                                                       annotation (Placement(transformation(extent={{-60,-232},{-40,-212}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow35(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=true,
    displayInertance=true)                                                       annotation (Placement(transformation(extent={{-20,-232},{0,-212}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow36(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=false,
    displayInertance=true)                                                       annotation (Placement(transformation(extent={{20,-232},{40,-212}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow37(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=true,
    displayInertance=true)                                                       annotation (Placement(transformation(extent={{60,-232},{80,-212}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow38(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=false,
    displayInertance=true)                                                       annotation (Placement(transformation(extent={{100,-232},{120,-212}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow39(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=true,
    displayInertance=true)                                                       annotation (Placement(transformation(extent={{140,-232},{160,-212}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow40(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=false,
    displayInertance=true,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{-140,-272},{-120,-252}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow41(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=true,
    displayInertance=true,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{-100,-272},{-80,-252}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow42(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=false,
    displayInertance=true,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{-60,-272},{-40,-252}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow43(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=true,
    displayInertance=true,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{-20,-272},{0,-252}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow44(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=false,
    displayInertance=true,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{20,-272},{40,-252}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow45(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=true,
    displayInertance=true,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{60,-272},{80,-252}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow46(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=false,
    displayInertance=true,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{100,-272},{120,-252}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow47(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=true,
    displayInertance=true,
    velocityFromInput=true)                                                      annotation (Placement(transformation(extent={{140,-272},{160,-252}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow48(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=false,
    displayInertance=true,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{-140,-312},{-120,-292}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow49(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=true,
    displayInertance=true,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{-100,-312},{-80,-292}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow50(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=false,
    displayInertance=true,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{-60,-312},{-40,-292}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow51(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=true,
    displayInertance=true,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{-20,-312},{0,-292}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow52(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=false,
    displayInertance=true,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{20,-312},{40,-292}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow53(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=true,
    displayInertance=true,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{60,-312},{80,-292}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow54(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=false,
    displayInertance=true,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{100,-312},{120,-292}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow55(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=true,
    displayInertance=true,
    velocityFromInput=false,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{140,-312},{160,-292}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow56(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=false,
    displayInertance=true,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{-140,-352},{-120,-332}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow57(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=false,
    displayInletVelocity=false,
    displayOutletArea=true,
    displayInertance=true,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{-100,-352},{-80,-332}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow58(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=false,
    displayInertance=true,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{-60,-352},{-40,-332}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow59(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=false,
    displayInletVelocity=true,
    displayOutletArea=true,
    displayInertance=true,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{-20,-352},{0,-332}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow60(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=false,
    displayInertance=true,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{20,-352},{40,-332}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow61(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=true,
    displayInletVelocity=false,
    displayOutletArea=true,
    displayInertance=true,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{60,-352},{80,-332}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow62(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=false,
    displayInertance=true,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{100,-352},{120,-332}})));
  Boundaries.DynamicPressureInflow dynamicPressureInflow63(
    displayParameters=true,
    L=1,
    displayCompressibilityApproach=true,
    displayInletVelocity=true,
    displayOutletArea=true,
    displayInertance=true,
    velocityFromInput=true,
    areaFromInput=true)                                                          annotation (Placement(transformation(extent={{140,-352},{160,-332}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow1(
    displayParameters=true,
    L=1,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=false,
    displayInertance=true)                                                         annotation (Placement(transformation(extent={{-480,-232},{-460,-212}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow34(
    displayParameters=true,
    L=1,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=true,
    displayInertance=true)                                                         annotation (Placement(transformation(extent={{-440,-232},{-420,-212}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow35(
    displayParameters=true,
    L=1,
    displayOutletVelocity=false,
    displayInletArea=true,
    displayCompressibilityApproach=false,
    displayInertance=true)                                                         annotation (Placement(transformation(extent={{-400,-232},{-380,-212}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow36(
    displayParameters=true,
    L=1,
    displayOutletVelocity=false,
    displayInertance=true)                                                         annotation (Placement(transformation(extent={{-360,-232},{-340,-212}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow37(
    displayParameters=true,
    L=1,
    displayInletArea=false,
    displayCompressibilityApproach=false,
    displayInertance=true)                                                         annotation (Placement(transformation(extent={{-320,-232},{-300,-212}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow38(
    displayParameters=true,
    L=1,
    displayInletArea=false,
    displayInertance=true)                                                         annotation (Placement(transformation(extent={{-280,-232},{-260,-212}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow39(
    displayParameters=true,
    L=1,
    displayInletArea=true,
    displayCompressibilityApproach=false,
    displayInertance=true)                                                         annotation (Placement(transformation(extent={{-240,-232},{-220,-212}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow40(
    displayParameters=true,
    L=1,
    displayInletArea=true,
    displayCompressibilityApproach=true,
    displayInertance=true)                                                         annotation (Placement(transformation(extent={{-200,-232},{-180,-212}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow41(
    displayParameters=true,
    L=1,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=false,
    displayInertance=true,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-480,-272},{-460,-252}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow42(
    displayParameters=true,
    L=1,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=true,
    displayInertance=true,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-440,-272},{-420,-252}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow43(
    displayParameters=true,
    L=1,
    displayOutletVelocity=false,
    displayInletArea=true,
    displayCompressibilityApproach=false,
    displayInertance=true,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-400,-272},{-380,-252}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow44(
    displayParameters=true,
    L=1,
    displayOutletVelocity=false,
    displayInertance=true,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-360,-272},{-340,-252}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow45(
    displayParameters=true,
    L=1,
    displayInletArea=false,
    displayCompressibilityApproach=false,
    displayInertance=true,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-320,-272},{-300,-252}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow46(
    displayParameters=true,
    L=1,
    displayInletArea=false,
    displayInertance=true,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-280,-272},{-260,-252}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow47(
    displayParameters=true,
    L=1,
    displayInletArea=true,
    displayCompressibilityApproach=false,
    displayInertance=true,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-240,-272},{-220,-252}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow48(
    displayParameters=true,
    L=1,
    displayInletArea=true,
    displayCompressibilityApproach=true,
    displayInertance=true,
    areaFromInput=true)                                                            annotation (Placement(transformation(extent={{-200,-272},{-180,-252}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow49(
    displayParameters=true,
    L=1,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=false,
    displayInertance=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-480,-312},{-460,-292}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow50(
    displayParameters=true,
    L=1,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=true,
    displayInertance=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-440,-312},{-420,-292}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow51(
    displayParameters=true,
    L=1,
    displayOutletVelocity=false,
    displayInletArea=true,
    displayCompressibilityApproach=false,
    displayInertance=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-400,-312},{-380,-292}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow52(
    displayParameters=true,
    L=1,
    displayOutletVelocity=false,
    displayInertance=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-360,-312},{-340,-292}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow53(
    displayParameters=true,
    L=1,
    displayInletArea=false,
    displayCompressibilityApproach=false,
    displayInertance=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-320,-312},{-300,-292}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow54(
    displayParameters=true,
    L=1,
    displayInletArea=false,
    displayInertance=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-280,-312},{-260,-292}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow55(
    displayParameters=true,
    L=1,
    displayInletArea=true,
    displayCompressibilityApproach=false,
    displayInertance=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-240,-312},{-220,-292}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow56(
    displayParameters=true,
    L=1,
    displayInletArea=true,
    displayCompressibilityApproach=true,
    displayInertance=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-200,-312},{-180,-292}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow57(
    displayParameters=true,
    L=1,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=false,
    displayInertance=true,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-480,-352},{-460,-332}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow58(
    displayParameters=true,
    L=1,
    displayOutletVelocity=false,
    displayInletArea=false,
    displayCompressibilityApproach=true,
    displayInertance=true,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-440,-352},{-420,-332}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow59(
    displayParameters=true,
    L=1,
    displayOutletVelocity=false,
    displayInletArea=true,
    displayCompressibilityApproach=false,
    displayInertance=true,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-400,-352},{-380,-332}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow60(
    displayParameters=true,
    L=1,
    displayOutletVelocity=false,
    displayInertance=true,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-360,-352},{-340,-332}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow61(
    displayParameters=true,
    L=1,
    displayInletArea=false,
    displayCompressibilityApproach=false,
    displayInertance=true,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-320,-352},{-300,-332}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow62(
    displayParameters=true,
    L=1,
    displayInletArea=false,
    displayInertance=true,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-280,-352},{-260,-332}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow63(
    displayParameters=true,
    L=1,
    displayInletArea=true,
    displayCompressibilityApproach=false,
    displayInertance=true,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-240,-352},{-220,-332}})));
  Boundaries.DynamicPressureOutflow dynamicPressureOutflow64(
    displayParameters=true,
    L=1,
    displayInletArea=true,
    displayCompressibilityApproach=true,
    displayInertance=true,
    areaFromInput=true,
    velocityFromInput=true)                                                        annotation (Placement(transformation(extent={{-200,-352},{-180,-332}})));
  Processes.Nozzle nozzle(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=false,
    displayOutletArea=false,
    displayInertance=false,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-820,-62},{-800,-42}})));
  Processes.Nozzle nozzle1(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=false,
    displayOutletArea=true,
    displayInertance=false,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-780,-62},{-760,-42}})));
  Processes.Nozzle nozzle2(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=true,
    displayOutletArea=false,
    displayInertance=false,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-740,-62},{-720,-42}})));
  Processes.Nozzle nozzle3(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=true,
    displayOutletArea=true,
    displayInertance=false,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-700,-62},{-680,-42}})));
  Processes.Nozzle nozzle4(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=false,
    displayOutletArea=false,
    displayInertance=false,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-660,-62},{-640,-42}})));
  Processes.Nozzle nozzle5(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=false,
    displayOutletArea=true,
    displayInertance=false,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-620,-62},{-600,-42}})));
  Processes.Nozzle nozzle6(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=true,
    displayOutletArea=false,
    displayInertance=false,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-580,-62},{-560,-42}})));
  Processes.Nozzle nozzle7(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=true,
    displayOutletArea=true,
    displayInertance=false,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-540,-62},{-520,-42}})));
  Processes.Nozzle nozzle8(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=false,
    displayOutletArea=false,
    displayInertance=false,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-820,-102},{-800,-82}})));
  Processes.Nozzle nozzle9(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=false,
    displayOutletArea=true,
    displayInertance=false,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-780,-102},{-760,-82}})));
  Processes.Nozzle nozzle10(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=true,
    displayOutletArea=false,
    displayInertance=false,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-740,-102},{-720,-82}})));
  Processes.Nozzle nozzle11(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=true,
    displayOutletArea=true,
    displayInertance=false,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-700,-102},{-680,-82}})));
  Processes.Nozzle nozzle12(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=false,
    displayOutletArea=false,
    displayInertance=false,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-660,-102},{-640,-82}})));
  Processes.Nozzle nozzle13(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=false,
    displayOutletArea=true,
    displayInertance=false,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-620,-102},{-600,-82}})));
  Processes.Nozzle nozzle14(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=true,
    displayOutletArea=false,
    displayInertance=false,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-580,-102},{-560,-82}})));
  Processes.Nozzle nozzle15(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=true,
    displayOutletArea=true,
    displayInertance=false,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-540,-102},{-520,-82}})));
  Processes.Nozzle nozzle16(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=false,
    displayOutletArea=false,
    displayInertance=false,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-820,-142},{-800,-122}})));
  Processes.Nozzle nozzle17(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=false,
    displayOutletArea=true,
    displayInertance=false,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-780,-142},{-760,-122}})));
  Processes.Nozzle nozzle18(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=true,
    displayOutletArea=false,
    displayInertance=false,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-740,-142},{-720,-122}})));
  Processes.Nozzle nozzle19(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=true,
    displayOutletArea=true,
    displayInertance=false,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-700,-142},{-680,-122}})));
  Processes.Nozzle nozzle20(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=false,
    displayOutletArea=false,
    displayInertance=false,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-660,-142},{-640,-122}})));
  Processes.Nozzle nozzle21(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=false,
    displayOutletArea=true,
    displayInertance=false,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-620,-142},{-600,-122}})));
  Processes.Nozzle nozzle22(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=true,
    displayOutletArea=false,
    displayInertance=false,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-580,-142},{-560,-122}})));
  Processes.Nozzle nozzle23(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=true,
    displayOutletArea=true,
    displayInertance=false,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-540,-142},{-520,-122}})));
  Processes.Nozzle nozzle24(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=false,
    displayOutletArea=false,
    displayInertance=false,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-820,-182},{-800,-162}})));
  Processes.Nozzle nozzle25(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=false,
    displayOutletArea=true,
    displayInertance=false,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-780,-182},{-760,-162}})));
  Processes.Nozzle nozzle26(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=true,
    displayOutletArea=false,
    displayInertance=false,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-740,-182},{-720,-162}})));
  Processes.Nozzle nozzle27(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=true,
    displayOutletArea=true,
    displayInertance=false,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-700,-182},{-680,-162}})));
  Processes.Nozzle nozzle28(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=false,
    displayOutletArea=false,
    displayInertance=false,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-660,-182},{-640,-162}})));
  Processes.Nozzle nozzle29(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=false,
    displayOutletArea=true,
    displayInertance=false,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-620,-182},{-600,-162}})));
  Processes.Nozzle nozzle30(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=true,
    displayOutletArea=false,
    displayInertance=false,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-580,-182},{-560,-162}})));
  Processes.Nozzle nozzle31(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=true,
    displayOutletArea=true,
    displayInertance=false,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-540,-182},{-520,-162}})));
  Processes.Nozzle nozzle32(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=false,
    displayOutletArea=false,
    displayInertance=true,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-820,-222},{-800,-202}})));
  Processes.Nozzle nozzle33(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=false,
    displayOutletArea=true,
    displayInertance=true,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-780,-222},{-760,-202}})));
  Processes.Nozzle nozzle34(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=true,
    displayOutletArea=false,
    displayInertance=true,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-740,-222},{-720,-202}})));
  Processes.Nozzle nozzle35(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=true,
    displayOutletArea=true,
    displayInertance=true,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-700,-222},{-680,-202}})));
  Processes.Nozzle nozzle36(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=false,
    displayOutletArea=false,
    displayInertance=true,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-660,-222},{-640,-202}})));
  Processes.Nozzle nozzle37(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=false,
    displayOutletArea=true,
    displayInertance=true,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-620,-222},{-600,-202}})));
  Processes.Nozzle nozzle38(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=true,
    displayOutletArea=false,
    displayInertance=true,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-580,-222},{-560,-202}})));
  Processes.Nozzle nozzle39(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=true,
    displayOutletArea=true,
    displayInertance=true,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-540,-222},{-520,-202}})));
  Processes.Nozzle nozzle40(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=false,
    displayOutletArea=false,
    displayInertance=true,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-820,-262},{-800,-242}})));
  Processes.Nozzle nozzle41(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=false,
    displayOutletArea=true,
    displayInertance=true,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-780,-262},{-760,-242}})));
  Processes.Nozzle nozzle42(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=true,
    displayOutletArea=false,
    displayInertance=true,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-740,-262},{-720,-242}})));
  Processes.Nozzle nozzle43(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=true,
    displayOutletArea=true,
    displayInertance=true,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-700,-262},{-680,-242}})));
  Processes.Nozzle nozzle44(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=false,
    displayOutletArea=false,
    displayInertance=true,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-660,-262},{-640,-242}})));
  Processes.Nozzle nozzle45(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=false,
    displayOutletArea=true,
    displayInertance=true,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-620,-262},{-600,-242}})));
  Processes.Nozzle nozzle46(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=true,
    displayOutletArea=false,
    displayInertance=true,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-580,-262},{-560,-242}})));
  Processes.Nozzle nozzle47(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=true,
    displayOutletArea=true,
    displayInertance=true,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=false,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-540,-262},{-520,-242}})));
  Processes.Nozzle nozzle48(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=false,
    displayOutletArea=false,
    displayInertance=true,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-820,-302},{-800,-282}})));
  Processes.Nozzle nozzle49(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=false,
    displayOutletArea=true,
    displayInertance=true,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-780,-302},{-760,-282}})));
  Processes.Nozzle nozzle50(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=true,
    displayOutletArea=false,
    displayInertance=true,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-740,-302},{-720,-282}})));
  Processes.Nozzle nozzle51(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=true,
    displayOutletArea=true,
    displayInertance=true,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-700,-302},{-680,-282}})));
  Processes.Nozzle nozzle52(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=false,
    displayOutletArea=false,
    displayInertance=true,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-660,-302},{-640,-282}})));
  Processes.Nozzle nozzle53(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=false,
    displayOutletArea=true,
    displayInertance=true,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-620,-302},{-600,-282}})));
  Processes.Nozzle nozzle54(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=true,
    displayOutletArea=false,
    displayInertance=true,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-580,-302},{-560,-282}})));
  Processes.Nozzle nozzle55(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=true,
    displayOutletArea=true,
    displayInertance=true,
    area_in_FromInput=false,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-540,-302},{-520,-282}})));
  Processes.Nozzle nozzle56(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=false,
    displayOutletArea=false,
    displayInertance=true,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-820,-342},{-800,-322}})));
  Processes.Nozzle nozzle57(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=false,
    displayOutletArea=true,
    displayInertance=true,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-780,-342},{-760,-322}})));
  Processes.Nozzle nozzle58(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=true,
    displayOutletArea=false,
    displayInertance=true,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-740,-342},{-720,-322}})));
  Processes.Nozzle nozzle59(
    displayParameters=true,
    displayCompressibilityApproach=false,
    displayInletArea=true,
    displayOutletArea=true,
    displayInertance=true,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-700,-342},{-680,-322}})));
  Processes.Nozzle nozzle60(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=false,
    displayOutletArea=false,
    displayInertance=true,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-660,-342},{-640,-322}})));
  Processes.Nozzle nozzle61(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=false,
    displayOutletArea=true,
    displayInertance=true,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-620,-342},{-600,-322}})));
  Processes.Nozzle nozzle62(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=true,
    displayOutletArea=false,
    displayInertance=true,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-580,-342},{-560,-322}})));
  Processes.Nozzle nozzle63(
    displayParameters=true,
    displayCompressibilityApproach=true,
    displayInletArea=true,
    displayOutletArea=true,
    displayInertance=true,
    area_in_FromInput=true,
    A_in=1,
    area_out_FromInput=true,
    A_out=2,
    assumeConstantDensity=false,
    L_value=0.5) annotation (Placement(transformation(extent={{-540,-342},{-520,-322}})));
  Processes.Pump pump annotation (Placement(transformation(extent={{-200,180},{-180,200}})));
  Processes.Compressor compressor annotation (Placement(transformation(extent={{-140,180},{-120,200}})));
  Processes.Turbine turbine annotation (Placement(transformation(extent={{-80,180},{-60,200}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-860,-500},{860,500}}), graphics={
        Text(
          extent={{-500,-2},{-160,-22}},
          textColor={28,108,200},
          textString="DynamicPressureOutflow"),
        Rectangle(
          extent={{-160,-402},{-500,-22}},
          lineColor={28,108,200},
          lineThickness=1),
        Rectangle(
          extent={{182,-402},{-160,-22}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-158,-2},{182,-22}},
          textColor={28,108,200},
          textString="DynamicPressureInflow"),
        Rectangle(
          extent={{-660,20},{-840,438}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-840,460},{-660,440}},
          textColor={28,108,200},
          textString="Source"),
        Rectangle(
          extent={{160,340},{-20,438}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-20,458},{160,438}},
          textColor={28,108,200},
          textString="Sink"),
        Rectangle(
          extent={{176,52},{-4,252}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-4,272},{176,252}},
          textColor={28,108,200},
          textString="CounterFlowNTU"),
        Rectangle(
          extent={{-460,20},{-640,440}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-640,460},{-460,440}},
          textColor={28,108,200},
          textString="BoundaryRear"),
        Rectangle(
          extent={{-260,20},{-440,440}},
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
          lineThickness=1),
        Rectangle(
          extent={{-500,-402},{-840,-22}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-840,-2},{-500,-22}},
          textColor={28,108,200},
          textString="Nozzle")}));
end TestIconParameters;
