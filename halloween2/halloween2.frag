#version 330 core

in vec2 vtexCoord; // coordenadas de textura o fragmento [0,1]
out vec4 fragColor;

void pintarFondo() {
    vec2 centro = vec2(2.0, 1.5);
    vec2 norm = vec2((vtexCoord.x - centro.x) / 2.0, (vtexCoord.y - centro.y) / 1.0);
    float dist = length(norm);
    dist = smoothstep(0.0, 1.0, dist);  // 0 = centro, 1 = borde
    vec3 naranja = vec3(1.0, 0.5, 0.0);
    vec3 negro   = vec3(0.0, 0.0, 0.0);
    vec3 color = mix(naranja, negro, dist);
    fragColor = vec4(color, 1.0);
}

void pintarCalabaza() {
    vec2 centro = vec2(2.0, 1.5);
    vec2 norm = vec2((vtexCoord.x - centro.x) / 1.1, (vtexCoord.y - centro.y) / 0.7);
    float dist = length(norm);
    dist = smoothstep(0.0, 1.0, dist); 
    // Ojo derecho
    vec2 centro2 = vec2(2.4, 1.7);
    vec2 norm2 = vec2((vtexCoord.x - centro2.x) / 0.35, (vtexCoord.y - centro2.y) / 0.2);
    float dist2 = length(norm2);
    dist2 = smoothstep(0.0, 1.0, dist2);
    // Ojo izquierdo
    vec2 centro3 = vec2(1.6, 1.7);
    vec2 norm3 = vec2((vtexCoord.x - centro3.x) / 0.35, (vtexCoord.y - centro3.y) / 0.2);
    float dist3 = length(norm3);
    dist3 = smoothstep(0.0, 1.0, dist3); 
    // Boca: circulo grande
    vec2 centro4 = vec2(2.0, 1.40);
    vec2 norm4 = vec2((vtexCoord.x - centro4.x) / 0.8, (vtexCoord.y - centro4.y) / 0.45);
    float dist4 = length(norm4);
    // Boca: ciruclo pequeño (parte superior para cortar el circulo grnade)
    vec2 centro5 = vec2(2.0, 1.55);
    vec2 norm5 = vec2((vtexCoord.x - centro5.x) / 0.8, (vtexCoord.y - centro5.y) / 0.45);
    float dist5 = length(norm5);
    // La boca es la parte del circulo grande que NO esta en el circulo pequeño
    bool esBoca = (dist4 < 1.0 && dist5 >= 1.0);
    // Cabeza
    if (dist < 1.0 && dist2 == 1.0 && dist3 == 1.0 && !esBoca) {
        vec3 gris = vec3(0.1, 0.1, 0.1);
        fragColor = vec4(gris, 1.0);
    }
    // Part de arriba de la calabaza
    if (vtexCoord.x > 1.9 && vtexCoord.x < 2.1 && vtexCoord.y > 2.15 && vtexCoord.y < 2.4) {
        vec3 gris = vec3(0.1, 0.1, 0.1);
        fragColor = vec4(gris, 1.0);
    }
}

void main()
{
    pintarFondo();
    pintarCalabaza();
}