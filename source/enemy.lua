local pd <const> = playdate
local gfx <const> = pd.graphics

class('Enemy').extends(gfx.sprite)

function Enemy:init(x,y, moveSpeed)
	local enemyImage = gfx.image.new("images/goblin")
	self:setImage(enemyImage)
	self:moveTo(x,y)
	self:add()
	
	self:setCollideRect(0, 0, self:getSize())
	
	self.moveSpeed = moveSpeed

end

function Enemy:update()
	local actualX, actualY, collisions, length = self:moveWithCollisions(self.x - self.moveSpeed, self.y)
	
	if length > 0 then
		for index, collisions in pairs(collisions) do
			local collidedObject = collisions['other'] 
			if collidedObject:isa(Player) then
				injured()
				self:remove()
			end
		end
	end
	
	if self.x < 0 then
		resetGame()
	end
	
end

function Enemy:collisionsResponse()
	retrun "overlap"
end