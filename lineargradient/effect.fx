////////////////////////////////////
// Linear Gradient effect for Construct 3
// by Jeremy Lonien aka Ludonaut

precision mediump float;
varying mediump vec2 vTex;
uniform lowp sampler2D samplerFront;

uniform lowp vec3 color1; //start
uniform lowp vec3 color2; //end
uniform lowp float angle;

void main() {
	// https://www.shadertoy.com/view/Mt2XDK

	vec4 front = texture2D(samplerFront, vTex);

	vec4 startColor = vec4(color1, 1.0);
	vec4 endColor = vec4(color2, 1.0);
	float currentAngle = -angle;

	vec2 uv = vTex;

	vec2 origin = vec2(0.5, 0.5);
	uv -= origin;

	float angle = radians(90.0) - radians(currentAngle) + atan(uv.y, uv.x);

	float len = length(uv);
	uv = vec2(cos(angle) * len, sin(angle) * len) + origin;

	gl_FragColor = vec4(mix(startColor, endColor, smoothstep(0.0, 1.0, uv.x)))*front.a;
}