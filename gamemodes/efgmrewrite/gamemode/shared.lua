GM.Name = "Escape From Garry's Mod 2"
GM.Author = "Penial & Porty"
GM.Email = "piss off"
GM.Website = "https://www.youtube.com/watch?v=dQw4w9WgXcQ"

if CLIENT then
    CreateClientConVar("efgm_music", 1, true, false, "Enable/disable the music", 0, 1)
    CreateClientConVar("efgm_musicvolume", 1, true, false, "Increase or lower the volume of the music", 0, 2)
end

-- thanks penicillin
hook.Add("Initialize", "Optimization", function()
    hook.Remove("PlayerTick", "TickWidgets")
    if SERVER and timer.Exists("CheckHookTimes") then timer.Remove("CheckHookTimes") end
    if CLIENT then
        hook.Remove("RenderScreenspaceEffects", "RenderColorModify")
        hook.Remove("RenderScreenspaceEffects", "RenderBloom")
        hook.Remove("RenderScreenspaceEffects", "RenderToyTown")
        hook.Remove("RenderScreenspaceEffects", "RenderTexturize")
        hook.Remove("RenderScreenspaceEffects", "RenderSunbeams")
        hook.Remove("RenderScreenspaceEffects", "RenderSobel")
        hook.Remove("RenderScreenspaceEffects", "RenderSharpen")
        hook.Remove("RenderScreenspaceEffects", "RenderMaterialOverlay")
        hook.Remove("RenderScreenspaceEffects", "RenderMotionBlur")
        hook.Remove("RenderScene", "RenderStereoscopy")
        hook.Remove("RenderScene", "RenderSuperDoF")
        hook.Remove("GUIMousePressed", "SuperDOFMouseDown")
        hook.Remove("GUIMouseReleased", "SuperDOFMouseUp")
        hook.Remove("PreventScreenClicks", "SuperDOFPreventClicks")
        hook.Remove("PostRender", "RenderFrameBlend")
        hook.Remove("PreRender", "PreRenderFrameBlend")
        hook.Remove("Think", "DOFThink")
        hook.Remove("RenderScreenspaceEffects", "RenderBokeh")
        hook.Remove("NeedsDepthPass", "NeedsDepthPass_Bokeh")
        hook.Remove("PostDrawEffects", "RenderWidgets")
        hook.Remove("PostDrawEffects", "RenderHalos")
    end
end)

if GetConVar("efgm_derivesbox"):GetInt() == 1 then DeriveGamemode("sandbox") end -- this will enable the spawn menu as well as countless other things that you do not want users to have access too, please leave this off unless you know what you are doing