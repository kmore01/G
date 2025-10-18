#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

void main()
{
    float d = length(vtexCoord - vec2(0.5));
    fragColor = vec4(step(0.2, d)) + vec4(1.0, 0.0, 0.0, 1.0);
    // Version con anti-aliasing
    //fragColor = vec4(smoothstep(0.2 - 0.02, 0.2 + 0.02, d)) + vec4(1.0, 0.0, 0.0, 1.0);
}
