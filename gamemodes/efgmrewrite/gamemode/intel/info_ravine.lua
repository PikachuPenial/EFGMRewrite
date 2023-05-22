
local ravine = {

    Name = "Ravine",

    Stats = {
        [1] = "Raid Time = 20 Minutes",
        [2] = "Map Size = Medium",
        [3] = "Hardcore Mode = Available"
    },

    Description = "A huge broken down facility, set in a ravine. Although the hydroelectric dam still generates power from the river below, " ..
    "the facility itself is barely functional, and has been falling apart for many years. Due to the map's secluded location, much of the loot has remained " ..
    "untouched. \n" ..
    "TBD: Features, extracts",

    Children = {

        [1] = {

            Name = "Helipad",

            Stats = {

                [1] = "Extraction Time = 10 Seconds",
                [2] = "Is Universal = True",
                [3] = "Is Guranteed = True"

            },

            Description = "A helicopter on a helipad, you aren't taking the helipad back to the hideout / commune."

        },

        [2] = {

            Name = "Boat",

            Stats = {

                [1] = "Extraction Time = 8 Seconds",
                [2] = "Is Universal = True",
                [3] = "Is Guranteed = False"

            },

            Description = "Its a motherfucking boat"

        },

        [3] = {

            Name = "Nate Higgers",

            Stats = {

                [1] = "Extraction Time = 69 Seconds",
                [2] = "Is Universal = False", -- segregation reference
                [3] = "Is Guranteed = True"

            },

            Description = "Man im running out of ideas to test the new intel system with"

        }

    }

}

table.insert(Intel.Locations, ravine)