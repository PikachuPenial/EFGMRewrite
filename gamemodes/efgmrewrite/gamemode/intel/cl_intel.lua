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

        },

        [7] = {

            Name = "Shop",

            Description = [[The shop system is fully functional, although the UI is still in development. ]] ..
            [[To buy or sell items, type "efgm_transaction_shop" into the console ]] ..
            [[(for instance, "efgm_transaction_shop + 1 1 weapon_pistol + 2 64 Pistol"). The first argument is a plus to buy an item ]] ..
            [[or a minus to sell an item. The second argument is the item type (there are ]] ..
            [[only two types supported, 1 is weapon and 2 is ammo). The third argument is the item count, which you should just keep at 1 if the item is ]] ..
            [[a weapon. Finally, the fourth argument is the item's internal name. To get an item's internal name, use "efgm_debug_printinventory" or ]] ..
            [["efgm_debug_shoplist" to read the contents of your inventory or available shop items, respectively.]]

        },

        [8] = {

            Name = "Stash",

            Description = [[The stash system is fully functional, although the UI is still in development. ]] ..
            [[To withdraw or deposit items into your stash, type "efgm_transaction_stash" into the console ]] ..
            [[(for instance, "efgm_transaction_stash + 1 1 weapon_pistol + 2 64 Pistol"). The first argument is a plus to remove an item from the stash ]] ..
            [[and take it, or a minus to take an item out of your inventory and put it into the stash. The second argument is the item type (there are ]] ..
            [[only two types supported, 1 is weapon and 2 is ammo). The third argument is the item count, which you should just keep at 1 if the item is ]] ..
            [[a weapon. Finally, the fourth argument is the item's internal name. To get an item's internal name, use "efgm_debug_printinventory" or ]] ..
            [["efgm_debug_printstash" to read the contents of your inventory or stash, respectively.]]

        }

    }

}
table.insert(Intel.Tutorial, tutorial)