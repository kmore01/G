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
    frontColor = vec4(color,1.0) * N.z;
    // Object Space a Normalized Device space
    vec4 clipPos = modelViewProjectionMatrix * vec4(vertex, 1.0);
    float w = clipPos.w; // para reconstruir de NDC --> Clip Space
    vec3 ndcPos = clipPos.xyz/clipPos.w;
    // Aplicar escalat
    vec2 vectorNDC_scale = vec2(ndcPos)*(0.5+abs(sin(time)));
    gl_Position = vec4(vectorNDC_scale*w, clipPos.z, w); 
    // vectorNDC_scale*w son les coordenades de clip space escalades
}
