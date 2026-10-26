// ============================================================
// OBJ_LIGHTRENDERER - DRAW END V1.1
// ============================================================

// ** Reset Counter **
lights_rendered = 0;

// ** Get Light Sources **
var _count = instance_number(Obj_LightSource);

// ** Get Camera **
var _cam = view_camera[0];

var _cam_x = camera_get_view_x(_cam);
var _cam_y = camera_get_view_y(_cam);

var _cam_w = camera_get_view_width(_cam);
var _cam_h = camera_get_view_height(_cam);

// ** View Bounds **
var _left = _cam_x;
var _top = _cam_y;
var _right = _cam_x + _cam_w;
var _bottom = _cam_y + _cam_h;

// ============================================================
// RENDER LIGHTS
// ============================================================

if (lighting_enabled && shader_ready)
{
    // ** Drawing State **
    draw_set_color(c_white);
    draw_set_alpha(1);

    // ** Additive Lighting **
    gpu_set_blendmode(bm_add);

    // ** Enable Shader **
    shader_set(Sh_RadialLight);

    for (var i = 0; i < _count; i++)
    {
        var _light = instance_find(Obj_LightSource, i);

        // ** Current Intensity **
        var _intensity = _light.light_current_intensity;

        if (_intensity <= 0.001)
        {
            continue;
        }

        // ** Light Dimensions **
        var _radius_x = max(
            1,
            _light.light_current_radius * _light.light_scale_x
        );

        var _radius_y = max(
            1,
            _light.light_current_radius * _light.light_scale_y
        );

        // ====================================================
        // CAMERA CULLING
        // ====================================================

        if (_light.x + _radius_x < _left
        || _light.x - _radius_x > _right
        || _light.y + _radius_y < _top
        || _light.y - _radius_y > _bottom)
        {
            continue;
        }

        // ====================================================
        // COLOR CONVERSION
        // ====================================================

        var _color = _light.light_color;

        var _r = color_get_red(_color) / 255;
        var _g = color_get_green(_color) / 255;
        var _b = color_get_blue(_color) / 255;

        // ====================================================
        // SHADER UNIFORMS
        // ====================================================

        shader_set_uniform_f(
            u_light_pos,
            _light.x,
            _light.y
        );

        shader_set_uniform_f(
            u_light_radius,
            _radius_x,
            _radius_y
        );

        shader_set_uniform_f(
            u_light_color,
            _r,
            _g,
            _b
        );

        shader_set_uniform_f(
            u_light_intensity,
            clamp(_intensity, 0, 1)
        );

        shader_set_uniform_f(
            u_falloff,
            _light.light_falloff
        );

        shader_set_uniform_f(
            u_core_size,
            _light.light_core_size
        );

        // ====================================================
        // DRAW LIGHT
        // ====================================================

        draw_sprite_stretched(
            Spr_LightQuad,
            0,
            _light.x - _radius_x,
            _light.y - _radius_y,
            _radius_x * 2,
            _radius_y * 2
        );

        lights_rendered++;
    }

    // ** Restore Shader **
    shader_reset();

    // ** Restore Blend Mode **
    gpu_set_blendmode(bm_normal);
}

// ============================================================
// DEBUG LIGHTS
// ============================================================

if (debug_lights)
{
    draw_set_alpha(1);
    draw_set_color(c_lime);

    for (var j = 0; j < _count; j++)
    {
        var _source = instance_find(Obj_LightSource, j);

        var _rx = _source.light_current_radius
            * _source.light_scale_x;

        var _ry = _source.light_current_radius
            * _source.light_scale_y;

        // ** Source Position **
        draw_circle(
            _source.x,
            _source.y,
            3,
            false
        );

        // ** Source Bounds **
        draw_set_color(c_yellow);

        draw_ellipse(
            _source.x - _rx,
            _source.y - _ry,
            _source.x + _rx,
            _source.y + _ry,
            true
        );

        draw_set_color(c_lime);
    }

    draw_set_color(c_white);
    draw_set_alpha(1);
}