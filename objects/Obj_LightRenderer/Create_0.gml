// ============================================================
// OBJ_LIGHTRENDERER - CREATE V1.1
// ============================================================

// ** Light Settings **
lighting_enabled = true;

// ** Debug Settings **
debug_lights = false;
lights_rendered = 0;

// ** Shader Validation **
shader_ready = shader_is_compiled(Sh_RadialLight);

// ** Shader Uniforms **
if (shader_ready)
{
    u_light_pos = shader_get_uniform(
        Sh_RadialLight,
        "u_light_pos"
    );

    u_light_radius = shader_get_uniform(
        Sh_RadialLight,
        "u_light_radius"
    );

    u_light_color = shader_get_uniform(
        Sh_RadialLight,
        "u_light_color"
    );

    u_light_intensity = shader_get_uniform(
        Sh_RadialLight,
        "u_light_intensity"
    );

    u_falloff = shader_get_uniform(
        Sh_RadialLight,
        "u_falloff"
    );

    u_core_size = shader_get_uniform(
        Sh_RadialLight,
        "u_core_size"
    );
}
else
{
    show_debug_message(
        "ERROR: Sh_RadialLight failed to compile!"
    );
}