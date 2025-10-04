#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

out vec3 norm;
out vec3 vert;

uniform mat4 modelViewProjectionMatrix;

void main()
{
    vert = vertex;
    norm = normal;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
