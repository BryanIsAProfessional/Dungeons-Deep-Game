extends Resource
class_name BattlePassItem

enum Rarity {Fucking_Epic = 0, Godlike = 1, HOLY_SHIT = 2, Best = 3}

@export var display_name := "Name"
@export var icon : Texture2D
@export var rarity : Rarity = Rarity.Fucking_Epic
