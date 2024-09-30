within ThermofluidStream.Media.myMedia;
package Incompressible
  "Medium model for T-dependent properties, defined by tables or polynomials"
  extends Modelica.Icons.VariantsPackage;
  import Modelica.Constants;
  import Modelica.Math;

  package Examples "Examples for incompressible media"
    extends Modelica.Icons.VariantsPackage;

  package Glycol47 "1,2-Propylene glycol, 47% mixture with water"
    extends TableBased(
      mediumName="Glycol-Water 47%",
      T_min = Cv.from_degC(-30), T_max = Cv.from_degC(100),
      TinK = false, T0=273.15,
      tableDensity=
        [-30, 1066; -20, 1062; -10, 1058; 0, 1054;
         20, 1044; 40, 1030; 60, 1015; 80, 999; 100, 984],
      tableHeatCapacity=
        [-30, 3450; -20, 3490; -10, 3520; 0, 3560;
         20, 3620; 40, 3690; 60, 3760; 80, 3820; 100, 3890],
      tableConductivity=
        [-30,0.397;  -20,0.396;  -10,0.395;  0,0.395;
         20,0.394;  40,0.393;  60,0.392;  80,0.391;  100,0.390],
      tableViscosity=
        [-30, 0.160; -20, 0.0743; -10, 0.0317; 0, 0.0190;
         20, 0.00626; 40, 0.00299; 60, 0.00162; 80, 0.00110; 100, 0.00081],
      tableVaporPressure=
        [0, 500; 20, 1.9e3; 40, 5.3e3; 60, 16e3; 80, 37e3; 100, 80e3]);
      annotation (Documentation(info="<html>

</html>"));
  end Glycol47;

  package Essotherm650 "Essotherm thermal oil"
    extends TableBased(
      mediumName="Essotherm 650",
      T_min = Cv.from_degC(0), T_max = Cv.from_degC(320),
      TinK = false, T0=273.15,
      tableDensity=
        [0, 909; 20, 897; 40, 884; 60, 871; 80, 859; 100, 846;
         150, 813; 200, 781; 250, 748; 300, 715; 320, 702],
      tableHeatCapacity=
        [0, 1770; 20, 1850; 40, 1920; 60, 1990; 80, 2060; 100, 2130;
         150, 2310; 200, 2490; 250, 2670; 300, 2850; 320, 2920],
      tableConductivity=
        [0,0.1302;  20,0.1288;  40,0.1274;  60,0.1260;  80,0.1246;  100,0.1232;
         150,0.1197;  200,0.1163;  250,0.1128;  300,0.1093;  320,0.1079],
      tableViscosity = [0, 14370; 20, 1917; 40, 424; 60, 134; 80, 54.5;
         100, 26.64; 150, 7.47; 200, 3.22; 250, 1.76; 300, 1.10; 320,0.94],
      tableVaporPressure=
        [160, 3; 180, 10; 200, 40; 220, 100; 240, 300; 260, 600;
         280, 1600; 300, 3e3; 320, 5.5e3]);
      annotation (Documentation(info="<html>

</html>"));
  end Essotherm650;

  model TestGlycol "Test Glycol47 Medium model"
    extends Modelica.Icons.Example;
    package Medium = Glycol47 "Medium model (Glycol47)";
    Medium.BaseProperties medium;

    Medium.DynamicViscosity eta=Medium.dynamicViscosity(medium.state);
    Medium.ThermalConductivity lambda=Medium.thermalConductivity(medium.state);
    Medium.SpecificEntropy s=Medium.specificEntropy(medium.state);
    Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(medium.state);
    Medium.SpecificInternalEnergy u=Medium.specificInternalEnergy(medium.state);
    Medium.SpecificInternalEnergy h=Medium.specificEnthalpy(medium.state);
    Medium.SpecificInternalEnergy d=Medium.density(medium.state);
    protected
    constant SI.Time timeUnit = 1;
    constant SI.Temperature Ta = 1;
  equation
    medium.p = 1.013e5;
    medium.T = Medium.T_min + time/timeUnit*Ta;
      annotation (__DLR_experiment(StopTime=1.01));
  end TestGlycol;

    package Dowcal100
      "Concentration 60 volume%, ethylene glycol-based mixed with water"
      extends ThermofluidStream.Media.myMedia.Incompressible.TableBased(
        mediumName="Dowcal100_60%",
        T_min=Modelica.Units.Conversions.from_degC(-50),
        T_max=Modelica.Units.Conversions.from_degC(175),
        TinK=false,
        T0=273.15,
        tableConductivity =
      [-50, 0.393;
       -45, 0.394;
       -40, 0.395;
       -35, 0.395;
       -30, 0.396;
       -25, 0.396;
       -20, 0.396;
       -15, 0.396;
       -10, 0.397;
       -5, 0.397;
       0, 0.396;
       5, 0.396;
       10, 0.396;
       15, 0.396;
       20, 0.395;
       25, 0.395;
       30, 0.394;
       35, 0.393;
       40, 0.392;
       45, 0.391;
       50, 0.39;
       55, 0.389;
       60, 0.388;
       65, 0.387;
       70, 0.385;
       75, 0.384;
       80, 0.383;
       85, 0.381;
       90, 0.379;
       95, 0.377;
       100, 0.375;
       105, 0.373;
       110, 0.371;
       115, 0.369;
       120, 0.367;
       125, 0.365;
       130, 0.362;
       135, 0.36;
       140, 0.357;
       145, 0.354;
       150, 0.352;
       155, 0.349;
       160, 0.346;
       165, 0.343;
       170, 0.34;
       175, 0.336],
    tableDensity =
      [-50, 1143;
       -45, 1139.1;
       -40, 1135.3;
       -35, 1131.5;
       -30, 1127.8;
       -25, 1124.2;
       -20, 1120.6;
       -15, 1117.1;
       -10, 1113.6;
       -5, 1110.2;
       0, 1106.9;
       5, 1103.6;
       10, 1100.3;
       15, 1097.1;
       20, 1094;
       25, 1090.9;
       30, 1087.9;
       35, 1084.9;
       40, 1081.9;
       45, 1079;
       50, 1076.1;
       55, 1073.3;
       60, 1070.5;
       65, 1067.7;
       70, 1065;
       75, 1062.4;
       80, 1059.7;
       85, 1057.1;
       90, 1054.6;
       95, 1052;
       100, 1049.5;
       105, 1047.1;
       110, 1044.7;
       115, 1042.3;
       120, 1039.9;
       125, 1037.6;
       130, 1035.3;
       135, 1033;
       140, 1030.8;
       145, 1028.6;
       150, 1026.4;
       155, 1024.2;
       160, 1022.1;
       165, 1020;
       170, 1017.9;
       175, 1015.9],
    tableHeatCapacity =
      [-50, 2900;
       -45, 2920;
       -40, 2940;
       -35, 2960;
       -30, 2980;
       -25, 3000;
       -20, 3020;
       -15, 3040;
       -10, 3060;
       -5, 3080;
       0, 3100;
       5, 3120;
       10, 3140;
       15, 3160;
       20, 3180;
       25, 3210;
       30, 3230;
       35, 3250;
       40, 3270;
       45, 3290;
       50, 3310;
       55, 3330;
       60, 3350;
       65, 3370;
       70, 3390;
       75, 3410;
       80, 3430;
       85, 3450;
       90, 3470;
       95, 3490;
       100, 3510;
       105, 3530;
       110, 3550;
       115, 3580;
       120, 3600;
       125, 3620;
       130, 3640;
       135, 3660;
       140, 3680;
       145, 3700;
       150, 3720;
       155, 3740;
       160, 3760;
       165, 3780;
       170, 3800;
       175, 3820],
    tableVaporPressure =
      [-50, 0;
       -45, 0;
       -40, 0;
       -35, 0;
       -30, 0;
       -25, 0;
       -20, 100;
       -15, 100;
       -10, 200;
       -5, 200;
       0, 400;
       5, 500;
       10, 800;
       15, 1100;
       20, 1500;
       25, 2100;
       30, 2900;
       35, 3900;
       40, 5100;
       45, 6700;
       50, 8800;
       55, 11300;
       60, 14400;
       65, 18200;
       70, 22900;
       75, 28400;
       80, 35100;
       85, 43000;
       90, 52300;
       95, 63200;
       100, 76000;
       105, 90800;
       110, 108000;
       115, 127000;
       120, 150000;
       125, 175000;
       130, 204000;
       135, 236000;
       140, 273000;
       145, 314000;
       150, 359000;
       155, 410000;
       160, 466000;
       165, 527000;
       170, 595000;
       175, 670000],
    tableViscosity =
      [-50, 1.5;
       -45, 0.692;
       -40, 0.357;
       -35, 0.202;
       -30, 0.122;
       -25, 0.0787;
       -20, 0.0532;
       -15, 0.0374;
       -10, 0.0273;
       -5, 0.0205;
       0, 0.0158;
       5, 0.0125;
       10, 0.0101;
       15, 0.00823;
       20, 0.00684;
       25, 0.00576;
       30, 0.00491;
       35, 0.00423;
       40, 0.00369;
       45, 0.00324;
       50, 0.00286;
       55, 0.00255;
       60, 0.00229;
       65, 0.00207;
       70, 0.00188;
       75, 0.00172;
       80, 0.00157;
       85, 0.00145;
       90, 0.00134;
       95, 0.00124;
       100, 0.00116;
       105, 0.00108;
       110, 0.00101;
       115, 0.000952;
       120, 0.000897;
       125, 0.000847;
       130, 0.000802;
       135, 0.00076;
       140, 0.000723;
       145, 0.000688;
       150, 0.000657;
       155, 0.000628;
       160, 0.000601;
       165, 0.000576;
       170, 0.000553;
       175, 0.000532]);

        annotation (Documentation(info="<html>
<p>The data in the Dowcal100 media is taken from https://www.dow.com/en-us/market/mkt-building-construction/sub-build-heating-cooling-refrigeration/heat-transfer-fluid-selection-calculator.html.</p>
<p>&quot;An ethylene glycol-based heat transfer fluid used in various industrial applications, highly recommended for heating applications&quot;</p>
<p>Density</p>
<p><img src=\"modelica://SAABdefinedMedia/TestDowcal100_density_T.png\"/></p>
<p>Heat capacity</p>
<p><img src=\"modelica://SAABdefinedMedia/TestDowcal100_specHeat_T.png\"/></p>
<p>Dynamic viscosity (double the viscosity od Dowcal100E)</p>
<p><img src=\"modelica://SAABdefinedMedia/TestDowcal100_dynVis_T.png\"/></p>
<p>Thermal conductivity</p>
<p><br><img src=\"modelica://SAABdefinedMedia/TestDowcal100_thermCond_T.png\"/></p>
</html>"));
    end Dowcal100;

    model TestDowcal100 "Test Dowcal Medium model"
      extends Modelica.Icons.Example;
      package Medium =
          ThermofluidStream.Media.myMedia.Incompressible.Examples.Dowcal100
                                "Medium model (Dowcal100)";
      Medium.BaseProperties medium;

      Medium.DynamicViscosity eta=Medium.dynamicViscosity(medium.state);
      Medium.ThermalConductivity lambda=Medium.thermalConductivity(medium.state);
      Medium.SpecificEntropy s=Medium.specificEntropy(medium.state);
      Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(medium.state);
      Medium.SpecificInternalEnergy u=Medium.specificInternalEnergy(medium.state);
      Medium.SpecificInternalEnergy h=Medium.specificEnthalpy(medium.state);
      Medium.SpecificInternalEnergy d=Medium.density(medium.state);
    protected
      constant Modelica.Units.SI.Time timeUnit=1;
      constant Modelica.Units.SI.Temperature Ta=1;
    equation
      medium.p = 1.013e5;
      medium.T = Medium.T_min + time/timeUnit*Ta;
        annotation (__DLR_experiment(StopTime=1.01),
        experiment(StopTime=225, __Dymola_Algorithm="Dassl"),
        Documentation(info="<html>
<p>Density</p>
<p><img src=\"modelica://SAABdefinedMedia/TestDowcal100_density_T.png\"/></p>
<p>Heat capacity</p>
<p><img src=\"modelica://SAABdefinedMedia/TestDowcal100_specHeat_T.png\"/></p>
<p>Dynamic viscosity</p>
<p><img src=\"modelica://SAABdefinedMedia/TestDowcal100_dynVis_T.png\"/></p>
<p>Thermal conductivity</p>
<p><img src=\"modelica://SAABdefinedMedia/TestDowcal100_thermCond_T.png\"/></p>
</html>"));
    end TestDowcal100;

    model TestLiqLoopDowcal100

        replaceable package SecondaryMedium =
          ThermofluidStream.Media.XRGMedia.CO2_ph constrainedby
        ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
        annotation(choicesAllMatching=true);

      replaceable package RefrigerantMedium =
        ThermofluidStream.Media.XRGMedia.CO2_ph  constrainedby
        ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
        annotation(choicesAllMatching=true);

      replaceable package TertiaryMedium =
        ThermofluidStream.Media.myMedia.Incompressible.Examples.Dowcal100
                  constrainedby
        ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
        annotation(choicesAllMatching=true);

      ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(
        redeclare package Medium = TertiaryMedium,
        outputTemperature=true,
        outputMassFlowRate=true,
        temperatureUnit="degC")
        annotation (Placement(transformation(extent={{-12,6},{-40,-24}})));
      ThermofluidStream.HeatExchangers.DiscretizedCounterFlowHEX evaporator(
        redeclare package MediumA = TertiaryMedium,
        redeclare package MediumB = SecondaryMedium,
        redeclare model ConductionElementA =
            ThermofluidStream.HeatExchangers.Internal.ConductionElementHEX,
        redeclare model ConductionElementB =
            ThermofluidStream.HeatExchangers.Internal.ConductionElementHEX_twoPhase,
        initializeMassFlow=false,
        nCells=10,
        A=15,
        V_Hex(displayUnit="m3"),
        k_wall=50) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={14,14})));

      ThermofluidStream.Processes.FlowResistance flowResistance1(
        redeclare package Medium = TertiaryMedium,
        initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
        r=0.05,
        l=1,
        redeclare function pLoss =
            ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss
            (k=1e4))
        annotation (Placement(transformation(extent={{114,-4},{94,16}})));
      ThermofluidStream.Processes.Pump pump(redeclare package Medium =
            TertiaryMedium,
        omega_from_input=true,
        redeclare function dp_tau_pump =
            ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal)
        annotation (Placement(transformation(extent={{92,-82},{112,-62}})));
      ThermofluidStream.Processes.ConductionElement conductionElement(redeclare
          package Medium = TertiaryMedium)
        annotation (Placement(transformation(extent={{4,-84},{24,-64}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heating_element
        annotation (Placement(transformation(extent={{-6,-58},{14,-38}})));
      Modelica.Blocks.Sources.RealExpression heat(y=40000)
        annotation (Placement(transformation(extent={{-46,-60},{-26,-40}})));
      ThermofluidStream.Boundaries.Reservoir reservoir(redeclare package Medium =
            TertiaryMedium)
        annotation (Placement(transformation(extent={{-52,-86},{-32,-66}})));
      ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(
        redeclare package Medium = TertiaryMedium,
        outputTemperature=true,
        outputMassFlowRate=false,
        temperatureUnit="degC")
        annotation (Placement(transformation(extent={{82,6},{36,-18}})));
      ThermofluidStream.Boundaries.Source
                        source1(redeclare package Medium = SecondaryMedium,
        temperatureFromInput=false,
        T0_par=283.15,
        p0_par(displayUnit="Pa") = (SecondaryMedium.saturationPressure(263.15)))
        annotation (Placement(transformation(extent={{-132,34},{-112,54}})));
      ThermofluidStream.Boundaries.Sink
                      sink1(redeclare package Medium = SecondaryMedium,
          pressureFromInput=true)
        annotation (Placement(transformation(extent={{76,16},{96,36}})));
      ThermofluidStream.Processes.FlowResistance
                               flowResistance2(
        redeclare package Medium = SecondaryMedium,
        initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
        r=0.05,
        l=1,
        redeclare function pLoss =
            ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss
            (k=1e4))
        annotation (Placement(transformation(extent={{-84,34},{-64,54}})));
      ThermofluidStream.Sensors.MultiSensor_Tpm
                              multiSensor_Tpm3(
        redeclare package Medium = SecondaryMedium,
        outputTemperature=true,
        outputMassFlowRate=true,
        temperatureUnit="degC")
        annotation (Placement(transformation(extent={{44,26},{64,46}})));
      Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=7e5, uMin=100)
        annotation (Placement(transformation(extent={{144,34},{132,46}})));
      Modelica.Blocks.Continuous.PI PI1(
        k=1000,
        T=0.1,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=1e5)
        annotation (Placement(transformation(extent={{170,30},{150,50}})));
      Modelica.Blocks.Math.Feedback feedback1
        annotation (Placement(transformation(extent={{198,30},{178,50}})));
      Modelica.Blocks.Sources.RealExpression refFlow_setPoint1(y=30)
        annotation (Placement(transformation(extent={{224,30},{204,50}})));
      ThermofluidStream.Sensors.MultiSensor_Tpm
                              multiSensor_Tpm4(
        redeclare package Medium = SecondaryMedium,
        outputMassFlowRate=true,
        temperatureUnit="degC")
        annotation (Placement(transformation(extent={{-48,42},{-24,20}})));
      inner ThermofluidStream.DropOfCommons dropOfCommons
        annotation (Placement(transformation(extent={{-102,-60},{-82,-40}})));
      Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=600, uMin=50)
        annotation (Placement(transformation(extent={{38,-140},{50,-128}})));
      Modelica.Blocks.Continuous.PI PI2(
        k=-5,
        T=0.1,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=300)
        annotation (Placement(transformation(extent={{4,-144},{24,-124}})));
      Modelica.Blocks.Math.Feedback feedback2
        annotation (Placement(transformation(extent={{-32,-124},{-12,-144}})));
      Modelica.Blocks.Sources.RealExpression refFlow_setPoint2(y=15)
        annotation (Placement(transformation(extent={{-66,-144},{-46,-124}})));
      ThermofluidStream.Sensors.DifferenceSensor_Tp differenceSensor_Tp(
      redeclare package MediumA = TertiaryMedium,
      redeclare package MediumB = TertiaryMedium,
          outputTemperature=true)
        annotation (Placement(transformation(extent={{28,-80},{48,-100}})));
      Modelica.Blocks.Math.Gain gain(k=-1)
        annotation (Placement(transformation(extent={{-4,-116},{-14,-106}})));
      Modelica.Blocks.Sources.RealExpression inlet_temp(y=283.15)
        annotation (Placement(transformation(extent={{-164,34},{-144,54}})));
    equation
      connect(pump.outlet,flowResistance1. inlet) annotation (Line(
          points={{112,-72},{142,-72},{142,6},{114,6}},
          color={28,108,200},
          thickness=0.5));
      connect(conductionElement.outlet,pump. inlet) annotation (Line(
          points={{24,-74},{84,-74},{84,-88},{92,-88},{92,-72}},
          color={28,108,200},
          thickness=0.5));
      connect(heating_element.port,conductionElement. heatPort) annotation (Line(
            points={{14,-48},{14,-64.2}},                                color={191,
              0,0}));
      connect(heat.y,heating_element. Q_flow) annotation (Line(points={{-25,-50},{-25,
              -48},{-6,-48}},    color={0,0,127}));
      connect(reservoir.outlet,conductionElement. inlet) annotation (Line(
          points={{-32,-76},{-4,-76},{-4,-74},{4,-74}},
          color={28,108,200},
          thickness=0.5));
      connect(multiSensor_Tpm1.outlet,reservoir. inlet) annotation (Line(
          points={{-40,6},{-40,14},{-54,14},{-54,-60},{-62,-60},{-62,-76},{-52,-76}},
          color={28,108,200},
          thickness=0.5));
      connect(flowResistance1.outlet, multiSensor_Tpm2.inlet) annotation (Line(
          points={{94,6},{82,6}},
          color={28,108,200},
          thickness=0.5));
      connect(evaporator.outletA, multiSensor_Tpm1.inlet) annotation (Line(
          points={{4,6},{-12,6},{-12,6}},
          color={28,108,200},
          thickness=0.5));
      connect(multiSensor_Tpm2.outlet, evaporator.inletA) annotation (Line(
          points={{36,6},{28,6},{28,6},{24,6}},
          color={28,108,200},
          thickness=0.5));
      connect(source1.outlet,flowResistance2. inlet) annotation (Line(
          points={{-112,44},{-84,44}},
          color={28,108,200},
          thickness=0.5));
      connect(sink1.inlet,multiSensor_Tpm3. outlet) annotation (Line(
          points={{76,26},{64,26}},
          color={28,108,200},
          thickness=0.5));
      connect(limiter1.y,sink1. p0_var)
        annotation (Line(points={{131.4,40},{88,40},{88,26}},
                                                         color={0,0,127}));
      connect(limiter1.u,PI1. y)
        annotation (Line(points={{145.2,40},{149,40}},     color={0,0,127}));
      connect(PI1.u,feedback1. y)
        annotation (Line(points={{172,40},{179,40}},     color={0,0,127}));
      connect(feedback1.u1,refFlow_setPoint1. y)
        annotation (Line(points={{196,40},{203,40}},     color={0,0,127}));
      connect(flowResistance2.outlet,multiSensor_Tpm4. inlet) annotation (Line(
          points={{-64,44},{-56,44},{-56,42},{-48,42}},
          color={28,108,200},
          thickness=0.5));
      connect(evaporator.outletB, multiSensor_Tpm3.inlet) annotation (Line(
          points={{24,22},{32,22},{32,26},{44,26}},
          color={28,108,200},
          thickness=0.5));
      connect(multiSensor_Tpm4.outlet, evaporator.inletB) annotation (Line(
          points={{-24,42},{-20,42},{-20,40},{-14,40},{-14,22},{4,22}},
          color={28,108,200},
          thickness=0.5));
      connect(limiter2.u,PI2. y)
        annotation (Line(points={{36.8,-134},{25,-134}},   color={0,0,127}));
      connect(limiter2.y, pump.omega_input) annotation (Line(points={{50.6,-134},{78,
              -134},{78,-138},{102,-138},{102,-82}}, color={0,0,127}));
      connect(multiSensor_Tpm1.T_out, feedback1.u2) annotation (Line(points={{-40,-18},
              {-48,-18},{-48,-30},{188,-30},{188,32}}, color={0,0,127}));
      connect(feedback2.y, PI2.u)
        annotation (Line(points={{-13,-134},{2,-134}}, color={0,0,127}));
      connect(feedback2.u1, refFlow_setPoint2.y)
        annotation (Line(points={{-30,-134},{-45,-134}}, color={0,0,127}));
      connect(differenceSensor_Tp.inletA, conductionElement.inlet) annotation (Line(
          points={{28,-98},{-4,-98},{-4,-74},{4,-74}},
          color={28,108,200},
          thickness=0.5));
      connect(differenceSensor_Tp.inletB, conductionElement.outlet) annotation (
          Line(
          points={{28,-82},{26,-82},{26,-74},{24,-74}},
          color={28,108,200},
          thickness=0.5));
      connect(differenceSensor_Tp.T_out, gain.u) annotation (Line(points={{48,-94},
              {56,-94},{56,-111},{-3,-111}}, color={0,0,127}));
      connect(feedback2.u2, gain.y) annotation (Line(points={{-22,-126},{-22,-111},
              {-14.5,-111}}, color={0,0,127}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-180},{260,100}}),
            graphics={
            Ellipse(lineColor = {75,138,73},
                    fillColor={255,255,255},
                    fillPattern = FillPattern.Solid,
                    extent={{-82,-178},{192,98}}),
            Polygon(lineColor = {0,0,255},
                    fillColor = {75,138,73},
                    pattern = LinePattern.None,
                    fillPattern = FillPattern.Solid,
                    points={{-18,74},{170,-46},{-18,-158},{-18,74}})}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-180},{260,
                100}})));
    end TestLiqLoopDowcal100;

    package Dowcal100E
      "Concentration 60 volume%, ethylene glycol-based mixed with water"
      extends ThermofluidStream.Media.myMedia.Incompressible.TableBased(
        mediumName="Dowcal100E_60%",
        T_min=Modelica.Units.Conversions.from_degC(-50),
        T_max=Modelica.Units.Conversions.from_degC(175),
        TinK=false,
        T0=273.15,
    tableConductivity =
      [-50, 0.393;
       -45, 0.393;
       -40, 0.394;
       -35, 0.394;
       -30, 0.394;
       -25, 0.395;
       -20, 0.395;
       -15, 0.395;
       -10, 0.395;
       -5, 0.395;
       0, 0.394;
       5, 0.394;
       10, 0.394;
       15, 0.393;
       20, 0.393;
       25, 0.392;
       30, 0.391;
       35, 0.39;
       40, 0.389;
       45, 0.388;
       50, 0.387;
       55, 0.386;
       60, 0.385;
       65, 0.384;
       70, 0.382;
       75, 0.381;
       80, 0.379;
       85, 0.377;
       90, 0.376;
       95, 0.374;
       100, 0.372;
       105, 0.37;
       110, 0.368;
       115, 0.366;
       120, 0.363;
       125, 0.361;
       130, 0.359;
       135, 0.356;
       140, 0.353;
       145, 0.351;
       150, 0.348;
       155, 0.345;
       160, 0.342;
       165, 0.339;
       170, 0.336;
       175, 0.333],
    tableDensity =
      [-50, 1115.3;
       -45, 1113.3;
       -40, 1111.1;
       -35, 1108.9;
       -30, 1106.5;
       -25, 1104.2;
       -20, 1101.7;
       -15, 1099.1;
       -10, 1096.5;
       -5, 1093.9;
       0, 1091.1;
       5, 1088.3;
       10, 1085.5;
       15, 1082.6;
       20, 1079.6;
       25, 1076.6;
       30, 1073.5;
       35, 1070.4;
       40, 1067.3;
       45, 1064;
       50, 1060.8;
       55, 1057.5;
       60, 1054.2;
       65, 1050.8;
       70, 1047.4;
       75, 1043.9;
       80, 1040.5;
       85, 1037;
       90, 1033.4;
       95, 1029.8;
       100, 1026.2;
       105, 1022.6;
       110, 1018.9;
       115, 1015.2;
       120, 1011.5;
       125, 1007.7;
       130, 1003.9;
       135, 1000.1;
       140, 996.3;
       145, 992.4;
       150, 988.5;
       155, 984.6;
       160, 980.7;
       165, 976.8;
       170, 972.8;
       175, 968.8],
    tableHeatCapacity =
      [-50, 2880;
       -45, 2900;
       -40, 2920;
       -35, 2940;
       -30, 2960;
       -25, 2980;
       -20, 3000;
       -15, 3020;
       -10, 3040;
       -5, 3060;
       0, 3080;
       5, 3110;
       10, 3130;
       15, 3150;
       20, 3170;
       25, 3190;
       30, 3210;
       35, 3230;
       40, 3250;
       45, 3270;
       50, 3290;
       55, 3310;
       60, 3330;
       65, 3350;
       70, 3380;
       75, 3400;
       80, 3420;
       85, 3440;
       90, 3460;
       95, 3480;
       100, 3500;
       105, 3520;
       110, 3540;
       115, 3560;
       120, 3580;
       125, 3600;
       130, 3620;
       135, 3650;
       140, 3670;
       145, 3690;
       150, 3710;
       155, 3730;
       160, 3750;
       165, 3770;
       170, 3790;
       175, 3810],
    tableVaporPressure =
      [-50, 0;
       -45, 0;
       -40, 0;
       -35, 0;
       -30, 0;
       -25, 0;
       -20, 100;
       -15, 100;
       -10, 200;
       -5, 200;
       0, 400;
       5, 500;
       10, 800;
       15, 1100;
       20, 1500;
       25, 2100;
       30, 2800;
       35, 3800;
       40, 5100;
       45, 6700;
       50, 8700;
       55, 11200;
       60, 14300;
       65, 18100;
       70, 22700;
       75, 28200;
       80, 34800;
       85, 42600;
       90, 51900;
       95, 62700;
       100, 75400;
       105, 90100;
       110, 107000;
       115, 126000;
       120, 149000;
       125, 174000;
       130, 202000;
       135, 235000;
       140, 271000;
       145, 311000;
       150, 356000;
       155, 407000;
       160, 462000;
       165, 523000;
       170, 591000;
       175, 665000],
    tableViscosity =
      [-50, 0.636;
       -45, 0.352;
       -40, 0.208;
       -35, 0.13;
       -30, 0.0847;
       -25, 0.0576;
       -20, 0.0406;
       -15, 0.0295;
       -10, 0.022;
       -5, 0.0168;
       0, 0.0131;
       5, 0.0104;
       10, 0.0084;
       15, 0.00689;
       20, 0.00572;
       25, 0.00481;
       30, 0.00409;
       35, 0.00351;
       40, 0.00304;
       45, 0.00266;
       50, 0.00234;
       55, 0.00208;
       60, 0.00186;
       65, 0.00167;
       70, 0.00151;
       75, 0.00137;
       80, 0.00125;
       85, 0.00114;
       90, 0.00105;
       95, 0.000971;
       100, 0.000900;
       105, 0.000838;
       110, 0.000782;
       115, 0.000732;
       120, 0.000687;
       125, 0.000647;
       130, 0.00061;
       135, 0.000577;
       140, 0.000547;
       145, 0.000520;
       150, 0.000495;
       155, 0.000472;
       160, 0.000451;
       165, 0.000432;
       170, 0.000414;
       175, 0.000397]);

        annotation (Documentation(info="<html>
<p>The data in the Dowcal100E media is taken from https://www.dow.com/en-us/market/mkt-building-construction/sub-build-heating-cooling-refrigeration/heat-transfer-fluid-selection-calculator.html.</p>
<p><br>&quot;An ethylene glycol-based heat transfer fluid used in various industrial applications, highly recommended for heating applications&quot;</p>
<p>Density</p>
<p><img src=\"modelica://SAABdefinedMedia/TestDowcal100E_density_T.png\"/></p>
<p>Heat capacity</p>
<p><img src=\"modelica://SAABdefinedMedia/TestDowcal100E_specHeat_T.png\"/></p>
<p>Dynamic viscosity (about half of Dowcal100)</p>
<p><img src=\"modelica://SAABdefinedMedia/TestDowcal100E_dynVis_T.png\"/></p>
<p>Thermal conductivity</p>
<p><img src=\"modelica://SAABdefinedMedia/TestDowcal100E_thermCond.png\"/></p>
</html>"));
    end Dowcal100E;

    model TestDowcal100E "Test Dowcal100E Medium model"
      extends Modelica.Icons.Example;
      package Medium =
          ThermofluidStream.Media.myMedia.Incompressible.Examples.Dowcal100E
                                "Medium model (Dowcal100E)";
      Medium.BaseProperties medium;

      Medium.DynamicViscosity eta=Medium.dynamicViscosity(medium.state);
      Medium.ThermalConductivity lambda=Medium.thermalConductivity(medium.state);
      Medium.SpecificEntropy s=Medium.specificEntropy(medium.state);
      Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(medium.state);
      Medium.SpecificInternalEnergy u=Medium.specificInternalEnergy(medium.state);
      Medium.SpecificInternalEnergy h=Medium.specificEnthalpy(medium.state);
      Medium.SpecificInternalEnergy d=Medium.density(medium.state);
    protected
      constant Modelica.Units.SI.Time timeUnit=1;
      constant Modelica.Units.SI.Temperature Ta=1;
    equation
      medium.p = 1.013e5;
      medium.T = Medium.T_min + time/timeUnit*Ta;
        annotation (__DLR_experiment(StopTime=1.01),
        experiment(StopTime=225, __Dymola_Algorithm="Dassl"),
        Documentation(info="<html>
<p>Density</p>
<p><img src=\"modelica://SAABdefinedMedia/TestDowcal100E_density_T.png\"/></p>
<p>Heat capacity</p>
<p><img src=\"modelica://SAABdefinedMedia/TestDowcal100E_specHeat_T.png\"/></p>
<p>Dynamic viscosity (about half of Dowcal100)</p>
<p><img src=\"modelica://SAABdefinedMedia/TestDowcal100E_dynVis_T.png\"/></p>
<p>Thermal conductivity</p>
<p><img src=\"modelica://SAABdefinedMedia/TestDowcal100E_thermCond.png\"/></p>
</html>"));
    end TestDowcal100E;

    package JP8 "Jet propulsion 8, JetA with additives, typical density"
      // Data from Handbook of Aviation Fuel properties, Coordinating Research Council Inc., 1983
      //Density data between -40 degC and 90 degC, linear in T, relative density data linear up to 120 degC
      //density could vary with 30 % between batches, the typical density used here is an average of measured data
      //Heat capacity data between 30 degC and 180 degC, linear in T
      //Thermal conductivity data between -8 degC and 220 degC, linear in T
      //Kinematic viscosity data between -50 and 145 degC, log(viscosity) is linear in T
      //True vapor pressure data between 50 degC and 140 degC, log(VaporPressure) is linear in 1/T(in Kelvin)
      extends ThermofluidStream.Media.myMedia.Incompressible.TableBased(
        mediumName="Jet propulsion 8 (JetA with additives)",
        T_min=Modelica.Units.Conversions.from_degC(-40),
        T_max=Modelica.Units.Conversions.from_degC(120),
        enthalpyOfT=true,
        TinK=false,
        T0=273.15,
        npolDensity=1,
        tableDensity=[-40,852; 90,758],
        npolHeatCapacity=1,
        tableHeatCapacity=[30,2000;  180,2650],
        npolConductivity =1,
        tableConductivity=[-8,0.12; 220,0.08],
        npolViscosity = 4,
        tableViscosity=[-50,0.016; -40,0.0095; -30,0.006; -20,0.0042; -10,0.0032; 30,0.0014; 70,0.0008;110,0.00053; 144,0.0004],
        npolVaporPressure= 4,
        tableVaporPressure=[50,1300; 72,3200; 112,12500;  143,32000]);
        annotation (Documentation(info="<html>
<h4>JP8</h4>
<p>JP8 is a jet propulsion fuel often used in military aircraft. It is essentially the same as JetA, but with some additives that e.g. allows for higher mass flows without static electricity build up. The data of this implementation comes from&nbsp;Handbook&nbsp;of&nbsp;Aviation&nbsp;Fuel&nbsp;properties,&nbsp;Coordinating&nbsp;Research&nbsp;Council&nbsp;Inc.(USA),&nbsp;1983. There are both more detailed property models available, for example in REFPROP, or with more attention to computational robustness, for example in Modelon&acute;s Fuel library. The data used in this model does not take into account properties important for combustion of the fuel, only those important for transportation and heat storage.</p>
<p>&nbsp;The main source of the density gives data&nbsp;between&nbsp;-40&nbsp;degC&nbsp;and&nbsp;90&nbsp;degC,&nbsp;linear&nbsp;in&nbsp;T,&nbsp;but complemetary relative&nbsp;density&nbsp;data&nbsp;is given as linear&nbsp;up&nbsp;to&nbsp;120&nbsp;degC, which implies that linear extraploation can be possible above 90 degC. Observe that the density&nbsp;can&nbsp;vary&nbsp;with&nbsp;30&percnt;&nbsp;between&nbsp;batches or over time as the ligther fractions tend to evaporate depending on manner of storage.&nbsp;The&nbsp;typical&nbsp;density&nbsp;used&nbsp;here&nbsp;is&nbsp;an&nbsp;average&nbsp;of&nbsp;measured&nbsp;data.</p>
<p><br>The heat&nbsp;capacity&nbsp;data is given&nbsp;between&nbsp;30&nbsp;degC&nbsp;and&nbsp;180&nbsp;degC,&nbsp;linear&nbsp;in&nbsp;T.</p>
<p><br>The thermal&nbsp;conductivity&nbsp;data&nbsp;is given between&nbsp;-8&nbsp;degC&nbsp;and&nbsp;220&nbsp;degC,&nbsp;linear&nbsp;in&nbsp;T.</p>
<p><br>The kinematic&nbsp;viscosity&nbsp;data&nbsp;is given between&nbsp;-50&nbsp;and&nbsp;145&nbsp;degC,&nbsp;with log(viscosity)&nbsp;linear&nbsp;in&nbsp;T.</p>
<p><br>The true&nbsp;vapor&nbsp;pressure&nbsp;data&nbsp;is given between&nbsp;50&nbsp;degC&nbsp;and&nbsp;140&nbsp;degC,&nbsp;with log(VaporPressure)&nbsp;linear&nbsp;in&nbsp;1/T(in&nbsp;Kelvin).</p>
<p>Density</p>
<p><img src=\"modelica://SAABdefinedMedia/TestJP8_density.png\"/></p>
<p>Heat capacity</p>
<p><img src=\"modelica://SAABdefinedMedia/TestJP8_specHeat.png\"/></p>
<p>Dynamic viscosity</p>
<p><img src=\"modelica://SAABdefinedMedia/TestJP8_dynVis.png\"/></p>
<p>Thermal conductivity</p>
<p><img src=\"modelica://SAABdefinedMedia/TestJP8_thermCond.png\"/></p>
</html>", revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"));
    end JP8;

    model TestJP8 "Test JP8 Medium model"
      extends Modelica.Icons.Example;
      package Medium =
          ThermofluidStream.Media.myMedia.Incompressible.Examples.JP8
                                "Jet fuel medium model";
      Medium.BaseProperties medium;

      Medium.DynamicViscosity eta=Medium.dynamicViscosity(medium.state);
      Medium.ThermalConductivity lambda=Medium.thermalConductivity(medium.state);
      Medium.SpecificEntropy s=Medium.specificEntropy(medium.state);
      Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(medium.state);
      Medium.SpecificInternalEnergy u=Medium.specificInternalEnergy(medium.state);
      Medium.SpecificInternalEnergy h=Medium.specificEnthalpy(medium.state);
      Medium.SpecificInternalEnergy d=Medium.density(medium.state);
      Real n=Medium.nS;
    protected
      constant Modelica.Units.SI.Time timeUnit=1;
      constant Modelica.Units.SI.Temperature Ta=1;
    equation
      medium.p = 1.013e5;
      medium.T = Medium.T_min + time/timeUnit*Ta;
        annotation (
        experiment(StopTime=225, __Dymola_Algorithm="Dassl"),
        Documentation(info="<html>
<p>Density</p>
<p><img src=\"modelica://SAABdefinedMedia/TestJP8_density.png\"/></p>
<p>Heat capacity</p>
<p><img src=\"modelica://SAABdefinedMedia/TestJP8_specHeat.png\"/></p>
<p>Dynamic viscosity</p>
<p><img src=\"modelica://SAABdefinedMedia/TestJP8_dynVis.png\"/></p>
<p>Thermal conductivity</p>
<p><img src=\"modelica://SAABdefinedMedia/TestJP8_thermCond.png\"/></p>
</html>"));
    end TestJP8;

    model TestLiqLoopJP8

        replaceable package SecondaryMedium =
          ThermofluidStream.Media.XRGMedia.CO2_ph constrainedby
        ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
        annotation(choicesAllMatching=true);

      replaceable package RefrigerantMedium =
        ThermofluidStream.Media.XRGMedia.CO2_ph  constrainedby
        ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
        annotation(choicesAllMatching=true);

      replaceable package TertiaryMedium =
        ThermofluidStream.Media.myMedia.Incompressible.Examples.JP8
                             constrainedby
        ThermofluidStream.Media.myMedia.Interfaces.PartialMedium
        annotation(choicesAllMatching=true);

      ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm1(
        redeclare package Medium = TertiaryMedium,
        outputTemperature=true,
        outputMassFlowRate=true,
        temperatureUnit="degC")
        annotation (Placement(transformation(extent={{-12,6},{-40,-24}})));
      ThermofluidStream.HeatExchangers.DiscretizedCounterFlowHEX evaporator(
        redeclare package MediumA = TertiaryMedium,
        redeclare package MediumB = SecondaryMedium,
        redeclare model ConductionElementA =
            ThermofluidStream.HeatExchangers.Internal.ConductionElementHEX,
        redeclare model ConductionElementB =
            ThermofluidStream.HeatExchangers.Internal.ConductionElementHEX_twoPhase,
        initializeMassFlow=false,
        nCells=10,
        A=15,
        V_Hex(displayUnit="m3"),
        k_wall=50) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={14,14})));

      ThermofluidStream.Processes.FlowResistance flowResistance1(
        redeclare package Medium = TertiaryMedium,
        initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
        r=0.05,
        l=1,
        redeclare function pLoss =
            ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss
            (k=1e4))
        annotation (Placement(transformation(extent={{114,-4},{94,16}})));
      ThermofluidStream.Processes.Pump pump(redeclare package Medium =
            TertiaryMedium,
        omega_from_input=true,
        redeclare function dp_tau_pump =
            ThermofluidStream.Processes.Internal.TurboComponent.dp_tau_centrifugal)
        annotation (Placement(transformation(extent={{92,-82},{112,-62}})));
      ThermofluidStream.Processes.ConductionElement conductionElement(redeclare
          package Medium = TertiaryMedium)
        annotation (Placement(transformation(extent={{4,-84},{24,-64}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heating_element
        annotation (Placement(transformation(extent={{-6,-58},{14,-38}})));
      Modelica.Blocks.Sources.RealExpression heat(y=40000)
        annotation (Placement(transformation(extent={{-46,-60},{-26,-40}})));
      ThermofluidStream.Boundaries.Reservoir reservoir(redeclare package Medium =
            TertiaryMedium)
        annotation (Placement(transformation(extent={{-52,-86},{-32,-66}})));
      ThermofluidStream.Sensors.MultiSensor_Tpm multiSensor_Tpm2(
        redeclare package Medium = TertiaryMedium,
        outputTemperature=true,
        outputMassFlowRate=false,
        temperatureUnit="degC")
        annotation (Placement(transformation(extent={{82,6},{36,-18}})));
      ThermofluidStream.Boundaries.Source
                        source1(redeclare package Medium = SecondaryMedium,
        temperatureFromInput=false,
        T0_par=283.15,
        p0_par(displayUnit="Pa") = (SecondaryMedium.saturationPressure(263.15)))
        annotation (Placement(transformation(extent={{-132,34},{-112,54}})));
      ThermofluidStream.Boundaries.Sink
                      sink1(redeclare package Medium = SecondaryMedium,
          pressureFromInput=true)
        annotation (Placement(transformation(extent={{76,16},{96,36}})));
      ThermofluidStream.Processes.FlowResistance
                               flowResistance2(
        redeclare package Medium = SecondaryMedium,
        initM_flow=ThermofluidStream.Utilities.Types.InitializationMethods.state,
        r=0.05,
        l=1,
        redeclare function pLoss =
            ThermofluidStream.Processes.Internal.FlowResistance.linearQuadraticPressureLoss
            (k=1e4))
        annotation (Placement(transformation(extent={{-84,34},{-64,54}})));
      ThermofluidStream.Sensors.MultiSensor_Tpm
                              multiSensor_Tpm3(
        redeclare package Medium = SecondaryMedium,
        outputTemperature=true,
        outputMassFlowRate=true,
        temperatureUnit="degC")
        annotation (Placement(transformation(extent={{44,26},{64,46}})));
      Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=7e5, uMin=100)
        annotation (Placement(transformation(extent={{144,34},{132,46}})));
      Modelica.Blocks.Continuous.PI PI1(
        k=1000,
        T=0.1,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=1e5)
        annotation (Placement(transformation(extent={{170,30},{150,50}})));
      Modelica.Blocks.Math.Feedback feedback1
        annotation (Placement(transformation(extent={{198,30},{178,50}})));
      Modelica.Blocks.Sources.RealExpression refFlow_setPoint1(y=30)
        annotation (Placement(transformation(extent={{224,30},{204,50}})));
      ThermofluidStream.Sensors.MultiSensor_Tpm
                              multiSensor_Tpm4(
        redeclare package Medium = SecondaryMedium,
        outputMassFlowRate=true,
        temperatureUnit="degC")
        annotation (Placement(transformation(extent={{-48,42},{-24,20}})));
      inner ThermofluidStream.DropOfCommons dropOfCommons
        annotation (Placement(transformation(extent={{-102,-60},{-82,-40}})));
      Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=600, uMin=50)
        annotation (Placement(transformation(extent={{38,-140},{50,-128}})));
      Modelica.Blocks.Continuous.PI PI2(
        k=-5,
        T=0.1,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=300)
        annotation (Placement(transformation(extent={{4,-144},{24,-124}})));
      Modelica.Blocks.Math.Feedback feedback2
        annotation (Placement(transformation(extent={{-32,-124},{-12,-144}})));
      Modelica.Blocks.Sources.RealExpression refFlow_setPoint2(y=15)
        annotation (Placement(transformation(extent={{-66,-144},{-46,-124}})));
      ThermofluidStream.Sensors.DifferenceSensor_Tp differenceSensor_Tp(
      redeclare package MediumA = TertiaryMedium,
      redeclare package MediumB = TertiaryMedium,
          outputTemperature=true)
        annotation (Placement(transformation(extent={{28,-80},{48,-100}})));
      Modelica.Blocks.Math.Gain gain(k=-1)
        annotation (Placement(transformation(extent={{-4,-116},{-14,-106}})));
      Modelica.Blocks.Sources.RealExpression inlet_temp(y=283.15)
        annotation (Placement(transformation(extent={{-164,34},{-144,54}})));
    equation
      connect(pump.outlet,flowResistance1. inlet) annotation (Line(
          points={{112,-72},{142,-72},{142,6},{114,6}},
          color={28,108,200},
          thickness=0.5));
      connect(conductionElement.outlet,pump. inlet) annotation (Line(
          points={{24,-74},{84,-74},{84,-88},{92,-88},{92,-72}},
          color={28,108,200},
          thickness=0.5));
      connect(heating_element.port,conductionElement. heatPort) annotation (Line(
            points={{14,-48},{14,-64.2}},                                color={191,
              0,0}));
      connect(heat.y,heating_element. Q_flow) annotation (Line(points={{-25,-50},{-25,
              -48},{-6,-48}},    color={0,0,127}));
      connect(reservoir.outlet,conductionElement. inlet) annotation (Line(
          points={{-32,-76},{-4,-76},{-4,-74},{4,-74}},
          color={28,108,200},
          thickness=0.5));
      connect(multiSensor_Tpm1.outlet,reservoir. inlet) annotation (Line(
          points={{-40,6},{-40,14},{-54,14},{-54,-60},{-62,-60},{-62,-76},{-52,-76}},
          color={28,108,200},
          thickness=0.5));
      connect(flowResistance1.outlet, multiSensor_Tpm2.inlet) annotation (Line(
          points={{94,6},{82,6}},
          color={28,108,200},
          thickness=0.5));
      connect(evaporator.outletA, multiSensor_Tpm1.inlet) annotation (Line(
          points={{4,6},{-12,6},{-12,6}},
          color={28,108,200},
          thickness=0.5));
      connect(multiSensor_Tpm2.outlet, evaporator.inletA) annotation (Line(
          points={{36,6},{28,6},{28,6},{24,6}},
          color={28,108,200},
          thickness=0.5));
      connect(source1.outlet,flowResistance2. inlet) annotation (Line(
          points={{-112,44},{-84,44}},
          color={28,108,200},
          thickness=0.5));
      connect(sink1.inlet,multiSensor_Tpm3. outlet) annotation (Line(
          points={{76,26},{64,26}},
          color={28,108,200},
          thickness=0.5));
      connect(limiter1.y,sink1. p0_var)
        annotation (Line(points={{131.4,40},{88,40},{88,26}},
                                                         color={0,0,127}));
      connect(limiter1.u,PI1. y)
        annotation (Line(points={{145.2,40},{149,40}},     color={0,0,127}));
      connect(PI1.u,feedback1. y)
        annotation (Line(points={{172,40},{179,40}},     color={0,0,127}));
      connect(feedback1.u1,refFlow_setPoint1. y)
        annotation (Line(points={{196,40},{203,40}},     color={0,0,127}));
      connect(flowResistance2.outlet,multiSensor_Tpm4. inlet) annotation (Line(
          points={{-64,44},{-56,44},{-56,42},{-48,42}},
          color={28,108,200},
          thickness=0.5));
      connect(evaporator.outletB, multiSensor_Tpm3.inlet) annotation (Line(
          points={{24,22},{32,22},{32,26},{44,26}},
          color={28,108,200},
          thickness=0.5));
      connect(multiSensor_Tpm4.outlet, evaporator.inletB) annotation (Line(
          points={{-24,42},{-20,42},{-20,40},{-14,40},{-14,22},{4,22}},
          color={28,108,200},
          thickness=0.5));
      connect(limiter2.u,PI2. y)
        annotation (Line(points={{36.8,-134},{25,-134}},   color={0,0,127}));
      connect(limiter2.y, pump.omega_input) annotation (Line(points={{50.6,-134},{78,
              -134},{78,-138},{102,-138},{102,-82}}, color={0,0,127}));
      connect(multiSensor_Tpm1.T_out, feedback1.u2) annotation (Line(points={{-40,-18},
              {-48,-18},{-48,-30},{188,-30},{188,32}}, color={0,0,127}));
      connect(feedback2.y, PI2.u)
        annotation (Line(points={{-13,-134},{2,-134}}, color={0,0,127}));
      connect(feedback2.u1, refFlow_setPoint2.y)
        annotation (Line(points={{-30,-134},{-45,-134}}, color={0,0,127}));
      connect(differenceSensor_Tp.inletA, conductionElement.inlet) annotation (Line(
          points={{28,-98},{-4,-98},{-4,-74},{4,-74}},
          color={28,108,200},
          thickness=0.5));
      connect(differenceSensor_Tp.inletB, conductionElement.outlet) annotation (
          Line(
          points={{28,-82},{26,-82},{26,-74},{24,-74}},
          color={28,108,200},
          thickness=0.5));
      connect(differenceSensor_Tp.T_out, gain.u) annotation (Line(points={{48,-94},
              {56,-94},{56,-111},{-3,-111}}, color={0,0,127}));
      connect(feedback2.u2, gain.y) annotation (Line(points={{-22,-126},{-22,-111},
              {-14.5,-111}}, color={0,0,127}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-180},{260,100}}),
            graphics={
            Ellipse(lineColor = {75,138,73},
                    fillColor={255,255,255},
                    fillPattern = FillPattern.Solid,
                    extent={{-82,-178},{192,98}}),
            Polygon(lineColor = {0,0,255},
                    fillColor = {75,138,73},
                    pattern = LinePattern.None,
                    fillPattern = FillPattern.Solid,
                    points={{-18,74},{170,-46},{-18,-158},{-18,74}})}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-180},{260,
                100}})));
    end TestLiqLoopJP8;
  annotation (
    Documentation(info="<html>

<p>
This package provides a few examples of how to construct medium models for
incompressible fluids. The package contains:
</p>
<ul>
<li><strong>Glycol47</strong>, a model of 47% glycol water mixture, based on tables of
density and heat capacity as functions of temperature.</li>
<li><strong>Essotherm650</strong>, a medium model for thermal oil, also based on tables.</li>
</ul>

</html>"));
  end Examples;

  package Common "Common data structures"
    extends Modelica.Icons.Package;

    // Extended record for input to functions based on polynomials
    record BaseProps_Tpoly "Fluid state record"
      extends Modelica.Icons.Record;
      SI.Temperature T "Temperature";
      SI.Pressure p "Pressure";
      //    SI.Density d "Density";
    end BaseProps_Tpoly;

    //     record BaseProps_Tpoly_old "Fluid state record"
    //       extends Modelica.Media.Interfaces.PartialMedium.ThermodynamicState;
    //       //      SI.SpecificHeatCapacity cp "Specific heat capacity";
    //       SI.Temperature T "Temperature";
    //       SI.Pressure p "Pressure";
    //       //    SI.Density d "Density";
    //       parameter Real[:] poly_rho "Polynomial coefficients";
    //       parameter Real[:] poly_Cp "Polynomial coefficients";
    //       parameter Real[:] poly_eta "Polynomial coefficients";
    //       parameter Real[:] poly_pVap "Polynomial coefficients";
    //       parameter Real[:] poly_lam "Polynomial coefficients";
    //       parameter Real[:] invTK "Inverse T [1/K]";
    //     end BaseProps_Tpoly_old;
  end Common;

  package TableBased "Incompressible medium properties based on tables"
    import Modelica.Math.Polynomials;

    extends ThermofluidStream.Media.myMedia.Interfaces.PartialMedium(
      ThermoStates=if enthalpyOfT then ThermofluidStream.Media.myMedia.Interfaces.Choices.IndependentVariables.T
           else ThermofluidStream.Media.myMedia.Interfaces.Choices.IndependentVariables.pT,
      final reducedX=true,
      final fixedX=true,
      mediumName="tableMedium",
      redeclare record ThermodynamicState = Common.BaseProps_Tpoly,
      singleState=true,
      reference_p=1.013e5,
      Temperature(min=T_min, max=T_max));

    // Constants to be set in actual Medium
    constant Boolean enthalpyOfT=true
      "True if enthalpy is approximated as a function of T only, (p-dependence neglected)";
    constant Boolean densityOfT = size(tableDensity,1) > 1
      "True if density is a function of temperature";
    constant SI.Temperature T_min
      "Minimum temperature valid for medium model";
    constant SI.Temperature T_max
      "Maximum temperature valid for medium model";
    constant Temperature T0=273.15 "Reference Temperature";
    constant SpecificEnthalpy h0=0 "Reference enthalpy at T0, reference_p";
    constant SpecificEntropy s0=0 "Reference entropy at T0, reference_p";
    constant MolarMass MM_const=0.1 "Molar mass";
    constant Integer npol=2 "Degree of polynomial used for fitting";
    constant Integer npolDensity=npol
      "Degree of polynomial used for fitting rho(T)";
    constant Integer npolHeatCapacity=npol
      "Degree of polynomial used for fitting Cp(T)";
    constant Integer npolViscosity=npol
      "Degree of polynomial used for fitting eta(T)";
    constant Integer npolVaporPressure=npol
      "Degree of polynomial used for fitting pVap(T)";
    constant Integer npolConductivity=npol
      "Degree of polynomial used for fitting lambda(T)";
    constant Integer neta=size(tableViscosity,1)
      "Number of data points for viscosity";
    constant Real[:,2] tableDensity "Table for rho(T)";
    constant Real[:,2] tableHeatCapacity "Table for Cp(T)";
    constant Real[:,2] tableViscosity "Table for eta(T)";
    constant Real[:,2] tableVaporPressure "Table for pVap(T)";
    constant Real[:,2] tableConductivity "Table for lambda(T)";
    //    constant Real[:] TK=tableViscosity[:,1]+T0*ones(neta) "Temperature for Viscosity";
    constant Boolean TinK "True if T[K],Kelvin used for table temperatures";
    constant Boolean hasDensity = not (size(tableDensity,1)==0)
      "True if table tableDensity is present";
    constant Boolean hasHeatCapacity = not (size(tableHeatCapacity,1)==0)
      "True if table tableHeatCapacity is present";
    constant Boolean hasViscosity = not (size(tableViscosity,1)==0)
      "True if table tableViscosity is present";
    constant Boolean hasVaporPressure = not (size(tableVaporPressure,1)==0)
      "True if table tableVaporPressure is present";
    final constant Real invTK[neta] = if size(tableViscosity,1) > 0 then
        (if TinK then 1 ./ tableViscosity[:,1] else 1 ./ Cv.from_degC(tableViscosity[:,1])) else fill(0,neta);
    final constant Real poly_rho[:] = if hasDensity then
                                         Polynomials.fitting(tableDensity[:,1],tableDensity[:,2],npolDensity) else
                                           zeros(npolDensity+1);
    final constant Real poly_Cp[:] = if hasHeatCapacity then
                                         Polynomials.fitting(tableHeatCapacity[:,1],tableHeatCapacity[:,2],npolHeatCapacity) else
                                           zeros(npolHeatCapacity+1);
    final constant Real poly_eta[:] = if hasViscosity then
                                         Polynomials.fitting(invTK, Math.log(tableViscosity[:,2]),npolViscosity) else
                                           zeros(npolViscosity+1);
    final constant Real poly_pVap[:] = if hasVaporPressure then
                                         Polynomials.fitting(tableVaporPressure[:,1],tableVaporPressure[:,2],npolVaporPressure) else
                                            zeros(npolVaporPressure+1);
    final constant Real poly_lam[:] = if size(tableConductivity,1)>0 then
                                         Polynomials.fitting(tableConductivity[:,1],tableConductivity[:,2],npolConductivity) else
                                           zeros(npolConductivity+1);

    redeclare replaceable function massFraction "Return independent mass Fraction"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    output MassFraction Xi[nXi] "(independent) Mass Fraction";
    algorithm
    Xi := fill(0,0);
    end massFraction;

    function invertTemp "Function to invert temperatures"
      extends Modelica.Icons.Function;
      input Real[:] table "Table temperature data";
      input Boolean Tink "Flag for Celsius or Kelvin";
      output Real invTable[size(table,1)] "Inverted temperatures";
    algorithm
      for i in 1:size(table,1) loop
        invTable[i] := if TinK then 1/table[i] else 1/Cv.from_degC(table[i]);
      end for;
      annotation(smoothOrder=3);
    end invertTemp;

    redeclare model extends BaseProperties(
      final standardOrderComponents=true,
      p_bar=Cv.to_bar(p),
      T_degC(start = T_start-273.15)=Cv.to_degC(T),
      T(start = T_start,
        stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default))
      "Base properties of T dependent medium"

      SI.SpecificHeatCapacity cp "Specific heat capacity";
      parameter SI.Temperature T_start = 298.15 "Initial temperature";
    equation
      assert(hasDensity,"Medium " + mediumName +
                        " can not be used without assigning tableDensity.");
      assert(T >= T_min and T <= T_max, "Temperature T (= " + String(T) +
             " K) is not in the allowed range (" + String(T_min) +
             " K <= T <= " + String(T_max) + " K) required from medium model \""
             + mediumName + "\".");
      R_s = Modelica.Constants.R/MM_const;
      cp = Polynomials.evaluate(poly_Cp,if TinK then T else T_degC);
      h = specificEnthalpyOfT(p,T,densityOfT);
      u = h - (if singleState then reference_p/d else state.p/d);
      d = Polynomials.evaluate(poly_rho,if TinK then T else T_degC);
      state.T = T;
      state.p = p;
      MM = MM_const;
      annotation(Documentation(info="<html>
<p>
Note that the inner energy neglects the pressure dependence, which is only
true for an incompressible medium with d = constant. The neglected term is
(p-reference_p)/rho*(T/rho)*(&part;rho /&part;T). This is very small for
liquids due to proportionality to 1/d^2, but can be problematic for gases that are
modeled incompressible.
</p>
<p>It should be noted that incompressible media only have 1 state per control volume (usually T),
but have both T and p as inputs for fully correct properties. The error of using only T-dependent
properties is small, therefore a Boolean flag enthalpyOfT exists. If it is true, the
enumeration Choices.IndependentVariables is set to Choices.IndependentVariables.T otherwise
it is set to Choices.IndependentVariables.pT.</p>
<p>
Enthalpy is never a function of T only (h = h(T) + (p-reference_p)/d), but the
error is also small and non-linear systems can be avoided. In particular,
non-linear systems are small and local as opposed to large and over all volumes.
</p>

<p>
Entropy is calculated as
</p>
<blockquote><pre>
s = s0 + integral(Cp(T)/T,dt)
</pre></blockquote>
<p>
which is only exactly true for a fluid with constant density d=d0.
</p>
</html>"));
    end BaseProperties;

    redeclare function extends setState_pTX
      "Returns state record, given pressure and temperature"
    algorithm
      state := ThermodynamicState(p=p,T=T);
      annotation(smoothOrder=3);
    end setState_pTX;

    redeclare function extends setState_dTX
      "Returns state record, given pressure and temperature"
    algorithm
      assert(false, "For incompressible media with d(T) only, state can not be set from density and temperature");
    end setState_dTX;

    function setState_pT "Returns state record as function of p and T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      output ThermodynamicState state "Thermodynamic state";
    algorithm
      state.T := T;
      state.p := p;
      annotation(smoothOrder=3);
    end setState_pT;

    redeclare function extends isentropicExponent
      //TODO: check if that is correct
    algorithm
      gamma :=1;
    end isentropicExponent;

    redeclare function extends molarMass
    algorithm
      MM :=MM_const;
    end molarMass;

    redeclare function extends setState_phX
      "Returns state record, given pressure and specific enthalpy"
    algorithm
      state :=ThermodynamicState(p=p,T=T_ph(p,h));
      annotation(Inline=true,smoothOrder=3);
    end setState_phX;

    function setState_ph "Returns state record as function of p and h"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      output ThermodynamicState state "Thermodynamic state";
    algorithm
      state :=ThermodynamicState(p=p,T=T_ph(p,h));
      annotation(Inline=true,smoothOrder=3);
    end setState_ph;

    redeclare function extends setState_psX
      "Returns state record, given pressure and specific entropy"
    algorithm
      state :=ThermodynamicState(p=p,T=T_ps(p,s));
      annotation(Inline=true,smoothOrder=3);
    end setState_psX;

    function setState_ps "Returns state record as function of p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output ThermodynamicState state "Thermodynamic state";
    algorithm
      state :=ThermodynamicState(p=p,T=T_ps(p,s));
      annotation(Inline=true,smoothOrder=3);
    end setState_ps;

    redeclare function extends setSmoothState
      "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
    algorithm
      state := ThermodynamicState(p=myMedia.Common.smoothStep(
          x,
          state_a.p,
          state_b.p,
          x_small), T=myMedia.Common.smoothStep(
          x,
          state_a.T,
          state_b.T,
          x_small));
      annotation(Inline=true,smoothOrder=3);
    end setSmoothState;

    redeclare function extends specificHeatCapacityCv
      "Specific heat capacity at constant volume (or pressure) of medium"

    algorithm
      assert(hasHeatCapacity,"Specific Heat Capacity, Cv, is not defined for medium "
                                             + mediumName + ".");
      cv := Polynomials.evaluate(poly_Cp,if TinK then state.T else state.T - 273.15);
     annotation(smoothOrder=2);
    end specificHeatCapacityCv;

    redeclare function extends specificHeatCapacityCp
      "Specific heat capacity at constant volume (or pressure) of medium"

    algorithm
      assert(hasHeatCapacity,"Specific Heat Capacity, Cv, is not defined for medium "
                                             + mediumName + ".");
      cp := Polynomials.evaluate(poly_Cp,if TinK then state.T else state.T - 273.15);
     annotation(smoothOrder=2);
    end specificHeatCapacityCp;

    redeclare function extends dynamicViscosity
      "Return dynamic viscosity as a function of the thermodynamic state record"

    algorithm
      assert(size(tableViscosity,1)>0,"DynamicViscosity, eta, is not defined for medium "
                                             + mediumName + ".");
      eta := Math.exp(Polynomials.evaluate(poly_eta, 1/state.T));
     annotation(smoothOrder=2);
    end dynamicViscosity;

    redeclare function extends thermalConductivity
      "Return thermal conductivity as a function of the thermodynamic state record"

    algorithm
      assert(size(tableConductivity,1)>0,"ThermalConductivity, lambda, is not defined for medium "
                                             + mediumName + ".");
      lambda := Polynomials.evaluate(poly_lam,if TinK then state.T else Cv.to_degC(state.T));
     annotation(smoothOrder=2);
    end thermalConductivity;

    function s_T "Compute specific entropy"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      output SpecificEntropy s "Specific entropy";
    algorithm
      s := s0 + (if TinK then
        Polynomials.integralValue(poly_Cp[1:npol],T, T0) else
        Polynomials.integralValue(poly_Cp[1:npol],Cv.to_degC(T),Cv.to_degC(T0)))
        + Modelica.Math.log(T/T0)*
        Polynomials.evaluate(poly_Cp,if TinK then 0 else Modelica.Constants.T_zero);
     annotation(Inline=true,smoothOrder=2);
    end s_T;

    redeclare function extends specificEntropy
      "Return specific entropy as a function of the thermodynamic state record"

    protected
      Integer npol=size(poly_Cp,1)-1;
    algorithm
      assert(hasHeatCapacity,"Specific Entropy, s(T), is not defined for medium "
                                             + mediumName + ".");
      s := s_T(state.T);
     annotation(smoothOrder=2);
    end specificEntropy;

    function h_T "Compute specific enthalpy from temperature"
      import Modelica.Units.Conversions.to_degC;
      extends Modelica.Icons.Function;
      input SI.Temperature T "Temperature";
      output SI.SpecificEnthalpy h "Specific enthalpy at p, T";
    algorithm
      h :=h0 + Polynomials.integralValue(poly_Cp, if TinK then T else Cv.to_degC(T), if TinK then
      T0 else Cv.to_degC(T0));
     annotation(derivative=h_T_der);
    end h_T;

    function h_T_der "Compute specific enthalpy from temperature"
      import Modelica.Units.Conversions.to_degC;
      extends Modelica.Icons.Function;
      input SI.Temperature T "Temperature";
      input Real dT "Temperature derivative";
      output Real dh "Derivative of Specific enthalpy at T";
    algorithm
      dh :=Polynomials.evaluate(poly_Cp, if TinK then T else Cv.to_degC(T))*dT;
     annotation(smoothOrder=1);
    end h_T_der;

    function h_pT "Compute specific enthalpy from pressure and temperature"
      import Modelica.Units.Conversions.to_degC;
      extends Modelica.Icons.Function;
      input SI.Pressure p "Pressure";
      input SI.Temperature T "Temperature";
      input Boolean densityOfT = false "Include or neglect density derivative dependence of enthalpy";
      output SI.SpecificEnthalpy h "Specific enthalpy at p, T";
    algorithm
      h :=h0 + Polynomials.integralValue(poly_Cp, if TinK then T else Cv.to_degC(T), if TinK then
      T0 else Cv.to_degC(T0)) + (p - reference_p)/Polynomials.evaluate(poly_rho, if TinK then
              T else Cv.to_degC(T))
        *(if densityOfT then (1 + T/Polynomials.evaluate(poly_rho, if TinK then T else Cv.to_degC(T))
      *Polynomials.derivativeValue(poly_rho,if TinK then T else Cv.to_degC(T))) else 1.0);
     annotation(smoothOrder=2);
    end h_pT;

    function density_T "Return density as function of temperature"
      extends Modelica.Icons.Function;

      input Temperature T "Temperature";
      output Density d "Density";
    algorithm
      d := Polynomials.evaluate(poly_rho,if TinK then T else Cv.to_degC(T));
      annotation(Inline=true,smoothOrder=2);
    end density_T;

    redeclare function extends temperature
      "Return temperature as a function of the thermodynamic state record"
    algorithm
     T := state.T;
     annotation(Inline=true,smoothOrder=2);
    end temperature;

    redeclare function extends pressure
      "Return pressure as a function of the thermodynamic state record"
    algorithm
     p := state.p;
     annotation(Inline=true,smoothOrder=2);
    end pressure;

    redeclare function extends density
      "Return density as a function of the thermodynamic state record"
    algorithm
      d := Polynomials.evaluate(poly_rho,if TinK then state.T else Cv.to_degC(state.T));
     annotation(Inline=true,smoothOrder=2);
    end density;

    redeclare function extends density_derp_T
      "Return density derivative w.r.t. pressure at const temperature"
    algorithm
      ddpT :=0; //incompressable
    end density_derp_T;

    redeclare function extends density_derp_h
      "Return density derivative w.r.t. pressure at const specific enthalpy"
    algorithm
      ddph :=0; //incompressable and h = cp*T; h=const; -> T=const
    end density_derp_h;

    redeclare function extends specificEnthalpy
      "Return specific enthalpy as a function of the thermodynamic state record"
    algorithm
      h := specificEnthalpyOfT(state.p, state.T);
     annotation(Inline=true,smoothOrder=2);
    end specificEnthalpy;

    redeclare function extends specificInternalEnergy
      "Return specific internal energy as a function of the thermodynamic state record"
    algorithm
      u := specificEnthalpyOfT(state.p,state.T) - (if singleState then reference_p else state.p)/density(state);
     annotation(Inline=true,smoothOrder=2);
    end specificInternalEnergy;

    function T_ph "Compute temperature from pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      output Temperature T "Temperature";

    protected
      function f_nonlinear "Solve specificEnthalpyOfT(p,T) for T with given h"
        extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
      algorithm
        y := specificEnthalpyOfT(p=p, T=u) - h;
      end f_nonlinear;

    algorithm
      T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
        function f_nonlinear(p=p, h=h), T_min, T_max);
      annotation(Inline=false, LateInline=true, inverse(h=specificEnthalpyOfT(p,T)));
    end T_ph;

    function T_ps "Compute temperature from pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure (unused)";
      input SpecificEntropy s "Specific entropy";
      output Temperature T "Temperature";

    protected
      function f_nonlinear "Solve s_T(T) for T with given s"
        extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
        input SpecificEntropy s "Specific entropy";
      algorithm
        y := s_T(T=u) - s;
      end f_nonlinear;

    algorithm
      T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
        function f_nonlinear(s=s), T_min, T_max);
    end T_ps;

  protected
    function specificEnthalpyOfT
      "Return specific enthalpy from pressure and temperature, taking the flag enthalpyOfT into account"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input Boolean densityOfT = false "Include or neglect density derivative dependence of enthalpy";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := if enthalpyOfT then h_T(T) else h_pT(p, T, densityOfT);
      annotation(Inline=true,smoothOrder=2);
    end specificEnthalpyOfT;

  annotation(Documentation(info="<html>
<p>
This is the base package for medium models of incompressible fluids based on
tables. The minimal data to provide for a useful medium description is tables
of density and heat capacity as functions of temperature.
</p>

<p>It should be noted that incompressible media only have 1 state per control volume (usually T),
but have both T and p as inputs for fully correct properties. The error of using only T-dependent
properties is small, therefore a Boolean flag enthalpyOfT exists. If it is true, the
enumeration Choices.IndependentVariables is set to Choices.IndependentVariables.T otherwise
it is set to Choices.IndependentVariables.pT.</p>

<h4>Using the package TableBased</h4>
<p>
To implement a new medium model, create a package that <strong>extends</strong> TableBased
and provides one or more of the constant tables:
</p>

<blockquote><pre>
tableDensity        = [T, d];
tableHeatCapacity   = [T, Cp];
tableConductivity   = [T, lam];
tableViscosity      = [T, eta];
tableVaporPressure  = [T, pVap];
</pre></blockquote>

<p>
The table data is used to fit constant polynomials of order <strong>npol</strong>, the
temperature data points do not need to be same for different properties. Properties
like enthalpy, inner energy and entropy are calculated consistently from integrals
and derivatives of d(T) and Cp(T). The minimal
data for a useful medium model is thus density and heat capacity. Transport
properties and vapor pressure are optional, if the data tables are empty the corresponding
function calls can not be used.
</p>
</html>"));
  end TableBased;

  annotation (
    Documentation(info="<html>
<h4>Incompressible media package</h4>
<p>
This package provides a structure and examples of how to create simple
medium models of incompressible fluids, meaning fluids with very little
pressure influence on density. The medium properties is typically described
in terms of tables, functions or polynomial coefficients.
</p>
<h4>Definitions</h4>
<p>
The common meaning of <em>incompressible</em> is that properties like density
and enthalpy are independent of pressure. Thus properties are conveniently
described as functions of temperature, e.g., as polynomials density(T) and cp(T).
However, enthalpy and inner energy can not both be independent of pressure since h = u + p/d.
(Normally when T is held constant dh/dp&ge;0 and du/dp&le;0.)
For liquids it is anyway common to neglect this dependence for
both of them since for constant density the neglected term is (p - p0)/d,
which in comparison with cp is very small for most liquids. For
water, the equivalent change of temperature to increasing pressure 1 bar is
0.025 Kelvin.
</p>
<p>
Two Boolean flags are used to choose how enthalpy and inner energy is calculated:
</p>
<ul>
<li><strong>enthalpyOfT</strong>=true, means assuming that enthalpy is only a function
of temperature, neglecting the pressure dependent term.</li>
<li><strong>singleState</strong>=true, means also neglect the pressure influence on inner
energy, which makes all medium properties pure functions of temperature.</li>
</ul>
<p>
The default setting for both these flags is true, which enables the simulation tool
to choose temperature as the only medium state and avoids non-linear equation
systems, see the section about
<a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.StaticStateSelection\">Static
state selection</a> in the Modelica.Media User's Guide.
</p>

<h4>Contents</h4>
<p>
Currently, the package contains the following parts:
</p>
<ol>
<li> <a href=\"modelica://Modelica.Media.Incompressible.TableBased\">
      Table based medium models</a></li>
<li> <a href=\"modelica://Modelica.Media.Incompressible.Examples\">
      Example medium models</a></li>
</ol>

<p>
A few examples are given in the Examples package. The model
<a href=\"modelica://Modelica.Media.Incompressible.Examples.Glycol47\">
Examples.Glycol47</a> shows how the medium models can be used. For more
realistic examples of how to implement volume models with medium properties
look in the <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage\">Medium
usage section</a> of the User's Guide.
</p>

</html>"));

end Incompressible;
