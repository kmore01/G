#version 330 core

in vec3 L;
in vec3 N;
in vec3 V;

out vec4 fragColor;

uniform vec4 lightAmbient;  // similar a gl_LightSource[0].ambient
uniform vec4 lightDiffuse;  // similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular
uniform vec4 matAmbient;    // similar a gl_FrontMaterial.ambient 
uniform vec4 matDiffuse;    // similar a gl_FrontMaterial.diffuse 
uniform vec4 matSpecular;   // similar a gl_FrontMaterial.specular
uniform float matShininess; // similar a gl_FrontMaterial.shininess

vec4 phong(vec3 N, vec3 V, vec3 L)
{
    // Ambient
    vec4 ambient = lightAmbient*matAmbient;
    // Difusa
    vec3 Nn = normalize(N);
    vec3 Ln = normalize(L);
    float aux = max(0.0, dot(Nn, Ln));
    vec4 difus = lightDiffuse*matDiffuse*aux;
    // Especular
    vec4 especular = vec4(0.0);
    vec3 R = 2*(aux)*Nn-Ln;
    vec3 Vn = normalize(V);
    if (aux >= 0.0) {
        especular = lightSpecular*matSpecular*pow(max(0.0, dot(R, Vn)), matShininess);
    }
    return (ambient + difus + especular);
}

void main()
{
    fragColor = phong(N, V, L);
}
