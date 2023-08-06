import "spider"

local pd <const> = playdate
local gfx <const> = pd.graphics

local spawnTimer

function startSpawner()

	math.randomseed(pd.getSecondsSinceEpoch())	
	createTimer()
	
end


function createTimer()
	local spawnTime = math.random(500, 1000)
	spawnTimer = pd.timer.performAfterDelay(spawnTime, function ()
		createTimer()
		spawnEnemy()
	end)
end

function spawnEnemy()
	local spawnPosition = math.random(10,230)
	-- spawn way off screen because there are weird effects when spawing on top of each other
	Spider(380, spawnPosition, 1)
	print("Spider Spawned At :" , spawnPosition)
end

function stopSpawner()
	if spawnTimer then
		spawnTimer:remove()
	end
end

function clearEnemies()
	local allSprites = gfx.sprite.getAllSprites()
	for index, sprite in ipairs(allSprites) do
		if sprite:isa(Spider) then
			sprite:remove()
		end
	end
end