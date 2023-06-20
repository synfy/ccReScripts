function GetBorerInitialValues()
    print("MIT license, no warranty, etc")
    print("Please enter digits only, ex. 2 NOT two")
    print("All values are INCLUSIVE of current position")
    print("How many blocks forward would you like me to dig?")
    local initY = io.read()
    local y = tonumber(initY)
    print("How many blocks right would you like me to dig?")
    local initX = io.read()
    local x = tonumber(initX)
    print("How many blocks up would you like me to dig?")
    local initZ = io.read()
    local z = tonumber(initZ)
    if (x <= 0) and (y <= 0) and (z <= 0) then
        print("Invalid sizes. Please enter positive, nonzero values")
        GetBorerInitialValues()
    end
    print("Alright, I will dig a hole that is " .. y .. " blocks by " .. x .. " blocks and is " .. z .. " blocks deep")
    print("Does this sound right? (y/n)")
    local confirmation = io.read()
    if confirmation == "y" then
        TunnelBorer(x,y,z)
    else
        print("No? Fine, we will start over.")
        GetBorerInitialValues()
    end
end

function TunnelBorer(x,y,z)
    CheckForRefuel(1)
    if turtle.detect() then
        turtle.dig()
    end
    turtle.forward()
    
    for j = 1, y, 1 do
        for i = 1, x, 1 do
            CheckForRefuel(z)
            ClearColumnAndReturn(z-1)
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
        if not (j == (y)) then
            if turtle.detect() then
                turtle.dig()
            end
            turtle.forward()
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

function ClearColumnAndReturn(z)
    for k = 1, z, 1 do
        if turtle.detectUp() then
            turtle.digUp()
        end
        if not (k == z) then
            turtle.up()
        end
    end
    for k = 1, z-1, 1 do
        turtle.down()
    end
end

GetBorerInitialValues()