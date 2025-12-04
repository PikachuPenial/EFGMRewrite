
TASK = {}

function TASK.Instantiate(name, progress)

    if name == nil then return nil end

    local task = {}
    task.name = name

    local info = EFGMTASKS[name]

    if info == nil then return nil end

    task.progress = {}

    if progress == nil then

        for k, v in ipairs(info.objectives) do
        
            task.progress[k] = 0

        end

        return task

    end


    task.progress = progress

    return task

end