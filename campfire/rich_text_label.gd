extends RichTextLabel

@export var chars_per_second := 40.0

func type_text(text_to_show: String) -> void:
	text = text_to_show
	visible_characters = 0

	var duration := text_to_show.length() / chars_per_second

	create_tween() \
		.tween_property(self, "visible_characters", text_to_show.length(), duration) \
		.set_trans(Tween.TRANS_LINEAR) \
		.set_ease(Tween.EASE_IN_OUT)
