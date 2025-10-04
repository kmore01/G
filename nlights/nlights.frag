#version 330 core

const float PI = 3.1415926535;
const float RADIUS = 10.0;

in vec3 norm;
in vec3 vert;

out vec4 fragColor;

uniform vec4 lightDiffuse;  // similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular
uniform vec4 matDiffuse;    // similar a gl_FrontMaterial.diffuse 
uniform vec4 matSpecular;   // similar a gl_FrontMaterial.specular
uniform float matShininess; // similar a gl_FrontMaterial.shininess
uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;
uniform int n = 4;

vec4 nlights(vec3 norm, vec3 vert)
{
    vec3 N = normalize(normalMatrix*norm);
    vec3 eyeVertex = vec3(modelViewMatrix * vec4(vert, 1.0));
    vec3 V = normalize(-eyeVertex); // camara en origen
    vec4 KdId = lightDiffuse*matDiffuse;
    vec4 KsIs = lightSpecular*matSpecular;
    vec4 llum = vec4(0.0);
    for (int i = 0; i < n; ++i) {
        // Calcular lightposition
        float x = RADIUS * cos(i * 2 * PI / n); // !
		float y = RADIUS * sin(i * 2 * PI / n); // !
        vec3 L = normalize(vec3(x, y, 0.0) - eyeVertex);
        float aux = max(0.0, dot(N, L));
        // Difus
        llum += KdId*aux/sqrt(n);
        // Especular
        if (aux >= 0.0) {
            vec3 R = 2*(aux)*N-L;
            llum += KsIs*pow(max(0.0, dot(R, V)), matShininess);
        }
    }
    return llum;
}

void main()
{
    fragColor = nlights(norm, vert);
}

/*
    Un circulo completo tiene 2*PI (360 grados). Lo dividimos entre el numero de luces
    y lo multiplicamos por la luz correspondiente.
*/
