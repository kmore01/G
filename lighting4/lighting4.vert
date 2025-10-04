#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;
uniform vec4 lightPosition; // similar a gl_LightSource[0].position en eye space

out vec3 L;
out vec3 N;
out vec3 V;

void main()
{
    N = normalMatrix * normal;
    vec3 eyeVertex = vec3(modelViewMatrix * vec4(vertex, 1.0));
    L = vec3(lightPosition) - eyeVertex;
    float aux = max(0.0, dot(N, L));
    V = -eyeVertex; // camara en origen
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
