# <img src="/doc/logo_lib.png" width="50"> The DLR Thermofluid Stream Library  

The DLR Thermofluid Stream Library is a free open-source library for the robust modeling of complex thermofluid architectures. Designed to be easy to use and easy to adapt and enriched by a number of examples, this library can be used as basis for many different applications such as thermal management of electric cars, power plants, or building physics. 

![](/doc/example.svg)


## Status

[![GitHub release](https://img.shields.io/github/release/DLR-SR/ThermofluidStream.svg?sort=semver)](https://github.com/DLR-SR/ThermofluidStream/releases/latest) [![GitHub license](https://img.shields.io/github/license/DLR-SR/ThermofluidStream)](https://github.com/DLR-SR/ThermofluidStream/blob/main/LICENSE) ![GitHub workflow](https://github.com/DLR-SR/ThermofluidStream/actions/workflows/checkCI.yml/badge.svg?event=pull_request) [![Modelica Library Award 2021](https://img.shields.io/badge/award-%F0%9F%A5%87_Modelica_Library_Award_2021-gold?labelColor=grey)](https://2021.international.conference.modelica.org/libraries.html) 

## News

**Tutorial at the Modelica Conference 2025**

We will give a tutorial on *Modeling complex thermal architectures using the DLR ThermoFluid Stream Library* at the [Modelica Conference 2025 Luzern](https://modelica.org/events/modelica2025/#agenda). The [Tutorial Abstract Booklet](https://modelica.org/events/modelica2025/Tutorial_Abstracts_16th_Modelica_and_FMI_Conference.pdf) is now available.

We look forward to meeting you there and sharing ideas.

## Highlights

- **Winner of the 2021 Modelica Library Award (1st prize) at the International Modelica Conference**
- Robust modeling of even complex architectures due to new computational scheme
- Easy to initialize and good support for switching bypasses and other configuration changes
- Many examples that enable an easy start to working with this library.
- Many base components that are easy to read, understand and to adapt to your own needs
- Support for systems that reverse their flow direction such as combined heat-pump/vapour cycle
- Support for discretized heat exchangers


## Technical Background
The DLR ThermoFluid Stream Library uses a [innovative computational scheme](https://www.tandfonline.com/doi/full/10.1080/13873954.2020.1757726) that has been developed for the object-oriented formulation of even complex system architectures. Key is the decomposition of pressure into a steady-flow component and an inertial component driving the balance of mass-flows. Using this decomposition all non-linear equations can be brought into explicit form and what remains to be solved is a purely linear equation system. 

Watch the <a href="https://youtu.be/u0Y7z0MyKd4" target="_blank">introductory video</a> from the 2021 Modelica Conference and read the <a href="https://www.mdpi.com/2079-9292/11/22/3790" target="_blank">corresponding paper in MDPI electronics</a>  (<a href="https://ecp.ep.liu.se/index.php/modelica/article/view/199/159" target="_blank">short version</a>):

<a href="https://youtu.be/u0Y7z0MyKd4" target="_blank"><img src="/doc/VideoThermoFluidCover.png" 
alt="IMAGE ALT TEXT HERE" height="200" border="1" /></a>

## License, Terms of Use, Literature

Likewise to Modelica Library of the Modelica Standard Library, the DLR Thermodluid Stream Library is published under the [3-Clause BSD License](https://modelica.org/licenses/modelica-3-clause-bsd.html).

If you publish work that is based on this library, please cite the following two papers. 

```
@article{TFS2022,
author = {Zimmer, Dirk and Meißner, Michael and Weber, Niels},
title = {The DLR ThermoFluid Stream Library},
journal = {Electronics},
volume = {11},
year = {2022},
number = {22},
doi = {10.3390/electronics11223790},
URL = {https://www.mdpi.com/2079-9292/11/22/3790},
ISSN = {2079-9292}
}

@article{RobustZimmer2020,
author = {Dirk Zimmer},
title = {Robust object-oriented formulation of directed thermofluid stream networks},
journal = {Mathematical and Computer Modelling of Dynamical Systems},
volume = {26},
number = {3},
pages = {204-233},
year  = {2020},
publisher = {Taylor & Francis},
doi = {10.1080/13873954.2020.1757726},
URL = {https://doi.org/10.1080/13873954.2020.1757726}
}

```

We also welcome feedback in form of issues raised here on GitHub. Also when you have positive feedback, you can feel free to raise an issue to share your experience. Have fun!

Further literature: The principal considerations for creating a solution for non-directed flows (or bidirectionality) is presented in

- Zimmer, D., N. Weber, M. Meissner  (2021) [Robust Simulation of Stream-Dominated Thermo-Fluid Systems: From Directed to Non-Directed Flows](https://www.sne-journal.org/sne-volumes/volume-31/sne-314-articles/robust-simulation-of-stream-dominated-thermo-fluid-systems-from-directed-to-non-directed-flows). Simulation Notes Europe, Volume 31(4):177-184
- Zimmer, Dirk, Michael Meißner, Niels Weber (2021) [The DLR ThermoFluidStream Library](https://ecp.ep.liu.se/index.php/modelica/article/view/199). 14th International Modelica Conference, Linköping, Sweden.
- Zimmer, Dirk (2019a). [Robust Simulation of StreamDominated Thermo-Fluid Systems: From Unidirectional to Bidirectional Applications](https://www.researchgate.net/publication/337812690_Robust_Simulation_of_Stream-Dominated_Thermo-Fluid_Systems_From_Unidirectional_to_Bidirectional_Applications). EUROSIM Congress (Logrono, Spain).

More details on the modeling of various types of volumes can be found in:

- M. Meissner, Zimmer, D. (2022) [Robust Modeling of Volumes for Dynamic Simulations of Thermo-Fluid Stream Networks](https://www.sciencedirect.com/science/article/pii/S2405896322012988). IFAC Papers Online Volume 55 Issue 20.

Further background literature on the methodology:

- Zimmer, Dirk, Daniel Bender, Alexander Pollok (2018). [Robust Modeling of Directed Thermofluid Flows in Complex Networks](https://elib.dlr.de/120701/1/Japan2018Robust.pdf). Proceedings of the 2nd Japanese Modelica Conference (Tokyo, Japan).
- Zimmer, Dirk (2019b). [Towards hard real-time simulation of complex fluid networks](https://ep.liu.se/ecp/157/059/ecp19157059.pdf). Proceedings of the 13th International Modelica Conference (Regensburg, Germany). Linköping University Electronic Press, Linköpings universitet, pp. 579–587.
- Otter, M. et al. (2019). [Thermodynamic Property and Fluid Modeling with Modern Programming Language Constructs](https://ep.liu.se/ecp/157/060/ecp19157060.pdf). Proceedings of the 13th International Modelica Conference (Regensburg, Germany). Linköping University Electronic Press, Linköpings universitet.

## Tool compatibility 
- [Dymola](https://www.3ds.com/products-services/catia/products/dymola/): The library has been developed using Dymola and is based on Modelica 3.2.3. Pedantic checking has been applied to all components in order to improve cross-tool compatibility. 
- [Open Modelica](https://www.openmodelica.org/): To a large extent, the library is compatible to Open Modelica. Details in [Issue 10](https://github.com/DLR-SR/ThermofluidStream/issues/10): 
- [Modelon Impact](https://www.modelon.com/modelon-impact/): The library is reported to be fully compatible to Modelon Impact. Details in [Issue 19](https://github.com/DLR-SR/ThermofluidStream/issues/19). 

## Authors and Contributors
The Library is provided by the [DLR Institute of System Dynamics and Control](https://www.dlr.de/sr/en). 

 <img src="/doc/DLR_Logo_engl_grau.png" width="300"> 
Deutsches Zentrum für Luft- und Raumfahrt, Institut für Systemdynamik und Regelungstechnik, Münchener Strasse 20, 82234 Wessling-Oberpfaffenhofen, Germany  

Individual authors of this organization are:
- [@dzimmer](https://github.com/dzimmer)
- [@RaphaelGebhart](https://github.com/RaphaelGebhart)
- [@nieweber](https://github.com/orgs/DLR-SR/people/nieweber)


### Further Notable Contributions
We are very grateful to [@IngelaLind](https://github.com/IngelaLind) from [Saab Aeronautics](http://www.saabgroup.com/), Linköping, Sweden for all models regarding static head pressure as well as media models for liquid and gas mixtures.

<img src="/doc/saab_logo.png" width="120">

We want to express our gratitude to Peter Stein and Philipp Jordan from [HTWG Konstanz](https://www.htwg-konstanz.de/) for their pipe models based on Idelchik.

We would like to thank very much [@wischhusen](https://github.com/wischhusen) from [XRG Simulation GmbH](https://www.xrg-simulation.de) for additional open-source Media models such as R1234yf.

<img src="/doc/XRG_Logo 2015_4c.png" width="120">

### Alumni
- [@mimeissner](https://github.com/orgs/DLR-SR/people/mimeissner)

## Acknowledgements

This work has been partially supported by the Helmholtz Gemeinschaft in frame of the research project for on-board diagnosis. Hence we would also like to thank the team of Robert Bosch GmbH for feedback and motivating use-case scenarios. Further thanks goes to Chistopher Laughman from Mitsubishi Electronic Research Center for providing initial feedback. Also the work of Tobias Krenz form TU Darmstadt was providing motivating use cases of the new approach. We are still grateful to Airbus and our former colleagues Dr Alexander Pollok and Dr. Daniel Bender who were pioneering the new methodology. Also we like to thank our colleague Dr. Peter Eschenbacher for his valuable modeling experience on valves and pumps. We would like to thank the Open Modelica Team for their support regarding tool compatibility.

The used **continuous integration** stuff originates in parts from that used in the development of the Modelica Standard Library. We would like to thank MAP-Lib project members who established this CI for their valuable work.

## Tutorial
At the 16th International Modelica Conference 2025, a tutorial is held about modeling of complex architectures using the library.
The modeling templates can be downloaded here:
[ThermoFluidStreamTutorial.zip](https://github.com/RaphaelGebhart/ThermofluidStream/blob/2025_Tutorial/ThermoFluidStreamTutorial.zip)
(Version 2023: [TFS_Tutorial.zip](https://github.com/nieweber/ThermofluidStream/files/12841619/TFS_Tutorial.zip))





