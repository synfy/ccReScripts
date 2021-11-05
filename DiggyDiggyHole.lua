-- This code digs a hole, and nothing else.
-- Seriously, it just digs a hole and refuels itself. No inventory dumping, no sorting, nothing. 
-- It will not suck your dick for you.

-- If you are standing on the turtle, facing the same direction
-- x is how far to your right it will go, inclusive of the block it's currently on
-- y is how far in front of you it will go, inclusive of the block it's currently on
-- z is how far below you it will go, inclusive of the block it's currently on


function DiggyDiggyHole(x,y,z)
    local dir = y % 2
    for stepsDown = 1,z,1 do
        mineSquare(x,y)
        checkFuel(x+y+1)

        if dir == 0 then
            turtle.turnRight()
            for i = 1,x,1 do
                turtle.forward()
            end
        else
            turtle.turnLeft()
        end

        turtle.turnLeft()

        if turtle.detectDown() then
            turtle.digDown()
        end
        turtle.down()

    end
end

function mineSquare(x,y)
    checkFuel(x*y)
    for stepsSide = 1,x,1 do

        for stepsForward = 1,y,1 do
            if turtle.detect() then
                turtle.dig()
            end
            turtle.forward()
        end

        if stepsSide < x then
            stepsForward = 1
            local dir = stepsSide % 2

            if dir == 0 then
                turtle.turnLeft()
            else 
                turtle.turnRight()
            end
            
            if turtle.detect() then
                turtle.dig()
            end
            turtle.forward()
            
            if dir == 0 then
                turtle.turnLeft()
            else
                turtle.turnRight()
            end
        end
    end
end

function checkFuel(amount)
    local fuelNeeded = amount + 1
    while turtle.getFuelLevel() < fuelNeeded do
        turtle.refuel(1)
    end
end

DiggyDiggyHole(9,9,9)