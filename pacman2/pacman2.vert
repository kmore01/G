#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 3) in vec2 texCoord;

out vec2 vc;

uniform mat4 modelViewProjectionMatrix;

void main()
{
    vc = texCoord * 15;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
