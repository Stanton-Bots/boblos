local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Terminal-Ware PRIVATE",
    LoadingTitle = "Terminal-Ware Loader",
    LoadingSubtitle = "Terminal-Ware is now loading...",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = TWARE, -- Create a custom folder for your hub/game
       FileName = "Terminal-Ware_CFG"
    },
    Discord = {
       Enabled = false,
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided",
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })

 local Tab = Window:CreateTab("Misc", 4483362458) -- Title, Image

 local Button = Tab:CreateButton({
    Name = "Kill UI",
    Callback = function()
        Rayfield:Destroy()-- The function that takes place when the button is pressed
    end,
 })

 local Section = Tab:CreateSection("Player Movement")

 local Slider = Tab:CreateSlider({
    Name = "SpeedHack",
    Range = {0, 100},
    Increment = 10,
    Suffix = "WS",
    CurrentValue = 16,
    Flag = "speedSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(s)
        player.Character.Humanoid.WalkSpeed = s -- The function that takes place when the slider changes
    -- The variable (Value) is a number which correlates to the value the slider is currently at
    end,
 })

 local Slider = Tab:CreateSlider({
    Name = "JumpHack",
    Range = {0, 100},
    Increment = 10,
    Suffix = "JP",
    CurrentValue = 20,
    Flag = "jumpSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(s)
        player.Character.Humanoid.JumpPower = s -- The function that takes place when the slider changes
    -- The variable (Value) is a number which correlates to the value the slider is currently at
    end,
 })

local Tab = Window:CreateTab("Visuals", 4483362458) -- Title, Image

local Section = Tab:CreateSection("Global")

local Toggle = Tab:CreateToggle({
   Name = "Universal Chams",
   CurrentValue = false,
   Flag = "universalChams", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(t)
   --Settings
getgenv().enabled = t --Toggle on/off
getgenv().uselocalplayer = false --Choose whether the ESP highlights LocalPlayer or not
getgenv().filluseteamcolor = false --Toggle fill color using player team color on/off
getgenv().outlineuseteamcolor = false --Toggle outline color using player team color on/off
getgenv().fillcolor = Color3.new(100, 0, 255) --Change fill color, no need to edit if using team color
getgenv().outlinecolor = Color3.new(165, 0, 255) --Change outline color, no need to edit if using team color
getgenv().filltrans = .7 --Change fill transparency
getgenv().outlinetrans = 0 --Change outline transparency

--Actual ESP
local holder = game.CoreGui:FindFirstChild("ESPHolder") or Instance.new("Folder")
if enabled == false then
    holder:Destroy()
end

if holder.Name == "Folder" then
    holder.Name = "ESPHolder"
    holder.Parent = game.CoreGui
end

if uselocalplayer == false and holder:FindFirstChild(game.Players.LocalPlayer.Name) then
    holder:FindFirstChild(game.Players.LocalPlayer.Name):Destroy()
end

if getgenv().enabled == true then 
    getgenv().enabled = false
    getgenv().enabled = true
end
while getgenv().enabled do
    task.wait()
    for _,v in pairs(game.Players:GetChildren()) do
        local chr = v.Character
        if chr ~= nil then
        local esp = holder:FindFirstChild(v.Name) or Instance.new("Highlight")
        esp.Name = v.Name
        if uselocalplayer == false and esp.Name == game.Players.LocalPlayer.Name then
            else
        esp.Parent = holder
        if filluseteamcolor then
            esp.FillColor = v.TeamColor.Color
        else
            esp.FillColor = fillcolor 
        end
        if outlineuseteamcolor then
            esp.OutlineColor = v.TeamColor.Color
        else
            esp.OutlineColor = outlinecolor    
        end
        esp.FillTransparency = filltrans
        esp.OutlineTransparency = outlinetrans
        esp.Adornee = chr
        esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        end
        end
    end
end-- The function that takes place when the toggle is pressed
   -- The variable (Value) is a boolean on whether the toggle is true or false
   end,
})

local ColorPicker = Tab:CreateColorPicker({
   Name = "Box ESP (Can't toggle off)",
   Color = Color3.fromRGB(255,255,255),
   Flag = "boxColor", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(c)
       -- settings
local settings = {
   defaultcolor = c,
   teamcheck = false,
   teamcolor = false
};

-- services
local runService = game:GetService("RunService");
local players = game:GetService("Players");

-- variables
local localPlayer = players.LocalPlayer;
local camera = workspace.CurrentCamera;

-- functions
local newVector2, newColor3, newDrawing = Vector2.new, Color3.new, Drawing.new;
local tan, rad = math.tan, math.rad;
local round = function(...) local a = {}; for i,v in next, table.pack(...) do a[i] = math.round(v); end return unpack(a); end;
local wtvp = function(...) local a, b = camera.WorldToViewportPoint(camera, ...) return newVector2(a.X, a.Y), b, a.Z end;

local espCache = {};
local function createEsp(player)
   local drawings = {};
   
   drawings.box = newDrawing("Square");
   drawings.box.Thickness = 1;
   drawings.box.Filled = false;
   drawings.box.Color = settings.defaultcolor;
   drawings.box.Visible = false;
   drawings.box.ZIndex = 2;

   drawings.boxoutline = newDrawing("Square");
   drawings.boxoutline.Thickness = 3;
   drawings.boxoutline.Filled = false;
   drawings.boxoutline.Color = newColor3();
   drawings.boxoutline.Visible = false;
   drawings.boxoutline.ZIndex = 1;

   espCache[player] = drawings;
end

local function removeEsp(player)
   if rawget(espCache, player) then
       for _, drawing in next, espCache[player] do
           drawing:Remove();
       end
       espCache[player] = nil;
   end
end

local function updateEsp(player, esp)
   local character = player and player.Character;
   if character then
       local cframe = character:GetModelCFrame();
       local position, visible, depth = wtvp(cframe.Position);
       esp.box.Visible = visible;
       esp.boxoutline.Visible = visible;

       if cframe and visible then
           local scaleFactor = 1 / (depth * tan(rad(camera.FieldOfView / 2)) * 2) * 1000;
           local width, height = round(4 * scaleFactor, 5 * scaleFactor);
           local x, y = round(position.X, position.Y);

           esp.box.Size = newVector2(width, height);
           esp.box.Position = newVector2(round(x - width / 2, y - height / 2));
           esp.box.Color = settings.teamcolor and player.TeamColor.Color or settings.defaultcolor;

           esp.boxoutline.Size = esp.box.Size;
           esp.boxoutline.Position = esp.box.Position;
       end
   else
       esp.box.Visible = false;
       esp.boxoutline.Visible = false;
   end
end

-- main
for _, player in next, players:GetPlayers() do
   if player ~= localPlayer then
       createEsp(player);
   end
end

players.PlayerAdded:Connect(function(player)
   createEsp(player);
end);

players.PlayerRemoving:Connect(function(player)
   removeEsp(player);
end)

runService:BindToRenderStep("esp", Enum.RenderPriority.Camera.Value, function()
   for player, drawings in next, espCache do
       if settings.teamcheck and player.Team == localPlayer.Team then
           continue;
       end

       if drawings and player ~= localPlayer then
           updateEsp(player, drawings);
       end
   end
end)
       
   end
})

local Toggle = Tab:CreateToggle({
   Name = "Custom Crosshair (You might need to disable in game crosshair)",
   CurrentValue = false,
   Flag = "crosshairToggle", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(t)
   -- Custom Crosshair by zzerexx#3970
function msg(text,duration)
   local hint = Instance.new("Hint",game.CoreGui)
   hint.Text = text
   wait(duration or 5)
   hint:Destroy()
end
function UpdateScript()
   local bind = Instance.new("BindableFunction")
   function bind.OnInvoke(response)
       if response == "Yes" then
           if not setclipboard then
               msg("https://pastebin.com/raw/eGiC2jPg")
           end
           setclipboard("https://pastebin.com/raw/eGiC2jPg")
           game.StarterGui:SetCore("SendNotification",{
               Title = "Custom Crosshair",
               Text = "Copied the script to your clipboard!",
               Duration = 5
           })
       end
   end
   game.StarterGui:SetCore("SendNotification",{
       Title = "Custom Crosshair",
       Text = "You are using an older version of Custom Crosshair. Would you like the latest version?",
       Duration = 20,
       Callback = bind,
       Button1 = "Yes",
       Button2 = "No"
   })
end
local player = game:GetService("Players").LocalPlayer
local camera = workspace.CurrentCamera
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ss = getgenv().CrosshairSettings
local middle = Vector2.new(camera.ViewportSize.X/2,camera.ViewportSize.Y/2)

if getgenv().CrosshairSettings.ToggleKey == nil then
   UpdateScript()
end
if typeof(Drawing.new) ~= "function" then
   msg("Your exploit does not have a Drawing Library",5)
   return
end
if typeof(ss.Color) ~= "Color3" then
   msg("Invalid Color",2)
   return
end

if typeof(getgenv().crosshairobj) == "table" then
   for i,v in pairs(getgenv().crosshairobj) do
       if typeof(v) == "table" or typeof(v) == "userdata" then
           v:Remove()
       end
   end
end
if typeof(getgenv().crosshairrs) == "RBXScriptConnection" then
   getgenv().crosshairrs:Disconnect()
end
local supported = false
for i,v in next, {286090429,301549746,4292776423,292439477,299659045,4716045691,3233893879,2377868063,2555870920,4651779470,606849621,2916899287,443406476,1224212277,3527629287,388599755} do
   if game.PlaceId == v then
       supported = true
   end
end
if ss.HideGameCrosshair and not supported then
   spawn(function()
       msg("HideGameCrosshair is not available for this game. Check the source for a list of supported games",5) 
   end)
end

local line1 = Drawing.new("Line") -- Top Line
local line2 = Drawing.new("Line") -- Right Line 
local line3 = Drawing.new("Line") -- Bottom Line 
local line4 = Drawing.new("Line") -- Left Line
local dot = Drawing.new("Square") -- garbage dot
getgenv().crosshairobj = {line1 = line1,line2 = line2,line3 = line3,line4 = line4,dot = dot}
line1.Visible = t
line2.Visible = t
line3.Visible = t
line4.Visible = t
dot.Thickness = 1
dot.Visible = false
dot.Filled = false
if not ss.Dot then
   dot.Visible = false
end

game:GetService("UserInputService").InputBegan:Connect(function(i,gp)
   if i.KeyCode == ss.ToggleKey and not gp and line1 and line2 and line3 and line4 and dot then
       line1.Visible = not line1.Visible
       line2.Visible = not line2.Visible
       line3.Visible = not line3.Visible
       line4.Visible = not line4.Visible
       if ss.Dot then
           dot.Visible = not dot.Visible
       end
   end
end)

getgenv().crosshairrs = RunService.RenderStepped:Connect(function()
   ss = getgenv().CrosshairSettings
   if ss.HideMouseIcon ~= 0 then
       if ss.HideMouseIcon then
           UIS.MouseIconEnabled = false
       else
           UIS.MouseIconEnabled = true
       end
   end
   if ss.FollowCursor then
       middle = UIS:GetMouseLocation()
   else
       middle = Vector2.new(camera.ViewportSize.X/2,camera.ViewportSize.Y/2)
   end
   line1.Transparency = ss.Opacity
   line2.Transparency = ss.Opacity
   line3.Transparency = ss.Opacity
   line4.Transparency = ss.Opacity
   line1.Thickness = ss.Thickness
   line2.Thickness = ss.Thickness
   line3.Thickness = ss.Thickness
   line4.Thickness = ss.Thickness
   line1.Color = ss.Color
   line2.Color = ss.Color
   line3.Color = ss.Color
   line4.Color = ss.Color
   dot.Transparency = ss.Opacity
   dot.Color = ss.Color
   if ss.Dot and not dot.Visible then
       
   end
   if ss.RainbowColor then
       line1.Color = Color3.fromHSV(tick()%5/5,1,1)
       line2.Color = Color3.fromHSV(tick()%5/5,1,1)
       line3.Color = Color3.fromHSV(tick()%5/5,1,1)
       line4.Color = Color3.fromHSV(tick()%5/5,1,1)
       dot.Color = Color3.fromHSV(tick()%5/5,1,1)
   end
   
   line1.From = Vector2.new(middle.X,middle.Y-ss.Offset)
   line2.From = Vector2.new(middle.X+ss.Offset,middle.Y)
   line3.From = Vector2.new(middle.X,middle.Y+ss.Offset)
   line4.From = Vector2.new(middle.X-ss.Offset,middle.Y)
   line1.To = Vector2.new(middle.X,middle.Y-ss.Offset-ss.Length)
   line2.To = Vector2.new(middle.X+ss.Offset+ss.Length,middle.Y)
   line3.To = Vector2.new(middle.X,middle.Y+ss.Offset+ss.Length)
   line4.To = Vector2.new(middle.X-ss.Offset-ss.Length,middle.Y)
   
   if ss.Dot then
       dot.Size = Vector2.new(ss.Thickness,ss.Thickness)
       dot.Position = Vector2.new(middle.X-(ss.Thickness/2),middle.Y-(ss.Thickness/2))
   end
   if ss.HideGameCrosshair then
       pcall(function()
           if game.PlaceId == 286090429 or game.PlaceId == 301549746 then -- Arsenal + Counter Blox
               player.PlayerGui.GUI.Crosshairs.Crosshair.LeftFrame.Visible = false
               player.PlayerGui.GUI.Crosshairs.Crosshair.RightFrame.Visible = false
               player.PlayerGui.GUI.Crosshairs.Crosshair.TopFrame.Visible = false
               player.PlayerGui.GUI.Crosshairs.Crosshair.BottomFrame.Visible = false
               player.PlayerGui.GUI.Crosshairs.Crosshair.Dot.Visible = false
           elseif game.PlaceId == 4292776423 then -- Unit: Classified
               player.PlayerGui.GUI.Crosshair.L.Visible = false
               player.PlayerGui.GUI.Crosshair.R.Visible = false
               player.PlayerGui.GUI.Crosshair.U.Visible = false
               player.PlayerGui.GUI.Crosshair.D.Visible = false
           elseif game.PlaceId == 292439477 or game.PlaceId == 299659045 then -- Phantom Forces + test place
               player.PlayerGui.MainGui.GameGui.CrossHud.Visible = false
           elseif game.PlaceId == 4716045691 then -- Polybattle
               player.PlayerGui.ScreenGui.Center.ScaleYY.Middle.MouseIcon.Crosshair.Visible = false
           elseif game.PlaceId == 3233893879 then -- Bad Business
               player.PlayerGui.MainGui.Reticle.Visible = false
           elseif game.PlaceId == 2377868063 then -- Strucid, doesnt even work xd
               player.PlayerGui.MainGui.CrossHairs.Visible = false
               player.PlayerGui.MainGui.AlternateCrosshair.Visible = false
               player.PlayerGui.MainGui.ShotgunCrossHairs.Visible = false
           elseif game.PlaceId == 2555870920 then -- AceOfSpadez
               player.PlayerGui.Core.Gameplay.Cursor.Aim.Visible = false
           elseif game.PlaceId == 4651779470 then -- RECOIL
               player.PlayerGui.WHUD.Crosshair.Visible = false
           elseif game.PlaceId == 606849621 then -- Jailbreak
               player.PlayerGui.CrossHairGui.CrossHair.Visible = false
           elseif game.PlaceId == 2916899287 then -- Blackhawk Rescue Mission 5
               player.PlayerGui.Screen["#main"]["#hud"]["#cursor"]["#left"].Visible = false
               player.PlayerGui.Screen["#main"]["#hud"]["#cursor"]["#right"].Visible = false
               player.PlayerGui.Screen["#main"]["#hud"]["#cursor"]["#top"].Visible = false
               player.PlayerGui.Screen["#main"]["#hud"]["#cursor"]["#bottom"].Visible = false
           elseif game.PlaceId == 443406476 then -- Project Lazarus
               player.PlayerGui.HUD.Reticle.Visible = false
           elseif game.PlaceId == 1224212277 then -- Mad City
               player.PlayerGui.CrosshairGUI.Crosshair.Visible = false
           elseif game.PlaceId == 3527629287 then -- Big Paintball
               player.PlayerGui.Crosshair.Frame.Visible = false
           elseif game.Placeid == 388599755 then -- POLYGUNS
               for i,v in next, player.PlayerGui.ScreenGui.Reticle:GetChildren() do
                   v.Visible = false
               end
           end
       end)
   end
end)-- The function that takes place when the toggle is pressed
   -- The variable (Value) is a boolean on whether the toggle is true or false
   end,
})

local Button = Tab:CreateButton({
    Name = "Flight (No toggle)",
    Callback = function()
    -- settings
local settings = {
    defaultcolor = Color3.fromRGB(255,0,0),
    teamcheck = false,
    teamcolor = true
 };
 
 -- services
 local runService = game:GetService("RunService");
 local players = game:GetService("Players");
 
 -- variables
 local localPlayer = players.LocalPlayer;
 local camera = workspace.CurrentCamera;
 
 -- functions
 local newVector2, newColor3, newDrawing = Vector2.new, Color3.new, Drawing.new;
 local tan, rad = math.tan, math.rad;
 local round = function(...) local a = {}; for i,v in next, table.pack(...) do a[i] = math.round(v); end return unpack(a); end;
 local wtvp = function(...) local a, b = camera.WorldToViewportPoint(camera, ...) return newVector2(a.X, a.Y), b, a.Z end;
 
 local espCache = {};
 local function createEsp(player)
    local drawings = {};
    
    drawings.box = newDrawing("Square");
    drawings.box.Thickness = 1;
    drawings.box.Filled = false;
    drawings.box.Color = settings.defaultcolor;
    drawings.box.Visible = false;
    drawings.box.ZIndex = 2;
 
    drawings.boxoutline = newDrawing("Square");
    drawings.boxoutline.Thickness = 3;
    drawings.boxoutline.Filled = false;
    drawings.boxoutline.Color = newColor3();
    drawings.boxoutline.Visible = false;
    drawings.boxoutline.ZIndex = 1;
 
    espCache[player] = drawings;
 end
 
 local function removeEsp(player)
    if rawget(espCache, player) then
        for _, drawing in next, espCache[player] do
            drawing:Remove();
        end
        espCache[player] = nil;
    end
 end
 
 local function updateEsp(player, esp)
    local character = player and player.Character;
    if character then
        local cframe = character:GetModelCFrame();
        local position, visible, depth = wtvp(cframe.Position);
        esp.box.Visible = visible;
        esp.boxoutline.Visible = visible;
 
        if cframe and visible then
            local scaleFactor = 1 / (depth * tan(rad(camera.FieldOfView / 2)) * 2) * 1000;
            local width, height = round(4 * scaleFactor, 5 * scaleFactor);
            local x, y = round(position.X, position.Y);
 
            esp.box.Size = newVector2(width, height);
            esp.box.Position = newVector2(round(x - width / 2, y - height / 2));
            esp.box.Color = settings.teamcolor and player.TeamColor.Color or settings.defaultcolor;
 
            esp.boxoutline.Size = esp.box.Size;
            esp.boxoutline.Position = esp.box.Position;
        end
    else
        esp.box.Visible = false;
        esp.boxoutline.Visible = false;
    end
 end
 
 -- main
 for _, player in next, players:GetPlayers() do
    if player ~= localPlayer then
        createEsp(player);
    end
 end
 
 players.PlayerAdded:Connect(function(player)
    createEsp(player);
 end);
 
 players.PlayerRemoving:Connect(function(player)
    removeEsp(player);
 end)
 
 runService:BindToRenderStep("esp", Enum.RenderPriority.Camera.Value, function()
    for player, drawings in next, espCache do
        if settings.teamcheck and player.Team == localPlayer.Team then
            continue;
        end
 
        if drawings and player ~= localPlayer then
            updateEsp(player, drawings);
        end
    end
 end)-- The function that takes place when the button is pressed
    end,
 })