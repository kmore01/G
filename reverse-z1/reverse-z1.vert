#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

void main()
{
    /* 
    Tenemos que pasar el vertice a Clip Space porque al aplicar la transformacion de 
    modelViewProjectionMatrix se puede alterar el signo y escala de Z. 
    */
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color, 1.0) * -N.z;
    vec4 clipPos = modelViewProjectionMatrix * vec4(vertex, 1.0);
    clipPos.z = -clipPos.z;
    gl_Position = clipPos;
}
