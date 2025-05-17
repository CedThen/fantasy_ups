shader_type canvas_item;

uniform float outline_size = 4.0;
uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 0.0); // Yellow

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    float alpha = tex_color.a;
    float outline = 0.0;

    
    // Check surrounding pixels for alpha > 0
    for (int x = -1; x <= 1; x++) {
        for (int y = -1; y <= 1; y++) {
            vec2 offset = vec2(float(x), float(y)) * (outline_size * TEXTURE_PIXEL_SIZE);
            outline += texture(TEXTURE, UV + offset).a;
        }
    }

    outline = clamp(outline, 0.0, 1.0);


    // Combine the result
    // If this pixel is transparent but near opaque pixels, show the outline
    if (alpha == 0.0 && outline > 0.0) {
        COLOR = outline_color;
    } else {
        COLOR = tex_color;
    }
}