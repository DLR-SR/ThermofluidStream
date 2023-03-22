within ThermofluidStream.HeatExchangers.Internal;
partial model PartialConductionElementHEX "Parent for CEs for discretizedHEX"
  extends Processes.Internal.PartialConductionElement(
    final init= Processes.Internal.InitializationMethodsCondElement.inlet,
    final neglectPressureChanges=true);

    parameter SI.Area A = 1 "Contact area of volume with medium";

    parameter Integer nCellsParallel "Number of parallel discretization elements";

    constant SI.CoefficientOfHeatTransfer U_min = 1 "Minimum heat transfer coefficient for temperature adaption at zero massflow";

    SI.CoefficientOfHeatTransfer U "Heat transfer coefficient to medium";
equation
  k = U*A;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end PartialConductionElementHEX;
