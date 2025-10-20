#version 330 core

in vec2 vCoord;
out vec4 fragColor;

uniform float smoothness = 25.0;
uniform mat3 normalMatrix;
uniform sampler2D heightMap;

void main()
{
    float epsilon = 1.0/128;
    float h_center = texture(heightMap, vCoord).r;
    float h_dx = texture(heightMap, vCoord + vec2(epsilon, 0.0)).r;
    float h_dy = texture(heightMap, vCoord + vec2(0.0, epsilon)).r;
    float gx = (h_dx - h_center) / epsilon;
    float gy = (h_dy - h_center) / epsilon;
    vec3 N = normalize(normalMatrix * normalize(vec3(-gx, -gy, smoothness)));
    fragColor = vec4(N.z);
}

