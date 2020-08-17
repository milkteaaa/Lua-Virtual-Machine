-- created by @yuukixdev || with help from H3x0r's LuaC VM

--------------
-- TABLE -----
--------------

if setreadonly then
    setreadonly(table, false)
_G.table = table
else
    _G.table = {}
end

local table = _G.table
table.new_protected = function(_table, message)
    local proxy = newproxy(true)
    local metatable = getmetatable(proxy)
    metatable.__index = function(_, field)
        return _table[field]
    end
    metatable.__newindex = function(_, field, value)
        if field ~= "Stack" then
            return(message or "This table is inaccessible.")
        else
            _table[field] = value
        end
    end
    metatable.__tostring = function()
        return(message or "This table is inaccessible.")
    end
    metatable.__metatable = message or "This table is inaccessible."
    return proxy
end

table.insert = function(...)
        local args = {...}
        local TABLE = args[1]
        local VALUE = args[2]
        local FIELD = args[3]
        if TABLE and VALUE then
            if FIELD then
                TABLE[FIELD] = VALUE
                return VALUE
            else
                TABLE[#TABLE + 1] = VALUE
                return VALUE
            end
        else
            return false
        end
end

table.shift = function(_table, _startiter)
    local temp = {}
    for i,v in pairs(_table) do
        if type(i) == "number" then
            temp[_startiter] = v
            _startiter = _startiter + 1
        elseif i == nil then
        else
            temp[i] = v
        end
    end
    _table = temp
    return temp
end

table.flip = function(_table)
    local temp = {}
    for i = #_table, 1, -1, do
        v = _table[i]
        table.insert(temp, v)
    end
    return temp
end

-----------------
----FUNCTIONS----
-----------------

local VMState = {}
lua_newstate = function()
    return table.insert(VMState, table.new_protected({
        IsLuaState = {ResetVMStack = false};
        VMStack = {};
        LuaNil = {};
    }, "Current VM State cannot be displayed."))
end

lua_error = function(VMState, message, ...)
    local arguments = {...}
    table.shift(arguments, 2)
    table.insert(arguments, 1)
    
    local _, err = pcall(function() error(unpack(arguments)) end)
    warn("VM: "..err)
    return err
end

lua_pushstring = function(VMState, string)
    local stack = VMState.VMStack
    table.insert(stack, tostring(string))
    return
end

lua_pushnil = function(VMState, num)
    local stack = VMState.VMStack
    local lua_nil = VMState.LuaNil
    table.insert(stack, lua_nil)
    return
end

lua_pushboolean = function(VMState, bool)
    local stack = VMState.VMStack
    local _bool;
    bool = string.lower(bool)

    if bool == "true" then
        _bool = true
    elseif bool == "false" then
        _bool = false
    else
        error("VM: bad argument #2 - lua_pushboolean: expected parsable string, got "..type(bool))
    end
    table.insert(stack, _bool)
end

lua_printstack = function(VMState)
    local stack = VMState.VMStack
    local iterator = 0
    local value = nil
    repeat
        iterator = iterator + 1
        if iterator ~= 1 then
            print((iterator - 1), value)
        end
        value = stack[iterator]
    until value == nil
