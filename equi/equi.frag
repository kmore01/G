#version 330 core

const float PI = 3.141592;

in vec3 punt;
out vec4 fragColor;

uniform sampler2D panorama;

void main()
{
    float psi = asin(punt.y);
    float theta = atan(punt.z, punt.x);
    float s = theta/(2*PI);
    float t = (psi/PI) + 0.5;
    fragColor = texture(panorama, vec2(s, t));
}
