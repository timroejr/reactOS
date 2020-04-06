rednet.open("top") -- side of wireless modem
local mon = peripheral.wrap("right") -- side or name of monitor
local dataprotocol = "data" -- data protocol
local powerprotocol = "power" -- power protocol
local monx ,mony = mon.getSize()

local mon2 = peripheral.wrap("bottom") -- fuel indicator
local mon2x ,mon2y = mon2.getSize()

local mon3 = peripheral.wrap("left")
local mon3x, mon3y = mon3.getSize()
local turbineprotocol = "turbine" -- turbine protocol
local turbinePower = "turbinePower"

mon2.clear()

function printdata()

local id, mes, pro = rednet.receive(dataprotocol)
term.redirect(mon)
term.clear()
mon.setTextScale(1)
term.setCursorPos(1,1)
if mes == false then
write("STATUS: ")
mon.setBackgroundColour(colors.red)
write("ERROR")
mon.setBackgroundColour(colors.black)
print()
mon.setBackgroundColour(colors.blue)
print()
print("Something is wrong with program or reactor setup")
print("Press Ctrl+T to terminate program")
mon.setBackgroundColour(colors.black)
else
write("STATUS: ")
if mes.active == true then
mon.setBackgroundColour(colors.lime)
write("ACTIVE")
elseif mes.active == false then
mon.setBackgroundColour(colors.yellow)
write("NOT ACTIVE")
end
mon.setBackgroundColour(colors.black)
print()
print()
print("Rods Level:        " .. 100-tostring(mes.rodlevel) .." %")
print("Energy Production: " .. math.floor(mes.energylasttick,0) .. " RF/t")
print("Energy Stored:     " .. mes.energystored .. " RF")
print()
if mes.fuelamount < 1000 then
mon.setBackgroundColour(colors.red)
print("Fuel:              " .. mes.fuelamount .. "/" .. mes.fuelmax .. " mB")
mon.setBackgroundColour(colors.black)
else
mon.setBackgroundColour(colors.lime)
print("Fuel:              " .. mes.fuelamount .. "/" .. mes.fuelmax .. " mB")
mon.setBackgroundColour(colors.black)
end
print("Fuel Usage:        " .. math.ceil(mes.fueleatlasttick*100)/100 .. " mB/t")
if mes.fueltemp < 300 then
mon.setBackgroundColour(colors.lime)
print("Fuel Temperature:  " .. math.floor(mes.fueltemp,1) .. " C")
mon.setBackgroundColour(colors.black)
else
mon.setBackgroundColour(colors.red)
print("Fuel Temperature:  " .. math.floor(mes.fueltemp,1) .. " C")
mon.setBackgroundColour(colors.black)
end
print("Fuel Reactivity:   " .. math.floor(mes.fuelreact,1) .. " %")
print("Waste:             " .. mes.wasteamount .. " mB")
print()
if mes.casingtemp < 300 then
mon.setBackgroundColour(colors.lime)
print("Casing Temperature:" .. math.floor(mes.casingtemp,1) .. " C")
mon.setBackgroundColour(colors.black)
else
mon.setBackgroundColour(colors.red)
print("Casing Temperature:" .. math.floor(mes.casingtemp,1) .. " C")
mon.setBackgroundColour(colors.black)
end
print()
mon.setBackgroundColour(colors.orange)
write("POWER ")
mon.setBackgroundColour(colors.black)
write(" ")
mon.setBackgroundColour(colors.gray)
write("   RODS LEVEL   ")
print()
mon.setBackgroundColour(colors.orange)
write("SWITCH")
mon.setBackgroundColour(colors.black)
write(" ")
mon.setBackgroundColour(colors.gray)
write("|<")
mon.setBackgroundColour(colors.black)
write(" ")
mon.setBackgroundColour(colors.gray)
write("<<")
mon.setBackgroundColour(colors.black)
write(" ")
mon.setBackgroundColour(colors.gray)
write("<")
mon.setBackgroundColour(colors.black)
write("  ")
mon.setBackgroundColour(colors.gray)
write(">")
mon.setBackgroundColour(colors.black)
write(" ")
mon.setBackgroundColour(colors.gray)
write(">>")
mon.setBackgroundColour(colors.black)
write(" ")
mon.setBackgroundColour(colors.gray)
write(">|")
mon.setBackgroundColour(colors.black)

term.redirect(mon2)
mon2.setCursorPos(1,1)
print("Fuel")
l = mes.fuelamount / 1000 --l stands for level
mon2.setCursorPos(1,12)
for i = 1, l do
local cX, cY = mon2.getCursorPos()
mon2.setBackgroundColour(colors.lime)
mon2.write("         ")
mon2.setCursorPos(1, cY-1)
end
m = 12 - l
mon2.setCursorPos(1, m)
for k = 1, m do
mon2.setBackgroundColour(colors.black)
local dX, dY = mon2.getCursorPos()
mon2.write("         ")
mon2.setCursorPos(1, dY-1)
end
--mon2.setBackgroundColour(colors.black)
--mon2.clear()

end
sleep(0.11)
end


function turbinePrintData() 

local id2, mes2, pro2 = rednet.receive(turbineprotocol)
term.redirect(mon3)
term.clear()
mon3.setTextScale(1)
term.setCursorPos(1,1)
if mes2 == false then
write("STATUS: ")
mon3.setBackgroundColour(colors.red)
write("ERROR")
mon3.setBackgroundColour(colors.black)
print()
mon3.setBackgroundColour(colors.blue)
print()
print("Something is wrong with the program or turbine setup")
print("Press Ctrl+T to terminal program")
mon3.setBackgroundColour(colors.black)
else
write("STATUS: ")
if mes2.active == true then
mon3.setBackgroundColour(colors.lime)
write("ACTIVE")
elseif mes2.active == false then
mon3.setBackgroundColour(colors.red)
write("OFFLINE")
end

if mes2.inductorEngaged == true then
mon3.setBackgroundColour(colors.lime)
print("Inductor Engaged:   ACTIVE")
mon3.setBackgroundColour(colors.black)
else
mon3.setBackgroundColour(colors.red)
print("Inductor Engaged:   DISABLED")
mon3.setBackgroundColour(colors.black)
end

mon3.setBackgroundColour(colors.black)
print()
print()
print("Energy Production: " .. math.floor(mes2.energyProduced, 0) .. " RF/t")
print("Energy Stored:     " .. mes2.energyStored .. " RF")
print("Max Flow Rate:     " .. mes2.maxFlowRate .. " mB/t")
print()

if mes2.rotorSpeed > 1900 then
mon2.setBackgroundColour(colors.red)
print("Rotor Speed:       " .. mes2.rotorSpeed .. " RPM")
mon2.setBackgroundColour(colors.black)
else
mon2.setBackgroundColour(colors.lime)
print("Rotor Speed:       " .. mes2.rotorSpeed .. " RPM")
mon2.setBackgroundColour(colors.black)
end
end
end



function sendpower()

local event, par1, tx, ty = os.pullEvent()
if event == "monitor_touch"  then

if tx == 8 or tx == 9 and ty == 16 then
rednet.broadcast("zero",powerprotocol)

elseif tx == 11 or tx == 12 and ty == 16 then
rednet.broadcast("minusten",powerprotocol)


elseif tx == 14 and ty == 16 then
rednet.broadcast("minus",powerprotocol)


elseif tx == 17 and ty == 16 then
rednet.broadcast("plus",powerprotocol)


elseif tx == 19 or tx == 20 and ty == 16 then
rednet.broadcast("plusten",powerprotocol)

elseif tx == 22 or tx == 24 and ty == 16 then
rednet.broadcast("sto",powerprotocol)

elseif tx<7 and ty == 15 or tx<7 and ty == 16 then
rednet.broadcast("poweron",powerprotocol)
end
end
end


while true do
parallel.waitForAny(printdata,turbinePrintData,sendpower)
end