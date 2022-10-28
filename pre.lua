#!/opt/homebrew/bin/lua

inifile = require "inifile"

-- parse the INI file and
-- put values into a table called conf
conf = inifile.parse('config.toml')

-- Clone into github repository for downloading source code into 
-- src directory.

local github_url = conf['meta-data']['repository']
local git_clone_command = "git clone " + github_url

-- Clone into repo.
os.execute(git_clone_command)

-- Rename directory
os.execute("mv qemu src")
