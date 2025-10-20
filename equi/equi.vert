#version 330 core

layout (location = 0) in vec3 vertex;

out vec3 punt;

uniform mat4 modelViewProjectionMatrix;

void main()
{
    punt = vertex;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
