
TASKSTATUS = {}
TASKSTATUS.Locked = 1
TASKSTATUS.InProgress = 2
TASKSTATUS.Complete = 3
TASKSTATUS.Declined = 4 -- wouldnt it be funny if people could just opt out of the fucking task line lmao
TASKSTATUS.AcceptPending = 5

TASK = {}

function TASK.Instantiate(name, status, progress)

    if name == nil then return nil end

    local task = {}

    local info = EFGMTASKS[name]

    if info == nil then return nil end

    task.progress = {}

    if progress == nil then

        for k, v in ipairs(info.objectives) do
        
            task.progress[k] = 0

        end

    else

        task.progress = progress

    end

    task.status = status or TASKSTATUS.AcceptPending

    return task

end