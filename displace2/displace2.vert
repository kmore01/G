#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

out vec2 vCoord;

uniform float scale = 0.05;
uniform mat4 modelViewProjectionMatrix;
uniform sampler2D heightMap;

void main()
{
    vec2 st = 0.49*vertex.xy + vec2(0.5);
    vCoord = st;
    vec4 colorTx = texture(heightMap, st);
    gl_Position = modelViewProjectionMatrix*vec4(vertex + normal*scale*colorTx.r, 1.0);

}
