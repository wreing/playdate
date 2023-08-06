import "bullet"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Player').extends(gfx.sprite)

function Player:init(x, y)
	self.playerImage1 = gfx.image.new("images/astro")
	self.playerInjure1 = gfx.image.new("images/astro_injure_1")
	self.playerInjure2 = gfx.image.new("images/astro_injure_2")
	
	self:setImage(self.playerImage1)
	self:moveTo(x, y)
	
	self:setCollideRect(0, 0, self:getSize())
	
	self.speed = 3
	self.injuredFrameCountdown = 0
	
	self:add()
end



function Player:update()
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
	
	print(crankChange)
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
		Bullet(self.x + w, self.y, 5)
	end
	
  	if self.injuredFrameCountdown  >  4 then
		self:setImage(self.playerInjure1)
		self.injuredFrameCountdown -= 1
	elseif self.injuredFrameCountdown  > 1 then
		self:setImage(self.playerInjure2)
		self.injuredFrameCountdown -= 1
	elseif self.injuredFrameCountdown == 1  then
		self:setImage(self.playerImage1)
		self.injuredFrameCountdown = 0
		resetGame()
	end
	
	
	
end