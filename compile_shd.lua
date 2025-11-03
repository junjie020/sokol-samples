local subprocess = require "bee.subprocess"

local shdexe, input, output, cwd = ...
print("exe:", shdexe, "input:", input, "output:", output, "cwd:", cwd)
local process = assert(subprocess.spawn {
    shdexe,
    "-i",     input,
    "-o",     output,
    "--slang", "hlsl5",
    "--format", "sokol",
    cwd     = cwd,
    stdout  = io.stdout,
    stderr  = "stdout",
})

local code = process:wait()
if code ~= 0 then
  os.exit(code, true)
end