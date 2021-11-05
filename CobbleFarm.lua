-- Literally just digs the block in front of it, then 
-- turns and drops it into whatever is to its left. 
-- Should not actually need fuel
function CobbleFarm()
    while turtle.getFuelLevel > 0 do
        if turtle.detect() then do
            turtle.dig()
        end
        if turtle.getItemCount(1) < 20 then do
            turtle.turnLeft()
            turtle.drop()
            turtle.turnRight()
        end
    end
end

CobbleFarm()