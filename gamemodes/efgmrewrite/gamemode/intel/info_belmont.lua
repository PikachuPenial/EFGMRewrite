local belmont = {

    Name = "Belmont",

    Stats = {
        [1] = "Raid Time = 40 minutes",
        [2] = "Map Size = Large"
    },

    Description = "A massive hybrid between a shopping center and a parking garage, all stationed underground away from civilization.",

    Children = {

        [1] = {

            Name = "Compartment",

            Stats = {

                [1] = "Extraction Time = 10 seconds",
                [2] = "Universal = False",
                [3] = "Guranteed = True"

            },

            Description = "A small hole within the drywall that is situated near the end of the first floor parking garage. " ..
            "Can be spotted via the glowing green light. "

        },

        [2] = {

            Name = "Dead End",

            Stats = {

                [1] = "Extraction Time = 10 seconds",
                [2] = "Universal = False",
                [3] = "Guranteed = True"

            },

            Description = "A sealed off corner near the entrance of the shopping mall. Can be spotted from the south of the shopping mall entrances escalator. "

        },

        [3] = {

            Name = "Escalator",

            Stats = {

                [1] = "Extraction Time = 10 seconds",
                [2] = "Universal = False",
                [3] = "Guranteed = True"

            },

            Description = "A relatively quiet extraction point, just head up the escalator inside of the shopping centers dining hall. "

        },

        [4] = {

            Name = "Circuit Heap",

            Stats = {

                [1] = "Extraction Time = 10 seconds",
                [2] = "Universal = True",
                [3] = "Guranteed = True"

            },

            Description = "A vulnrable extraaction point located at the end of the incredibly long electrical hall. Can be spotted near " ..
            "the security office, directly in the middle of the first floor parking lot."

        },

        [5] = {

            Name = "Hermetic Door",

            Stats = {

                [1] = "Extraction Time = 10 seconds",
                [2] = "Universal = True",
                [3] = "Guranteed = True"

            },

            Description = "A vulnrable extraaction point located near the notorious water pumps. Can be spotted after taking " ..
            "a sharp left after exiting the elevator at Floor 1. The extraction can be used from either floor of the room."

        },

        [6] = {

            Name = "Parked Trailer",

            Stats = {

                [1] = "Extraction Time = 10 seconds",
                [2] = "Universal = False",
                [3] = "Guranteed = True"

            },

            Description = "A conveniently placed truck near the back of the second floor parking lot."

        }

    }

}

table.insert(Intel.LOCATIONS, belmont)