#!/opt/homebrew/bin/lua

-- Set the build dir
os.execute("src/build")

-- Setting the execute command
local execute_command = "./qemu-system-x86_64 -display none -no-user-config -m 2048 \
-nodefaults -monitor stdio -machine pc,usb=off \
-smp 1,maxcpus=2 -cpu IvyBridge-IBRS \
-qmp unix:/tmp/qmp-sock,server=on,wait=off"

-- Running the system
os.execute(execute_command)
