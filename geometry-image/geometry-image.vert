#version 330 core

layout (location = 0) in vec3 vertex;

out vec4 frontColor;

uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 modelViewProjectionMatrix;
uniform int mode = 0;
uniform sampler2D positionMap;
uniform sampler2D normalMap1;
uniform vec4 lightAmbient;  // similar a gl_LightSource[0].ambient
uniform vec4 lightDiffuse;  // similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular
uniform vec4 lightPosition; // similar a gl_LightSource[0].position en eye space
uniform vec4 matAmbient;    // similar a gl_FrontMaterial.ambient 
uniform vec4 matDiffuse;    // similar a gl_FrontMaterial.diffuse 
uniform vec4 matSpecular;   // similar a gl_FrontMaterial.specular
uniform float matShininess; // similar a gl_FrontMaterial.shininess

vec4 phong(vec3 N, vec3 vert, bool p)
{
    // Ambient
    vec4 ambient = lightAmbient*matAmbient;
    // Difusa
    vec3 eyeVertex = vec3(modelViewMatrix * vec4(vert, 1.0));
    vec3 L = normalize(vec3(lightPosition - vec4(eyeVertex, 1.0)));
    float aux = max(0.0, dot(N, L));
    vec4 difus;
    if (p == false) {
        difus = lightDiffuse*matDiffuse*aux;
    } else {
        difus = lightDiffuse*vec4(vert, 1.0)*aux;
    }
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
    // [-1, 1] --> [0, 1] --> [0, 0.992] --> [0.004, 0.996]
    // Las transformaciones se las tienes que aplicar a todos los vertices
    vec2 st = ((vertex.xy*0.5) + 0.5)*0.992 + 0.004;
    vec4 colorPositionMap = texture(positionMap, st);
    vec4 colornormalMap1 = texture(normalMap1, st);
    vec3 P = colorPositionMap.xyz;
    // [0, 1] --> [0, 2] --> [-1, 1]
    vec3 N = normalize(normalMatrix*(colornormalMap1.xyz*2.0 - vec3(1.0)));
    if (mode == 0) {
        frontColor = vec4(P, 1.0);
    } else if (mode == 1)  {
        frontColor = vec4(P, 1.0)*N.z;
    } else if (mode == 2) {
        frontColor = phong(N, P, false);
    } else {
        frontColor = phong(N, P, true);
    }
    gl_Position = modelViewProjectionMatrix*vec4(P, 1.0);
}
