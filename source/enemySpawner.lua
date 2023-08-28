import "spider"
import "slug"

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
	--print(gfx.sprite:spriteCount() ) 
	local spawnPosition = math.random(10,230)
	-- What to spawn
	local enemyType = math.random(1,2)
	if enemyType == 1 then
	    Spider(430, spawnPosition, 1, 0)
	elseif enemyType == 2 then
	    Slug(430, spawnPosition, 1, -1)
	end
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