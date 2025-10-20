#version 330 core

in vec2 vtexCoord;
in vec3 N;
out vec4 fragColor;

uniform float time;
uniform sampler2D window;
uniform sampler2D palm1;
uniform sampler2D background2;


void main()
{
    vec4 C = texture(window, vtexCoord);
    if (C.a == 1.0) {
        fragColor = C;
    } else {
        vec2 coordPalm = vtexCoord + 0.25*N.xy + vec2(0.1*sin(2*time)*vtexCoord.t, 0);
        vec4 D = texture(palm1, coordPalm);
        if (D.a >= 0.5) {
            fragColor = D;
        } else {
            vec2 coordBack = vtexCoord + 0.5*N.xy;
            vec4 E = texture(background2, coordBack);
            fragColor = E;
        }
    }
}
