shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	float screenr = textureLod(screen_texture, SCREEN_UV + vec2(0.01,0), 0.0).r;
	float screeng = textureLod(screen_texture, SCREEN_UV, 0.0).g;
	float screenb = textureLod(screen_texture, SCREEN_UV + vec2(-0.01,0), 0.0).b;
	COLOR = vec4 (screenr, screeng, screenb, 1.0);
}
