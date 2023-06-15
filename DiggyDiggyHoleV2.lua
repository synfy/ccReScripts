-- Digs a hole, same as the predecessor, except it doesn't fuck up on even numbers
-- A bit less fuel efficient, but way less buggy and way more user friendly

function GetInitialValues()
    print("MIT license, no warranty, etc")
    print("Please enter digits only, ex. 2 NOT two")
    print("All values are INCLUSIVE of current position")
    print("How many blocks forward would you like me to dig?")
    local initY = io.read()
    local y = tonumber(initY)
    print("How many blocks right would you like me to dig?")
    local initX = io.read()
    local x = tonumber(initX)
    print("How many blocks down would you like me to dig")
    local initZ = io.read()
    local z = tonumber(initZ)
    if (x <= 0) and (y <= 0) and (z <= 0) then
        print("Invalid sizes. Please enter positive, nonzero values")
        GetInitialValues()
    end
    print("Alright, I will dig a hole that is " .. y .. " blocks by " .. x .. " blocks and is " .. z .. " blocks deep")
    print("Does this sound right? (y/n)")
    local confirmation = io.read()
    if confirmation == "y" then
        DiggyDiggyHole(x,y,z)
    else
        print("No? Fine, we will start over.")
        GetInitialValues()
    end
end

function DiggyDiggyHole(x,y,z)
    for k = 1, z, 1 do
        for i = 1, x, 1 do
            CheckForRefuel(y)
            ClearColumnAndReturn(y-1)
            if not (i == x) then
                turtle.turnRight()
                if turtle.detect() then
                    turtle.dig()
                end
                turtle.forward()
                turtle.turnLeft()
            end
            
        end
        turtle.turnLeft()
        for i = 1, x-1, 1 do
            turtle.forward()
            if (i == (x-1)) then
                turtle.turnRight()
            end
        end
        if not (k == (z)) then
            if turtle.detectDown() then
                turtle.digDown()
            end
            turtle.down()
        end
    end
end

function CheckForRefuel(num)
    local fuel = turtle.getFuelLevel()
    local fuelNeeded = 1 + (num*2)
    if fuel < fuelNeeded then
        local fueled = turtle.refuel()
        if not fueled then
            print("I need fuel!")
            print("Please add fuel to my selected slot, then type 'go'")
            local useless = io.read()
            CheckForRefuel(num)
        end
    end
end

function ClearColumnAndReturn(y)
    for j = 1, y, 1 do
        if turtle.detect() then
            turtle.dig()
        end
        turtle.forward()
    end
    turtle.turnRight()
    turtle.turnRight()
    for j = 1, y, 1 do
        turtle.forward()
    end
    turtle.turnRight()
    turtle.turnRight()
end

GetInitialValues()