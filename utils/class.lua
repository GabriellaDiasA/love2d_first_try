local Class = {}

local function search(key, parents)
    for i = 1, #parents do
        local found = parents[i][key]
        if found then return found end
    end
end

function Class.inherit(class, parents)
    class.parents = {
        __index = function (_, key)
            return search(key, parents)
        end
    }

    setmetatable(class, class.parents)
end

return Class