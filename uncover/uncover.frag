#version 330 core

in float ndc_x; // [-1..1]

out vec4 fragColor;

uniform float time;

void main()
{  
    /* 
    ((ndc_x + 1.0) / 2.0) --> normalizar [0..1]
    time = 0 → 0 / 2 = 0 → no se ve nada
    time = 1 → 1 / 2 = 0.5 → se ve el 50% izquierdo
    time = 2 → 2 / 2 = 1.0 → se ve todo
    */
    if ((ndc_x + 1.0) / 2.0 <= time / 2.0) fragColor = vec4(0.0, 0.0, 1.0, 1.0); 
    else discard; // descartar fragmento
}
