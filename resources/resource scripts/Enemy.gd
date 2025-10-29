class_name enemyBase
extends Resource

@export_category("Enemy Stats")
@export var id:int = 0;
@export var health:float = 1.0;
@export var playerDamage:int = 1;
@export var speed:float = 1.0;
@export var killReward:int = 1;
@export_category("Enemy Visuals")
@export var enemySprite:CompressedTexture2D;
@export var enemyDeathSound:String = "NOT IMPLEMENTED";
