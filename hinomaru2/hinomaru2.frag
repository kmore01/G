#version 330 core

const float PI = 3.141592653589793;
const vec2 centre = vec2(0.5, 0.5);
const vec4 vermell = vec4(1.0, 0.0, 0.0, 1.0);
const vec4 blanc = vec4(1.0, 1.0, 1.0, 1.0);

in vec2 vtexCoord;
out vec4 fragColor;

uniform bool classic;

void main()
{
    float d = length(vtexCoord - vec2(0.5));
    if (classic) {
        fragColor = vec4(step(0.2, d)) + vec4(1.0, 0.0, 0.0, 1.0);
    } else {
        float phi = PI/16.0;
        vec2 u = centre - vtexCoord;
        float theta = atan(u.t, u.s);
        if (mod(theta/phi + 0.5, 2) < 1 || d < 0.2) fragColor = vermell;
        else fragColor = blanc;
    }
}
