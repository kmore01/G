#version 330 core

layout (location = 0) in vec3 vertex; // object space
layout (location = 1) in vec3 normal; // world space

out vec3 N;
out vec3 L;
out vec3 V;

uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 modelViewProjectionMatrix;
uniform vec4 lightPosition; // similar a gl_LightSource[0].position en eye space
uniform bool world;

uniform mat4 viewMatrixInverse;

void main()
{
    if (world) {
        // World space 
        N = normal;
        // viewMatrixInverse*vec4(0,0,0,1) --> origen (on esta la camera, en ES) en WS
        // object space es world space (model transform identitat)
        V = (viewMatrixInverse*vec4(0.0 ,0.0, 0.0, 1.0)).xyz - (vec4(vertex, 1.0)).xyz;
        L = (viewMatrixInverse*lightPosition).xyz - (vec4(vertex, 1.0)).xyz;
    }
    else {
        // Eye space
        N = normalMatrix * normal;
        vec3 eyeVertex = vec3(modelViewMatrix * vec4(vertex, 1.0));
        L = lightPosition.xyz - eyeVertex;
        float aux = max(0.0, dot(N, L));
        V = -eyeVertex; // camara en origen
    }
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}

