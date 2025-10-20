#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform sampler2D colorMap;

vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}


void main()
{
    vec3 c = rgb2hsv((texture(colorMap, vtexCoord)).rgb);
    if (vtexCoord.x < 1.0 && vtexCoord.y < 1.0) {
        c.r = fract(c.r + 0.2);             // [0, 1]
        c.g = clamp(c.g * 2.0, 0.0, 1.0);   // [0, 1]
        fragColor = vec4(hsv2rgb(c), 1.0);
    } else if (vtexCoord.x < 1.0) {
        c.r = fract(c.r + 0.4);             // [0, 1]
        c.g = clamp(c.g * 2.0, 0.0, 1.0);   // [0, 1]
        fragColor = vec4(hsv2rgb(c), 1.0);
    } else if (vtexCoord.y < 1.0) {
        c.r = fract(c.r + 0.6);             // [0, 1]
        c.g = clamp(c.g * 2.0, 0.0, 1.0);   // [0, 1]
        fragColor = vec4(hsv2rgb(c), 1.0);
    } else {
        c.r = fract(c.r + 0.8);             // [0, 1]
        c.g = clamp(c.g * 2.0, 0.0, 1.0);   // [0, 1]
        fragColor = vec4(hsv2rgb(c), 1.0);
    }
}
