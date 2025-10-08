#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;

uniform int test = 0;
uniform vec3 boundingBoxMin; 
uniform vec3 boundingBoxMax; 
uniform vec2 mousePosition;
uniform float radius = 300;
uniform vec2 viewport;

vec2 getMousePositionWindowSpace() {
    if (test == 0) return mousePosition;
    else if (test == 1) return vec2(400.0, 520.0);
    else if (test == 2) return vec2(600.0, 225.0);
    else if (test == 3) return vec2(200.0, 375.0);
    else return vec2(400.0, 300.0);
}

void main()
{
    // Transformar a eye space
    vec4 eyePosition = modelViewMatrix * vec4(vertex, 1.0);
    vec3 N = normalize(normalMatrix * normal);
    
    float diag = length(boundingBoxMax - boundingBoxMin);
    vec3 displacedVertex = eyePosition.xyz + 0.03 * diag * N;
    
    // Transformar posición del vértice a window space!!
    vec4 clipPos = modelViewProjectionMatrix * vec4(vertex, 1.0);
    vec3 ndcPos = clipPos.xyz / clipPos.w;
    vec2 windowPos = (ndcPos.xy + 1.0) * 0.5 * viewport;
    
    // Calcular distancia al ratón
    vec2 mousePosWS = getMousePositionWindowSpace();
    float d = length(mousePosWS - windowPos);
    
    float t = 1.0 - smoothstep(0.05 * radius, 0.8 * radius, d);
    
    // Calcular color
    vec3 blanco = vec3(1.0);
    vec3 rojo = vec3(1.0, 0.0, 0.0);
    vec3 finalColor = mix(blanco, rojo, t);
    frontColor = vec4(finalColor, 1.0) * N.z;
    
    vec3 displacedModelVertex = mix(vertex, vertex + 0.03 * diag * normal, t);
    gl_Position = modelViewProjectionMatrix * vec4(displacedModelVertex, 1.0);
}
