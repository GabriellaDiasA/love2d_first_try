local Cursor = {
    index = 1
}

function Cursor:down(elements)
    if self.index == #elements then
        self.index = 1
    else
        self.index = self.index + 1
    end
end

function Cursor:up(elements)
    if self.index == 1 then
        self.index = #elements
    else
        self.index = self.index - 1
    end
end

function Cursor:get_index()
    return self.index
end

return Cursor
