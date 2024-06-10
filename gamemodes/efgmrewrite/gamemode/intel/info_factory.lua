local factory = {

    Name = "Factory",

    Stats = {
        [1] = "Raid Time = 20 minutes",
        [2] = "Map Size = Small"
    },

    Description = "A small, fast-paced CQC map inside of a multi-story industrial factory, complete with tunnels and overhead walkways.",

    Children = {

        [1] = {

            Name = "Gate 0",

            Stats = {

                [1] = "Extraction Time = 10 seconds",
                [2] = "Universal = False",
                [3] = "Guranteed = True"

            },

            Description = "A rusted metal gate located at the southeastern corner of the factory."

        },

        [2] = {

            Name = "Gate 3",

            Stats = {

                [1] = "Extraction Time = 10 seconds",
                [2] = "Universal = True",
                [3] = "Guranteed = True"

            },

            Description = "A rusted metal gate located at the southwestern corner of the factory."

        },

        [3] = {

            Name = "Camera Bunker Door",

            Stats = {

                [1] = "Extraction Time = 10 seconds",
                [2] = "Universal = False",
                [3] = "Guranteed = True"

            },

            Description = "A hermetic door located in the underground tunnel system, roughly in the southern part of the factory."

        },

        [4] = {

            Name = "Cellars",

            Stats = {

                [1] = "Extraction Time = 10 seconds",
                [2] = "Universal = False",
                [3] = "Guranteed = True"

            },

            Description = "A hermetic door located in the underground tunnel system, specifically under the area with the forklifts in the northwestern corner of the location."

        },

        [5] = {

            Name = "Med Tent Gate",

            Stats = {

                [1] = "Extraction Time = 10 seconds",
                [2] = "Universal = False",
                [3] = "Guranteed = True"

            },

            Description = "A rusted metal gate, located behind a white medical tent in the northeastern corner of the map."

        }

    }

}

table.insert(Intel.Locations, factory)