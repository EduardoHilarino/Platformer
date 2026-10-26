// ============================================================
// OBJ_LIGHTRENDERER - DRAW GUI END V1.1
// ============================================================

if (debug_lights)
{
    shader_reset();
    gpu_set_blendmode(bm_normal);

    draw_set_alpha(1);
    draw_set_color(c_white);

    draw_text(10, 10, "LIGHT SYSTEM V1.1");

    draw_text(
        10,
        30,
        "Total Lights: "
        + string(instance_number(Obj_LightSource))
    );

    draw_text(
        10,
        50,
        "Rendered Lights: "
        + string(lights_rendered)
    );

    draw_text(
        10,
        70,
        "Shader Compiled: "
        + string(shader_ready)
    );

    draw_text(
        10,
        90,
        "Lighting Enabled: "
        + string(lighting_enabled)
    );
}