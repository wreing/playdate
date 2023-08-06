import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "player"
import "enemySpawner"
import "scoreDisplay"
import "screenShake"

local pd <const> = playdate
local gfx <const> = pd.graphics

-- todo
-- 2. fix spawer issue where they spawn and un spawn
-- 3. fix issue where bullets hitting enemy's sometimes try to remove the enemy (or bullet ) twice
-- 4. add a new enemy type
-- 5. Abstract new enemy type to parent class
-- 6. Switch player movment to crank


local screenShakeSprite = ScreenShake()

function resetGame()
	resetScore()
	clearEnemies()
	stopSpawner()
	startSpawner()
	--setShakeAmount(10)
end

function setShakeAmount(amount)
	screenShakeSprite:setShakeAmount(amount)
end

p = Player(30,120)
startSpawner()
createScoreDisplay()

function injured()
	p.injuredFrameCountdown = 10
end


function pd.update()
	gfx.sprite.update()
	pd.timer.updateTimers()
end

