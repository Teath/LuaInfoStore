info = {}

local line = "==============================="

function header()
    os.execute("cls")
    print "INFO STORAGE TEST PROGRAM"
    print (line)
    print "COMMANDS:"
    print "new: Create new detail"
    print "del: Delete detail"
    print "list: List all details"
    print "read: Read detail"
    print "exit: Exit program"
    print (line)
end

function startup()
    loadDetail()
    return menu()
end

function menu()
    header()
    print "Type command"
    local option = io.read()
    if option == "new" then
        return addDetail()
    elseif option == "list" then
        return listDetail()
    elseif option == "del" then
        return delDetail()
    elseif option == "read" then
        return readDetail()
    elseif option == "exit" then
        return true
    else 
        print "Invalid choice!"
        io.read()
        return menu()
    end
end

function loadDetail()
    local file = io.open("info", "r")
    for lines in io.lines("info") do
        local rawData = file:read("*l")
        if rawData ~= nil then
            local dName = string.match(rawData, "(%w+):")
            local dValue = string.match(rawData, ":(%w+);")
            info[dName] = dValue
        end
    end
end

function addDetail()
    header()
    print "Enter detail name:"
    local detName = io.read()
    print "Enter detail data:"
    local detData = io.read()
    info[detName] = detData
    save()
    print "Detail created and saved!"
    io.read()
    return menu()
end

function listDetail()
    header()
    print "Information"
    print(line)
    for k,v in pairs(info) do
        print(k,v)
    end
    io.read()
    return menu()
end

function save()
    local file = io.open("info", "w+")
    for k,v in pairs(info) do
        file:write(k..":",v..";\n")
    end
    file:close()
end

function delDetail()
    header()
    print "Enter detail name:"
    local detName = io.read()
    info[detName] = nil
    save()
    print("Detail deleted!")
    io.read()
    return menu()
end

function readDetail()
    header()
    print "Enter detail name:"
    local detName = io.read()
    if info[detName] ~= nil then
        print (info[detName])
        io.read()
        return menu()
    else
        print ("Detail does not exist!")
        io.read()
        return menu()
    end
end


startup()

