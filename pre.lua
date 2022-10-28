#!/opt/homebrew/bin/lua

-- Clone into github repository for downloading source code into 
-- src directory.

local github_url = "https://github.com/qemu/qemu"
local git_clone_command = "git clone " + github_url

-- Clone into repo.
os.execute(git_clone_command)

-- Rename directory
os.execute("mv qemu src")
