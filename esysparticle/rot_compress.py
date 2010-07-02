#rot_compress.py: A uniaxial compression simulation using ESyS-Particle
#       Author: D. Weatherley
#       Date: 27 December 2008
#       Organisation: ESSCC, University of Queensland
#       (C) All rights reserved, 2008.
#
#
#import the appropriate ESyS-Particle modules:
from esys.lsm import *
from esys.lsm.util import *
from esys.lsm.geometry import *
from WallLoader import WallLoaderRunnable

#instantiate a simulation object: 
sim = LsmMpi (numWorkerProcesses = 3, mpiDimList = [1,3,1])

#initialise the neighbour search algorithm:
sim.initNeighbourSearch (
   particleType = "RotSphere",
   gridSpacing = 2.5000,
   verletDist = 0.2000
)
#set the number of timesteps and timestep increment:
sim.setNumTimeSteps (100000)
sim.setTimeStepSize (1.0000e-02)

#specify the spatial domain for the simulation
domain = BoundingBox(Vec3(-20,-20,-20), Vec3(20,20,20))
sim.setSpatialDomain (domain)

#create a prism of spherical particles:
geoRandomBlock = RandomBoxPacker (
   minRadius = 0.200,
   maxRadius = 1.0000,
   cubicPackRadius = 2.2000,
   maxInsertFails = 5000,
   bBox = BoundingBox(
      Vec3(-5.0000, 0.0000,-5.0000),
      Vec3(5.0000, 20.0000, 5.0000)
   ),
   circDimList = [False, False, False],
   tolerance = 1.0000e-05
)
geoRandomBlock.generate()
geoRandomBlock_particles = geoRandomBlock.getSimpleSphereCollection()

#add the particles to the simulation object:
sim.createParticles(geoRandomBlock_particles)

#bond particles together with bondTag = 0:
sim.createConnections(
   ConnectionFinder(
      maxDist = 0.005,
      bondTag = 0,
      pList = geoRandomBlock_particles
   )
)

#create a wall at the bottom of the model:
sim.createWall (
   name = "bottom_wall",
   posn = Vec3(0.0000, 0.0000, 0.0000),
   normal = Vec3(0.0000, 1.0000, 0.0000)
)

#create a wall at the top of the model:
sim.createWall (
   name = "top_wall",
   posn = Vec3(0.0000, 20.0000, 0.0000),
   normal = Vec3(0.0000, -1.0000, 0.0000)
)

#create rotational elastic-brittle bonds between particles:
pp_bonds = sim.createInteractionGroup (
   RotBondPrms(
      name="pp_bonds",
      normalK=0.5,
      shearK=0.15,
      torsionK=0.04,
      bendingK=0.017,
      normalBrkForce=0.0025,
      shearBrkForce=0.0125,
      torsionBrkForce=0.00125,
      bendingBrkForce=0.00125,
      tag=0,
      scaling = True
   )
)

#initialise frictional interactions for unbonded particles:
sim.createInteractionGroup (
   RotFrictionPrms(
      name="friction",
      normalK=1.0,
      dynamicMu=0.4,
      staticMu=0.6,
      shearK=1.0,
      scaling = True
   ) 
)

#create an exclusion between bonded and frictional interactions:
sim.createExclusion (
   interactionName1 = "pp_bonds",
   interactionName2 = "friction"
)

#specify elastic repulsion from the bottom wall:
sim.createInteractionGroup (
   NRotElasticWallPrms (
      name = "bottom_wall_repel",
      wallName = "bottom_wall",
      normalK = 1.0
   )
)

#specify elastic repulsion from the top wall:
sim.createInteractionGroup (
   NRotElasticWallPrms (
      name = "top_wall_repel",
      wallName = "top_wall",
      normalK = 1.0
   )
)

#add translational viscous damping:
sim.createInteractionGroup (
   LinDampingPrms(
      name="damping1",
      viscosity=0.002,
      maxIterations=50
   )
)

#add rotational viscous damping:
sim.createInteractionGroup (
   RotDampingPrms(
      name="damping2",
      viscosity=0.002,
      maxIterations=50
   )
)

#add a wall loader to move the top wall:
wall_loader = WallLoaderRunnable(
   LsmMpi = sim,
   wallName = "top_wall",
   vPlate = Vec3 (0.0000e+00, -1.0000e-03, 0.0000e+00),
   startTime = 0,
   rampTime = 400
)
sim.addPreTimeStepRunnable (wall_loader)

#add a wall loader to move the bottom wall:
wall_loader2 = WallLoaderRunnable(
   LsmMpi = sim,
   wallName = "bottom_wall",
   vPlate = Vec3 (0.0000e+00, 1.0000e-03, 0.0000e+00),
   startTime = 0,
   rampTime = 400
)
sim.addPreTimeStepRunnable (wall_loader2)

#create a FieldSaver to store number of bonds:
sim.createFieldSaver (
   InteractionScalarFieldSaverPrms(
      interactionName="pp_bonds",
      fieldName="count",
      fileName="nbonds.dat",
      fileFormat="SUM",
      beginTimeStep=0,
      endTimeStep=100000,
      timeStepIncr=1
   )
)

#create a FieldSaver to store potential energy stored in bonds:
sim.createFieldSaver (
   InteractionScalarFieldSaverPrms(
      interactionName="pp_bonds",
      fieldName="potential_energy",
      fileName="epot.dat",
      fileFormat="SUM",
      beginTimeStep=0,
      endTimeStep=100000,
      timeStepIncr=1
   )
)

#create a FieldSaver to wall positions:
posn_saver = WallVectorFieldSaverPrms(
   wallName=["bottom_wall", "top_wall"],
   fieldName="Position",
   fileName="out_Position.dat",
   fileFormat="RAW_SERIES",
   beginTimeStep=0,
   endTimeStep=100000,
   timeStepIncr=10
)
sim.createFieldSaver(posn_saver)

#create a FieldSaver to wall forces:
force_saver = WallVectorFieldSaverPrms(
   wallName=["bottom_wall", "top_wall"],
   fieldName="Force",
   fileName="out_Force.dat",
   fileFormat="RAW_SERIES",
   beginTimeStep=0,
   endTimeStep=100000,
   timeStepIncr=10
)
sim.createFieldSaver(force_saver)

#execute the simulation:
sim.run()

