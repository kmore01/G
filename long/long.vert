#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform float t = 4.0;
uniform float scale = 4.0;

uniform vec3 boundingBoxMin; // ?
uniform vec3 boundingBoxMax; // ?

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0) * N.z;

    float c = mix(boundingBoxMin.y, boundingBoxMax.y, t); // interpolacio lineal
    vec3 nouVertex;
    if (vertex.y < c) {
        nouVertex = vertex*vec3(1.0, scale, 1.0); // scale
    } else {
        float delta = c*scale - c;
        nouVertex = vertex + vec3(0.0, delta, 0.0); // translate
    }

    gl_Position = modelViewProjectionMatrix * vec4(nouVertex, 1.0);
}
