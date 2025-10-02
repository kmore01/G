#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;

out vec4 frontColor;

const float pi = 3.141592;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform float amp = 0.5;
uniform float freq = 0.25;
uniform float time;

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0) * N.z;
    float theta = -amp*sin(2*pi*freq*time + vertex.y); // sinusoidal
    mat3 rotate = mat3(1.0, 0.0, 0.0,
                       0.0, cos(theta), -sin(theta),
                       0.0, sin(theta), cos(theta));
    gl_Position = modelViewProjectionMatrix * vec4(rotate*vertex, 1.0);
}
