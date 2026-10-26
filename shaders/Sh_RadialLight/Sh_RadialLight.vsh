// ============================================================
// RADIAL LIGHT - VERTEX SHADER
// ============================================================

attribute vec3 in_Position;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying vec2 v_world_pos;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    // ** World Position **
    vec4 pos = vec4(in_Position.xyz, 1.0);

    gl_Position =
        gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * pos;

    // ** Pass Position To Fragment Shader **
    v_world_pos = in_Position.xy;

    // ** Texture Coordinates **
    v_vTexcoord = in_TextureCoord;

    // ** Vertex Color **
    v_vColour = in_Colour;
}