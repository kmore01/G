#version 330 core

layout (location = 0) in vec3 vertex;

out float ndc_x;

uniform mat4 modelViewProjectionMatrix;

// returns x in NDC (between 0...1)
float OS_to_NDC(vec3 x) {
    vec4 clipPos = modelViewProjectionMatrix * vec4(x, 1.0);
    vec3 ndcPos = clipPos.xyz / clipPos.w;
    return ndcPos.x; // [-1, 1]
}

void main()
{
    ndc_x = OS_to_NDC(vertex);
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
