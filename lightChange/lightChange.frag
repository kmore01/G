#version 330 core

in vec3 NES;
in vec3 vertexES;
in vec2 vtexCoord;
out vec4 fragColor;

uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular
uniform vec4 lightPosition;
uniform vec4 matSpecular;   // similar a gl_FrontMaterial.specular
uniform float matShininess; // similar a gl_FrontMaterial.shininess
uniform float time;
uniform sampler2D colorMap;

vec4 phong(vec3 N, vec3 V, vec3 L)
{
    // Difusa
    vec3 Nn = normalize(N);
    vec3 Ln = normalize(L);
    float nDotL = max(0.0, dot(Nn, Ln));
    // lightDiffuse
    vec4 lightDiffuse;  
    if (int(time) % 2 == 0) lightDiffuse = vec4(mix(0, 0.8, fract(time)));
    else lightDiffuse = vec4(mix(0.8, 0, fract(time))); 
    // matDiffuse  
    /*
        el frame 0 es el 1 de la imagen...
    */
    int frame = int(mod(time / 2.0, 12.0));
    int columna = frame / 3;        
    int fila = (3 - 1) - frame % 3;     
    vec2 vtexCoord2 = vtexCoord*vec2(1.0/4.0, 1.0/3.0);
    vtexCoord2.s += (columna)/4.0;
    vtexCoord2.t += (fila)/3.0;
    vec4 difus = lightDiffuse*texture(colorMap, vtexCoord2)*nDotL;
    // Especular
    vec4 especular = vec4(0.0);
    vec3 R = 2*(nDotL)*Nn-Ln;
    vec3 Vn = normalize(V);
    if (nDotL >= 0.0) {
        especular = lightSpecular*matSpecular*pow(max(0.0, dot(R, Vn)), matShininess);
    }
    return (difus + especular);
}

void main()
{
    fragColor = phong(NES, -vertexES, lightPosition.xyz - vertexES);
}
