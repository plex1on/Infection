team modify players friendlyFire true
scoreboard players set period time 2

# Infect a random player
team leave @a[team=infected]
execute as @a at @s run playsound minecraft:entity.zombie_villager.cure player @s
team join infected @r
team join alive @a[team=!spec,team=!infected]
tag @a[team=alive] add alive
# Give sets to infected
function infection:give_sets

# Up alive counters
execute as @a[team=alive] run scoreboard players add alive alive_players 1
execute as @a[team=infected] run scoreboard players add infected alive_players 1

title @a[team=!infected] title ["",{"selector":"@a[team=infected]","bold":true,"color":"#007A00"},{"text":" has been infected!","color":"dark_green"}]
title @a subtitle {"text":"The games have begun, your actionbar will display your current role.","color":"white"}

gamerule naturalRegeneration true

effect clear @a weakness
effect clear @a regeneration
effect clear @a resistance

scoreboard players set time_seconds time 0