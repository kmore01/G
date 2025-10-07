#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform float time;
uniform sampler2D explosion;

void main()
{
    float slice = 1.0/30.0;
    // Cada 1/30 segons es canvia el frame
    // En total hi ha 48 frames
    int frame = int(mod(time/slice, 48));
    int columna = frame%8;
    int fila = (6 - 1) - frame/8;
    /*
        En OpenGL, la coordenada t=0 está abajo, t=1 arriba! De modo
        que queremos algo asi:
        fila 5
        fila 4
        fila 3
        fila 2
        fila 1 
        fila 0
        Lo normal hubiera sido frame/8, pero en OpenGL no es asi.
    */

    vec2 vtexCoord2 = vtexCoord*vec2(1.0/8.0, 1.0/6.0);
    vtexCoord2.s += (columna)/8.0;
    vtexCoord2.t += (fila)/6.0;
    fragColor = texture(explosion, vtexCoord2);
    fragColor *= fragColor.w;
}
