shader_type canvas_item;

uniform vec3 color: source_color = vec3(1.0);
uniform float progress: hint_range(0.0, 1.0, 0.1) = 0.0;

void fragment() {
	vec4 orig_color = texture(TEXTURE, UV);
	vec4 target_color = mix(orig_color, vec4(color, orig_color.a), progress);
	COLOR = target_color;
}
