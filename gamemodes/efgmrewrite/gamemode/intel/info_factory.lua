local factory = {

    Name = "Factory",

    Stats = {
        [1] = "Raid Time = 20 Minutes",
        [2] = "Map Size = Small"
    },

    Description = "A small, fast-paced CQC map inside of a multi-story industrial factory, complete with tunnels and overhead walkways.",

    Children = {

        [1] = {

            Name = "Gate 0",

            Stats = {

                [1] = "Extraction Time = 10 Seconds",
                [2] = "Is Universal = False",
                [3] = "Is Guranteed = True"

            },

            Description = "Gate 0"

        },

        [2] = {

            Name = "Gate 3",

            Stats = {

                [1] = "Extraction Time = 10 Seconds",
                [2] = "Is Universal = True",
                [3] = "Is Guranteed = True"

            },

            Description = "Gate 3"

        },

        [3] = {

            Name = "Camera Bunker Door",

            Stats = {

                [1] = "Extraction Time = 10 Seconds",
                [2] = "Is Universal = False",
                [3] = "Is Guranteed = True"

            },

            Description = "Camera Bunker Door"

        },

        [4] = {

            Name = "Cellars",

            Stats = {

                [1] = "Extraction Time = 10 Seconds",
                [2] = "Is Universal = False",
                [3] = "Is Guranteed = True"

            },

            Description = "Cellars"

        },

        [5] = {

            Name = "Med Tent Gate",

            Stats = {

                [1] = "Extraction Time = 10 Seconds",
                [2] = "Is Universal = False",
                [3] = "Is Guranteed = True"

            },

            Description = "Med Tent Gate"

        }

    }

}

table.insert(Intel.Locations, factory)