rednet.open("top")
local reactor = peripheral.wrap("right")
local dataprotocol = "data"
local powerprotocol = "power"

function reacreceive()
works = reactor.getConnected()
if works == false then
rednet.broadcast(works, dataprotocol)
sleep(0.1)
else
local mytable = {
active = reactor.getActive(),
casingtemp = reactor.getCasingTemperature(),
energylasttick = reactor.getEnergyProducedLastTick(),
energystored = reactor.getEnergyStored(),
fuelamount = reactor.getFuelAmount(),
fuelmax = reactor.getFuelAmountMax(),
fueleatlasttick = reactor.getFuelConsumedLastTick(),
fueltemp = reactor.getFuelTemperature(),
fuelreact = reactor.getFuelReactivity(),
wasteamount = reactor.getWasteAmount(),
rodlevel = reactor.getControlRodLevel(0)
}
rednet.broadcast(mytable, dataprotocol)
sleep(0.1)
end
end

function reacsend()
local id, mes, pro = rednet.receive(powerprotocol, 0.1)
if mes == "poweron" then
if reactor.getActive() == true then
reactor.setActive(false)
elseif reactor.getActive() == false then
reactor.setActive(true)
end
end
end

function reacrod()
local e = reactor.getControlRodLevel(0)
local id, mes, pro = rednet.receive(powerprotocol, 0.1)
if mes == "minus" then
local e = e + 1
reactor.setAllControlRodLevels(e)

elseif mes == "minusten" then
local e = e + 10
reactor.setAllControlRodLevels(e)

elseif mes == "plusten" then
local e = e - 10
reactor.setAllControlRodLevels(e)

elseif mes == "plus" then
local e = e - 1
reactor.setAllControlRodLevels(e)

elseif mes == "zero" then
local e = 100
reactor.setAllControlRodLevels(e)

elseif mes == "sto" then
local e = 0
reactor.setAllControlRodLevels(e)
end
end

while true do
parallel.waitForAll(reacreceive, reacsend, reacrod)
end