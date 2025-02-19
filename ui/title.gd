extends CenterContainer
class_name TitleScreen

signal quit_button
signal level_button(level: int)

enum MENUS {
	TITLE = 0,
	LEVEL_SELECT = 1
}

@onready var title: Control = $title
@onready var level_select: Control = $level_select
var current_menu: MENUS

func _ready() -> void:
	set_menu(MENUS.TITLE)

func _on_quit_pressed() -> void:
	emit_signal("quit_button")

func set_menu(new_setting: MENUS) -> void:
	current_menu = new_setting
	if new_setting == MENUS.TITLE:
		title.visible = true
	else:
		title.visible = false
	if new_setting == MENUS.LEVEL_SELECT:
		level_select.visible = true
	else:
		level_select.visible = false

func _on_start_pressed() -> void:
	set_menu(MENUS.LEVEL_SELECT)

func _on_level_button_pressed(level: int) -> void:
	emit_signal("level_button", level)

func _on_back_button_pressed() -> void:
	set_menu(MENUS.TITLE)
