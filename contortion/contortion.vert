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
    float A;
    if (vertex.y < 0.5) A = 0.0;
    else A = -(vertex.y - 0.5)*sin(time); // !
    mat3 rotate = mat3(1.0, 0.0, 0.0,
                       0.0, cos(A), -sin(A),
                       0.0, sin(A), cos(A));

    vec3 translation = vertex - vec3(0.0, 1.0, 0.0); // trasladar al origen
    vec3 rotation = rotate * translation; // rotacion sobre el origen 
    vec3 finalVertex = rotation + vec3(0.0, 1.0, 0.0); // trasladar donde estaba
    gl_Position = modelViewProjectionMatrix * vec4(finalVertex, 1.0);
}
