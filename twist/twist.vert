#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform float time;

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0);

    float A = -0.4*vertex.y*sin(time); // !
    mat3 rotate = mat3(cos(A), 0.0, sin(A),
                       0.0, 1.0, 0.0,
                       -sin(A), 0.0, cos(A));

    gl_Position = modelViewProjectionMatrix * vec4(rotate*vertex, 1.0);
}
