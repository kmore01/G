#version 330 core

layout (location = 0) in vec3 vertex; // object space
layout (location = 2) in vec3 color;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform vec3 boundingBoxMin; 
uniform vec3 boundingBoxMax; 

vec3 gradient_color() {
    // Colors possibles
    vec3 red = vec3(1.0, 0.0, 0.0);
    vec3 yellow = vec3(1.0, 1.0, 0.0);
    vec3 green = vec3(0.0, 1.0, 0.0);
    vec3 cian = vec3(0.0, 1.0, 1.0);
    vec3 blue = vec3(0.0, 0.0, 1.0);
    // Calcul del valor de t segons la coordenada [0...1]
    float minY = boundingBoxMin.y;
    float maxY = boundingBoxMax.y;
    float t = (vertex.y - minY) / (maxY - minY); // [0...1]
    float generalT = t * 4.0; // Trams [0,4]
    float localT = fract(generalT); // part fraccionaria de cada tram
    // Color
    vec3 color; 
    if (generalT == 0.0) color = red;
    else if (generalT > 0.0 && generalT < 1.0) color = mix(red, yellow, localT); 
    else if (generalT >= 1.0 && generalT < 2.0) color = mix(yellow, green, localT); 
    else if (generalT >= 2.0 && generalT < 3.0) color = mix(green, cian, localT); 
    else if (generalT >= 3.0 && generalT < 4.0) color = mix(cian, blue, localT);
    else color = blue;
    return color;
}

void main()
{
    frontColor = vec4(gradient_color(), 1.0);
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
