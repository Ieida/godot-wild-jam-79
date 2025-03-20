shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture;
uniform float pixel_size = 128.;
uniform vec4 color: source_color = vec4(1.);
uniform sampler2D noise: repeat_enable;
uniform vec2 speed = vec2(0.03, 0.07);
uniform float wave_strength = 2.;
uniform float y_scale;
uniform float y_zoom;
uniform bool editor;

void fragment() {
	vec2 uv = UV;

	float time = mod(((TIME / 128.) * 128.), 128.);
	uv = uv + (speed * time);

	vec2 _noise = texture(noise, uv).rg;

	float uv_height = SCREEN_PIXEL_SIZE.y / TEXTURE_PIXEL_SIZE.y;
	float uv_y = uv_height * UV.y * y_scale * 2.0;
	if (editor) {uv_y *= y_zoom;}
	vec2 reflected_uv = vec2(SCREEN_UV.x, SCREEN_UV.y - uv_y);

	vec4 waves = texture(screen_texture, reflected_uv + _noise * y_zoom * (wave_strength / 100.0));
	COLOR = waves * color;
}
