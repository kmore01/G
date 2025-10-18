#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform float n = 8;

void main()
{
    vec2 aux = vtexCoord*n;
    int s = int(floor(aux.s));
    int t = int(floor(aux.t));
    if ((s + t) % 2 == 0)  
        fragColor = vec4(0.8);
    else
        fragColor = vec4(0.0); 
}
