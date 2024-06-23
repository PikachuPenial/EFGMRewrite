
if SERVER then

    -- dont allow players to use team chat if not in a team chat channel
    hook.Add("PlayerSay", "SuppressTeamChat", function(ply, text, teamChat)

        if not teamChat then return end

        if ply:GetNW2String("TeamChatChannel", "nil") == "nil" then

            ply:SendLua("chat.AddText(Color(255, 105, 105, 255), 'You are not in a squad!')")
            return ""

        end

    end )

end

if SERVER then

    -- only send team chat messages to other players in the senders team channel
    hook.Add("PlayerCanSeePlayersChat", "SuppressTeamChat", function(text, teamOnly, listener, speaker)

        if not speaker:IsPlayer() or not teamOnly then return end

        local channel = speaker:GetNW2String("TeamChatChannel", "nil")

        if channel == "nil" then return end

        if listener:GetNW2String("TeamChatChannel", "nil") == channel then

            return true

        else

            return false

        end

    end )

end