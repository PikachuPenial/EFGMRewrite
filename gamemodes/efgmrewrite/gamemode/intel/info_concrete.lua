local concrete = {

    Name = "Concrete",

    Stats = {
        [1] = "Raid Time = 15 Minutes",
        [2] = "Map Size = Medium",
        [3] = "Hardcore Mode = Available"
    },

    Description = "A large and once thriving city, now abandoned by both the military and civilians. " ..
    "While this location has many long sight lines, close quarter engagements are not uncommon due to the handful of " ..
    "buildings and warehouses dotted around the area. As such, your choice of weapon here should be dependent " ..
    "on what you plan to do, and where you plan to go.\n\n" ..
    "Although Concrete seems generic, there is more to it than a bunch of abandoned buildings. " ..
    "The hotel looming over the location makes the roof a great spot for snipers, though its claustrophobic floors " ..
    "and OSHA non-compliant scaffolding allows for people to contest the roof with little difficulty. The web of underground tunnels " ..
    "and the extract they lead to may sound like a good deal for rats and other would-be loot goblins, but good luck finding your " ..
    "way without a flashlight. And the mildly vandalized garage door at the edge of the location appears to never have been opened, " ..
    "although it could be extremely lucrative to try.\n\n" ..
    "Concrete has no shortage of extraction points, though many of them are unreliable, " ..
    "hard to reach, or have prerequisites that need to be completed before they can be used. ",

    Children = {

        [1] = {

            Name = "Sewer Manhole",

            Stats = {

                [1] = "Extraction Time = 30 Seconds",
                [2] = "Is Universal = False",
                [3] = "Is Guranteed = True"

            },

            Description = "A heavy metal manhole, located in a grassy field, just south of the two white warehouses. " ..
            "As it takes a long time to extract with no surrounding cover, the sewer manhole can be a life saver if the raid is almost over, " ..
            "but is dangerous and risky to use nonetheless."

        },

        [2] = {

            Name = "Railway to Belmont",

            Stats = {

                [1] = "Extraction Time = 10 Seconds",
                [2] = "Is Universal = False",
                [3] = "Is Guranteed = True"

            },

            Description = "A metal gate, located at the eastern end of the southern railroad tracks. " ..
            "The extract is shielded from most sides, thanks to the large building blocking visibility from both the north and from the hotel. " ..
            "Furthermore, the gate has a relatively quick extraction time, with no prerequisites to boot, making it one of the safest extracts in Concrete."

        },

        [3] = {

            Name = "ZB-1337",

            Stats = {

                [1] = "Extraction Time = 20 Seconds",
                [2] = "Is Universal = True",
                [3] = "Is Guranteed = True"

            },

            Description = "An expertly camouflaged door situated in an underground tunnel. This extract is unique, as it is " ..
            "the only extract available to everybody, all the time, with no prerequisites. While the extraction point is lit up, the rest of the tunnel system is extremely dark, " ..
            "making it easy for people to sneak up and ambush you while you wait for the extract's 20 seconds to be over."

        },

        [4] = {

            Name = "Getaway Driver",

            Stats = {

                [1] = "Extraction Time = 10 Seconds",
                [2] = "Is Universal = True",
                [3] = "Is Guranteed = False"

            },

            Description = "A white, somehow windowless truck behind a gate in the northwestern corner of the location. " ..
            "The extraction point is very safe, as crouching in the rear of the truck shields your entire body from virtually every angle. The only downside " ..
            "to using this extract (apart from its prerequisites) is that the extract is very claustrophobic, and anybody with a grenade can easily flush you out.\n\n" ..
            "The gate leading to the truck can be temporarily opened by pressing the button on the top floor of the red, " ..
            "windowed building in the western part of the map. While the truck can be easily reached without opening the gate, the driver " ..
            "(probably a client of the guy who built the ZB-1337 door) will enigmatically refuse to let you extract unless the gate has been opened."

        },

        [5] = {

            Name = "USEC Helicopter",

            Stats = {

                [1] = "Extraction Time = 20 Seconds",
                [2] = "Is Universal = True",
                [3] = "Is Guranteed = False"

            },

            Description = "A combine helicopter atop a red building, next to the railroad tracks. While the USEC helicopter " ..
            "may have more easily accessable alternatives, the helicopter itself provides excellent cover, if only from one angle at a time, " ..
            "and is a guranteed extract to everyone once the button has been pressed, making it a worthy rival to the getaway driver's truck.\n\n" ..
            "While the extract is easily reachable just by climbing up the ladders and scaffolding surrounding the building, " ..
            "the helicopter pilot (who may or may not be the getaway driver) will deny you an extraction unless you've pressed the button in the entrance to the bunker. " ..
            "Godspeed."

        }

    }

}

table.insert(Intel.Locations, concrete)