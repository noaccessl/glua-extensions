function file.Lines( filename, path )
    local File = file.Open( filename, 'r', path )

    local lines = ''
    while true do
        local line = File:ReadLine()
        if line == nil then break end

        lines = lines .. line
    end
    File:Close()

    return lines
end

function file.LinesCount( filename, path )
    local File = file.Open( filename, 'r', path )

    local count = 1
    while true do
        local line = File:ReadLine()
        if line == nil then break end

        count = count + 1
    end
    File:Close()

    return count
end

--[[ Meta ]]--
local File = FindMetaTable 'File'

function File:Lines()
    local lines = ''

    while true do
        local line = self:ReadLine()
        if line == nil then break end

        lines = lines .. line
    end

    return lines
end

function File:LinesCount()
    local count = 1

    while true do
        local line = self:ReadLine()
        if line == nil then break end

        count = count + 1
    end

    return count
end
