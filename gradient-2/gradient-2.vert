#version 330 core

layout (location = 0) in vec3 vertex; // object space

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform vec3 boundingBoxMin; 
uniform vec3 boundingBoxMax; 

// returns x in NDC (between 0...1)
vec2 OS_to_NDC(vec3 x) {
    vec4 clipPos = modelViewProjectionMatrix * vec4(x, 1.0);
    vec3 ndcPos = clipPos.xyz / clipPos.w;
    return ndcPos.xy; // [-1, 1]
}

vec3 gradient_color() {
    // Colors possibles
    vec3 red = vec3(1.0, 0.0, 0.0);
    vec3 yellow = vec3(1.0, 1.0, 0.0);
    vec3 green = vec3(0.0, 1.0, 0.0);
    vec3 cian = vec3(0.0, 1.0, 1.0);
    vec3 blue = vec3(0.0, 0.0, 1.0);
    // Calcul del valor de t segons la coordenada [0...1]
    float minY = OS_to_NDC(boundingBoxMin).y;
    float maxY = OS_to_NDC(boundingBoxMax).y;
    float t = (OS_to_NDC(vertex).y + 1.0)*2.0; // [0..4]
    float localT = fract(t); // part fraccionaria de cada tram
    // Color
    vec3 color; 
    if (t <= 0.0) color = red;
    else if (t > 0.0 && t < 1.0) color = mix(red, yellow, localT); 
    else if (t >= 1.0 && t < 2.0) color = mix(yellow, green, localT); 
    else if (t >= 2.0 && t < 3.0) color = mix(green, cian, localT); 
    else if (t >= 3.0 && t < 4.0) color = mix(cian, blue, localT);
    else color = blue;
    return color;
}

void main()
{
    frontColor = vec4(gradient_color(), 1.0);
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
