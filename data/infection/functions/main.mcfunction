# INFECTION main loop


# world
bossbar set infection:period players @a

# time loop
execute if score period internal matches 0..2 run function infection:time

# setup flow
## only runs once
execute as @a unless score setup_flow internal matches 1 run function infection:setup_flow

# ensure player is not stuck
execute if score period internal matches -1 as @a at @s unless block ~ ~1 ~ #infection:safe run tp @s ~ ~5 ~ 


# death checks
## reset before perma deaths can happen (@Bluetofu___ for pointing that out)
execute as @a if score @s death matches 1.. if score period internal matches 2 run function infection:death
execute unless score period internal matches 2 run scoreboard players reset @a[scores={death=1..}] death

# options
execute if score cut_clean global matches 1.. run function infection:extras/cut_clean
execute if score speed_uhc global matches 1.. run function infection:extras/speed_uhc
execute if score height_limit global matches 1.. run function infection:extras/height_limit

# win checks
execute if score period internal matches 2 run function infection:win/check


# run commands for infected
## particles
execute as @a[team=infected] at @s run particle minecraft:spore_blossom_air ~ ~0.5 ~ 0 0 0 0 2
## health boost
execute unless score period internal matches -1 run function infection:health_boost
## tracker compass
execute as @a[team=infected,nbt=!{Inventory:[{id:"minecraft:compass",tag:{tag:{survivor_compass:1b}}}]}] at @s run function infection:compass
## effects
effect give @a[team=infected] saturation 9999 40 true
effect give @a[team=infected] speed 9999 0 true
execute unless score percent75 internal matches 1 run effect give @a[team=infected] strength 9999 1 true
execute if score percent75 internal matches 1 run effect clear @a[team=infected] strength

# actionbar
title @a[team=alive] actionbar ["",{"text":"YOU ARE ","color":"dark_green"},{"text":"ALIVE","bold":true,"color":"green"},{"text":", SURVIVE THE INFECTED","color":"dark_green"}]
title @a[team=infected] actionbar ["",{"text":"YOU ARE ","color":"dark_green"},{"text":"INFECTED","bold":true,"color":"green"},{"text":", KILL ALL THE SURVIVORS","color":"dark_green"}]