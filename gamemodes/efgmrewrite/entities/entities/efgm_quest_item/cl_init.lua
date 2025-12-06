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
        
        local taskInfo = EFGMTASKS[taskName]

        for objIndex, objType in ipairs(taskInfo.objectiveTypes) do

            if objType == OBJECTIVE.QuestItem and taskInfo.objectives[objIndex] == self.Item and taskInstance.progress[objIndex] == 0 then

	            self:DrawModel()

                return

            end
            
        end

    end
    
end