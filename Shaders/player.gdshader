shader_type canvas_item;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.r = COLOR.r * 1.0;
	COLOR.g = COLOR.g * 1.5;
	COLOR.b = COLOR.b * 1.0;
}
