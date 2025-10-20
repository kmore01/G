#version 330 core

in vec4 frontColor;
in vec3 vES;
out vec4 fragColor;

uniform mat4 normalMatrix;

void main()
{
    vec3 dX = dFdx(vES);
    vec3 dY = dFdy(vES);
    vec3 normal = normalize(cross(dX, dY));
    fragColor = frontColor*normal.z;
}
