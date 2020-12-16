--rework coming soon

local bit = bit32 or require "bit"
if not bit.blshift then
    bit.blshift = bit.lshift
    bit.brshift = bit.rshift
end

local band, brshift = bit.band, bit.brshift
local tostring, unpack = tostring, unpack or table.unpack

