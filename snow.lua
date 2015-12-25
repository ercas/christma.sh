#!/usr/bin/lua
-- replace spaces in a frame with snowflakes randomly
-- usage: ./snow.lua frame

snowFreqDenominator = 32
snowChars = {"❄","*","*","*",".",".",",",",","`"}

math.randomseed(io.popen("date +%N"):read("*all"))

function err(str)
    print(str)
    os.exit(1)
end

if not arg[1] then
    err("frame not specified")
end

file = io.open(arg[1], "r")

if not file then
    err("file \""..arg[1].."\" does not exist")
else
    data = file:read("*all")
    for _, code in utf8.codes(data) do
        char = utf8.char(code)
        if code == utf8.codepoint(" ") and math.random(snowFreqDenominator) == 1 then
            io.write(snowChars[math.random(#snowChars)])
        else
            io.write(char)
        end
    end
end
