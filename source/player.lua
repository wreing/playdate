import "bullet"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Player').extends(AnimatedSprite)

function Player:init(x, y)
	
    local playerImageTable = gfx.imagetable.new("images/astro-hero-table-40-40")
    Player.super.init(self, playerImageTable)	

	self:addState("idle", 1, 2, {tickStep=10})
    self:addState("shoot", 3, 3, {tickStep = 6, nextAnimation = "idle"} )
    self:addState("walk", 4, 5)
    self:addState("jumpCompress", 6, 6)
    self:addState("jumpAscend", 7, 7)
    self:addState("jump apex", 8, 8)
    self:addState("jumpLand", 9, 9)
    self:addState("recoil", 11, 11)
    self:addState("death", 12, 14)
    self:addState("blink", 15, 16)


    self:setDefaultState("idle")
    self:playAnimation()
	self:moveTo(x, y)
	
	self:setCollideRect(0, 0, self:getSize())
	
	self.speed = 3
	
	self:add()
end



function Player:update()
	self:updateAnimation()
	local w, h = self:getSize()
	local crankChange = pd.getCrankChange()
	
	if pd.buttonIsPressed(pd.kButtonUp) then
		if self.y > 0 + 15 then
		    self:moveBy(0,-self.speed)
		end
	elseif pd.buttonIsPressed(pd.kButtonDown) then
		if self.y < 240 -15  then 
		    self:moveBy(0,self.speed)
		end
	end
	
	if crankChange > 0 then
		if self.y > 0 +15 then
			self:moveBy(0,-crankChange)
		end
	elseif crankChange < 0 then
		if self.y < 240-15 then
			self:moveBy(0, -crankChange)
		end
	end
		
	
	if pd.buttonJustPressed(pd.kButtonA) then
		self:changeState("shoot")
		Bullet(self.x + w, self.y, 5)
	end
	
end