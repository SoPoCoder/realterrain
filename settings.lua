-- all trees and bushes are randomized when multiple shapes exist (using "apple" will randomly pick between multiple apple tree shapes)
-- for probability values, decimal numbers between 0 and 100 to two places (i.e. 25 or .02) are accepted. prob1 and prob2 are cumulative, meaning if prob1 and prob2 are both set to 50, prob1 will be 50 and prob2 will effectively be 25
-- see the "schems" folder for tree options. To add new trees use the Minetest-WorldEdit tool to save your tree as an .mts file and add it to the schems folder of the realterrain mod.
-- if you are making multiple shapes of the same tree for randomization purposes, give them all the sme name them with a suffix number from 1-4 and update the "trees" table at the bottom of this page. Then use the name without the number suffix in the settings below.
-- for ground and shrubs use the item string for any node found within the Minetest game (i.e. default:dirt). For a reference of node itemstring names, either press F5 in the Minetest game to view a nodes itemstring, or see https://wiki.minetest.net/Games/Minetest_Game/Nodes
local settings_table = {
--  {"setting_name",    "type",         "value"},

    --default settings
    {"fileelev",        "string",       "dem.bmp"},                 -- raster image file describing elevation (must be .bmp)
    {"filecover",       "string",       "biomes.bmp"},              -- raster image file describing biomes (must be .bmp)
    
    {"yscale",          "number",       1},                         -- increase/decrease scale along y (vertical) axis
    {"xscale",          "number",       1},                         -- increase/decrease scale along x (east-west) axis
    {"zscale",          "number",       1},                         -- increase/decrease scale along z (north-south) axis
    {"yoffset",         "number",       0},                         -- increase/decrease offset along y (vertical) axis
    {"xoffset",         "number",       0},                         -- increase/decrease offset along x (east-west) axis (i.e. 886)
    {"zoffset",         "number",       0},                         -- increase/decrease offset along z (north-south) axis (i.e. -997)
    {"centermap",       "boolean",      true},                      -- boolean, if true xoffset/zoffset will be set to half of raster width/breadth

    {"alpinelevel",     "number",       100},                       -- height of alpine biome start (i.e. 150)
    {"subalpine",       "number",       30},                        -- offset for sub_alpine zone set to 0 for none
    {"waterlevel",      "number",       16},                        -- height of water level (i.e. 16)
    {"kelpmindep",      "number",       6},                         -- minimum depth required for kelp to grow (recommend 6)
    {"wlilymaxdep",     "number",       6},                         -- maximum depth allowed for lillypads to grow (recommend 6)
    {"wlilyprob",       "number",       40},                        -- probability of waterlily presence
    {"bugmaxheight",    "number",       2},                         -- maximum height above surface that bugs can appear (minimum 2)
    {"addbugs",         "boolean",      true},                      -- randomly adds butterflies or fireflies when set to true
    {"addmushrooms",    "boolean",      true},                      -- randomly adds brown and red mushrooms to forest biomes when set to true

    {"nodecoration",    "boolean",      false},                     -- set to true for a world devoid of decorations (shrubs, trees, bugs, etc.)
    {"nobiomes",        "boolean",      false},                     -- set to true for a world devoid of biomes (grassland, desert, etc.)
    {"generateores",    "boolean",      false},                     -- for generating a strata of stone and ores rather than stone alone
    {"mgparams",        "string",       {                           -- mapgen parameters used by the minetest engine to generate map outside the borders of the raster map
        water_level = 16,                                           -- This should be the same as the water level setting above to avoid tsunamis
        flags = "nocaves, nodungeons, nodecorations, nobiomes, light", -- flags to conrol how the ocean floor beyond the raster map will generate (removing nodecorations will make trees appear under water, setting biomes to nobiomes will make ocean floor stone but prevent unexpected biome effects on the raster map like snow and ice)
        mgname = "flat",                                            -- the mapgen to use to generate the map beyond the borders of the raster map ("singlenode", "v6", "v7", "flat", etc.) to avoid landmasses appearing abruptly where the raster map ends use "flat"
        -- mgflat_ground_level = 0,                                 -- this controls the height of the ocean floor generated after the raster map ends, should be 0 to match the level of the raster map ocean floor (need to define on your minetest settings tab (Settings >> All Settings >> Mapgen >> Mapgen Flat >> Ground Level)
        -- mgflat_spflags = "nolakes, nohills",                     -- ensures that the ocean floor generated beyond the raster map is flat (need to define on your minetest settings tab (Settings >> All Settings >> Mapgen >> Mapgen Flat >> Mapgen Flat Specific Flags)
    }},

    --#000000 (black) lake (reserved, do not order)
    {"b00ground1",      "string",       "default:silver_sand"},     -- primary ground surface node
    {"b00ground2",      "string",       "default:coral_green"},     -- secondary ground surface node
    {"b00gprob",        "number",       30},                        -- probability of secondary surface node
    {"b00tree1",        "string",       ""},                        -- first .mts filename
    {"b00tprob1",       "number",       0},                         -- first .mts file probability
    {"b00tree2",        "string",       ""},                        -- second .mts filename
    {"b00tprob2",       "number",       0},                         -- second .mts file probability (% of first)
    {"b00shrub1",       "string",       ""},                        -- first ground cover node
    {"b00sprob1",       "number",       0},                         -- first ground cover node probability
    {"b00shrub2",       "string",       ""},                        -- secondary ground cover node
    {"b00sprob2",       "number",       0},                         -- secondary ground cover node probability (% of first)

    --#101010 (gray1) beach (reserved, do not order)
    {"b01ground1",      "string",       "default:sand"},
    {"b01ground2",      "string",       ""},
    {"b01gprob",        "number",       0},
    {"b01tree1",        "string",       ""},
    {"b01tprob1",       "number",       0},
    {"b01tree2",        "string",       ""},
    {"b01tprob2",       "number",       0},
    {"b01shrub1",       "string",       "flowers:dandelion_white"},
    {"b01sprob1",       "number",       2},
    {"b01shrub2",       "string",       "flowers:tulip_black"},
    {"b01sprob2",       "number",       20},
    
    --#202020 (gray2) grassland
    {"b02ground1",      "string",       "default:dirt_with_grass"},
    {"b02ground2",      "string",       ""},
    {"b02gprob",        "number",       0},
    {"b02tree1",        "string",       "aspen"},
    {"b02tprob1",       "number",       .05},
    {"b02tree2",        "string",       ""},
    {"b02tprob2",       "number",       0},
    {"b02shrub1",       "string",       "flowers:dandelion_white"},
    {"b02sprob1",       "number",       5},
    {"b02shrub2",       "string",       "flowers:tulip"},
    {"b02sprob2",       "number",       20},
    
    --#303030 (gray3) bushland
    {"b03ground1",      "string",       "default:dirt_with_grass"},
    {"b03ground2",      "string",       ""},
    {"b03gprob",        "number",       0},
    {"b03tree1",        "string",       "bush"},
    {"b03tprob1",       "number",       .5},
    {"b03tree2",        "string",       "big_wpine"},
    {"b03tprob2",       "number",       15},
    {"b03shrub1",       "string",       "flowers:dandelion_white"},
    {"b03sprob1",       "number",       5},
    {"b03shrub2",       "string",       "flowers:dandelion_yellow"},
    {"b03sprob2",       "number",       20},

    --#404040 (gray4) deciduous forest (new)
    {"b04ground1",      "string",       "default:dirt_with_coniferous_litter"},
    {"b04ground2",      "string",       "default:dirt_with_grass"},
    {"b04gprob",        "number",       20},
    {"b04tree1",        "string",       "apple"},
    {"b04tprob1",       "number",       5},
    {"b04tree2",        "string",       "aspen"},
    {"b04tprob2",       "number",       30},
    {"b04shrub1",       "string",       "flowers:dandelion_white"},
    {"b04sprob1",       "number",       5},
    {"b04shrub2",       "string",       "flowers:geranium"},
    {"b04sprob2",       "number",       20},

    --#505050 (gray5) deciduous forest (old)
    {"b05ground1",      "string",       "default:dirt_with_coniferous_litter"},
    {"b05ground2",      "string",       "default:dirt_with_grass"},
    {"b05gprob",        "number",       3},
    {"b05tree1",        "string",       "gtree"},
    {"b05tprob1",       "number",       6},
    {"b05tree2",        "string",       "bush"},
    {"b05tprob2",       "number",       20},
    {"b05shrub1",       "string",       "flowers:geranium"},
    {"b05sprob1",       "number",       0},
    {"b05shrub2",       "string",       "flowers:viola"},
    {"b05sprob2",       "number",       0},

    --#606060 (gray6) coniferous forest (new)
    {"b06ground1",      "string",       "default:dirt_with_coniferous_litter"},
    {"b06ground2",      "string",       "default:dirt_with_grass"},
    {"b06gprob",        "number",       5},
    {"b06tree1",        "string",       "pine"},
    {"b06tprob1",       "number",       6},
    {"b06tree2",        "string",       "pbush"},
    {"b06tprob2",       "number",       5},
    {"b06shrub1",       "string",       "flowers:viola"},
    {"b06sprob1",       "number",       5},
    {"b06shrub2",       "string",       ""},
    {"b06sprob2",       "number",       0},
        
    --#707070 (gray7) coniferous forest (old)
    {"b07ground1",      "string",       "default:dirt_with_coniferous_litter"},
    {"b07ground2",      "string",       "default:dirt_with_grass"},
    {"b07gprob",        "number",       5},
    {"b07tree1",        "string",       "gpine"},
    {"b07tprob1",       "number",       8},
    {"b07tree2",        "string",       "big_jeffrey"},
    {"b07tprob2",       "number",       20},
    {"b07shrub1",       "string",       "flowers:viola"},
    {"b07sprob1",       "number",       5},
    {"b07shrub2",       "string",       ""},
    {"b07sprob2",       "number",       0},

    --#808080 (gray8) savannah
    {"b08ground1",      "string",       "default:dirt_with_dry_grass"},
    {"b08ground2",      "string",       ""},
    {"b08gprob",        "number",       0},
    {"b08tree1",        "string",       "acacia"},
    {"b08tprob1",       "number",       .7},
    {"b08tree2",        "string",       ""},
    {"b08tprob2",       "number",       0},
    {"b08shrub1",       "string",       ""},
    {"b08sprob1",       "number",       0},
    {"b08shrub2",       "string",       ""},
    {"b08sprob2",       "number",       0},

    --#909090 (gray9) desert
    {"b09ground1",      "string",       "default:desert_sand"},
    {"b09ground2",      "string",       ""},
    {"b09gprob",        "number",       0},
    {"b09tree1",        "string",       "cactus"},
    {"b09tprob1",       "number",       .1},
    {"b09tree2",        "string",       ""},
    {"b09tprob2",       "number",       0},
    {"b09shrub1",       "string",       ""},
    {"b09sprob1",       "number",       0},
    {"b09shrub2",       "string",       ""},
    {"b09sprob2",       "number",       0},
    
    --#A0A0A0 (gray10) marsh
    {"b10ground1",      "string",       "default:dirt_with_rainforest_litter"},
    {"b10ground2",      "string",       "default:water_source"},
    {"b10gprob",        "number",       35},
    {"b10tree1",        "string",       "papyrus"},
    {"b10tprob1",       "number",       10},
    {"b10tree2",        "string",       ""},
    {"b10tprob2",       "number",       0},
    {"b10shrub1",       "string",       "flowers:dandelion_yellow"},
    {"b10sprob1",       "number",       10},
    {"b10shrub2",       "string",       "flowers:rose"},
    {"b10sprob2",       "number",       20},
    
    --#B0B0B0 (gray11) tropical rainforest
    {"b11ground1",      "string",       "default:dirt_with_rainforest_litter"},
    {"b11ground2",      "string",       "default:water_source"},
    {"b11gprob",        "number",       10},
    {"b11tree1",        "string",       "jungletree"},
    {"b11tprob1",       "number",       15},
    {"b11tree2",        "string",       "big_jungle"},
    {"b11tprob2",       "number",       5},
    {"b11shrub1",       "string",       "flowers:viola"},
    {"b11sprob1",       "number",       5},
    {"b11shrub2",       "string",       "flowers:dandelion_yellow"},
    {"b11sprob2",       "number",       20},
    
    --#C0C0C0 (gray12) snowy grassland
    {"b12ground1",      "string",       "default:dirt_with_snow"},
    {"b12ground2",      "string",       ""},
    {"b12gprob",        "number",       0},
    {"b12tree1",        "string",       "spbush"},
    {"b12tprob1",       "number",       1},
    {"b12tree2",        "string",       ""},
    {"b12tprob2",       "number",       0},
    {"b12shrub1",       "string",       ""},
    {"b12sprob1",       "number",       0},
    {"b12shrub2",       "string",       ""},
    {"b12sprob2",       "number",       0},
    
    --#D0D0D0 (gray13) tundra
    {"b13ground1",      "string",       "default:permafrost_with_stones"},
    {"b13ground2",      "string",       "default:dirt_with_snow"},
    {"b13gprob",        "number",       10},
    {"b13tree1",        "string",       ""},
    {"b13tprob1",       "number",       0},
    {"b13tree2",        "string",       ""},
    {"b13tprob2",       "number",       0},
    {"b13shrub1",       "string",       "default:snow"},
    {"b13sprob1",       "number",       20},
    {"b13shrub2",       "string",       "flowers:viola"},
    {"b13sprob2",       "number",       2},
    
    --#E0E0E0 (gray14) coniferous forest (boreal/tiaga)
    {"b14ground1",      "string",       "default:dirt_with_snow"},
    {"b14ground2",      "string",       "default:dirt_with_coniferous_litter"},
    {"b14gprob",        "number",       4},
    {"b14tree1",        "string",       "spine"},
    {"b14tprob1",       "number",       4},
    {"b14tree2",        "string",       "big_sspruce"},
    {"b14tprob2",       "number",       10},
    {"b14shrub1",       "string",       "flowers:viola"},
    {"b14sprob1",       "number",       0},
    {"b14shrub2",       "string",       ""},
    {"b14sprob2",       "number",       0},
    
    --#F0F0F0 (gray15) river
    {"b15ground1",      "string",       "default:river_water_source"},
    {"b15ground2",      "string",       ""},
    {"b15gprob",        "number",       0},
    {"b15tree1",        "string",       ""},
    {"b15tprob1",       "number",       0},
    {"b15tree2",        "string",       ""},
    {"b15tprob2",       "number",       0},
    {"b15shrub1",       "string",       ""},
    {"b15sprob1",       "number",       0},
    {"b15shrub2",       "string",       ""},
    {"b15sprob2",       "number",       0},
    
    --#FFFFFF (white) cobblestone road
    {"b16ground1",      "string",       "default:mossycobble"},
    {"b16ground2",      "string",       "default:dirt_with_grass"},
    {"b16gprob",        "number",       1},
    {"b16tree1",        "string",       ""},
    {"b16tprob1",       "number",       0},
    {"b16tree2",        "string",       ""},
    {"b16tprob2",       "number",       0},
    {"b16shrub1",       "string",       ""},
    {"b16sprob1",       "number",       0},
    {"b16shrub2",       "string",       ""},
    {"b16sprob2",       "number",       0},

    --(hard-coded) ocean (256 in threshhold table)
    {"b17ground1",      "string",       "default:sand"},
    {"b17ground2",      "string",       "default:sand_with_kelp"}, 
    {"b17gprob",        "number",       30},
    {"b17tree1",        "string",       ""},
    {"b17tprob1",       "number",       0},
    {"b17tree2",        "string",       ""},
    {"b17tprob2",       "number",       0},
    {"b17shrub1",       "string",       ""},
    {"b17sprob1",       "number",       0},
    {"b17shrub2",       "string",       ""},
    {"b17sprob2",       "number",       0},

    --(hard-coded) alpine (257 in threshhold table)
    {"b18ground1",      "string",       "default:snowblock"},
    {"b18ground2",      "string",       ""},
    {"b18gprob",        "number",       0},
    {"b18tree1",        "string",       ""},
    {"b18tprob1",       "number",       0},
    {"b18tree2",        "string",       ""},
    {"b18tprob2",       "number",       0},
    {"b18shrub1",       "string",       ""},
    {"b18sprob1",       "number",       0},
    {"b18shrub2",       "string",       ""},
    {"b18sprob2",       "number",       0},

    --(hard-coded) sub-alpine (258 in threshhold table)
    {"b19ground1",      "string",       "default:dirt_with_snow"},
    {"b19ground2",      "string",       ""},
    {"b19gprob",        "number",       0},
    {"b19tree1",        "string",       "spine2"},
    {"b19tprob1",       "number",       2},
    {"b19tree2",        "string",       ""},
    {"b19tprob2",       "number",       0},
    {"b19shrub1",       "string",       "default:snowblock"},
    {"b19sprob1",       "number",       0},
    {"b19shrub2",       "string",       ""},
    {"b19sprob2",       "number",       0},
    
}

local errors = {}
start = 1
finish = 0
for _ in pairs(settings_table) do finish = finish + 1 end  -- get table count

-- read settings into table
realterrain.settings = {}
for i=start, finish do
    if (settings_table[i]) then
        local setting = settings_table[i][1]
        local validate = settings_table[i][2]
        local value = settings_table[i][3]
        if validate == "number" then
            if tonumber(value) then
                realterrain.settings[setting] = tonumber(value)
            else
                if not errors then errors = {} end
                table.insert(errors, k)
            end
        elseif validate == "boolean" then
            if value or tostring(value) == "1" then
                realterrain.settings[setting] = true
            elseif not value or tostring(value) == "0" then
                realterrain.settings[setting] = false
            else
                if not errors then errors = {} end
                table.insert(errors, k)
            end
        else -- string
            realterrain.settings[setting] = value ~= "" and value or nil
        end
    end
end

-- additional checks
if realterrain.settings.alpinelevel < 0 then
    realterrain.settings.alpinelevel = 0
end
if realterrain.settings.subalpine < 0 then
    realterrain.settings.subalpine = 0
end
if realterrain.settings.waterlevel < 0 then
    realterrain.settings.waterlevel = 0
end
if realterrain.settings.kelpmindep < 4 then
    realterrain.settings.kelpmindep = 4
end
if realterrain.settings.bugmaxheight < 2 then
    realterrain.settings.bugmaxheight = 2
end

--  using the treename in the following table for the tree1 or tree2 settings above will randomize the shape of the tree you choose
--  for best results x and z dimensions of schems should be the same odd number
--  schems represents how many schems the same tree type has for randomization purposes
--  radius is (x-1)/2 so a tree with volume 7*12*7 would have a radius of 3, this is used for placing the tree so the center of the schem lies over the associated node
--  tradius is used for clearing decorations from around large tree trunks to avoid overwriting the trunk (tradius of 0 will only clear the center node, tradius of 1 will clear a 1 node perimeter around the center node, etc.)
--  trees with the lowest foliage should be labeled 0, highest foliage 3 to avoid low foliage of one tree from overwriting bare trunks of another
--  schems not found in this list (i.e. snowblocks, papyrus, etc.) will load with radius = 0
realterrain.trees = {
--  treename    = { schems,     radius,     tradius     }, -- dimensions of schem x*y*z
    bush        = { schems = 4, radius = 2, tradius = 2 }, -- 4*2*4
    bbush       = { schems = 4, radius = 2, tradius = 2 }, -- 4*2*4
    pbush       = { schems = 4, radius = 2, tradius = 2 }, -- 4*2*4
    spbush      = { schems = 4, radius = 2, tradius = 2 }, -- 4*3*4
    apple       = { schems = 4, radius = 3, tradius = 0 }, -- 7*?*7
    aspen       = { schems = 4, radius = 3, tradius = 0 }, -- 7*?*7
    gtree       = { schems = 4, radius = 4, tradius = 0 }, -- 9*?*9
    gpine       = { schems = 4, radius = 2, tradius = 0 }, -- 5*?*5
    spruce      = { schems = 4, radius = 4, tradius = 4 }, -- 9*?*9
    pine        = { schems = 4, radius = 2, tradius = 0 }, -- 5*?*5
    spine       = { schems = 4, radius = 3, tradius = 1 }, -- 7*?*7
    cactus      = { schems = 4, radius = 2, tradius = 0 }, -- 5*8*5
    acacia      = { schems = 4, radius = 4, tradius = 0 }, -- 9*?*9
    marshtree   = { schems = 2, radius = 4, tradius = 0 }, -- 9*?*9
    bonsai      = { schems = 2, radius = 4, tradius = 1 }, -- 9*?*9
    boulder     = { schems = 2, radius = 4, tradius = 0 }, -- 9*?*9
    jungletree  = { schems = 4, radius = 3, tradius = 1 }, -- 7*?*7
    papyrus     = { schems = 4, radius = 0, tradius = 0 }, -- 1*?*1
    big_oak     = { schems = 1, radius = 9, tradius = 1 }, -- 19*20*19
    big_birch   = { schems = 1, radius = 9, tradius = 1 }, -- 19*16*19
    big_jmaple  = { schems = 1, radius = 9, tradius = 1 }, -- 19*20*19
    big_wpine   = { schems = 1, radius = 9, tradius = 1 }, -- 19*25*19
    big_sspruce = { schems = 1, radius = 5, tradius = 5 }, -- 11*17*11
    big_jeffrey = { schems = 1, radius = 5, tradius = 1 }, -- 11*25*11
    big_jungle  = { schems = 1, radius = 4, tradius = 2 }, -- 9*27*9
}

--  the following table of "shafts" is meant to help abstract away the details of defining biomes
--  the word shaft is used because it is defining all of the relavent nodes on the y (vertical) axis for a single x/z coordinate
--  you can customize what filler (the buffer of nodes between the surface and bedrock), bedrock, base shrub as well as appearance probabilities for base shrub, bugs and mushrooms
realterrain.shafts = {
 -- { "name of the top node",                   "filler",                   "bedrock",              "shrub",    shrub%,   bug%, shrm% }
    { "default:dirt_with_grass",                "default:dirt",             "default:stone",        "grass",        40,     5,      0.1 },
    { "default:dirt_with_dry_grass",            "default:dirt",             "default:stone",        "dry_grass",    40,     0,      0 },
    { "default:dirt_with_coniferous_litter",    "default:dirt",             "default:stone",        "fern",         20,     2,      1 },
    { "default:dirt_with_rainforest_litter",    "default:dirt",             "default:stone",        "junglegrass",  60,     2,      1 },
    { "default:dirt_with_snow",                 "default:dirt",             "default:stone",        "snow",         50,     0,      0 },
    { "default:sand",                           "default:sandstone",        "default:stone",        "marram_grass", 30,     1,      0 },
    { "default:sand_with_kelp",                 "default:sandstone",        "default:stone",        nil,            0,      0,      0 },
    { "default:coral_green",                    "default:sandstone",        "default:stone",        nil,            30,     0,      0 },
    { "default:water_source",                   "default:dirt",             "default:stone",        "waterlily",    30,     5,      0 },
    { "default:river_water_source",             "default:clay",             "default:stone",        nil,            0,      2,      0 },
    { "default:desert_sand",                    "default:desert_sandstone", "default:desert_stone", nil,            0,      0,      0 },
    { "default:silver_sand",                    "default:silver_sandstone", "default:stone",        "dry_shrub",    5,      0,      0 },
    { "default:permafrost",                     "default:permafrost",       "default:stone",        "snow",         30,     2,      0 },
    { "default:permafrost_with_moss",           "default:permafrost",       "default:stone",        "snow",         30,     0,      0 },
    { "default:permafrost_with_stones",         "default:permafrost",       "default:stone",        "snow",         30,     0,      0 },
    { "default:snowblock",                      "default:permafrost",       "default:stone",        "snowblock",    100,    0,      0 },
    { "default:ice",                            "default:ice",              "default:stone",        "snow",         30,     0,      0 },
    { "default:mossycobble",                    "default:gravel",           "default:stone",        "grass",        10,     0,      0 },
}

-- used to divide the 8-bit biomes raster input of 256 values into 17 threshhold numbers plus 3 hard-coded slots(256-258) 
realterrain.threshholds = { 0, 16, 32, 48, 64, 80, 96, 112, 128, 144, 160, 176, 192, 208, 224, 240, 255, 256, 257, 258 }
-- used to divide the 8-bit biomes raster input of 256 values into 33 threshhold numbers plus 3 hard-coded slots(256-258) 
-- { 0, 8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120, 128, 136, 144, 152, 160, 168, 176, 184, 192, 200, 208, 216, 224, 232, 240, 248, 255, 256, 257, 258 }