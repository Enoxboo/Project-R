extends CharacterBody2D

class_name Player

const MAIN_DATA = preload("uid://dsefs1fellje")
const ELEANOR_DATA = preload("uid://davvempunmoqd")

@onready var sprite: Sprite2D = $Sprite

var data: PlayerData = MAIN_DATA
var is_main_active = true
