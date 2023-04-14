-- Import OrbitLib
local CelestialBody = require(game.ReplicatedStorage.Common.OrbitLib.CelestialBody)
local Orbit = require(game.ReplicatedStorage.Common.OrbitLib.Orbit)

-- Convert from Roblox coordinates to OrbitLib coordinates.
function RobloxToOrbitLib(x: number, y: number, z: number)
    return x, -z, y
end

-- Convert from OrbitLib coordinates to Roblox Coordinates.
function OrbitLibToRoblox(i: number, j: number, k: number)
    return i, k, -j
end

-- Conversion Factors
local oneStudEqualsKilometers = 1000
local oneKilometerEqualsStuds = 1/oneStudEqualsKilometers


-- Time Values
local timeAcceleration = 10000 -- How many times normal speed
local currentTime = 0

-- Prediction constants
local TOLERANCE = 0.0008 -- A constant used for calculating precision of prediction
                         -- See Orbital Prediction for documentation.

-- Parent body and orbit
local earth = CelestialBody.new("Earth", 5.972e24, 6378.1)
local orbit = Orbit.fromKeplerianElements(
    earth, 0.3, 22000, 1, 0, 0, 0, 0
)

-- Makes a part to show the spacecraft's position.
function CreateSpacecraftPart()

    -- Create part to match
    local part = Instance.new("Part")
    part.Anchored = true
    part.Color = Color3.new(1,0,0)
    part.Name = "Spacecraft"
    part.Size = Vector3.new(1, 1, 1)
    part.Shape = Enum.PartType.Ball
    part.TopSurface = Enum.SurfaceType.Smooth
    part.BottomSurface = Enum.SurfaceType.Smooth
    part.Position = Vector3.new(0,0,0)
    part.Parent = game.Workspace

    return part

end

-- Part for spacecraft
local spacecraftPart = CreateSpacecraftPart()


-- Positions the spacecraft based on the current time.
function PositionPartBasedOnPrediction(orbit: table, part: BasePart, currentTime: number)

    -- Get the predicted true anomaly
    local trueAnomaly = orbit:UniversalPrediction(currentTime, TOLERANCE)

    print(trueAnomaly)

    -- Get ECI position from true anomaly
    local currentPosXEci, currentPosYEci, currentPosZEci =
        orbit:GetPositionVelocityECI(trueAnomaly)

    -- Convert ECI position from OrbitLib reference vectors
    -- to Roblox reference vectors
    currentPosXEci, currentPosYEci, currentPosZEci =
        OrbitLibToRoblox(currentPosXEci, currentPosYEci, currentPosZEci)

    -- Convert from kilometers to Roblox studs from
    -- our arbitrary conversion factor
    currentPosXEci = currentPosXEci * oneKilometerEqualsStuds
    currentPosYEci = currentPosYEci * oneKilometerEqualsStuds
    currentPosZEci = currentPosZEci * oneKilometerEqualsStuds

    -- Position part
    part.Position = Vector3.new(currentPosXEci, currentPosYEci, currentPosZEci)

end


-- A handler for the Heartbeat event. The argument step contains the time since the last frame.
function OnHeartbeat(step: number)

    currentTime += step * timeAcceleration

    PositionPartBasedOnPrediction(orbit, spacecraftPart, currentTime)

end
game:GetService("RunService").Heartbeat:Connect(OnHeartbeat)
