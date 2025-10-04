#version 330 core

layout (location = 0) in vec3 vertex; // object space
layout (location = 1) in vec3 normal; // world space

out vec3 LE;
out vec3 NE;
out vec3 VE;
out vec3 LW;
out vec3 NW;
out vec3 VW;

uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 modelViewProjectionMatrix;
uniform vec4 lightPosition; // similar a gl_LightSource[0].position en eye space

uniform mat4 modelViewMatrixInverse;

void main()
{
    // Eye space
    NE = normalMatrix * normal;
    vec3 eyeVertex = vec3(modelViewMatrix * vec4(vertex, 1.0));
    LE = lightPosition.xyz - eyeVertex;
    float aux = max(0.0, dot(NE, LE));
    VE = -eyeVertex; // camara en origen
    // World space 
    NW = normal;
    // modelViewMatrixInverse*vec4(0,0,0,1) --> origen (on esta la camera, en ES) en WS
    // object space es world space (model transform identitat)
    VW=(modelViewMatrixInverse*vec4(0.0 ,0.0, 0.0, 1.0)).xyz - (vec4(vertex, 1.0)).xyz;
    LW=(modelViewMatrixInverse*lightPosition).xyz - (vec4(vertex, 1.0)).xyz;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}

