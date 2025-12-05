
-- If requirements aren't set, task is unlocked at start
-- Also, tasks are only unlocked if ALL requirements are met, this should change at some point
REQUIREMENT = {}
REQUIREMENT.Level = 1
REQUIREMENT.QuestCompletion = 2
REQUIREMENT.ItemFound = 3
REQUIREMENT.PlayerStat = 4

REWARD = {}
REWARD.Experience = 1
REWARD.Money = 2
REWARD.Item = 3
REWARD.Skill = 4
REWARD.MarketUnlock = 5

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
        [[Hello there, soldier. I got a job that's a little too easy for my guys. But you'll do fine.
        Hey, don't get pissy, I don't know you that well yet to give you a normal job! There's a lot of
        bandit scum roaming the streets. They don't bother me much, but they're still a nuisance. Calm
        down, say, five of them, and get a couple of MP-133 shotguns off them. I think that'll be enough
        for you. Dismissed, soldier!]],
    traderName = "Prapor",

    -- Objectives and rewards work by having separate type tables. The main table sets the parameters, and the type sets how the parameters are used.
    objectiveTypes = {OBJECTIVE.Kill},
    objectives = {5},

    rewardTypes = { REWARD.Experience, REWARD.Money, REWARD.Item, REWARD.Item, REWARD.Item},
    rewards = {1700, 15000, ITEM.Instantiate("arc9_eft_pp1901", 1, {}), ITEM.Instantiate("arc9_eft_pp1901", 1, {}), ITEM.Instantiate("efgm_ammo_9x19", 2, {count = 60})},

}

EFGMTASKS["luxlife"] = {

    name = "Luxurious Life",
    description =
        [[Hey! You did well on the first job, but it's not enough to make me happy.
        You're gonna have to do a little more legwork, soldier. I need to find a bottle
        of wine. I myself am more of a hard drinker, but I know a man who collects
        wine. And not just any kind, but the rarest kind! I want to give him a
        bottle as a gesture of goodwill. Nowadays in Tarkov, any connections with
        reputable people are worth their weight in gold, you know? There was a
        liquor store in the city center. They used to sell booze three times the
        price, for the elite folks. I'm sure there's some left. Go there and search
        the place and get me a good bottle of some French wine! And don't even try
        to slip me some fake shit.]],
    traderName = "Prapor",

    requirementTypes = {REQUIREMENT.QuestCompletion},
    requirements = {"debut"},

    objectiveTypes = {OBJECTIVE.Kill},
    objectives = {20},

    rewardTypes = { REWARD.Experience, REWARD.Money, REWARD.Item, REWARD.Item, REWARD.Item},
    rewards = {1700, 15000, ITEM.Instantiate("arc9_eft_pp1901", 1, {}), ITEM.Instantiate("arc9_eft_pp1901", 1, {}), ITEM.Instantiate("efgm_ammo_9x19", 2, {count = 60})}

}

EFGMTASKS["testTask"] = {

    name = "Test Task",
    description =
        [[Yo. Do some shit, idk.]],
    traderName = "Some shit, idk",

    objectiveTypes = {OBJECTIVE.Kill, OBJECTIVE.Extract, OBJECTIVE.GiveItem, OBJECTIVE.Pay, OBJECTIVE.QuestItem},
    objectives = {2, {1, "efgm_concrete_rw", "extract_helicopter"}, {1, "efgm_barter_tankbattery", true}, 25000, "briefcase"},

    rewardTypes = { REWARD.Experience, REWARD.Money, REWARD.Item, REWARD.Item, REWARD.Item},
    rewards = {1700, 15000, ITEM.Instantiate("arc9_eft_pp1901", 1, {}), ITEM.Instantiate("arc9_eft_pp1901", 1, {}), ITEM.Instantiate("efgm_ammo_9x19", 2, {count = 60})}

}