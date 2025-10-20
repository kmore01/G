#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 2) in vec3 color;

out vec4 frontColor;
out vec3 vES;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;

void main()
{
    frontColor = vec4(color, 1.0);
    vES = (modelViewMatrix*vec4(vertex, 1.0)).xyz;
    gl_Position = modelViewProjectionMatrix*vec4(vertex, 1.0);
}
