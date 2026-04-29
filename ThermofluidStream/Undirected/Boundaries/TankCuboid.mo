within ThermofluidStream.Undirected.Boundaries;
model TankCuboid
  "This is a cuboid tank in an acceleration field for the special case of the liquid surface normal to xz-plane."
  extends ThermofluidStream.Undirected.Boundaries.Internal.PartialTankUndirected;
  //Everything media related is located in the partialTank. Below is only geometry
  //dependent equations for the computation of static head and, for now, a
  // constant centre of mass. To complete the partialTank equations for total tank volume V,
  //centreOfMass, staticHeadInlets and staticHeadOutlets needs to be provided.
  //The division is made to easily implement any geometry, regardless of complexity.

  parameter SI.Length xLength "Length in x-direction" annotation(Dialog(tab="General",group="Geometry"));
  parameter SI.Length yLength "Length in y-direction" annotation(Dialog(tab="General",group="Geometry"));
  parameter SI.Length zLength "Length in z-direction" annotation(Dialog(tab="General",group="Geometry"));
     SI.Length D;

protected
   final parameter Real eps_geometry = 0.0000001 "numerical epsilon for geometric considerations";
   SI.Length D1;
   SI.Length D2;
   SI.Length D3;
   SI.Length D4;
   Real nx=normAcc[1];
   Real nz=normAcc[3];
   SI.Area Area = V_liquid/yLength;
   SI.Area AxLimit;
   SI.Area AzLimit;

initial equation

  //check that all inlet and outlet positions are within the tank geometry
   for i in 1:N_inlets loop
   assert(tankCenter[1]-xLength/2<=inletPositions[i,1] and inletPositions[i,1] <= tankCenter[1]+xLength/2, "Inlet outside tank geometry",level = AssertionLevel.error);
   assert(tankCenter[2]-yLength/2<=inletPositions[i,2] and inletPositions[i,2] <= tankCenter[2]+yLength/2,"Inlet outside tank geometry",level = AssertionLevel.error);
   assert(tankCenter[3]-zLength/2<=inletPositions[i,3] and inletPositions[i,3] <= tankCenter[3]+zLength/2,"Inlet outside tank geometry",level = AssertionLevel.error);
   end for;

   for i in 1:N_outlets loop
   assert(tankCenter[1]-xLength/2<=outletPositions[i,1] and outletPositions[i,1] <= tankCenter[1]+xLength/2,"Outlet outside tank geometry",level = AssertionLevel.error);
   assert(tankCenter[2]-yLength/2<=outletPositions[i,2] and outletPositions[i,2] <= tankCenter[2]+yLength/2,"Outlet outside tank geometry",level = AssertionLevel.error);
   assert(tankCenter[3]-zLength/2<=outletPositions[i,3] and outletPositions[i,3] <= tankCenter[3]+zLength/2,"Outlet outside tank geometry",level = AssertionLevel.error);
   end for;

      for i in 1:N_rears loop
   assert(tankCenter[1]-xLength/2<=rearPositions[i,1] and rearPositions[i,1] <= tankCenter[1]+xLength/2,"Outlet outside tank geometry",level = AssertionLevel.error);
   assert(tankCenter[2]-yLength/2<=rearPositions[i,2] and rearPositions[i,2] <= tankCenter[2]+yLength/2,"Outlet outside tank geometry",level = AssertionLevel.error);
   assert(tankCenter[3]-zLength/2<=rearPositions[i,3] and rearPositions[i,3] <= tankCenter[3]+zLength/2,"Outlet outside tank geometry",level = AssertionLevel.error);
      end for;
         for i in 1:N_fores loop
   assert(tankCenter[1]-xLength/2<=forePositions[i,1] and forePositions[i,1] <= tankCenter[1]+xLength/2,"Outlet outside tank geometry",level = AssertionLevel.error);
   assert(tankCenter[2]-yLength/2<=forePositions[i,2] and forePositions[i,2] <= tankCenter[2]+yLength/2,"Outlet outside tank geometry",level = AssertionLevel.error);
   assert(tankCenter[3]-zLength/2<=forePositions[i,3] and forePositions[i,3] <= tankCenter[3]+zLength/2,"Outlet outside tank geometry",level = AssertionLevel.error);
   end for;
equation
  V_ref =xLength*yLength*zLength;

  assert((Modelica.Math.Vectors.length(normAcc)>0.99 and Modelica.Math.Vectors.length(normAcc)<1.01),"Acceleration vector is not normalized",level = AssertionLevel.error);
  assert(-eps_geometry <= normAcc[2] and normAcc[2] <= eps_geometry,"Acceleration in y-direction not supported by squareBlockGeometry",level=AssertionLevel.warning);
  assert(V_liquid<=V_ref,"Trying to fit more liquid into tank than it holds",level=AssertionLevel.warning);

  centreOfMass =tankCenter;//constant in first implementation

  // where is the liquid surface? The possible solutions D1 to D4 goes from small liquid volume to large liquid volume.
  if nz<0 then
    if nx<0 then
      //small triangle of liquid
      D1 =sqrt(2*abs(nx*nz)*Area);
      //rectangle plus triangle of liquid, bottom mostly in z-direction
      D2 =-nz*Area/xLength - nx*xLength/2;
      //rectangle plus triangle of liquid, bottom mostly in x-direction
      D3 =-nx*Area/zLength - nz*zLength/2;
      // Full apart from small triangle of gas
      D4 =-(nx*xLength + nz*zLength) - sqrt(2*abs(nx*nz)*(xLength*zLength - Area));

    else
      //nx >=0
      D1 =-nx*xLength + sqrt(2*abs(nx*nz)*Area);
      D2 =-nz*Area/xLength - nx*xLength/2;
      D3 =nx*Area/zLength - nx*xLength - nz*zLength/2;
      D4 =-nz*zLength - sqrt(2*abs(nx*nz)*(xLength*zLength - Area));

    end if;
  else
    //nz >=0
      if nx < 0 then
        D1 =-nz*zLength + sqrt(2*abs(nx*nz)*Area);
        D2 =nz*Area/xLength - nx*xLength/2 - nz*zLength;
        D3 =-nx*Area/zLength - nz*zLength/2;
        D4 =-nx*xLength - sqrt(2*abs(nx*nz)*(xLength*zLength - Area));

      else
        //nx>=0
        D1 =-(nx*xLength + nz*zLength) + sqrt(2*abs(nx*nz)*Area);
        D2 =nz*Area/xLength - nx*xLength/2 - nz*zLength;
        D3 =nx*Area/zLength - nx*xLength - nz*zLength/2;
        D4 =-sqrt(2*abs(nx*nz)*(xLength*zLength - Area));

    end if;
  end if;

  if abs(nx) <= eps_geometry then
    D =D2;
    AzLimit =0;
    AxLimit =0;
  elseif abs(nz) <= eps_geometry then
    D =D3;
    AzLimit =0;
    AxLimit =0;
  else
    AxLimit =abs(nx/nz)*xLength^2/2;
    AzLimit =abs(nz/nx)*zLength^2/2;
    if (Area <= AzLimit) and (Area <= AxLimit) then
      D =D1;
    elseif (AxLimit <= Area) and (Area <= xLength*zLength - AxLimit) then
      D =D2;
    elseif (AzLimit <= Area) and (Area <= xLength*zLength - AzLimit) then
      D =D3;
    else
      D =D4;
    end if;
  end if;
  //D is relative to origo in the tank corner chosen such that all coordinates within the tank are positive
  //The distance from a point p to the surface is given by p*normAcc+D
for i in 1:N_inlets loop
  staticHeadInlets[i] =(inletPositions[i] - (tankCenter - {xLength/2,
      yLength/2,zLength/2}))*normAcc + D;
end for;
for i in 1:N_outlets loop
  staticHeadOutlets[i]=(outletPositions[i] - (tankCenter - {xLength/2,
      yLength/2,zLength/2}))*normAcc + D;
end for;
for i in 1:N_rears loop
  staticHeadRears[i]=(rearPositions[i] - (tankCenter - {xLength/2,
      yLength/2,zLength/2}))*normAcc + D;
end for;
for i in 1:N_fores loop
  staticHeadFores[i]=(forePositions[i] - (tankCenter - {xLength/2,
      yLength/2,zLength/2}))*normAcc + D;
end for;

  annotation (Documentation(info="<html>
<p><span style=\"font-family: Arial;\">In order to ensure that the surface is level is perpendicular to the xz-plane, the acceleration in y-direction is neglected.</span></p>
<p><span style=\"font-family: Arial;\">To specify the acceleration vector, please use the&nbsp;<a href=\"modelica://ThermofluidStream.Boundaries.AccelerationBoundary\">AccelerationBoundary</a>&nbsp;component.</span></p>
<p><span style=\"font-family: Arial;\">The tank works only with media that have gas and incompressible parts contained in them.</span></p>
<p><span style=\"font-family: Arial; color: #ff5500;\">Beware: This is a new addition to the library. It may be subject to design reconsiderations in future versions</span></p>
</html>", revisions="<html>
<p><img src=\"modelica:/ThermofluidStream/Resources/saab_logo.png\"/>Author: Ingela Lind, M Sc, Ph D, Technical Fellow,
Simulation and Thermal Analysis,
Vehicle Systems,
SAAB Aerosystems, 2024
</p>
</html>"));
end TankCuboid;
