include("shared.lua")

ENT.Model = ""
ENT.Item = ""

function ENT:Initialize()

    self.Item = self:GetNWString("Item", "")

    self.Model = EFGMQUESTITEM[self.Item].model

end

-- is it great, iterating over dozens of objectives every frame? no. do i care? also no
function ENT:Draw()

    if table.IsEmpty(playerTasks) then return end

    for taskName, taskInstance in pairs(playerTasks) do
        
        if taskInstance.status == TASKSTATUS.InProgress then

            local taskInfo = EFGMTASKS[taskName]

            for objIndex, objInfo in ipairs(taskInfo.objectives) do

                if objInfo.type == OBJECTIVE.QuestItem and objInfo.subInfo == self.Item and taskInstance.progress[objIndex] + taskInstance.tempProgress[objIndex] == 0 then

                    self:DrawModel()

                end
                
            end
            
        end

    end
    
end