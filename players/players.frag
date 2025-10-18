#version 330 core

in vec2 vtexCoord;
in vec2 P;
out vec4 fragColor;

uniform int mode = 0;
uniform sampler2D courtMap;
uniform sampler2D player1;
// 3m hacia la derecha (-X), 8m hacia abajo (-Y)
uniform vec2 p1 = vec2(-3, -8); 
uniform vec2 p2 = vec2(3, -8);
uniform vec2 p3 = vec2(-2, 2);
uniform vec2 p4 = vec2(2, 2);

vec4 colorearLineas() {
    vec4 colorTex = texture(courtMap, vtexCoord);
    // Lineas verticales
    for (int i = -5; i < 5; ++i) {
        if (P.x >= i && P.x < (i + 0.05)) {
            return colorTex * 1.2;
        }
    }
    // Lineas horizontales
    for (int i = -10; i < 10; ++i) {
        if (P.y >= i && P.y < (i + 0.05)) {
            return colorTex * 1.2;
        }
    }
    return colorTex;
}

void auxCirculo(float d) {
    vec4 blanco = vec4(1.0, 1.0, 1.0, 1.0);
    vec4 negro = vec4(0.0, 0.0, 0.0, 1.0);
    if (d <= 0.4) { 
        fragColor = blanco;
    } else if (d <= 0.5) {
        fragColor = negro;
    } 
}

void pintarCirculos() {
    // distancia entre P y p1
    float distancia = length(P - p1);
    auxCirculo(distancia);
    distancia = length(P - p2);
    auxCirculo(distancia);
    distancia = length(P - p3);
    auxCirculo(distancia);
    distancia = length(P - p4);
    auxCirculo(distancia);
}

// usar length solo sirve para circulos
void pintarPlayers() {
    if (abs(P.x - p1.x) <= 1.0 && abs(P.y - p1.y) <= 1.0) {
        // [-1, 1] --> [-0.5, 0.5] --> [0, 1]
        vec2 local = (P - p1) / 2.0 + 0.5; // [0, 1]
        vec4 C = texture(player1, vec2(-local.x, local.y));
        if (C.r > 0.5 || C.b < 0.5) fragColor = C;
        else fragColor = colorearLineas();
    }
    else if (abs(P.x - p2.x) <= 1.0 && abs(P.y - p2.y) <= 1.0) {
        vec2 local = (P - p2) / 2.0 + 0.5; 
        vec4 C = texture(player1, vec2(-local.x, local.y));
        if (C.r > 0.5 || C.b < 0.5) fragColor = C;
        else fragColor = colorearLineas();
    }
    else if (abs(P.x - p3.x) <= 1. && abs(P.y - p3.y) <= 1.) {
        vec2 local = - (P - p3) / 2.0 + 0.5; 
        vec4 C = texture(player1, local);
        if (C.r > 0.5 || C.b < 0.5) fragColor = C;
        else fragColor = colorearLineas();
    }
    else if (abs(P.x - p4.x) <= 1.0 && abs(P.y - p4.y) <= 1.0) {
        vec2 local = - (P - p4) / 2.0 + 0.5; 
        vec4 C = texture(player1, local);
        if (C.r > 0.5 || C.b < 0.5) fragColor = C;
        else fragColor = colorearLineas();
    }
}
    
void main()
{
    if (mode == 0) {
        fragColor = texture(courtMap, vtexCoord);
    } else {
        fragColor = colorearLineas();
        if (mode == 2) {
            pintarCirculos();
        }
        else if (mode == 3) {
            pintarPlayers();
        }
    }
}