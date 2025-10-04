#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;

uniform vec4 lightAmbient;  // similar a gl_LightSource[0].ambient
uniform vec4 lightDiffuse;  // similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular
uniform vec4 lightPosition; // similar a gl_LightSource[0].position en eye space
uniform vec4 matAmbient;    // similar a gl_FrontMaterial.ambient 
uniform vec4 matDiffuse;    // similar a gl_FrontMaterial.diffuse 
uniform vec4 matSpecular;   // similar a gl_FrontMaterial.specular
uniform float matShininess; // similar a gl_FrontMaterial.shininess

vec4 phong()
{
    // Ambient
    vec4 ambient = lightAmbient*matAmbient;
    // Difusa
    vec3 N = normalize(normalMatrix * normal);
    vec3 eyeVertex = vec3(modelViewMatrix * vec4(vertex, 1.0));
    vec3 L = normalize(vec3(lightPosition - vec4(eyeVertex, 1.0)));
    float aux = max(0.0, dot(N, L));
    vec4 difus = lightDiffuse*matDiffuse*aux;
    // Especular
    vec4 especular = vec4(0.0);
    vec3 R = 2*(aux)*N-L;
    vec3 V = normalize(-eyeVertex); // camara en origen
    if (aux >= 0.0) {
        especular = lightSpecular*matSpecular*pow(max(0.0, dot(R, V)), matShininess);
    }
    return (ambient + difus + especular);
}

void main()
{
    frontColor = phong();
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}