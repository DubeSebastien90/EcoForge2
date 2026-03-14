varying vec2 v_vTexcoord;
void main() {
    vec4 base_tex = texture2D(gm_BaseTexture, v_vTexcoord);
    // On force la couleur à noir, mais on garde l'alpha du sprite original
    gl_FragColor = vec4(0.0, 0.0, 0.0, 0.3 * base_tex.a);
}