// ============================================================
// OBJ_LIGHTSOURCE - STEP V1.1
// ============================================================

// ** Delta Time In Seconds **
var _dt = min(delta_time / 1000000, 0.05);

// ** Animation Timer **
light_time += _dt;

// ============================================================
// FOLLOW TARGET
// ============================================================

if (instance_exists(light_follow))
{
    x = light_follow.x + light_offset_x;
    y = light_follow.y + light_offset_y;
}

// ============================================================
// BASE INTENSITY
// ============================================================

var _target_intensity = 0;

if (light_enabled)
{
    _target_intensity = light_intensity;

    // ** Natural Flicker **
    if (light_flicker)
    {
        var _flicker =
            sin(light_time * 6.2 + light_phase) * 0.65
            + sin(light_time * 11.7 + light_phase) * 0.35;

        _target_intensity +=
            _flicker * light_flicker_amount;
    }
}

_target_intensity = clamp(_target_intensity, 0, 1);

// ============================================================
// SMOOTH TRANSITIONS
// ============================================================

// ** Frame Independent Smoothing **
var _smooth = 1 - exp(-light_fade_speed * _dt);

light_current_intensity = lerp(
    light_current_intensity,
    _target_intensity,
    _smooth
);

// ============================================================
// PULSATING RADIUS
// ============================================================

var _target_radius = light_radius;

if (light_pulse)
{
    _target_radius *= 1
        + sin(light_time * light_pulse_speed + light_phase)
        * light_pulse_amount;
}

light_current_radius = lerp(
    light_current_radius,
    _target_radius,
    _smooth
);