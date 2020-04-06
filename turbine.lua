rednet.open("top")
local turbine = peripheral.wrap("back")
local turbineprotocol = "turbine" -- turbine protocol
local turbinePower = "turbinePower"

function turbineRec()
works = turbine.getConnected()
if works == false then
rednet.broadcast(works, turbineprotocol)
sleep(0.1)
else
local table = {

active = turbine.getActive(),
energyStored = turbine.getEnergyStored(),
rotorSpeed = turbine.getRotorSpeed(),
inputValue = turbine.getInputAmount(),
outputValue = turbine.getOutputAmount(),
flowRate = turbine.getFluidFlowRate(),
maxFlowRate = turbine.getFluidFlowRateMax(),
energyProduced = turbine.getEnergyProducedLastTick(),
inductorEngaged = turbine.getInductorEngaged(),

}
rednet.broadcast(table, turbineprotocol)
sleep(0.1)
end
end

function turbineSend()
local id, mes, pro = rednet.receive(turbinePower, 0.1)
if "mes" == "poweron" then
if turbine.getActive() == true then
turbine.setActive(false)
elseif turbine.getActive() == false then
turbine.setActive(true)
end
end
end



while true do
parallel.waitForAll(turbineRec, turbineSend)
end

