#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform float time;
uniform sampler2D sampler;

void main()
{
    vec2 vtexCoordDef = vtexCoord;
    if (fract(time) > 0.5) {
        // Distancia del punto al ojo
        float distance = length(vtexCoord - vec2(0.393, 0.652));
        // Si esta dentro del rango del ojo, lo queremos cerrar
        if (distance < 0.025) {
            vtexCoordDef = vec2(vtexCoord.s + 0.057, vtexCoord.t + (-0.172));
        }
    }
    fragColor = texture(sampler, vtexCoordDef);
}
