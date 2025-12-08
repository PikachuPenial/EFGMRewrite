
-- If requirements aren't set, task is unlocked at start
-- Also, tasks are only unlocked if ALL requirements are met, this should change at some point
REQUIREMENT = {}
REQUIREMENT.PlayerStat = 1 -- Only supports NWInt's rn
REQUIREMENT.QuestCompletion = 2
REQUIREMENT.ItemDiscovered = 3 -- (Not implemented) So special quests can open if like, idk, the player finds a certain key
REQUIREMENT.AreaVisited = 4 -- (Not fully implemented)

OBJECTIVE = {}
OBJECTIVE.Kill = 1
OBJECTIVE.Extract = 2
OBJECTIVE.GiveItem = 3
OBJECTIVE.Pay = 4
OBJECTIVE.QuestItem = 5
OBJECTIVE.VisitArea = 6

REWARD = {}
REWARD.PlayerStat = 1
REWARD.Item = 2
REWARD.MarketUnlock = 3


SAVEON = {}
SAVEON.Progress = 1
SAVEON.Extract = 2
SAVEON.ObjectiveComplete = 3
SAVEON.TaskComplete = 4

-- Requirement functions

    NewRequirement = {}

    function NewRequirement.PlayerStat(count, stat)

        local req = {}
        
        req.type = REQUIREMENT.PlayerStat
        req.count = count or 1
        req.info = stat

        return req

    end

    function NewRequirement.QuestCompletion(taskName)

        local req = {}
        
        req.type = REQUIREMENT.QuestCompletion
        req.count = 1
        req.info = taskName

        return req

    end

-- Objective functions

    NewObjective = {}

    function NewObjective.Kill(count, mapName, areaName, areaDisplayName, whenToSave)

        local obj = {}

        obj.type = OBJECTIVE.Kill
        obj.count = count or 1
        obj.info = mapName
        obj.subInfo = areaName
        obj.subInfoDisplay = areaDisplayName
        obj.whenToSave = whenToSave or SAVEON.Progress

        return obj

    end

    function NewObjective.Extract(count, mapName, extractName, extractDisplayName, whenToSave)

        local obj = {}

        obj.type = OBJECTIVE.Extract
        obj.count = count or 1
        obj.info = mapName
        obj.subInfo = extractName
        obj.subInfoDisplay = extractDisplayName
        obj.whenToSave = whenToSave or SAVEON.Progress

        return obj

    end

    function NewObjective.GiveItem(count, itemName, isFIR)

        local obj = {}

        obj.type = OBJECTIVE.GiveItem
        obj.count = count or 1
        obj.info = itemName
        obj.subInfo = isFIR
        obj.whenToSave = SAVEON.Progress

        return obj

    end

    function NewObjective.Pay(count)

        local obj = {}

        obj.type = OBJECTIVE.Pay
        obj.count = count or 1
        obj.whenToSave = SAVEON.Progress

        return obj

    end

    function NewObjective.QuestItem(itemName, mapName)

        local obj = {}

        obj.type = OBJECTIVE.QuestItem
        obj.count = 1
        obj.info = mapName
        obj.subInfo = itemName
        obj.whenToSave = SAVEON.Extract

        return obj

    end

    function NewObjective.VisitArea(mapName, areaName, areaDisplayName, whenToSave)

        local obj = {}

        obj.type = OBJECTIVE.VisitArea
        obj.count = 1
        obj.info = mapName
        obj.subInfo = areaName
        obj.subInfoDisplay = areaDisplayName
        obj.whenToSave = whenToSave or SAVEON.Progress

        return obj

    end

-- Reward functions

    NewReward = {}

    function NewReward.PlayerStat(count, stat)

        local reward = {}
        
        reward.type = REWARD.PlayerStat
        reward.count = count or 1
        reward.info = stat

        return reward

    end

EFGMTASKS = {}

-- wip tasks to spruce up playtesting maybe
-- for the record i havent wrote a story since like third grade and that shit was ass
EFGMTASKS["connections"] = {
    
    name = "Connections",
    description = "Hey, soldier. I don't think I've seen you before. What do you want? Guns? Ammunition? Vodka? "..
    "Oh, I should've guessed, you want to escape the city. Well, I can't say I can help you there, but I might know a guy who knows a guy. "..
    "You're not gonna get any names out of me yet, though, I don't trust you. How about this? I have a job that needs doing, and I have some "..
    "roubles burning a hole in my pocket. You're familiar with that Concrete place, right? South of the capital? I had some guys get ambushed "..
    "there the other day, and I gotta make sure it doesn't happen again. I want you to scout out some vantage points around the location... "..
    "say, the top of the hotel, and the roof of the workshop. You know, that white building up north, with the bigass awning at the front. "..
    "While you're at it, get rid of some of the locals, let's say five of them. Let's see you get that done, then we can talk about connections.",
    
    traderName = "Bartender",
    traderIcon = Material("traders/generic.png", "smooth"),

    requirements = {
        NewRequirement.PlayerStat(2, "Level")
    },

    objectives = {
        NewObjective.VisitArea("efgm_concrete_rw", "qa_hotel_roof", "Hotel Roof"),
        NewObjective.VisitArea("efgm_concrete_rw", "qa_workshop_roof", "Workshop Roof"),
        NewObjective.Kill(5, "efgm_concrete_rw")
    },

    rewards = {
        NewReward.PlayerStat(10000, "Experience"),
        NewReward.PlayerStat(50000, "Money")
    },

    uibackground = Material("taskbg/concrete/general.jpg", "smooth")

}

EFGMTASKS["shooter"] = {
    
    name = "The Garkov Shooter",
    description = "[description here]",
    
    traderName = "Bartender",
    traderIcon = Material("traders/generic.png", "smooth"),

    requirements = {
        NewRequirement.PlayerStat(2, "Level"),
        NewRequirement.QuestCompletion("connections")
    },

    objectives = {
        NewObjective.Kill(30, "efgm_concrete_rw"),
        NewObjective.Kill(30, "efgm_belmont_rw"),
        NewObjective.Kill(30, "efgm_factory_rw")
    },

    rewards = {
        NewReward.PlayerStat(50000, "Experience"),
        NewReward.PlayerStat(5000000, "Money")
    },

    uibackground = Material("taskbg/concrete/general.jpg", "smooth")

}

EFGMTASKS["restock"] = {
    
    name = "Restocking",
    description = "[Description Here] The body armor plates are in the locked armory room in the workshop, check your map. They'll look like a briefcase because I haven't modeled them yet.",
    
    traderName = "Bartender",
    traderIcon = Material("traders/generic.png", "smooth"),

    requirements = {
        NewRequirement.PlayerStat(5, "Level"),
        NewRequirement.QuestCompletion("connections")
    },

    objectives = {
        NewObjective.Kill(5)
        NewObjective.QuestItem("plates", "efgm_concrete_rw")
    },

    rewards = {
        NewReward.PlayerStat(10000, "Experience"),
        NewReward.PlayerStat(300000, "Money")
    },

    uibackground = Material("taskbg/concrete/general.jpg", "smooth")

}

EFGMTASKS["civs1"] = {
    
    name = "Civilians - Part 1",
    description = "Greetings, operator. I am Aleksei, a PMC like yourself, and I have a request for you. "..
    "Earlier, as I was scouting out the southern parts of the city for an associate, I came across a few civilians in a bombed out building, "..
    "with a small child among them. Usually, I would mind my own business, but against my better judgement I promised to guide them to a "..
    "safer part of the city once my job is complete. Anyway, I decided on a place for them, but to get there I'll have to guide them straight "..
    "through Concrete.\n\nFor their sake and for mine, I want to make sure this trip is as uneventful as possible. I'll need you to verify some safe "..
    "extraction routes, and to dispatch any threats you come across while doing so. In the meantime, I will stay with the family, and make sure no "..
    "harm comes their way. Good luck, and let me know when it is done.",
    
    traderName = "Soldier",
    traderIcon = Material("traders/soldier.png", "smooth"),

    requirements = {
        NewRequirement.PlayerStat(7, "Level")
    },

    objectives = {
        NewObjective.Extract(1, "efgm_concrete_rw", "extract_driver", "Getaway Driver"),
        NewObjective.Extract(1, "efgm_concrete_rw", "extract_helicopter", "USEC Helicopter"),
        NewObjective.Extract(1, "efgm_concrete_rw", "extract_manhole", "Sewer Manhole"),
        NewObjective.Extract(1, "efgm_concrete_rw", "extract_railway", "Railway to Belmont"),
        NewObjective.Kill(5, "efgm_concrete_rw")
    },

    rewards = {
        NewReward.PlayerStat(15000, "Experience"),
        NewReward.PlayerStat(200000, "Money")
    },

    uibackground = Material("taskbg/concrete/outdoors.jpg", "smooth")

}

EFGMTASKS["civs2"] = {
    
    name = "Civilians - Part 2",
    description = "Hello again, operator. Thanks to you, I managed to guide them through Concrete unharmed. Unfortunately, "..
    "there is still more to be done before I feel comfortable leaving the family. For one, the safehouse "..
    "I had planned for them to stay at had been looted by the locals. Although some of the supplies have been untouched, "..
    "the threat of bandits returning makes it an unsuitable location for these civilians to stay long-term. As such, we made the decision that they would "..
    "accompany me to my own base of operations, many kilometers north of here. It will be a dangerous journey for them, which is "..
    "why I must ask more of you.\n\nI need good quality supplies; rations, medicine, ammunition, utilities, and weapons for the family. "..
    "I also need you to retrieve a briefcase left behind on Concrete. If memory serves, it would have been lost on the floor of "..
    "that old car dealership. It contains documents and other items of importance to the family, so it must be "..
    "returned to them prior to our expedition. Here is my location; please return shortly.",
    
    traderName = "Soldier",
    traderIcon = Material("traders/soldier.png", "smooth"),

    requirements = {
        NewRequirement.PlayerStat(13, "Level"),
        NewRequirement.QuestCompletion("civs1")
    },

    objectives = {
        NewObjective.Kill(15, "efgm_concrete_rw"),
        NewObjective.QuestItem("briefcase", "efgm_concrete_rw")
    },

    rewards = {
        NewReward.PlayerStat(15000, "Experience")
    },

    uibackground = Material("taskbg/concrete/outdoors.jpg", "smooth")

}