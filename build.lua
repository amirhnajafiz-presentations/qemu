#!/opt/homebrew/bin/lua
-- Path: build.lua
-- Build script building QEMU

print("Building QEMU ...")

-- Set the build directory
os.execute("cd src")

-- Configure QEMU
os.execute("chmod +x ./configure")

-- Build QEMU
os.execute("./configure)
os.execute("make")
