#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 3) in vec2 texCoord;

out vec2 vtexCoord;
out vec2 P;

uniform mat4 modelViewProjectionMatrix;

void main()
{
    vtexCoord = texCoord;
    vec3 scaledVertex = vertex*vec3(1.0, 2.0, 1.0);
    P = vertex.xy*vec2(5.0, 10.0);
    gl_Position = modelViewProjectionMatrix * vec4(scaledVertex, 1.0);
}
