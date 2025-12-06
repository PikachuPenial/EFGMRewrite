
TASKSTATUS = {}
TASKSTATUS.InProgress = 1
TASKSTATUS.Complete = 2
TASKSTATUS.Declined = 3 -- wouldnt it be funny if people could just opt out of the fucking task line lmao
TASKSTATUS.AcceptPending = 4
TASKSTATUS.CompletePending = 5 -- for when the task is technically complete but player needs to claim they rewards

TASKSTATUSSTRING = {}
TASKSTATUSSTRING[1] = "In Progress"
TASKSTATUSSTRING[2] = "Completed"
TASKSTATUSSTRING[3] = "Declined"
TASKSTATUSSTRING[4] = "Accept Pending"
TASKSTATUSSTRING[5] = "Completion Pending"

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