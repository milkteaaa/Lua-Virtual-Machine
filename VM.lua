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
    metatable._index = function(_, field)
        return _table[field]
    end
    metatable._newindex = function(_, field, value)
        if field ~= "Stack" then
            return(message or "This table is inaccessible.")
        else
            _table[field] = value
        end
    end
    metatable._tostring = function()
        return(message or "This table is inaccessible.")
    end
    metatable._metatable = message or "This table is inaccessible."
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



    