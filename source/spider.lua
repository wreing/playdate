local pd <const> = playdate
local gfx <const> = pd.graphics

class('Spider').extends(AnimatedSprite)

function Spider:init(x,y, moveSpeed, deltaY)
	self.deltaY = deltaY
	
	local spiderImageTable = gfx.imagetable.new("images/astro-spiderbot-table-32-32")
    Player.super.init(self, spiderImageTable)
	
	self:setCollideRect(0, 0, 32, 32)

	self:addState("idle", 1, 2, {tickStep=10})
    self:addState("walk", 3, 6, {tickStep = 4} )
    self:addState("recoil", 7, 8)
    self:addState("shoot", 9, 9)
	
	self:setDefaultState("walk")
	self:playAnimation()

	
	
	-- For some reason added the move w/ collisions fixes an issue where the sprites jump around weirdly if they sqawn on top of each other.
	-- Using just the move to cause the sprites to not  spawn at all.
	self:moveTo(x,y)
	local actualX, actualY, collisions, length = self:moveWithCollisions(self.x , self.y)
	
	self.moveSpeed = moveSpeed
	self:add()

end

function Spider:update()

    self:updateAnimation()

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

function Spider:collisionsResponse()
	retrun "bounce"
end