local customs = {

    Name = "Customs",

    Stats = {
        [1] = "Raid Time = 20 minutes",
        [2] = "Map Size = Medium"
    },

    Description = "A section of the 'Customs' map from Escape from Tarkov, which includes Fortress, Crackhouse, and other familiar landmarks.",

    Children = {

        [1] = {

            Name = "Hole in Containers",

            Stats = {

                [1] = "Extraction Time = 10 seconds",
                [2] = "Is Universal = False",
                [3] = "Is Guranteed = True"

            },

            Description = "A corner surrounded by containers, at the back of construction."

        },

        [2] = {

            Name = "Crackhouse Gate",

            Stats = {

                [1] = "Extraction Time = 10 seconds",
                [2] = "Is Universal = False",
                [3] = "Is Guranteed = True"

            },

            Description = "A gate, located behind the crackhouse building."

        },

        [3] = {

            Name = "Factory Yard",

            Stats = {

                [1] = "Extraction Time = 10 seconds",
                [2] = "Is Universal = False",
                [3] = "Is Guranteed = True"

            },

            Description = "A corner, located right next to the factory building with the truck inside of it."

        },

        [4] = {

            Name = "Old Gas Station",

            Stats = {

                [1] = "Extraction Time = 10 seconds",
                [2] = "Is Universal = False",
                [3] = "Is Guranteed = True"

            },

            Description = "A gate located in a mostly walled-off corner of the map. One of the train tracks behind fortress leads to this extract."

        }

    }

}

table.insert(Intel.Locations, customs)