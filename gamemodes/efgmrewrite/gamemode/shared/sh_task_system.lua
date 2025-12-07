
TASKSTATUS = {}
TASKSTATUS.InProgress = 1
TASKSTATUS.Complete = 2
TASKSTATUS.AcceptPending = 3
TASKSTATUS.CompletePending = 4 -- for when the task is technically complete but player needs to claim they rewards

TASKSTATUSSTRING = {}
TASKSTATUSSTRING[1] = "In Progress"
TASKSTATUSSTRING[2] = "Completed"
TASKSTATUSSTRING[3] = "Declined"
TASKSTATUSSTRING[4] = "Accept Pending"
TASKSTATUSSTRING[5] = "Completion Pending"

TASK = {}

function TASK.Instantiate(name, status, progress, tempProgress)

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

    task.tempProgress = {}

    if tempProgress == nil then

        for k, v in ipairs(info.objectives) do

            task.tempProgress[k] = 0

        end

    else

        task.tempProgress = tempProgress

    end

    task.status = status or TASKSTATUS.AcceptPending

    return task

end