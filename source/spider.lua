local pd <const> = playdate
local gfx <const> = pd.graphics

class('Spider').extends(gfx.sprite)

function Spider:init(x,y, moveSpeed)
	self:add()
	self.fRate = 5
	
	self.imgFrames = { "images/spider_1", "images/spider_2", "images/spider_3", "images/spider_4" }
	
	self.currentFrame=1
	self.ct = 1
	--self:setImage(self.imgFrames[currentFrame])
	self:setImage(gfx.image.new(self.imgFrames[self.currentFrame]))
	
	self:setCollideRect(0, 0, 32, 32)
	
	
	-- For some reason added the move w/ collisions fixes an issue where the sprites jump around weirdly if they sqawn on top of each other.
	-- Using just the move to cause the sprites to not  spawn at all.
	self:moveTo(x,y)
	local actualX, actualY, collisions, length = self:moveWithCollisions(self.x , self.y)
	
	self.moveSpeed = moveSpeed

end

function Spider:update()
	local actualX, actualY, collisions, length = self:moveWithCollisions(self.x - self.moveSpeed, self.y)
	
	if self.ct == self.fRate then
		self.ct = 1
		
		self.currentFrame = self.currentFrame%3 + 1
	    self:setImage(gfx.image.new(self.imgFrames[self.currentFrame]))
		
	end
	self.ct = self.ct+1
	
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
	retrun "overlap"
end