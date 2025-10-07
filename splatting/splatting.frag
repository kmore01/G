#version 330 core

in vec2 vtexCoord; // coordenadas de textura (t, s)
out vec4 fragColor;

uniform sampler2D noise0;
uniform sampler2D rock1;
uniform sampler2D grass2;

void main()
{
    /*
        texture: lee un valor de color de una textura
        vec4 colorRock = texture(rock1, vtexCoord):
        toma el color de la textura rock1 en la coordenada vtexCoord
        ...
    */
    vec4 colorRock = texture(rock1, vtexCoord);
    vec4 colorGrass = texture(grass2, vtexCoord);
    float t = texture(noise0, vtexCoord).r;
    fragColor = mix(colorRock, colorGrass, t);
}
