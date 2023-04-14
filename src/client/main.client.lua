print("Hello OrbitLib!")
local replicatedStorage = game:GetService("ReplicatedStorage")
local shared = replicatedStorage:WaitForChild("Common")

-- Import modules from OrbitLib
local CelestialBody = require(shared.OrbitLib.CelestialBody)
local Orbit = require(shared.OrbitLib.Orbit)

-- Create Earth, a CelestialBody with a mass of 5.972*10^24 kg 
-- and a radius of 6378.1 kilometers
local earth = CelestialBody.new("Earth", 5.972e24, 6378.1)

-- Create a circular orbit about 1700 kilometers above the surface.
local orbitTest = Orbit.fromKeplerianElements(
    earth, 0, 6548.1, 0, 0, 0, 0, 0
)

print(orbitTest)

--[[ TODO: Code below does not seem to work
-- Get the position and velocity at the periapsis (true anomaly = 0 radians)
-- local eciPosX, eciPosY, eciPosZ, eciVelX, eciVelY, eciVelZ = orbit:GetPositionVelocityECI(0)

-- Pythagorean theorem to calculate the magnitude of the velocity.
local velMagnitude = math.sqrt(eciVelX*eciVelX + eciVelY*eciVelY + eciVelZ*eciVelZ)
print("Position at Periapsis: "..eciPosX.." km,"..eciPosY.." km,"..eciPosZ.." km. Velocity: "..velMagnitude.." km/s")
--]]

