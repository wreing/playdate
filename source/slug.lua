local pd <const> = playdate
local gfx <const> = pd.graphics

class('Slug').extends(gfx.sprite)

function Slug:init(x,y, moveSpeed, deltaY)
	self:add()
	self.fRate = 5
	self.deltaY = deltaY
	
	self.imgFrames = { "images/slug_1", "images/slug_2", "images/slug_3", "images/slug_4" }
	
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
	self.skipframe = 0  
end

function Slug:update()
	if self.y < 0 or self.y > 220 then
		self.deltaY = -1 * self.deltaY
	end 
	
    -- Skip movment for one frame	
	local curX = self.x - self.moveSpeed
	local curY = self.y + self.deltaY
	
	if self.skipframe > 0  then
		print("-----Freeze-------")
	    print(self.skipframe)
	    curX = self.x
	    curY = self.y
		self.skipframe = self.skipframe -1 
	end
	
	
	
    local actualX, actualY, collisions, length = self:moveWithCollisions(curX, curY)
	
	
	if self.ct == self.fRate then
		self.ct = 1
		
		self.currentFrame = self.currentFrame%2 + 1
	    self:setImage(gfx.image.new(self.imgFrames[self.currentFrame]))
		
	end
	self.ct = self.ct+1
	
	if length > 0 then
		for index, collisions in pairs(collisions) do
			local collidedObject = collisions['other'] 
			if collidedObject:isa(Player) then
				injured()
				self:remove()
			elseif collidedObject:isa(Spider) or collidedObject:isa(Slug) then
				print("hit slug or spider")
				
			    if collidedObject.x > self.x  then
					print("Set Freeze")
					self.skipframe = 6
				end
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