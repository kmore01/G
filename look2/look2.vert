#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform float angle = 0.5;

void main()
{
    float t = smoothstep(1.45, 1.55, vertex.y);
    // Rotacio
    float s = sin(angle * t);
	float c = cos(angle * t);
	mat4 rotate = mat4(c, 0.0, -s, 0.0,
                       0.0, 1.0, 0.0, 0.0,
                       s, 0.0, c, 0.0, 0.0,
                       0.0, 0.0, 1.0);
    vec3 vertexP = vec3(rotate*vec4(vertex, 1.0));
    vec3 newPos = mix(vertex, vertexP, t);          
    // Normals
    vec3 N = normalize(normalMatrix * normal);
    vec3 Np = normalize(mat3(rotate) * N);
    vec3 NPos = normalize(mix(N, Np, t));
    frontColor = vec4(vec3(NPos.z), 1.0);
    gl_Position = modelViewProjectionMatrix * vec4(newPos, 1.0);
}
