// ============================================================
// SH_RADIAL LIGHT - FRAGMENT SHADER V1.1
// ============================================================

#ifdef GL_ES
precision mediump float;
#endif

varying vec2 v_world_pos;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// ** Light Position **
uniform vec2 u_light_pos;

// ** Horizontal / Vertical Radius **
uniform vec2 u_light_radius;

// ** Light Properties **
uniform vec3 u_light_color;
uniform float u_light_intensity;

// ** Advanced Light Settings **
uniform float u_falloff;
uniform float u_core_size;

void main()
{
    // ** Distance From Center **
    vec2 offset = v_world_pos - u_light_pos;

    // ** Normalize Light Shape **
    vec2 normalized = offset / max(
        u_light_radius,
        vec2(1.0)
    );

    float dist = length(normalized);

    // ** Main Light Falloff **
    float halo = pow(
        max(1.0 - dist, 0.0),
        max(u_falloff, 0.25)
    );

    // ** Bright Inner Core **
    float core = 1.0 - smoothstep(
        0.0,
        max(u_core_size, 0.001),
        dist
    );

    // ** Combine Both Effects **
    float brightness = halo + core * 0.35;

    // ** Sprite Alpha **
    vec4 tex = texture2D(
        gm_BaseTexture,
        v_vTexcoord
    );

    // ** Final Light Intensity **
    float alpha = clamp(
        brightness
        * u_light_intensity
        * tex.a
        * v_vColour.a,
        0.0,
        1.0
    );

    // ** Final Color **
    gl_FragColor = vec4(
        u_light_color,
        alpha
    );
}