shell.run("clear")
function install()
print("Would you like to install ReactOS? (y/n)")
local input = read
if input == y then
term.clear()
write("Preparing you computer for first boot.")
sleep(1)
write(.)
sleep(1)
write(.)
sleep(1)
write(.)
sleep(1)
write(.)
sleep(1)
shell.run("disk/install")
elseif input == n then
term.clear()
print("Booting to CraftOS")
sleep(2)
term.clear()
else
print("Please Enter a Valid Option")
install()
end

