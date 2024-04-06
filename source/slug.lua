local pd <const> = playdate
local gfx <const> = pd.graphics

class('Slug').extends(AnimatedSprite)

function Slug:init(x,y, moveSpeed, deltaY)
	self.deltaY = deltaY
	
	 
	local slugImageTable = gfx.imagetable.new("images/astro-slug-table-32-32")
    Player.super.init(self, slugImageTable)

	self:addState("crawl", 1, 2, {tickStep = 8})
    self:addState("recoil", 3, 4, {tickStep = 4})

	self:setCollideRect(0, 0, 32, 32)

	self:setDefaultState("crawl")
    self:playAnimation()
	
	-- For some reason added the move w/ collisions fixes an issue where the sprites jump around weirdly if they sqawn on top of each other.
	-- Using just the move to cause the sprites to not  spawn at all.
	self:moveTo(x,y)
	local actualX, actualY, collisions, length = self:moveWithCollisions(self.x , self.y)
	
	self.moveSpeed = moveSpeed
	self:add()
	self.killed = 0
end

function Slug:update()

    self:updateAnimation()

	if self.y < 0 or self.y > 220 then
		self.deltaY = -1 * self.deltaY
	end 
	
	local curX = self.x - self.moveSpeed
	local curY = self.y + self.deltaY
	
    local actualX, actualY, collisions, length = self:moveWithCollisions(curX, curY)
	
	if length > 0 then
		for index, collisions in pairs(collisions) do
			local collidedObject = collisions['other'] 
			if collidedObject:isa(Player) then
				injured()
				self:remove()
			elseif collidedObject:isa(Spider) or collidedObject:isa(Slug) then
			    if collidedObject.x < self.x  then
					self.deltaY = -1 * self.deltaY
				end
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