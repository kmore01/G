#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform float time;
uniform sampler2D fons;
uniform sampler2D noise1;

void main()
{
    vec2 coordNoise1 = vec2(vtexCoord.s + 0.08*time, vtexCoord.t + 0.07*time);
    vec4 colorNoise1 = texture(noise1, coordNoise1);

    vec2 coordFons = colorNoise1.rg*vec2(.003, -.005);
    vec2 coordFinal = vtexCoord + coordFons;
    fragColor = texture(fons, coordFinal);
}





