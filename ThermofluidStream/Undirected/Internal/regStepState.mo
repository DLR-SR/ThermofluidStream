within ThermofluidStream.Undirected.Internal;
function regStepState "Apply regStep on State"
  extends Modelica.Icons.Function;

  replaceable package Medium = Media.myMedia.Interfaces.PartialMedium
    "Medium model"
    annotation (choicesAllMatching=true, Documentation(
        info="<html>
<p>Replaceable medium package for the function.</p>
</html>"));

  input SI.MassFlowRate m_flow;
  input Medium.ThermodynamicState state_forwards;
  input Medium.ThermodynamicState state_rearwards;
  input SI.MassFlowRate m_flow_reg;

  output Medium.ThermodynamicState state;

protected
  SI.Pressure p;
  SI.SpecificEnthalpy h;
  Medium.MassFraction Xi[Medium.nXi];

  Medium.MassFraction Xi_forwards[Medium.nXi] = Medium.massFraction(state_forwards);
  Medium.MassFraction Xi_rearwards[Medium.nXi] = Medium.massFraction(state_rearwards);

algorithm
  p := regStep(m_flow, Medium.pressure(state_forwards), Medium.pressure(state_rearwards), m_flow_reg);
  h := regStep(m_flow, Medium.specificEnthalpy(state_forwards), Medium.specificEnthalpy(state_rearwards), m_flow_reg);
  for i in 1:Medium.nXi loop
    Xi[i] := regStep(m_flow, Xi_forwards[i], Xi_rearwards[i], m_flow_reg);
  end for;

  state := Medium.setState_phX(p, h, Xi);

  annotation (Documentation(info="<html>
<p>This function applies the regStep function to p,T and Xi of a state and creates and returns the resulting state.</p>
</html>"));
end regStepState;
