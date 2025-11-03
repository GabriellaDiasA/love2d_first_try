local Vector = require("utils.vector")

Origin = Vector.new(0, 0)
MaxAcceleration = 5
MaxSpeed = 20
MinSpeed = 0
Friction = 2
FrictionThreshold = 2
--BreakingForceThreshold = 0.1
--BreakingForceFactor = 2
TurningFactor = 1.8
BoostFactor = 8
BoostRechargeSeconds = 0.5
BounceThreshold = 1
Damping = 0.9
ScreenDimensions = Vector.new(love.graphics.getWidth(), love.graphics.getHeight())
