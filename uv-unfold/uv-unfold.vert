#version 330 core

layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform vec2 Min = vec2(-1, -1);
uniform vec2 Max = vec2(1, 1);

void main()
{
    frontColor = vec4(color, 1.0);
    vtexCoord = texCoord;
    /*
        La idea es acotar vtexCoord para que se encuentre en el 
        cuadrado formado por el punto Min y Max:
        - (texCoord.x - Min.x)/(Max.x - Min.x): lleva texCoord 
        al rango [0, 1]
        - 2.0*(texCoord.x - Min.x)/(Max.x - Min.x): lleva texCoord
        al rango [0, 2]
        - 2.0*(texCoord.x - Min.x)/(Max.x - Min.x) - 1.0: lleva texCoord
        al rango [-1, 1], que es lo que nos pide el ejercicio
    */
    float x = 2.0*(texCoord.x - Min.x)/(Max.x - Min.x) - 1.0;
    float y = 2.0*(texCoord.y - Min.y)/(Max.y - Min.y) - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
}
