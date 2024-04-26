extends Node3D

signal transgress
var press = 0
var value = 0 
# Called when the node enters the scene tree for the first time.
func _ready():
	$intro_cam.set_current(true)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and press <= 0:
		$intro_cam/AnimationPlayer.play("intro")
		press = 1


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "intro":
		$CharacterBody3D/head/Camera3D.set_current(true)
	if anim_name == "transgress":
		get_tree().change_scene_to_file("res://Scenes/death_screen.tscn")
	if anim_name == "good":
		get_tree().quit()


func _on_area_3d_body_exited(body):
	if value <= 0:
		$Camera3D.set_current(true)
		$intro_cam/AnimationPlayer.play("transgress")
		value = 1 
	#$CharacterBody3D/head/Camera3D.set_current(true)


func _on_kill_vol_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://Scenes/death_screen.tscn")


func _on_timer_timeout():
	$intro_cam/AnimationPlayer.play("good")
