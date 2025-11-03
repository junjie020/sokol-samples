local lm = require "luamake"

lm.mode     = "debug"
lm.bindir   = "bin/" .. lm.mode
lm.builddir = "build/" .. lm.mode

local sokoldir = lm.workdir .. "/../sokol"

local shdc<const> = lm.shdc or "D:/code/sokolprojects/sokol-tools-bin/bin/win32/sokol-shdc.exe"

lm:conf {
    c = "c17",
}

lm:runlua "compile_shd"{
    script = "compile_shd.lua",
    args = {
        shdc,
        "$in",
        "$out",
        lm.workdir,
    },
    inputs = "sapp/arraytex-sapp.glsl",
    outputs = "sapp/arraytex-sapp.glsl.h",
}

lm:exe "sapp_arraytext-sapp"{
    sources = {
        "sapp/arraytex-sapp.c",
    },
    includes = {
        lm.workdir,
        sokoldir,
        lm.workdir .. "/sapp",
        lm.workdir .. "/libs",
    },
    defines = {
        "SOKOL_D3D11",
        "SOKOL_IMPL",
    },
    objdeps = {
        "compile_shd",
    }
}

lm:default {
    "sapp_arraytext-sapp",
}