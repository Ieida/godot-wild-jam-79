shader_type canvas_item;

uniform bool flash;
uniform vec4 flash_color: source_color = vec4(1.);

void fragment() {
	if(flash){
		vec4 clr = texture(TEXTURE, UV);
		if(clr.a != 0.0){
			clr = flash_color;
			COLOR = clr;
		}
	}
}
