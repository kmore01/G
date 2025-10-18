#version 330 core

in vec2 vc;
out vec4 fragColor;

uniform sampler2D colormap;

/*
    Tenemos que ir moviendo las coordenadas de textura a el objeto que queramos pintar, por ejemplo
    si queremos pintar el pacman, las coordenadas de textura deben ir de [1/6, 2/6] y asi sucesivamente.
*/


void pintarParedes(bool extremos) {
    vec2 ftexCoord;
    // Curva superior izquierda
    if (extremos) {
        if (vc.s < 1 && vc.t > 14) ftexCoord = vec2((1.0 - fract(vc.s))/6.0 + 4.0/6.0, fract(vc.t));
        // Curva superior derecha
        else if (vc.s > 14 && vc.t > 14) ftexCoord = vec2(fract(vc.s)/6.0 + 4.0/6.0, fract(vc.t));
        // Curva inferior izquierda
        else if (vc.s < 1 && vc.t < 1) ftexCoord = vec2((1.0 - fract(vc.s))/6.0 + 4.0/6.0, 1.0 - fract(vc.t));
        // Curva inferior derecha
        else if (vc.s > 14 && vc.t < 1) ftexCoord = vec2(fract(vc.s)/6.0 + 4.0/6.0, 1.0 - fract(vc.t));
        // Horizontales
        else if (vc.s > 1 && vc.s < 14) ftexCoord = vec2(fract(vc.s)/6.0 + 3.0/6.0, fract(vc.t));
        // Verticales
        else if (vc.s < 1 || vc.s > 14) ftexCoord = vec2(fract(vc.t)/6.0 + 3.0/6.0, fract(vc.s)); // Intercambias vc.s y vc.t
    } else {
        if (int(vc.s) == 7) ftexCoord = vec2(fract(vc.s)/6.0 + 2.0/6.0, fract(vc.t));
        else if (vc.s > 2 && vc.s < 7 && int(vc.t) % 2 != 0) ftexCoord = vec2(fract(vc.s)/6.0 + 3.0/6.0, fract(vc.t));
    }
    fragColor = texture(colormap, ftexCoord);
}

void pintarPacman() {
    vec2 ftexCoord = vec2(fract(vc.s)/6. + 1/6., fract(vc.t));
    fragColor = texture(colormap, ftexCoord);
}

void pintarFantasmas() {
    vec2 ftexCoord = vec2(fract(vc.s)/6., fract(vc.t));
    fragColor = texture(colormap, ftexCoord);
}

void pintarPildoras() {
    vec2 ftexCoord = vec2(fract(vc.s)/6. + 5/6., fract(vc.t));
    fragColor = texture(colormap, ftexCoord);
}

void main()
{
    if (vc.s < 1 || vc.s > 14 || vc.t < 1 || vc.t > 14) pintarParedes(true);
    else if (vc.s < 8 && vc.s > 7 && vc.t < 2 && vc.t > 1) pintarPacman();
    else if (vc.s > 7 && vc.s < 8 && vc.t > 13 && vc.t < 14) pintarFantasmas();
    else if (vc.s > 13 && vc.s < 14 && vc.t > 1 && vc.t < 2) pintarFantasmas();
    else if (vc.s > 1 && vc.s < 2 && vc.t > 7 && vc.t < 8) pintarFantasmas();
    else if (vc.s > 2 && vc.s < 7 && int(vc.t) % 2 != 0 || vc.s > 8 && vc.s < 13
             && int(vc.t) % 2 != 0 || vc.s < 2 || vc.s > 13 || int(vc.s) == 7) pintarPildoras();
    else pintarParedes(false);
}
