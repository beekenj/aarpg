# QUEST MANAGER - GLOBAL SCRIPT
extends Node

signal quest_updated(q : Quest)

const QUEST_DATA_LOCATION : String = "res://quests/"

var quests : Array[Quest]
var current_quests : Array


