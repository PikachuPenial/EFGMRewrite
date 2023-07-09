Intel = {}

Intel.Tutorial = {}
Intel.Gameplay = {}
Intel.Objectives = {}
Intel.Locations = {}

local tutorial = {

    Name = "Basics",

    Description = "Escape from Garry's Mod Rewrite is an extraction shooter, loosely based off of Escape from Tarkov. In the lobby, you can " ..
        "store and equip weapons from your stash, buy and sell guns from the shop, keep tabs on your progression, and customize your "..
        "weapons to suit your playstyle. In the raid, your only goal is to get to an extraction point by whatever means necessary. " ..
        "If you get to one of the various extraction points, you will survive and bring all that you have with you back into the lobby. " ..
        "If you die, however, you loose everything you brought in, and other players will be free to loot your body. To supplement " ..
        "the gameplay, there are various contracts and unlocks you can work towards, and various maps are available to test your skills " ..
        "in different environments.",

    Children = {

        [1] = {

            Name = "Extracting",

            Description = "TODO: This"

        },

        [2] = {

            Name = "Looting",

            Description = "TODO: This"

        },

        [3] = {

            Name = "Customization",

            Description = "TODO: This"

        },

        [4] = {

            Name = "Contracts",

            Description = "TODO: This"

        },

        [5] = {

            Name = "Unlocks",

            Description = "TODO: This"

        },

        [6] = {

            Name = "Progression",

            Description = "TODO: This"

        }

    }

}
table.insert(Intel.Tutorial, tutorial)