#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal; // object space
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;

const float PI = 3.141592653589793;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform float amplitude = 0.1;
uniform float freq = 1; // expressada en Hz
uniform float time;

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    float d = amplitude*sin(2.0*PI*freq*time); // sinusoidal
    frontColor = vec4(vec3(N.z), 1.0);
    gl_Position = modelViewProjectionMatrix * vec4(vertex + d*normal, 1.0); 
}
