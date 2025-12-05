
-- If requirements aren't set, task is unlocked at start
-- Also, tasks are only unlocked if ALL requirements are met, this should change at some point
REQUIREMENT = {}
REQUIREMENT.PlayerStat = 1 -- Only supports NWInt's rn
REQUIREMENT.QuestCompletion = 2
REQUIREMENT.ItemFound = 3

REWARD = {}
REWARD.PlayerStat = 1
REWARD.Item = 2
REWARD.MarketUnlock = 3

OBJECTIVE = {}
OBJECTIVE.Kill = 1
OBJECTIVE.Extract = 2
OBJECTIVE.GiveItem = 3
OBJECTIVE.Pay = 4
OBJECTIVE.QuestItem = 5

EFGMTASKS = {}

-- for testing porpuses
EFGMTASKS["debut"] = {

    name = "Debut",
    description =
        "Hello there, soldier. I got a job that's a little too easy for my guys. But you'll do fine. "..
        "Hey, don't get pissy, I don't know you that well yet to give you a normal job! There's a lot of "..
        "bandit scum roaming the streets. They don't bother me much, but they're still a nuisance. Calm "..
        "down, say, five of them, and get a couple of MP-133 shotguns off them. I think that'll be enough "..
        "for you. Dismissed, soldier!",
    traderName = "Prapor",

    -- Objectives and rewards work by having separate type tables. The main table sets the parameters, and the type sets how the parameters are used.
    objectiveTypes = {OBJECTIVE.Kill},
    objectives = {{5, "efgm_concrete_rw"}},

    rewardTypes = { REWARD.Experience, REWARD.Money, REWARD.Item, REWARD.Item, REWARD.Item},
    rewards = {
        1700,
        15000,
        ITEM.Instantiate("arc9_eft_pp1901", 1, {}),
        ITEM.Instantiate("arc9_eft_pp1901", 1, {}),
        ITEM.Instantiate("efgm_ammo_9x19", 2, {count = 60})
    },

    uibackground = Material("taskbg/concrete/general.jpg", "smooth")

}

EFGMTASKS["luxlife"] = {

    name = "Luxurious Life",
    description =
        "Hey! You did well on the first job, but it's not enough to make me happy. "..
        "You're gonna have to do a little more legwork, soldier. I need to find a bottle "..
        "of wine. I myself am more of a hard drinker, but I know a man who collects "..
        "wine. And not just any kind, but the rarest kind! I want to give him a "..
        "bottle as a gesture of goodwill. Nowadays in Tarkov, any connections with "..
        "reputable people are worth their weight in gold, you know? There was a "..
        "liquor store in the city center. They used to sell booze three times the "..
        "price, for the elite folks. I'm sure there's some left. Go there and search "..
        "the place and get me a good bottle of some French wine! And don't even try "..
        "to slip me some fake shit.",
    traderName = "Prapor",

    requirementTypes = {REQUIREMENT.QuestCompletion},
    requirements = {"debut"},

    objectiveTypes = {OBJECTIVE.Kill},
    objectives = {{20, "efgm_concrete_rw"}},

    rewardTypes = { REWARD.Experience, REWARD.Money, REWARD.Item, REWARD.Item, REWARD.Item},
    rewards = {
        1700,
        15000,
        ITEM.Instantiate("arc9_eft_pp1901", 1, {}),
        ITEM.Instantiate("arc9_eft_pp1901", 1, {}),
        ITEM.Instantiate("efgm_ammo_9x19", 2, {count = 60})
    },

    uibackground = Material("taskbg/concrete/general.jpg", "smooth")

}

EFGMTASKS["testtask"] = {

    name = "Test Task",
    description =
        [[Yo. Do some shit, idk.]],
    traderName = "Some shit, idk",

    objectiveTypes = {OBJECTIVE.Kill, OBJECTIVE.Extract, OBJECTIVE.GiveItem, OBJECTIVE.Pay, OBJECTIVE.QuestItem},
    objectives = {{2, "efgm_concrete_rw"}, {1, "efgm_concrete_rw", "extract_helicopter"}, {1, "efgm_barter_tankbattery", true}, 25000, "briefcase"},

    rewardTypes = { REWARD.Experience, REWARD.Money, REWARD.Item, REWARD.Item, REWARD.Item},
    rewards = {
        1700,
        15000,
        ITEM.Instantiate("arc9_eft_pp1901", 1, {}),
        ITEM.Instantiate("arc9_eft_pp1901", 1, {}),
        ITEM.Instantiate("efgm_ammo_9x19", 2, {count = 60})
    },

    uibackground = Material("taskbg/concrete/workshop.jpg", "smooth")

}

EFGMTASKS["testreq"] = {

    name = "Test Requirements",
    description = "Just hook it up to a car and have the gas pedal pushed down so that it spins as fast as possible, at that point it’ll go so fast that the chair tears itself apart. But, for the sake of argument let’s assume that hypothetically this chair does not break this would mean that the Escape from Tarkov: Edge of Darkness Edition is moving up and down at speeds of roughly 200 miles an hour because of this if someone were to sit on the chair I think they would literally get torn open or assuming once more than for the sake of argument this person hypothetically receives no damage this word instead stretch the Escape from Tarkov: Edge of Darkness Edition to the point where it could cause permanent damage to the colonOr otherwise at the very least result in set a person not being able to walk or even stand upright for possibly hours if not even days due to the extreme trauma that their ass went through Now assuming that this contraption can work with interchangeable attachments we will stick with the method of using a car or some other sort of motorized vehicle in order to power the chair this could also become a very useful tool as the flat part of the chair used for sitting could also be used to lay certain items on if this were true then a Escape from Tarkov: Edge of Darkness Edition could be attached to the end instead and could be used as a very fine precision cutting tool which may be effective and useful against thin  but durable materials such as aluminum or planks of wood which would allow the chair to become industrialized and even possibly a common household appliance however if we were going to Stick with the original intended purpose of the chair then it could be used in interrogations as a way of forcing enemy operatives to divulge classified information the chair may not even have to be used as seeing it implies the third of having to sit on it which means that it could become very effective and convincing in the argument of asking one to divulge information, however if this chair were used for self Escape from Tarkov: Edge of Darkness Edition then it would likely require high amounts of Escape from Tarkov: Edge of Darkness Edition not only for the chain so that I can remain in working order but also for the participant who is sitting on the chair as without said Escape from Tarkov: Edge of Darkness Edition A higher velocity Escape from Tarkov: Edge of Darkness Edition travelling into the Escape from Tarkov: Edge of Darkness Edition could cause irrepairable damage. I’m going back to the argument of interchangeable accessory’s the hole on the chair is clearly large enough to fit larger items onto the attachment which means even larger Escape from Tarkov: Edge of Darkness Editions could be in fact applied to the chair with similar affects however these may have the effect of being too dangerous as they would carry much more force with them as they would be likely heavier This could lead to the chair rapidly moving upward and downward’s or shaking Side to side which could be marketed as a Escape from Tarkov: Edge of Darkness Edition function. Thank you for attending my speech",
    traderName = "Jaeger Probably",

    requirementTypes = {REQUIREMENT.PlayerStat},
    requirements = {{1, "Level"}},

    objectiveTypes = {OBJECTIVE.Extract},
    objectives = {{1}},

    rewardTypes = { REWARD.PlayerStat},
    rewards = {{10000, "Experience"}},

    uibackground = Material("taskbg/concrete/old_warehouse.jpg", "smooth")

}