
// ill fill this out later but rn its more or less an outline so i can cross off "work on efgm inventory system" from my calender for once
// (i have written it every weekday for the past 2 weeks) without actually being productive

// just so i keep in mind what went wrong with the old system, it got way too cluttered with helper functions, and i kept swinging back
// and forth between different ideas that were all technically supported by the system, even though any of them wouldve been
// too much of a pain in the ass to implement

// i also really liked how terraria did it from what i remember from my days with tmodloader, and being that there's jack shit on the internet about
// how to actually code an inventory system, i want to stick to what i know is probably gonna work

// i think it'd be cool to have each item's stats defined somewhere (like weight, equip type, display price, etc), but idk where
// i could either have them defined in the entity file, which would be neat, but that would then require probably multiple functions to grab that data
// as opposed to just going to some json file to grab it, but then if it's all stored in a json file that would all have to be manually kept up to date

// as for how items would be stored in an inventory, i'm thinking about just having like inv.itemname = {count, metadata}, which would be simple, but
// then the stack logic might get complex

// on the other hand, i could just give each inventory slot a string / integer identifier, and have it like inv.slot = {itemname, count, metadata}

// shit so lua doesn't get mad at me for having an empty .lua file
// https://www.youtube.com/watch?v=Iv3F5ARdu58

local a = 0